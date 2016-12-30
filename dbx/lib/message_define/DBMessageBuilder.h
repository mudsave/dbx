#ifndef __MESSAGE_BUILDER_H_
#define __MESSAGE_BUILDER_H_

// @note by wangshufeng.
// for AppMsg。AppMsg在msgdef.h中声明，但却需要包含vsdef.h，因为msgdef.h中的一些声明依赖于vsdef.h，不能独立使用，vsdef.h在文件尾包含了msgdef.h。
#include "lindef.h"
#include "vsdef.h"

#include "DBXClientMessage.h"


class DBMessageBuilder
{
public:
    static DBXClientMessage *BuildDBXMessage(AppMsg *p_appMsg)
    {}
};

#endif // __MESSAGE_BUILDER_H_