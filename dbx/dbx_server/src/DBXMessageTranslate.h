#ifndef __DBX_MESSAGE_TRANSLATE_
#define __DBX_MESSAGE_TRANSLATE_

#include "lindef.h"	// 包含lindef.h来使用trace.h
#include "dbx_msgdef.h"
//mysql
#include "m_string.h"
#include "mysql.h"
//std
#include <list>
#include <string>
#include <map>
using namespace std;


// 最大参数名称长度
#define MAX_PARAMNAME_LEN			32

// QueryBuffer长度
#define QUERYBUFFER_MAX_LEN			1024 * 128

// 参数方向定义
enum
{
	PARAM_DIR_IN = 0,				/// 输入参数
	PARAM_DIR_OUT,					/// 输出参数
};

// 输出数据
struct SOutParam
{
	char szVariableName[MAX_PARAMNAME_LEN];	// 输出变量名
	PType nDataType;						// 数据类型

	int size() { return DbxMessage::getTypeSize(nDataType); }

	SOutParam(void)
	{
		memset(this, 0, sizeof(SOutParam));
	}

	SOutParam(const char * vname, PType & type):
		nDataType(type)
	{
		strcpy(szVariableName, vname);
	}
};


typedef std::list< SOutParam >  TListOutput;


// 消息参数
struct SParam
{
	char szVariableName[MAX_PARAMNAME_LEN];	// 参数名
	int nDataDir;							// 参数方向
	PType nDataType;						// 数据类型
	const void * pvData;					// 数据

	int size() { return DbxMessage::getTypeSize(nDataType); }

	SParam(void)
	{
		memset(this, 0, sizeof(SParam));
	}

	SParam(const char * vname, PType & type, const void * data) :
		nDataType(type), pvData(data)
	{
		strcpy(szVariableName, vname);
	}

	SParam(const char * vname, PType && type, const void * data) :
		nDataType(type), pvData(data)
	{
		strcpy(szVariableName, vname);
	}
};

struct SCharPtrCmp
{
	bool operator() (const char * s1, const char * s2) const
	{
		return strcmp(s1, s2) < 0;
	}
};


typedef std::list< SParam >  TListParam;
typedef std::map<const char *, SParam, SCharPtrCmp> TMapParam;


bool build_sql_query_buffer(CCSResultMsg & message, char * pBuffer)
{
	return true;
}


bool build_sp_query_buffer(MYSQL * pMysql, CCSResultMsg * pMessage, char * pBuffer/*out*/, int & nBufferLen/*in-out*/, TListOutput & outParams/*out*/)
{
	char spName[MAX_PARAMNAME_LEN] = { 0 };

	list<char *> sort_params;
	TMapParam mapped_params;
	TListParam ordered_params;

	bool ok = true;

	//整理存储过程参数
	string attrName; PType attrType; const void * pAttrValue;
	for (int i = 0; i < pMessage->getAttributeCount(); i++)
	{
		pMessage->getAttribute(attrName, attrType, pAttrValue, i);

		if (attrName == "spName")
		{
			//存储过程名
			memcpy(spName, pAttrValue, attrType);
		}
		else if (attrName == "dataBase")
		{
			//这里用不到这个字段
		}
		else if (attrName == "sort")
		{
			//存储过程参数顺序定义
			const char * temp = (const char *)pAttrValue;

			char * param = NULL;
			int start = 0, pos = 0;

			for (; pos < attrType; pos++)
			{
				if (temp[pos] == ',')
				{
					if (pos > start)
					{
						param = (char *)malloc(pos - start + 1);
						memcpy(param, temp + start, pos - start);
						param[pos - start] = '\0';
						upper_first_char(param);

						sort_params.push_back(param);
					}
					//从','的下一个字符开始
					start = pos + 1;
				}
			}

			//最后一个参数
			if (start < attrType)
			{
				param = (char *)malloc(attrType - start + 1);
				memcpy(param, temp + start, attrType - start);
				param[attrType - start] = '\0';
				upper_first_char(param);

				sort_params.push_back(param);
			}
		}
		else
		{
			if (attrName.length() >= MAX_PARAMNAME_LEN)
			{
				ok = false;
				TRACE3_ERROR("Attr name %s > MAX_PARAMNAME_LEN(%i), spName %s", attrName.c_str(), MAX_PARAMNAME_LEN, spName);
				break;
			}
			else
			{
				SParam param(attrName.c_str(), attrType, pAttrValue);
				//输出参数
				if (attrName[0] == '@')
				{
					param.nDataDir = PARAM_DIR_OUT;
					outParams.push_back(SOutParam(attrName.c_str(), attrType));
				}
				else
				{
					param.nDataDir = PARAM_DIR_IN;
				}
				mapped_params[attrName.c_str()] = param;
			}
		}
	}

	if (ok)
	{
		if (sort_params.size() > 0)
		{
			//根据参数顺序填充列表
			list<char *>::iterator s_it = sort_params.begin();
			for (; s_it != sort_params.end(); s_it++)
			{
				TMapParam::iterator m_it = mapped_params.find(*s_it);

				if (m_it != mapped_params.end())
				{
					ordered_params.push_back(m_it->second);
				}
				else
				{
					ok = false;
					TRACE2_ERROR("Invalid sort param %s, spName %s", *s_it, spName);
					break;
				}
			}
		}
		else if (mapped_params.size() > 0)
		{
			TMapParam::iterator m_it = mapped_params.begin();
			for (; m_it != mapped_params.end(); m_it++)
			{
				ordered_params.push_back(m_it->second);
			}
		}
		else
		{
			//根据规则，参数中必须至少包含一个RoleID
			ok = false;
			TRACE1_ERROR("Call sp no param found, need at least RoleID? spName %s", spName);
		}
	}

	//下面开始生成存储过程调用语句
	if (ok)
	{
		char * pEnd = NULL;
		pEnd = strmov(pBuffer, "call");

		//存储过程名
		pEnd = strmov(pEnd, spName);
		pEnd = strmov(pEnd, "(");

		//存储过程参数
		TListParam::iterator o_it = ordered_params.begin();
		for (; o_it != ordered_params.end(); o_it++)
		{
			SParam & param = *o_it;
			if (param.nDataDir == PARAM_DIR_IN)
			{
				if (param.nDataType == PARAMINT)
				{
					char szInt[128] = { 0 };
					sprintf(szInt, "%d", *(int *)param.pvData);

					// 判断是否越界
					if (pEnd + strlen(szInt) + 32/*用来放）号等*/ >= (pBuffer + nBufferLen))
					{
						ok = false;
						TRACE2_ERROR("Fail to build query buffer, content larger than buffer length(%d). spName %s", spName, nBufferLen);
						break;
					}

					pEnd = strmov(pEnd, szInt);
				}
				else if (param.nDataType == PARAMFLOAT)
				{
					char szFloat[128] = { 0 };
					sprintf(szFloat, "%f", *(float *)param.pvData);

					// 判断是否越界
					if (pEnd + strlen(szFloat) + 32/*用来放）号等*/ >= (pBuffer + nBufferLen))
					{
						ok = false;
						TRACE2_ERROR("Fail to build query buffer, content larger than buffer length(%d). spName %s", spName, nBufferLen);
						break;
					}

					pEnd += mysql_real_escape_string(pMysql, pEnd, szFloat, strlen(szFloat));
				}
				else if (param.nDataType == PARAMBOOL)
				{
					char szInt[128] = { 0 };
					int res = 0;
					bool bres = *(bool *)param.pvData;
					if (bres) res = 1;
					sprintf(szInt, "%d", res);

					// 判断是否越界
					if (pEnd + strlen(szInt) + 32/*用来放）号等*/ >= (pBuffer + nBufferLen))
					{
						ok = false;
						TRACE2_ERROR("Fail to build query buffer, content larger than buffer length(%d). spName %s", spName, nBufferLen);
						break;
					}

					pEnd = strmov(pEnd, szInt);
				}
				else if (param.nDataType > 0)
				{
					//字符串处理

					// 判断是否会越界. mysql_real_escape_string() 必须为“to”缓冲区分配至少length*2+1字节
					if ((pEnd + param.size() * 2 + 32/*用来放）号等*/) >= (pBuffer + nBufferLen))
					{
						ok = false;
						TRACE2_ERROR("Fail to build query buffer, content larger than buffer length(%d). spName %s", spName, nBufferLen);
						break;
					}

					// '
					*pEnd++ = '\'';

					int nSize = param.size();
					char * temp = (char *)malloc(nSize + 1);
					memcpy(temp, param.pvData, nSize);
					temp[nSize] = '\0';

					pEnd += mysql_real_escape_string(pMysql, pEnd, temp, nSize);
					free(temp);

					// '
					*pEnd++ = '\'';
				}
			}
			else if (param.nDataDir == PARAM_DIR_OUT)
			{
				// 判断是否越界
				if ((pEnd + param.size() + 32/*用来放）号等*/) >= (pBuffer + nBufferLen))
				{
					ok = false;
					TRACE2_ERROR("Fail to build query buffer, content larger than buffer length(%d). spName %s", spName, nBufferLen);
					break;
				}

				pEnd = strmov(pEnd, param.szVariableName);
			}

			pEnd = strmov(pEnd, ", ");
		}

		if (ok)
		{
			//去掉最后一个", "
			if (ordered_params.size() > 0)
			{
				*(--pEnd) = '\0';
				*(--pEnd) = '\0';
			}

			pEnd = strmov(pEnd, ");");
			nBufferLen = pEnd - pBuffer;
		}
	}

	//释放分配的内存
	list<char *>::iterator it = sort_params.begin();
	for (; it != sort_params.end(); it++)
	{
		free(*it);
	}

	return ok;
}

void upper_first_char(char * buffer)
{
	if (*buffer >= 'a' && *(buffer + 1) >= 'a')
		*buffer -= 'a' - 'A';
}

bool translate_sql_result_mysql(const char * pData, CSCResultMsg & message)
{
	return true;
}


bool translate_sp_result_mysql(const char * pData, CSCResultMsg & message)
{
	return true;
}


#endif //__DBX_MESSAGE_TRANSLATE_
