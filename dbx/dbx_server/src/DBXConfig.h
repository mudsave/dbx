#ifndef __DBX_CONFIG_H_
#define __DBX_CONFIG_H_

#include <string>

#include "Singleton.h"


class DBXConfig: public Singleton<DBXConfig>
{
public:
    bool LoadConfig(std::string p_filePath);
};


#define g_dbxServerConfig DBXConfig::Instance()

#endif  // __DBX_CONFIG_H_