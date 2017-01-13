#include "DBCommon.h"


namespace DBXCommon
{
    char *DBXStrncpy(char *dststr, const char *srcstr, size_t size)
    {
        char *result = strncpy(dststr, srcstr, size);
        result[size - 1] = '\0';
        return result;
    }

}   // end of namespace DBXCommon