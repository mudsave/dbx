#ifndef __UNIT_CONFIG_H__
#define __UNIT_CONFIG_H__

#include "PropertySet.h"

#define PROP_PRIVATE	0
#define PROP_PUBLIC		1

struct lua_State;

class CUnitConfig {
public:
	static	CUnitConfig &Instance();
public:
	bool	Init(lua_State *L);
	void	Close();
	bool	CopyPropSet(int cls,_PropSet &out);
	const	_RefList& GetPublicProps(int cls);
	char	GetPropType(int cls,int propID);
public:
	void	initPropSet(int cls);
	int		addProperty(int cls,const char *type,const char *def,int bPub,int bSync);
private:
	void	addPublicProp(int cls,int propID);
	void	addSharedProps(int cls);
private:
	CUnitConfig();
private:
	_PropSet m_propSets[MAX_CLASS_TYPE];
	_RefList m_refLists[MAX_CLASS_TYPE];
};

#endif
