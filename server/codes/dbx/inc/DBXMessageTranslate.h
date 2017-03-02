#ifndef __DBX_MESSAGE_TRANSLATE_
#define __DBX_MESSAGE_TRANSLATE_

#include "lindef.h" // 包含lindef.h来使用trace.h
#include "dbx_msgdef.h"
//mysql
//#include "m_string.h"
#include "mysql.h"
//std
#include <list>
#include <string>
#include <map>
using namespace std;


// 最大参数名称长度
#define MAX_PARAMNAME_LEN           32

// QueryBuffer长度
#define QUERYBUFFER_MAX_LEN         1024 * 128

// 参数方向定义
enum
{
    PARAM_DIR_IN = 0,               /// 输入参数
    PARAM_DIR_OUT,                  /// 输出参数
};

// 输出数据
struct SOutParam
{
    char szVariableName[MAX_PARAMNAME_LEN]; // 输出变量名
    PType nDataType;                        // 数据类型

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
    char szVariableName[MAX_PARAMNAME_LEN]; // 参数名
    int nDataDir;                           // 参数方向
    PType nDataType;                        // 数据类型
    const void * pvData;                    // 数据

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

    SParam(const char * vname, const PType & type, const void * data) :
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
typedef std::map<char *, SParam, SCharPtrCmp> TMapParam;


char * strmov(char * dst, const char * src);

void upper_first_char(char * buffer);

void lower_first_char(char * buffer);

bool build_sql_query_buffer(CCSResultMsg & message, const int & row, char * pBuffer);

bool build_sp_query_buffer(MYSQL * pMysql, CCSResultMsg * pMessage, const int & row,
    char * pBuffer/*out*/, int & nBufferLen/*in-out*/, TListOutput & outParams/*out*/);

bool translate_sql_result_mysql(const char * pData, CSCResultMsg & message);

bool translate_sp_result_mysql(const char * pData, CSCResultMsg & message);

#endif //__DBX_MESSAGE_TRANSLATE_
