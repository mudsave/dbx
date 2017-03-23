/*
 * filename 	: UnitConfig.cpp
 * transplanter : chenmin
*/
#include "lindef.h"
#include "vsdef.h"
#include "UnitConfig.h"

#define CheckValidSet(list,index) ( (index < MAX_CLASS_TYPE && index >= 0) ? list + index : 0 )
#define StrEquals(_1,_2) ( strcmp( _1 , _2 ) == 0 )
#define AddProperty(propID,...) ASSERT_(addProperty(__VA_ARGS__) == propID)
#define PropAllocSize 64

CUnitConfig &CUnitConfig::Instance(){
	static CUnitConfig instance;
	return instance;
}

CUnitConfig::CUnitConfig(){
	for(int i=0;i<MAX_CLASS_TYPE;i++){
		AddProperty(UNIT_STATUS,     i,"BYTE",	"0",	Public,	Sync,	"UNIT_STATUS");
		AddProperty(UNIT_POS,        i,"POSDATA", "0",	Public,	Sync,	"UNIT_POS");
		AddProperty(UNIT_MOVE_SPEED, i,"SHORT",  "40",	Public,	Sync,	"UNIT_MOVE_SPEED");
	}
}

CUnitConfig::~CUnitConfig(){
	for(int i=0;i<MAX_CLASS_TYPE;i++){
		_PropSet *set = m_propSets + i;
		for(int id = 0;id < set->count;id++){
			_Property *p = (*set)[id];
			if(p->name){
				delete[] (char *)p->name;
			}
		}
	}
}

bool CUnitConfig::CopyPropSet(int cls,_PropSet &out){
	_PropSet *set = CheckValidSet(m_propSets,cls);
	if( !set || set->count < 1 || !set->p ){
		TRACE1_L0("[CUnitConfig::CopyPropSet] 出错:%d对应的同步集合模板无效\n",cls);
		return false;
	}
	if(out.p){
		delete []out.p;
	}

	int count = set->count;
	out.p = new _Property[count];
	out.count = count;

	for(int i=0;i<count;i++){
		*( out[i] ) = *( *set )[i];
	}

	return true;
}


int CUnitConfig::addProperty(int cls,const char *szType,const char *szDef,int bPub,int bSync,const char *szName){
	_PropSet *set = CheckValidSet(m_propSets,cls);
	if(!set){
		TRACE1_L0("CUnitConfig::addProperty 出错:无效的同步集合%d\n",cls);
		return -1;
	}

	int count = set->count;
	if(0 == count % PropAllocSize){
		_Property *p = new _Property[ (count / PropAllocSize + 1) * PropAllocSize ];
		if(set->p){
			for(int i=0;i<count;i++){
				p[ i ] = set->p[i];
			}
			delete[] set->p;
		}
		set->p = p;
	}

	char		ptype	= VAR_NULL;
	const void *ud		= 0;
	size_t		udlen	= 0;

	do{
		if(StrEquals(szType,"INT")){
			ptype = VAR_INT;
			break;
		}
		if(StrEquals(szType,"STRING")){
			ptype = VAR_STRING;
			break;
		}
		if(StrEquals(szType,"SHORT")){
			ptype = VAR_SHORT;
			break;
		}
		if(StrEquals(szType,"FLOAT")){
			ptype = VAR_FLOAT;
			break;
		}
		if(StrEquals(szType,"BYTE")){
			ptype = VAR_BYTE;
			break;
		}
		if(StrEquals(szType,"POSDATA")){
			static char defPosData[PosDataLen];
			static bool inited = false;
			if(!inited){
				_PropPosData _def = 
				{
					false,  //bMove
					1,      //len
					0,      //idx
					0,      //delay
					0,      //step
					true,   //endPath
				};
				memcpy(&defPosData,&_def,sizeof(_PropPosData));
				inited = true;
			}
			ptype	= VAR_DATA;
			ud		= defPosData;
			udlen	= PosDataLen;
			break;
		}
		if(StrEquals(szType,"LONGLONG")){
			ptype = VAR_LONGLONG;
			break;
		}
		return -2;
	}while(false);

	_Property *prop	= set->p + count;

	prop->type(ptype);
	prop->radius	= bPub ? 1 : 0;
	prop->sync		= bSync ? 1 : 0;
	prop->name		= strcpy( new char[strlen(szName) + 1],szName );

	do {
		if(VAR_NULL < ptype && VAR_FLOAT > ptype ){
			prop->setValue(atoi(szDef));
			break;
		}
		if( VAR_FLOAT == ptype ){
			prop->setValue(atof(szDef));
			break;
		}
		if( VAR_STRING == ptype ){
			prop->setValue(szDef);
			break;
		}
		if( VAR_DATA == ptype ){
			prop->setValue(ud,udlen);
			break;
		}
		return -2;
	}while(false);

	set->count = count + 1;

	// 返回索引作为ID
	return count;
}

