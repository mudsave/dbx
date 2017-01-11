#ifndef __DB_INTERFACE_H_
#define __DB_INTERFACE_H_

// @note by wangshufeng.
// for AppMsg。AppMsg在msgdef.h中声明，但却需要包含vsdef.h，因为msgdef.h中的一些声明依赖于vsdef.h，不能独立使用，vsdef.h在文件尾包含了msgdef.h。
#include "lindef.h"
#include "vsdef.h"

class DBInterface
{
    virtual bool Query(const char *p_cmd, int p_size, AppMsg *p_appMsg) = 0;
};



#endif // end of __DB_INTERFACE_H_