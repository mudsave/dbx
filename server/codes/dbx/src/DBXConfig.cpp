/*
Written by wangshufeng.
RTX:6016.
描述：

*/

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
        TRACE2_ERROR("DBXConfig::LoadConfig:Cant load xml file %s:%s.\n", p_filePath.c_str(), doc.ErrorDesc());
        return false;
    }

    TiXmlElement *rootElement = doc.RootElement();
    if (rootElement == NULL)
    {
        TRACE1_ERROR("DBXConfig::LoadConfig:%s has not root element.\n", p_filePath.c_str());
        return false;
    }

    TiXmlElement *databaseElem = rootElement->FirstChildElement();
    for (; databaseElem != NULL; databaseElem = databaseElem->NextSiblingElement())
    {
        DBInterfaceInfo dbinfo;
        dbinfo.id = GetElementAttributeInt(databaseElem, "databaseid");
        strncpy((char *)&dbinfo.db_type, GetElementAttributeStr(databaseElem, "type").c_str(), DBX_MAX_BUF);

        TiXmlElement *baseinfo = databaseElem->FirstChildElement("baseinfo");
        if (baseinfo != NULL)
        {
            strncpy((char *)&dbinfo.db_ip, GetElementAttributeStr(baseinfo, "servername").c_str(), DBX_MAX_BUF);
            strncpy((char *)&dbinfo.db_name, GetElementAttributeStr(baseinfo, "databasename").c_str(), DBX_MAX_NAME);
            dbinfo.db_port = GetElementAttributeInt(baseinfo, "port");
        }

        TiXmlElement *popedom = databaseElem->FirstChildElement("popedom");
        if (popedom != NULL)
        {
            strncpy((char *)&dbinfo.db_username, GetElementAttributeStr(popedom, "username").c_str(), DBX_MAX_NAME);
            strncpy((char *)&dbinfo.db_password, GetElementAttributeStr(popedom, "password").c_str(), DBX_MAX_BUF);
        }

        TiXmlElement *asynqueue = databaseElem->FirstChildElement("asynqueue");
        if (asynqueue != NULL)
            dbinfo.db_connectionsNum = GetElementAttributeInt(asynqueue, "num");

        m_interfaceInfos.push_back(dbinfo);
    }

    return true;

}

std::string DBXConfig::GetElementAttributeStr(TiXmlElement *p_element, const char *p_key)
{
    const char *attr = p_element->Attribute(p_key);
    if (attr == NULL)
    {
        TRACE2_ERROR("DBXConfig::GetElementAttributeStr:cant find attribute %s from element %s\n", p_key, p_element->Value());
        return "";
    }
        
    return attr;
}

int DBXConfig::GetElementAttributeInt(TiXmlElement *p_element, const char *p_key)
{
    const char *attr = p_element->Attribute(p_key);
    if (attr == NULL)
    {
        TRACE2_ERROR("DBXConfig::GetElementAttributeInt: cant find attribute %s from element %s\n", p_key, p_element->Value());
        return 0;
    }
    return atoi(attr);
}

DBInterfaceInfo *DBXConfig::GetDBInterfaceInfo(int p_dbInterfaceID)
{
    std::vector<DBInterfaceInfo>::iterator iter = m_interfaceInfos.begin();
    for (; iter != m_interfaceInfos.end(); ++iter)
    {
        if (iter->id == p_dbInterfaceID)
        {
            return &(*iter);
        }
    }

    return NULL;
}

DBXConfig::DB_INTERFACE_INFOS const &DBXConfig::GetAllDBInterfaceInfo()
{
    return m_interfaceInfos;
}