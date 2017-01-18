#include "lindef.h"
#include "tolua++.h"
#include "PropertyUtils.h"
#include "Entity.h"

static int getPropValue(lua_State *L){
	CoEntity *pEntity = (CoEntity *)tolua_tousertype(L,1,0);
	long propID = (long)luaL_checkinteger(L,2);

	if(!pEntity){
		luaL_error(L,"[getPropValue] #1 excepted a CoEntity Instance,got null");
	}
	if(propID < 0 || propID >= pEntity->m_propSet.count){
		luaL_error(L,"[getPropValue] #2 out of range:%d",propID);
	}

	_Property *property = pEntity->getProperty(propID);
	switch(property->val.type){
		case VAR_BYTE:
			lua_pushinteger(L,property->val.cVal);
			break;
		case VAR_SHORT:
			lua_pushinteger(L,property->val.sVal);
			break;
		case VAR_INT:
			lua_pushinteger(L,property->val.iVal);
			break;
		case VAR_LONGLONG:
			lua_pushinteger(L,property->val.llVal);
			break;
		case VAR_FLOAT:
			lua_pushnumber(L,property->val.fVal);
			break;
		case VAR_STRING:
			lua_pushstring(L,(const char *)property->val.dataVal);
			break;
		case VAR_DATA:
			lua_pushlightuserdata(L,property->val.dataVal);
			break;
		default:
			luaL_error(L,"[getPropValue] unsupport Variant type:%d",property->val.type);
	}
	return 1;
}

static int setPropValue(lua_State *L){
	CoEntity *pEntity = (CoEntity *)tolua_tousertype(L,1,0);
	if(!pEntity){
		luaL_error(L,"[setPropValue] #1 excepted a CoEntity Instance,got null");
	}
	long propID = (long)luaL_checkinteger(L,2);
	if(propID < 0 || propID >= pEntity->m_propSet.count){
		luaL_error(L,"[setPropValue] #2 out of range:%d",propID);
	}

	bool bPropChanged = true;
	_Property *property = pEntity->m_propSet[propID];
	switch(property->val.type){
		case VAR_BYTE:
			property->val.cVal = (char)luaL_checkinteger(L,3);
			break;
		case VAR_SHORT:
			property->val.sVal = (short)luaL_checkinteger(L,3);
			break;
		case VAR_INT:
			property->val.iVal = (int)luaL_checkinteger(L,3);
			break;
		case VAR_LONGLONG:
			property->val.llVal = (long long)luaL_checkinteger(L,3);
			break;
		case VAR_FLOAT:
			property->val.fVal = (float)luaL_checknumber(L,3);
			break;
		case VAR_STRING:{
				size_t len;
				const char *str = luaL_checklstring(L,3,&len);
				property->val.Set(str,len);
			}
			break;
		case VAR_DATA:
			//Bad design
			if(!lua_isuserdata(L,3)){
				luaL_error(L,"[setPropValue] #3 excepted a userdata,got %s",lua_typename(L,lua_type(L,3)));
			}
			property->val.Set((const void *)tolua_touserdata(L,3,0));
			break;
		case VAR_NULL:
			bPropChanged = false;
			break;
		default:
			luaL_error(L,"[setPropValue] unsupport Variant type:%d",property->val.type);
	}
	if(bPropChanged){
		pEntity->PropValChanged(propID);
	}
	return 0;
}

static int flushPropBatch(lua_State *L){
	CoEntity *pEntity = (CoEntity *)tolua_tousertype(L,1,0);
	if(!pEntity){
		luaL_error(L,"[flushPropBatch] #1 excepted a CoEntity instance,got null");
	}
	handle hSendTo = lua_tointeger(L,2);
	if(lua_toboolean(L,3)){
		pEntity->bcAllProps(hSendTo);
	}
	else{
		pEntity->bcPropUpdates(hSendTo);
	}
	return 0;
}

int lua_PropertySet_open(lua_State *L){
	tolua_open(L);
	tolua_module(L,0,0);
	tolua_beginmodule(L,0);
	tolua_function(L,"getPropValue",getPropValue);
	tolua_function(L,"setPropValue",setPropValue);
	tolua_function(L,"flushPropBatch",flushPropBatch);
	tolua_endmodule(L);
	return 1;
}
