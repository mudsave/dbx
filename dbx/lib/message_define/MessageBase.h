#ifndef __MESSAGE_BASE_H_
#define __MESSAGE_BASE_H_

// @note by wangshufeng.
// for AppMsg。AppMsg在msgdef.h中声明，但却需要包含vsdef.h，因为msgdef.h中的一些声明依赖于vsdef.h，不能独立使用，vsdef.h在文件尾包含了msgdef.h。
#include "vsdef.h"

class MessageBase
{
public:
    void Build()
    {}

protected:
    
};


#endif // __MESSAGE_BASE_H_