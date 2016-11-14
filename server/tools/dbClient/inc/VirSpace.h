// VirSpace.h :
#pragma once

#include "vsdeftemp.h"

/// 属性类型
/**
*/
enum _UnitPropType
{
	PT_CHAR,			/**< 单个字符 */
	PT_SHORT,			/**< 16位短整数 */
	PT_LONG,			/**< 32位长整数 */
	PT_LONGLONG,		/**< 64位整数 */
	PT_BYTE,			/**< 单个字节 */
	PT_USHORT,			/**< 16位无符号短整数 */
	PT_ULONG,			/**< 32位无符号长整数 */
	PT_ULONGLONG,		/**< 64位无符号整数 */
	PT_FLOAT,			/**< 32位浮点数 */
	PT_DOUBLE,			/**< 64位双精度浮点数 */
	PT_STRING,			/**< 字符串 */
	PT_DATA				/**< 数据块 */
};
