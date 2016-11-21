/*
 * filename		: PropertySet.h
 * transplant	: chenmin
*/
#ifndef __PROPERTY_SET_H__
#define __PROPERTY_SET_H__

#include "lindef.h"
#include "vsdef.h"
#include "Variant.h"

struct _Property{
	Variant val;
	short radius;	//such a Property is public,true if radius bigger than 0
	short update;	//times that property has been modified
	short casted;	//times that property has been broadcasted
	_Property():radius(0),update(0),casted(0){}
};

typedef _CountedArray<_Property>	_PropSet;
typedef _CountedArray<BYTE>			_RefList;

#define auxCheckProp(p,t) (assert(p && t==p->val.type),(p && t==p->val.type))

class PropertySet{
public:
	HRESULT SetPropByte(long propID,char cVal){
		_Property *prop = m_propSet[propID];
		if(auxCheckProp(prop,VAR_BYTE)){
			prop->val.cVal = cVal;
			PropValChanged(propID);
			return S_OK;
		}
		return E_FAIL;
	}
	HRESULT GetPropByte(long propID,char *cVal){
		_Property *prop = m_propSet[propID];
		if(auxCheckProp(prop,VAR_BYTE)){
			*cVal = prop->val.cVal;
			return S_OK;
		}
		return E_FAIL;
	}
	HRESULT SetPropShort(long propID,short sVal){
		_Property *prop = m_propSet[propID];
		if(auxCheckProp(prop,VAR_SHORT)){
			prop->val.sVal = sVal;
			PropValChanged(propID);
			return S_OK;
		}
		return E_FAIL;
	}
	HRESULT GetPropShort(long propID,short *sVal){
		_Property *prop = m_propSet[propID];
		if(auxCheckProp(prop,VAR_SHORT)){
			*sVal = prop->val.sVal;
			return S_OK;
		}
		return E_FAIL;
	}
	HRESULT SetPropInt(long propID,int iVal){
		_Property *prop = m_propSet[propID];
		if(auxCheckProp(prop,VAR_INT)){
			prop->val.iVal = iVal;
			PropValChanged(propID);
			return S_OK;
		}
		return E_FAIL;
	}
	HRESULT GetPropInt(long propID,int *iVal){
		_Property *prop = m_propSet[propID];
		if(auxCheckProp(prop,VAR_INT)){
			*iVal = prop->val.iVal;
			return S_OK;
		}
		return E_FAIL;
	}
	HRESULT SetPropLonglong(long propID,long long llVal){
		_Property *prop = m_propSet[propID];
		if(auxCheckProp(prop,VAR_LONGLONG)){
			prop->val.llVal = llVal;
			PropValChanged(propID);
			return S_OK;
		}
		return E_FAIL;
	}
	HRESULT GetPropLonglong(long propID,long long *llVal){
		_Property *prop = m_propSet[propID];
		if(auxCheckProp(prop,VAR_LONGLONG)){
			*llVal = prop->val.llVal;
			return S_OK;
		}
		return E_FAIL;
	}
	HRESULT SetPropFloat(long propID,float fVal){
		_Property *prop = m_propSet[propID];
		if(auxCheckProp(prop,VAR_FLOAT)){
			prop->val.fVal = fVal;
			PropValChanged(propID);
			return S_OK;
		}
		return E_FAIL;
	}
	HRESULT GetPropFloat(long propID,float *fVal){
		_Property *prop = m_propSet[propID];
		if(auxCheckProp(prop,VAR_FLOAT)){
			*fVal = prop->val.fVal;
			return S_OK;
		}
		return E_FAIL;
	}
	HRESULT SetPropString(long propID,const char *pVal,long len){
		_Property *prop = m_propSet[propID];
		if(auxCheckProp(prop,VAR_STRING)){
			prop->val.Set(pVal,len);
			PropValChanged(propID);
			return S_OK;
		}
		return E_FAIL;
	}
	HRESULT GetPropStringLen(long propID,long *pLen){
		_Property *prop = m_propSet[propID];
		if(auxCheckProp(prop,VAR_STRING)){
			*pLen = prop->val.length;
			return S_OK;
		}
		return E_FAIL;
	}
	HRESULT GetPropString(long propID,char *pVal,long *pLen){
		_Property *prop = m_propSet[propID];
		if(auxCheckProp(prop,VAR_STRING)){
			int copied = prop->val.Get(pVal,*pLen);
			if(copied < 0){
				return E_FAIL;
			}
			*pLen = copied;
			return S_OK;
		}
		return E_FAIL;
	}
	HRESULT SetPropData(long propID,const void *pVal,long len){	
		_Property *prop = m_propSet[propID];
		if(auxCheckProp(prop,VAR_DATA)){
			prop->val.Set(pVal,len);
			PropValChanged(propID);
			return S_OK;
		}
		return E_FAIL;
	}
	HRESULT GetPropData(long propID,void *pVal,long *pLen){
		_Property *prop = m_propSet[propID];
		if(auxCheckProp(prop,VAR_DATA)){
			int copied = prop->val.Get(pVal,*pLen);
			*pLen = copied;
			return S_OK;
		}
		return E_FAIL;
	}

public:
	long GetPropCount(){
		return m_propSet.count;
	}
	_Property *getProperty(long propID){
		return m_propSet[propID];
	}
	const char *GetPropName(long propID){
		return NULL;
	}
	char GetPropType(long propID){
		ASSERT_(propID < m_propSet.count);
		if(propID < m_propSet.count){
			return m_propSet[propID]->val.type;
		}
		return VAR_NULL;
	}
public:
	short DestX(){
		_PropPosData *pPosData = (_PropPosData *)m_propSet[UNIT_POS]->val.dataVal;
		return pPosData->path[pPosData->len - 1].x;
	}
	short DestY(){	
		_PropPosData *pPosData = (_PropPosData *)m_propSet[UNIT_POS]->val.dataVal;
		return pPosData->path[pPosData->len - 1].y;
	}
public:
	virtual void PropValChanged(int propID)=0;
public:
	_PropSet m_propSet;
};


#endif
