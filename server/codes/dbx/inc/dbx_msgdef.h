#ifndef __DBX_MSGDEF_
#define __DBX_MSGDEF_

#include "stdlib.h"
#include "vsdef.h"
#include <string>
#include <vector>

enum msg_id
{
	C_DOACTION = 1,
	C_DOSQL,
	C_SP_FROM_CPP
};

enum DataType
{
	PARAMINT = -1,
	PARAMBOOL = -2,
	PARAMFLOAT = -3,
	DATATYPEEND = -4
};

typedef int PType;
typedef unsigned char BYTE;


class DbxMessage : public AppMsg
{
public:
	DbxMessage() : p_content(NULL) {}

	int getParamCount()
	{
		return p_content ? *(int *)p_content : 0;
	}

	int getParamLen()
	{
		int param_count = getParamCount();
		if (param_count == 0) return 0;

		const BYTE * rpos = p_content;
		const PType * temp;

		//���������ֽ�
		rpos += sizeof(int);

		int type_size;
		//���������ֽ� + �����ͳ��ȵ��ֽ�
		int len = sizeof(int) + getParamCount() * sizeof(PType);

		for (int i = 0; i < getParamCount(); i++)
		{
			temp = (PType *)rpos;
			type_size = getTypeSize(*temp);
			len += type_size;

			//�������ͺ������ֽ�
			rpos += sizeof(PType) + type_size;
		}
		return len;
	}

	bool getParam(PType & type/*out*/, const void *& pValue/*out*/, const int & index/*from 0*/)
	{
		//���ݽṹ��|��������|����1����|����1������|����2����|����2������|...|

		if (index >= getParamCount())
			return false;

		const BYTE * rpos = p_content;
		const PType * temp;

		//���������ֽ�
		rpos += sizeof(int);

		for (int i = 0; i < getParamCount(); i++)
		{
			if (i == index)
			{
				type = *(PType *)rpos;
				pValue = (void *)(rpos + sizeof(PType));
				return true;
			}
			else
			{
				temp = (PType *)rpos;
				//�������ͺ������ֽ�
				rpos += sizeof(PType) + getTypeSize(*temp);
			}
		}
		return false;
	}

	/*Ϊ�˼��ݾɰ�*/
	bool getParam(PType & type/*out*/, void *& pValue/*out*/, const int & index/*from 0*/)
	{
		const void * temp = NULL;
		if (getParam(type, temp, index))
		{
			pValue = const_cast<void *>(temp);
			return true;
		}
		else
		{
			pValue = NULL;
			return false;
		}
	}

	bool getAttribute(std::string & name/*out*/, PType & valueType/*out*/, const void *& pValue/*out*/, const int & col, const int & row)
	{
		if (col < attribute_cols)
		{
			return getAttribute(name, valueType, pValue, row * attribute_cols + col);
		}
		return false;
	}

	bool getAttribute(std::string & name/*out*/, PType & valueType/*out*/, const void *& pValue/*out*/, const int & index)
	{
		if (index < attribute_count)
		{
			int nameType; const void * pName(NULL);
			if (getParam(nameType, pName, index % attribute_cols))
			{
				char * temp = (char*)malloc(nameType + 1);
				if (temp == NULL) return false;

				//ȡ������
				memcpy(temp, pName, nameType);
				temp[nameType] = '\0';
				name = temp;
				free(temp);

				/*ȡ����ֵ����ŵ�˳���ǣ�
				|������1����|������1|������2����|������2...|����1����|����1|����2����|����2|...|��������|
				��*/
				int value_pos = attribute_cols + index;
				return getParam(valueType, pValue, value_pos);
			}
		}
		return false;
	}

	/*Ϊ�˼��ݾɰ�*/
	bool getAttribute(char *& name/*out*/, PType & valueType/*out*/, void *& pValue/*out*/, const int & col, const int & row)
	{
		if (col < attribute_cols)
		{
			int nameType; const void * pName(NULL);
			if (getParam(nameType, pName, col))
			{
				name = (char*)malloc(nameType + 1);
				if (name == NULL) return false;

				//ȡ������
				memcpy(name, pName, nameType);
				name[nameType] = '\0';
				//name = temp;
				//free(temp);	���ⲿ�ͷ�

				/*ȡ����ֵ����ŵ�˳���ǣ�
				|������1����|������1|������2����|������2...|����1����|����1|����2����|����2|...|��������|
				��*/
				int value_pos = attribute_cols + row * attribute_cols + col;
				return getParam(valueType, pValue, value_pos);
			}
		}
		return false;
	}

	bool getAttibuteByName(const char * name, PType & valueType/*out*/, const void *& pValue/*out*/)
	{
		for (int i = 0; i < attribute_count; i++)
		{

		}
		return true;
	}

	/*
	* ����������ȡ�����Բ���
	*/
	bool getNonAttribute(PType & type/*out*/, const void *& pValue/*out*/, const int & index/*from 0*/)
	{
		return getParam(type, pValue, attribute_cols + attribute_count + index);
	}

	int getAttributeRows()
	{
		return attribute_count / attribute_cols;
	}

	int getAttributeCols()
	{
		return attribute_cols;
	}

	int getAttributeCount()
	{
		return attribute_count;
	}

	static int getTypeSize(const PType & paramType)
	{
		if (paramType >= 0) return paramType;
		switch (paramType)
		{
		case PARAMINT:
			return sizeof(int);
		case PARAMBOOL:
			return sizeof(bool);
		case PARAMFLOAT:
			return sizeof(float);
		}
		return 0;
	}

	static int getCharacterSize(const char* pValue)
	{
		return (int)strlen(pValue);
	}

	static int getCharacterType(const char* pValue)
	{
		return getCharacterSize(pValue);
	}

	template<class T>
	static T convert(const void * pValue)
	{
		return *(T *)pValue;
	}

	/*
	* �ⲿ�ǵ���free�ͷŵ�
	*/
	static char * convertString(const int & len, const void * pValue)
	{
		char * temp = (char *)malloc(len + 1);
		memcpy(temp, pValue, len);
		temp[len] = '\0';
		return temp;
	}

protected:
	template<class T> friend class DbxMessageBuilder;

	int attribute_cols;		//���Ե�����
	int attribute_count;	//��������

	//���ݽṹ��|��������|����1����|����1������|����2����|����2������|...|
	BYTE * p_content;
};


template<class MessageType>
class DbxMessageBuilder
{
private:
	struct Param
	{
		Param(const PType & t, const void * v)
		{
			type = t;

			int size = DbxMessage::getTypeSize(t);
			p_value = malloc(size);
			if (p_value)
			{
				memcpy(p_value, v, size);
			}
		}

		~Param()
		{
			if (p_value)
			{
				free(p_value);
				p_value = NULL;
			}
		}

		PType type;
		void * p_value;
	};

public:
	~DbxMessageBuilder()
	{
		reset();
	}

	void reset()
	{
		attribute_cols = 0;
		attribute_count = 0;

		if (params.size() > 0)
		{
			for (size_t i = 0; i < params.size(); i++)
			{
				delete params[i];
			}
			params.clear();
			//��֤vector���ڴ�����ͷŵ�
			std::vector<Param *>(params).swap(params);
		}
	}

	void beginMessage()
	{
		reset();
	}

	/*
	* ��Ϣ�����ɣ����������ݷ������ڴ�
	*/
	MessageType * finishMessage()
	{
		int size = sizeof(MessageType) + getParamLen();
		MessageType * p_msg = (MessageType *)malloc(size);
		if (p_msg == NULL) return NULL;
		memset(p_msg, 0, size);

		//������Ϣ����
		p_msg->msgLen = (unsigned short)size;
		p_msg->attribute_cols = attribute_cols;
		p_msg->attribute_count = attribute_count;

		int param_count = params.size();
		if (param_count <= 0) return p_msg;

		/*��λp_contentָ�룬ָ��ṹĩβ*/
		p_msg->p_content = (BYTE *)p_msg;
		p_msg->p_content += sizeof(MessageType);
		BYTE * wpos = p_msg->p_content;

		//д��������
		memcpy(wpos, &param_count, sizeof(int));
		wpos += sizeof(int);

		for (int i = 0; i < param_count; i++)
		{
			//д����
			memcpy(wpos, &params[i]->type, sizeof(PType));
			wpos += sizeof(PType);

			//д����
			size = DbxMessage::getTypeSize(params[i]->type);
			memcpy(wpos, params[i]->p_value, size);
			wpos += size;
		}

		//��Ϣд�꣬����ʱ���������
		reset();

		return p_msg;
	}

	void addParam(const PType & ParamType, const void* pParam)
	{
		params.push_back(new Param(ParamType, pParam));
	}

	void addAttribute(const char* name, const void* value, const PType &  valueType)
	{
		int pos;

		/*���Իᰴ˳����뵽ǰ�棬��ŵ�˳���ǣ�
		|������1����|������1|������2����|������2|...|����1����|����1|����2����|����2|...|��������|
		*/
		if (name != NULL)
		{
			pos = attribute_cols++;
			params.insert(params.begin() + pos, new Param((PType)strlen(name), name));
		}
		if (value != NULL)
		{
			pos = attribute_cols + attribute_count;
			params.insert(params.begin() + pos, new Param(valueType, value));
			attribute_count++;
		}
	}

	int getParamLen()
	{
		int param_count = params.size();
		if (param_count == 0)
			return 0;

		//���������ֽ� + �����ͳ��ȵ��ֽ�
		int len = sizeof(int) + param_count * sizeof(PType);

		for (int i = 0; i < param_count; i++)
		{
			len += DbxMessage::getTypeSize(params[i]->type);
		}
		return len;
	}

	static void locateContent(MessageType * p_msg)
	{
		if (p_msg->msgLen <= sizeof(MessageType))
		{
			p_msg->p_content = NULL;
		}
		else
		{
			/*��λp_contentָ�룬ָ��ṹĩβ*/
			p_msg->p_content = (BYTE *)p_msg;
			p_msg->p_content += sizeof(MessageType);
		}
	}

private:
	int attribute_cols;
	int attribute_count;
	std::vector<Param *> params;
};


class DbxResultMessage : public DbxMessage
{
public:

	char* getStream()
	{
		std::string paramstr;
		int tempsize = 20;	//��֤���Է���һ������/������תΪ�ַ�����ʾ֮��ĳߴ�
		char * temp = (char *)malloc(tempsize);
		if (temp == NULL) return NULL;

		for (int index = 0; index < attribute_count; index++)
		{
			std::string name; PType type; const void * pValue;
			getAttribute(name, type, pValue, index);
			int typesize = getTypeSize(type);

			//�ַ�����Ҫ���Ͻ�����
			if (type > 0)
			{
				typesize += 1;
			}

			//����temp�Ĵ�С��ʹ��������µ�ǰ������
			if (typesize > tempsize)
			{
				free(temp);
				tempsize = typesize;
				temp = (char *)malloc(tempsize);

				if (temp == NULL)
					return NULL;
			}

			memcpy(temp, 0, tempsize);
			paramstr = paramstr + name + ": ";

			switch (type)
			{
			case PARAMINT:
				sprintf(temp, "%d", *(int*)pValue);
				break;
			case PARAMBOOL:
				sprintf(temp, "%d", *(bool*)pValue);
				break;
			case PARAMFLOAT:
				sprintf(temp, "%f", *(float*)pValue);
				break;
			default:
				memcpy(temp, pValue, type);
			}

			paramstr = paramstr + temp + " ";

		}
		free(temp);

		//�������µ�ַ�Ա㷵��
		temp = (char *)malloc(paramstr.length() + 1);
		if (temp == NULL) return NULL;
		strcpy(temp, paramstr.c_str());

		return temp;
	}

public:
	//	int		m_nAttriIndex;  //�ӵڼ���������ʼ�����Բ���
	//	int		m_nAttriNameCount;
	//	int		m_nAttriCount;
	int		m_nTempObjId;  //��Ӧ����ˮ��
	int		m_nSessionId;	//session��
	int		m_spId;			//�洢����ID��
	bool	m_bEnd;
	bool	m_bNeedCallback;
	short	m_nLevel;
};


class CSSResultMsg :public DbxResultMessage
{
public:
	void init()
	{
	}

	void getInit()
	{
	}

	CSSResultMsg & operator=(CSSResultMsg &obj)
	{
		if (this == &obj)
			return *this;

		static_cast<DbxResultMessage &>(*this) = obj;
		m_nResCount = obj.m_nResCount;
		return *this;
	}

public:
	int m_nResCount;
};


class CCSResultMsg :public DbxResultMessage
{
public:
	void init()
	{
	}
	void getInit()
	{
	}
};


class CSCResultMsg :public DbxResultMessage
{
public:

	void init()
	{
	}
	void getInit()
	{
	}
};


#endif //__DBX_MSGDEF_
