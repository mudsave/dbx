#ifndef __UNIT_CONFIG_H__
#define __UNIT_CONFIG_H__

#include "PropertySet.h"

class CUnitConfig {
public:
	static	CUnitConfig &Instance();
	~CUnitConfig();
public:
	bool	CopyPropSet(int cls,_PropSet &out);
public:
	int		addProperty(int cls,const char *szType,const char *szDef,int bPub,int bSync,const char *szName);
private:
	CUnitConfig();
private:
	_PropSet m_propSets[MAX_CLASS_TYPE];
};

#endif
