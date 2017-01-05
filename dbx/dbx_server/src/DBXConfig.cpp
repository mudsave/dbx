#include "DBXConfig.h"

#include <string>

//#include "trace.h"
#include "lindef.h" // for trace.h

bool DBXConfig::LoadConfig(std::string p_filePath)
{
    TRACE1_L0("DBXConfig::LoadConfig:%s...\n", p_filePath.c_str());
    TiXmlDocument doc;
    bool loadOK = doc.LoadFile(p_filePath.c_str());
    if (!loadOK)
    {
        TRACE2_L0("DBXConfig::LoadConfig:[Error]:Cant load xml file %s:%s.\n", p_filePath.c_str(), doc.ErrorDesc());
        return false;
    }

    TiXmlElement *rootElement = doc.RootElement();
    if (rootElement == NULL)
    {
        TRACE1_L0("DBXConfig::LoadConfig:[Error]:%s has not root element.\n", p_filePath.c_str());
        return false;
    }

    TiXmlElement *databaseElem = rootElement->FirstChildElement();
    for (; databaseElem != NULL; databaseElem = databaseElem->NextSiblingElement())
    {
        DBInterfaceInfo dbinfo;

        dbinfo.id = GetElementAttributeInt(databaseElem, "databaseid");
        TiXmlElement *baseinfor = databaseElem->FirstChildElement("baseinfor");
        if (baseinfor != NULL)
        {
            strncpy((char *)&dbinfo.db_ip, GetElementAttributeStr(baseinfor, "servername").c_str(), DBX_MAX_NAME);
            strncpy((char *)&dbinfo.db_name, GetElementAttributeStr(baseinfor, "databasename").c_str(), DBX_MAX_NAME);
            dbinfo.db_port = GetElementAttributeInt(baseinfor, "port");
        }

        TiXmlElement *popedom = databaseElem->FirstChildElement("popedom");
        if (popedom != NULL)
        {
            strncpy((char *)&dbinfo.db_username, GetElementAttributeStr(popedom, "username").c_str(), DBX_MAX_NAME);
            strncpy((char *)&dbinfo.db_password, GetElementAttributeStr(popedom, "password").c_str(), DBX_MAX_NAME);
        }

        TiXmlElement *asynqueue = databaseElem->FirstChildElement("asynqueue");
        if (asynqueue != NULL)
        {
            dbinfo.db_connectionsNum = GetElementAttributeInt(asynqueue, "num");
        }

        m_interfaceInfos.push_back(dbinfo);
    }

    return true;

}