#ifndef __DB_COMMON_H_
#define __DB_COMMON_H_

#include <string.h>

#define DBX_MAX_BUF 256     // 常规buff的最大长度
#define DBX_MAX_NAME 256    // 名称字符串的最大长度

namespace DBXCommon
{
    // 安全的字符串复制，确保最后一个字符是'\0'
    char *DBXStrncpy(char *dststr, const char *srcstr, size_t size);


}   // end of namespace DBXCommon

#endif // end of __DB_COMMON_H_