/*
 * filename 	: UnitConfig.cpp
 * transplanter : chenmin
*/
#include "lindef.h"
#include "vsdef.h"
#include "UnitConfig.h"
#include "LuaFunctor.h"

#define auxCheckValidSet(ss,cls) (assert(cls>=0 && cls < MAX_CLASS_TYPE),ss[cls])
#define auxStrEquals(s1,s2) (strcmp(s1,s2)==0)
#define auxAddProperty(propID,...) ASSERT_(addProperty(__VA_ARGS__) == propID)
#define PropAllocSize 64
#define IdAllocSize 32


CUnitConfig::CUnitConfig(){
}

CUnitConfig &CUnitConfig::Instance(){
	static CUnitConfig instance;
	return instance;
}

bool CUnitConfig::Init(lua_State *L){
	bool bSuccess = LuaFunctor<>::Call(L,"loadUnitConfig");
	if(!bSuccess){
		TRACE1_L0("%s\n",LuaFunctor<>::getLastError());
	}
	return bSuccess;
}

bool CUnitConfig::CopyPropSet(int cls,_PropSet &out){
	_PropSet &set = auxCheckValidSet(m_propSets,cls);
	long count = set.count;
	ASSERT_(set.p && count >= 0);
	if(!set.p || count < 1){
		return false;
	}
	if(out.p){
		delete []out.p;
	}

	out.p = new _Property[count];
	out.count = count;

	for(int i=0;i<count;i++){
		out.p[i] = set.p[i];
	}

	return true;
}

char CUnitConfig::GetPropType(int cls,int propID){
	_PropSet &set = auxCheckValidSet(m_propSets,cls);
	_Property *p = set[propID];
	return p->val.type;
}

const _RefList& CUnitConfig::GetPublicProps(int cls){
	ASSERT_(cls>=0 && cls<MAX_CLASS_TYPE);
	return m_refLists[cls];
}

void CUnitConfig::initPropSet(int cls){
	_PropSet &set = auxCheckValidSet(m_propSets,cls);
	if(set.p){
		delete[] set.p;
	}
	set.count = 0;

	_RefList &pset = m_refLists[cls];
	if(pset.p){
		delete[] pset.p;
	}
	pset.count = 0;

	addSharedProps(cls);
}

void CUnitConfig::addPublicProp(int cls,int propID){
	_RefList &set = m_refLists[cls];
	if(0 == set.count%IdAllocSize){
		BYTE *p = new BYTE[(set.count / IdAllocSize + 1) * IdAllocSize];
		if(set.p){
			memcpy(p,set.p,set.count);
			delete[] set.p;
		}
		set.p = p;
	}
	set.p[set.count++] = (BYTE)propID;
}

int CUnitConfig::addProperty(int cls,const char *type,const char *def,int pub){
	_PropSet &set = auxCheckValidSet(m_propSets,cls);
	ASSERT_(type);

	int count = set.count;
	if(0 == count%PropAllocSize){
		_Property *p = new _Property[ (count / PropAllocSize + 1) * PropAllocSize ];
		if(set.p){
			for(int i=0;i<count;i++){
				p[i] = set.p[i];
			}
			delete[] set.p;
		}
		set.p = p;
	}

	char		ptype	= VAR_NULL;
	const void *ud		= 0;
	size_t		udlen	= 0;

	do{
		if(auxStrEquals(type,"INT")){
			ptype = VAR_INT;
			break;
		}
		if(auxStrEquals(type,"STRING")){
			ptype = VAR_STRING;
			break;
		}
		if(auxStrEquals(type,"SHORT")){
			ptype = VAR_SHORT;
			break;
		}
		if(auxStrEquals(type,"FLOAT")){
			ptype = VAR_FLOAT;
			break;
		}
		if(auxStrEquals(type,"BYTE")){
			ptype = VAR_BYTE;
			break;
		}
		if(auxStrEquals(type,"POSDATA")){
			static char defPosData[PosDataLen];
			static bool inited = false;
			if(!inited){
				_PropPosData _def;
				memcpy(&defPosData,&_def,sizeof(_PropPosData));
				inited = true;
			}
			ptype	= VAR_DATA;
			ud		= defPosData;
			udlen	= PosDataLen;
			break;
		}
		if(auxStrEquals(type,"LONGLONG")){
			ptype = VAR_LONGLONG;
			break;
		}
		ASSERT_(0);
	}while(false);

	set.count = count + 1;
	_Property *prop	= set[count];
	prop->val.type	= ptype;
	switch(ptype){
		case VAR_NULL:
			break;
		case VAR_BYTE:
			prop->val.cVal = atoi(def);
			break;
		case VAR_SHORT:
			prop->val.sVal = atoi(def);
			break;
		case VAR_INT:
			prop->val.iVal = atoi(def);
			break;
		case VAR_LONGLONG:
			prop->val.llVal = atoi(def);
			break;
		case VAR_STRING:
			prop->val.Set(def);
			break;
		case VAR_FLOAT:
			prop->val.fVal = (float)atof(def);
			break;
		case VAR_DATA:
			prop->val.Set(ud,udlen);
			//do nothing?i think there should be some memory alloc...
			break;
	}

	prop->radius	= 0;

	if(pub > 0){//whether it be a public property
		prop->radius = 1;
		addPublicProp(cls,count);
	}
	return count;
}

/*
 * 所有C++实体共有的PROP定义
*/
void CUnitConfig::addSharedProps(int cls){
	ASSERT_(cls >= 0 && cls < MAX_CLASS_TYPE);

	auxAddProperty(UNIT_STATUS,     cls,"BYTE",	   "0",PROP_PUBLIC);
	auxAddProperty(UNIT_POS,        cls,"POSDATA", "0",PROP_PUBLIC);
	auxAddProperty(UNIT_MOVE_SPEED, cls,"SHORT",  "40",PROP_PUBLIC);
}

void CUnitConfig::Close(){
}

