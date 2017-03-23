/*
 * filename		: PropertySet.h
 * transplant	: chenmin
*/
#ifndef __PROPERTY_SET_H__
#define __PROPERTY_SET_H__

#include "lindef.h"
#include "vsdef.h"
#include "Variant.h"
#include <cstdarg>

#define Private		0
#define Public		1
#define Postpone	0
#define Sync		1

struct _Property{
	Variant val;
	short radius;		//whether a property is public,true if radius bigger than 0
	short update;		//times that property has been modified
	short casted;		//times that property has been broadcasted
	short sync;			//sync or not
	const char *name;	//name

	_Property():radius(0),update(0),casted(0),name(0){
	}
	inline int type() const {
		return val.type;
	}
	inline void type(int type) {
		val.type = type;
	}
	template<typename T>
	inline bool setValue(T value){
		int t = type();
		ASSERT_( t >= VAR_BYTE && t <= VAR_FLOAT );
		if( t < VAR_BYTE || t > VAR_FLOAT ){
			return false;
		}
		switch( t )	{
			case VAR_BYTE:
				val.cVal = value;
				break;
			case VAR_SHORT:
				val.sVal = value;
				break;
			case VAR_INT:
				val.iVal = value;
				break;
			case VAR_LONGLONG:
				val.llVal = value;
				break;
			case VAR_FLOAT:
				val.fVal = value;
				break;
		}
		return true;
	}
	inline bool setValue(const char *str,size_t len = 0){
		ASSERT_( type() == VAR_STRING );
		if( type() != VAR_STRING ){
			return false;
		}
		val.Set(str,len);
		return true;
	}
	inline bool setValue(const void *ptr,size_t len = 0){
		ASSERT_( type() == VAR_DATA);
		if( type() != VAR_DATA ){
			return false;
		}
		val.Set(ptr,len);
		return true;
	}
};

typedef _CountedArray<_Property> _PropSet;

class PropertySet{
public:
	inline int getPropCount(){
		return m_propSet.count;
	}
	inline _Property *getProperty(long propID){
		return m_propSet[propID];
	}
	const char *getPropName(int propID){
		_Property *p = getProperty(propID);
		return p?p->name:"invalid property";
	}
	template<typename T>
	bool SetPropNumber(int propID,T value){
		_Property *p = getProperty(propID);
		if( p && p->setValue(value) ){
			PropValChanged(propID);
			return true;
		}
		return false;
	}
	bool SetPropData(int propID,const void *ptr,size_t len = 0){
		_Property *p = getProperty(propID);
		if( p && p->setValue(ptr,len) ){
			PropValChanged(propID);
			return true;
		}
		return false;
	}
	bool SetPropData(int propID,const char *str,size_t len = 0){
		_Property *p = getProperty(propID);
		if( p && p->setValue(str,len) ){
			PropValChanged(propID);
			return true;
		}
		return false;
	}
	void PropValChanged(int propID){
		_Property *p = getProperty(propID);
		if(p){
			p->update++;
			onPropValChanged(propID);
		}
	}
	virtual void onPropValChanged(int propID) = 0;
protected:
	_PropSet m_propSet;
};

/*
	高兴是种偏见,视不开心为不幸,却把快乐当成必然,
*/
#endif
