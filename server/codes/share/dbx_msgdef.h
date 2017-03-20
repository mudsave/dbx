#ifndef __DBX_MSGDEF_
#define __DBX_MSGDEF_

#include <stdlib.h>
#include <string>
#include <vector>
#include "vsdef.h"

#pragma pack(push, 1)

enum msg_id
{
    C_DOACTION = 1,
    C_DOSQL,
    C_SP_FROM_CPP
};

enum action_res
{
    S_DOACTION_RESULT = 1001,
    S_DOSQL_RESULT,
    S_SP_CPP_RESULT
};

enum DataType
{
    PARAMINT = -1,
    PARAMBOOL = -2,
    PARAMFLOAT = -3,
    DATATYPEEND = -4
};

// 最大参数名称长度
#define MAX_PARAMNAME_LEN           32

typedef int PType;
typedef unsigned char BYTE;


struct SAppMsgNode
{
    AppMsg * p_msg;
    SAppMsgNode * next;

    SAppMsgNode(AppMsg * p_msg) :
        p_msg(p_msg), next(NULL)
    {
    }

    SAppMsgNode * tail()
    {
        SAppMsgNode * current = this;
        while (current->next != NULL) { current = current->next; };
        return current;
    }
};


class DbxMessage : public AppMsg
{
public:
    DbxMessage() : content_offset(0) {}

    int getParamCount()
    {
        BYTE * p_content = getContent();
        return p_content ? *(int *)p_content : 0;
    }

    int getParamLen()
    {
        int param_count = getParamCount();
        if (param_count == 0) return 0;

        const BYTE * rpos = getContent();
        const PType * temp;

        //跳过数量字节
        rpos += sizeof(int);

        int type_size;
        //放数量的字节 + 放类型长度的字节
        int len = sizeof(int) + getParamCount() * sizeof(PType);

        for (int i = 0; i < getParamCount(); i++)
        {
            temp = (PType *)rpos;
            type_size = getTypeSize(*temp);
            len += type_size;

            //跳过类型和数据字节
            rpos += sizeof(PType) + type_size;
        }
        return len;
    }

    bool getParam(PType & type/*out*/, const void *& pValue/*out*/, const int & index/*from 0*/)
    {
        //数据结构：|变量数量|变量1类型|变量1的数据|变量2类型|变量2的数据|...|

        if (index >= getParamCount())
            return false;

        const BYTE * rpos = getContent();
        const PType * temp;

        //跳过数量字节
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
                //跳过类型和数据字节
                rpos += sizeof(PType) + getTypeSize(*temp);
            }
        }
        return false;
    }

    /*为了兼容旧版*/
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

                //取属性名
                memcpy(temp, pName, nameType);
                temp[nameType] = '\0';
                name = temp;
                free(temp);

                /*取属性值（存放的顺序是：
                |属性名1长度|属性名1|属性名2长度|属性名2...|属性1类型|属性1|属性2类型|属性2|...|其他参数|
                ）*/
                int value_pos = attribute_cols + index;
                return getParam(valueType, pValue, value_pos);
            }
        }
        return false;
    }

    /*为了兼容旧版*/
    bool getAttribute(char *& name/*out*/, PType & valueType/*out*/, void *& pValue/*out*/, const int & col, const int & row)
    {
        if (col < attribute_cols)
        {
            int nameType; const void * pName(NULL);
            if (getParam(nameType, pName, col))
            {
                name = (char*)malloc(nameType + 1);
                if (name == NULL) return false;

                //取属性名
                memcpy(name, pName, nameType);
                name[nameType] = '\0';
                //name = temp;
                //free(temp);   由外部释放

                /*取属性值（存放的顺序是：
                |属性名1长度|属性名1|属性名2长度|属性名2...|属性1类型|属性1|属性2类型|属性2|...|其他参数|
                ）*/
                int value_pos = attribute_cols + row * attribute_cols + col;
                return getParam(valueType, pValue, value_pos);
            }
        }
        return false;
    }

    bool getAttibuteByName(const char * name, const int & row, PType & valueType/*out*/, const void *& pValue/*out*/)
    {
        char * currentName = NULL;
        void * currentValue = NULL;
        bool found = false;

        for (int i = 0; i < attribute_cols; i++)
        {
            if (getAttribute(currentName, valueType, currentValue, i, row))
            {
                if (strcmp(currentName, name) == 0)
                {
                    pValue = currentValue;
                    found = true;
                }
                free(currentName);

                if (found) break;
            }
            else
            {
                break;
            }
        }

        return found;
    }

    /*
    * 根据索引获取非属性参数
    */
    bool getNonAttribute(PType & type/*out*/, const void *& pValue/*out*/, const int & index/*from 0*/)
    {
        return getParam(type, pValue, attribute_cols + attribute_count + index);
    }

    int getAttributeRows()
    {
        return attribute_cols == 0 ? 0 : attribute_count / attribute_cols;
    }

    int getAttributeCols()
    {
        return attribute_cols;
    }

    int getAttributeCount()
    {
        return attribute_count;
    }

    BYTE * getContent()
    {
        return content_offset != 0 ? ((BYTE *)this) + content_offset : NULL;
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
    * 外部记得用free释放掉
    */
    static char * convertString(const int & len, const void * pValue)
    {
        char * temp = (char *)malloc(len + 1);
        memcpy(temp, pValue, len);
        temp[len] = '\0';
        return temp;
    }

protected:
public:
    template<class T> friend class DbxMessageBuilder;

    int attribute_cols;     //属性的列数
    int attribute_count;    //属性总数

    //数据结构：|变量数量|变量1类型|变量1的数据|变量2类型|变量2的数据|...|
    int content_offset;     //数据存放位置的偏移量（从当前对象的首地址开始）
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
            //保证vector的内存可以释放掉
            std::vector<Param *>(params).swap(params);
        }
    }

    void beginMessage()
    {
        reset();
    }

    /*
    * 消息填充完成，将所有数据放入新内存
    */
    MessageType * finishMessage()
    {
        int size = sizeof(MessageType) + getParamLen();
        MessageType * p_msg = (MessageType *)malloc(size);
        if (p_msg == NULL) return NULL;
        memset(p_msg, 0, size);

        //设置消息长度
        p_msg->msgLen = (unsigned short)size;
        p_msg->attribute_cols = attribute_cols;
        p_msg->attribute_count = attribute_count;

        int param_count = params.size();
        if (param_count <= 0) return p_msg;

        /*设置内容偏移量，指向结构末尾*/
        p_msg->content_offset = sizeof(MessageType);
        BYTE * wpos = p_msg->getContent();

        //写参数数量
        memcpy(wpos, &param_count, sizeof(int));
        wpos += sizeof(int);

        for (int i = 0; i < param_count; i++)
        {
            //写类型
            memcpy(wpos, &params[i]->type, sizeof(PType));
            wpos += sizeof(PType);

            //写数据
            size = DbxMessage::getTypeSize(params[i]->type);
            memcpy(wpos, params[i]->p_value, size);
            wpos += size;
        }

        //消息写完，把临时数据清理掉
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

        /*属性会按顺序放入到前面，存放的顺序是：
        |属性名1长度|属性名1|属性名2长度|属性名2|...|属性1类型|属性1|属性2类型|属性2|...|其他参数|
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

    void addQueryParam(const char* name, const char* value)
    {
        addAttribute(name, value, strlen(value));
    }

    void addQueryParam(const char* name, int value)
    {
        addAttribute(name, &value, PARAMINT);
    }

    int getParamLen()
    {
        int param_count = params.size();
        if (param_count == 0)
            return 0;

        //放数量的字节 + 放类型长度的字节
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
            p_msg->content_offset = 0;
        }
        else
        {
            /*设置内容存放位置的偏移值，指向结构末尾*/
            p_msg->content_offset = sizeof(MessageType);
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
        int tempsize = 20;  //保证可以放下一个整数/浮点数转为字符串表示之后的尺寸
        char * temp = (char *)malloc(tempsize);
        if (temp == NULL) return NULL;

        for (int index = 0; index < attribute_count; index++)
        {
            std::string name; PType type; const void * pValue;
            getAttribute(name, type, pValue, index);
            int typesize = getTypeSize(type);

            //字符串需要加上结束符
            if (type > 0)
            {
                typesize += 1;
            }

            //调整temp的大小，使其可以容下当前的内容
            if (typesize > tempsize)
            {
                free(temp);
                tempsize = typesize;
                temp = (char *)malloc(tempsize);

                if (temp == NULL)
                    return NULL;
            }

            memset(temp, 0, tempsize);
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

        //拷贝到新地址以便返回
        temp = (char *)malloc(paramstr.length() + 1);
        if (temp == NULL) return NULL;
        strcpy(temp, paramstr.c_str());

        return temp;
    }

public:
    //  int     m_nAttriIndex;  //从第几个参数开始是属性参数
    //  int     m_nAttriNameCount;
    //  int     m_nAttriCount;
    int     m_nTempObjId;  //响应的流水号
    int     m_nSessionId;   //session号
    int     m_spId;         //存储过程ID号
    bool    m_bEnd;
    bool    m_bNeedCallback;
    short   m_nLevel;
};


class CSSResultMsg :public DbxResultMessage
{
public:
    void init()
    {
    }

    void getInit()
    {
        DbxMessageBuilder<CSSResultMsg>::locateContent(this);
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
        DbxMessageBuilder<CCSResultMsg>::locateContent(this);
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
        DbxMessageBuilder<CSCResultMsg>::locateContent(this);
    }
};

#pragma pack(pop)

#endif //__DBX_MSGDEF_
