#include "DBXMessageTranslate.h"

char * strmov(char * dst, const char * src)
{
    while ((*dst++ = *src++) != '\0');
    return dst - 1;
}


void upper_first_char(char * buffer)
{
    if (*buffer >= 'a' && *buffer <= 'z')
        if (*(buffer + 1) >= 'a' && *(buffer + 1) <= 'z')
            *buffer -= 'a' - 'A';
}

void lower_first_char(char * buffer)
{
    if (*buffer >= 'A' && *buffer <= 'Z')
        if (*(buffer + 1) >= 'A' && *(buffer + 1) <= 'Z')
            *buffer += 'a' - 'A';
}

bool build_sql_query_buffer(CCSResultMsg & message, const int & row, char * pBuffer/*out*/)
{
    return true;
}


bool build_sp_query_buffer(MYSQL * pMysql, CCSResultMsg * pMessage, const int & row,
    char * pBuffer/*out*/, int & nBufferLen/*in-out*/, TListOutput & outParams/*out*/)
{
    char spName[MAX_PARAMNAME_LEN] = { 0 };

    list<char *> sort_params;
    TMapParam mapped_params;
    TListParam ordered_params;

    bool ok = true;

    //整理存储过程参数
    string attrName; PType attrType; const void * pAttrValue;
    for (int i = 0; i < pMessage->getAttributeCols(); i++)
    {
        pMessage->getAttribute(attrName, attrType, pAttrValue, i, row);

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
		char * attrNameStr = (char *)malloc(attrName.length() + 1);
		strcpy(attrNameStr, attrName.c_str());
		upper_first_char(attrNameStr);

                SParam param(attrNameStr,attrType, pAttrValue);
                //输出参数
                if (attrNameStr[0] == '@')
                {
                    param.nDataDir = PARAM_DIR_OUT;
                    outParams.push_back(SOutParam(attrNameStr, attrType));
                }
                else
                {
                    param.nDataDir = PARAM_DIR_IN;
                }
                mapped_params[attrNameStr] = param;
		free(attrNameStr);
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
        pEnd = strmov(pBuffer, "call ");

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

bool translate_sql_result_mysql(const char * pData, CSCResultMsg & message)
{
    return true;
}


bool translate_sp_result_mysql(const char * pData, CSCResultMsg & message)
{
    return true;
}
