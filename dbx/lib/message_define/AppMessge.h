#ifndef __APP_MESSAGE_H_
#define __APP_MESSAGE_H_

// @note by wangshufeng.
// for AppMsg。AppMsg在msgdef.h中声明，但却需要包含vsdef.h，因为msgdef.h中的一些声明依赖于vsdef.h，不能独立使用，vsdef.h在文件尾包含了msgdef.h。
#include "vsdef.h"

#include "MessageBase.h"

// 基于AppMsg的新协议封装
class AppMessage : public MessageBase
{
protected:
    AppMsg m_appMsg;
};

#endif  // __APP_MESSAGE_H_