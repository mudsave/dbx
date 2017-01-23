/**
 * filename : Version.h
 * desc :  消息版本号生成
 */

#ifndef __VERSION_H
#define __VERSION_H

int GenerateVersionNum()
{
	static int s_version = 0;
	s_version++;
	return s_version;
}

#endif
