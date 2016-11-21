/*
** Lua binding: api4lua
** Generated automatically by tolua++-1.0.92 on Fri Nov 18 17:53:15 2016.
*/

#ifndef __cplusplus
#include "stdlib.h"
#endif
#include "string.h"

#include "tolua++.h"

/* Exported function */
TOLUA_API int  tolua_api4lua_open (lua_State* tolua_S);

#include "lindef.h"
#include "vsdef.h"
#include "UnitConfig.h"
#include "Entity.h"
#include "world.h"
#include "Scene.h"

/* function to release collected object via destructor */
#ifdef __cplusplus

static int tolua_collect_GridVct (lua_State* tolua_S)
{
 GridVct* self = (GridVct*) tolua_tousertype(tolua_S,1,0);
	Mtolua_delete(self);
	return 0;
}
#endif


/* function to register type */
static void tolua_reg_types (lua_State* tolua_S)
{
 tolua_usertype(tolua_S,"CoEntity");
 tolua_usertype(tolua_S,"GridVct");
 tolua_usertype(tolua_S,"_MsgGW_PlayerLoginInfo");
 tolua_usertype(tolua_S,"AppMsg");
 tolua_usertype(tolua_S,"CoScene");
 tolua_usertype(tolua_S,"_MsgGW_PlayerLogoutInfo");
 tolua_usertype(tolua_S,"CWorld");
 tolua_usertype(tolua_S,"_PropPosData");
 tolua_usertype(tolua_S,"_MsgWG_PlayerLogin_ResultInfo");
 tolua_usertype(tolua_S,"CUnitConfig");
}

/* get function: msgLen of class  AppMsg */
#ifndef TOLUA_DISABLE_tolua_get_AppMsg_unsigned_msgLen
static int tolua_get_AppMsg_unsigned_msgLen(lua_State* tolua_S)
{
  AppMsg* self = (AppMsg*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in accessing variable 'msgLen'",NULL);
#endif
  tolua_pushnumber(tolua_S,(lua_Number)self->msgLen);
 return 1;
}
#endif //#ifndef TOLUA_DISABLE

/* set function: msgLen of class  AppMsg */
#ifndef TOLUA_DISABLE_tolua_set_AppMsg_unsigned_msgLen
static int tolua_set_AppMsg_unsigned_msgLen(lua_State* tolua_S)
{
  AppMsg* self = (AppMsg*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  tolua_Error tolua_err;
  if (!self) tolua_error(tolua_S,"invalid 'self' in accessing variable 'msgLen'",NULL);
  if (!tolua_isnumber(tolua_S,2,0,&tolua_err))
   tolua_error(tolua_S,"#vinvalid type in variable assignment.",&tolua_err);
#endif
  self->msgLen = ((unsigned short)  tolua_tonumber(tolua_S,2,0))
;
 return 0;
}
#endif //#ifndef TOLUA_DISABLE

/* get function: msgFlags of class  AppMsg */
#ifndef TOLUA_DISABLE_tolua_get_AppMsg_unsigned_msgFlags
static int tolua_get_AppMsg_unsigned_msgFlags(lua_State* tolua_S)
{
  AppMsg* self = (AppMsg*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in accessing variable 'msgFlags'",NULL);
#endif
  tolua_pushnumber(tolua_S,(lua_Number)self->msgFlags);
 return 1;
}
#endif //#ifndef TOLUA_DISABLE

/* set function: msgFlags of class  AppMsg */
#ifndef TOLUA_DISABLE_tolua_set_AppMsg_unsigned_msgFlags
static int tolua_set_AppMsg_unsigned_msgFlags(lua_State* tolua_S)
{
  AppMsg* self = (AppMsg*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  tolua_Error tolua_err;
  if (!self) tolua_error(tolua_S,"invalid 'self' in accessing variable 'msgFlags'",NULL);
  if (!tolua_isnumber(tolua_S,2,0,&tolua_err))
   tolua_error(tolua_S,"#vinvalid type in variable assignment.",&tolua_err);
#endif
  self->msgFlags = ((unsigned char)  tolua_tonumber(tolua_S,2,0))
;
 return 0;
}
#endif //#ifndef TOLUA_DISABLE

/* get function: msgCls of class  AppMsg */
#ifndef TOLUA_DISABLE_tolua_get_AppMsg_unsigned_msgCls
static int tolua_get_AppMsg_unsigned_msgCls(lua_State* tolua_S)
{
  AppMsg* self = (AppMsg*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in accessing variable 'msgCls'",NULL);
#endif
  tolua_pushnumber(tolua_S,(lua_Number)self->msgCls);
 return 1;
}
#endif //#ifndef TOLUA_DISABLE

/* set function: msgCls of class  AppMsg */
#ifndef TOLUA_DISABLE_tolua_set_AppMsg_unsigned_msgCls
static int tolua_set_AppMsg_unsigned_msgCls(lua_State* tolua_S)
{
  AppMsg* self = (AppMsg*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  tolua_Error tolua_err;
  if (!self) tolua_error(tolua_S,"invalid 'self' in accessing variable 'msgCls'",NULL);
  if (!tolua_isnumber(tolua_S,2,0,&tolua_err))
   tolua_error(tolua_S,"#vinvalid type in variable assignment.",&tolua_err);
#endif
  self->msgCls = ((unsigned char)  tolua_tonumber(tolua_S,2,0))
;
 return 0;
}
#endif //#ifndef TOLUA_DISABLE

/* get function: msgId of class  AppMsg */
#ifndef TOLUA_DISABLE_tolua_get_AppMsg_unsigned_msgId
static int tolua_get_AppMsg_unsigned_msgId(lua_State* tolua_S)
{
  AppMsg* self = (AppMsg*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in accessing variable 'msgId'",NULL);
#endif
  tolua_pushnumber(tolua_S,(lua_Number)self->msgId);
 return 1;
}
#endif //#ifndef TOLUA_DISABLE

/* set function: msgId of class  AppMsg */
#ifndef TOLUA_DISABLE_tolua_set_AppMsg_unsigned_msgId
static int tolua_set_AppMsg_unsigned_msgId(lua_State* tolua_S)
{
  AppMsg* self = (AppMsg*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  tolua_Error tolua_err;
  if (!self) tolua_error(tolua_S,"invalid 'self' in accessing variable 'msgId'",NULL);
  if (!tolua_isnumber(tolua_S,2,0,&tolua_err))
   tolua_error(tolua_S,"#vinvalid type in variable assignment.",&tolua_err);
#endif
  self->msgId = ((unsigned short)  tolua_tonumber(tolua_S,2,0))
;
 return 0;
}
#endif //#ifndef TOLUA_DISABLE

/* get function: context of class  AppMsg */
#ifndef TOLUA_DISABLE_tolua_get_AppMsg_context
static int tolua_get_AppMsg_context(lua_State* tolua_S)
{
  AppMsg* self = (AppMsg*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in accessing variable 'context'",NULL);
#endif
  tolua_pushnumber(tolua_S,(lua_Number)self->context);
 return 1;
}
#endif //#ifndef TOLUA_DISABLE

/* set function: context of class  AppMsg */
#ifndef TOLUA_DISABLE_tolua_set_AppMsg_context
static int tolua_set_AppMsg_context(lua_State* tolua_S)
{
  AppMsg* self = (AppMsg*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  tolua_Error tolua_err;
  if (!self) tolua_error(tolua_S,"invalid 'self' in accessing variable 'context'",NULL);
  if (!tolua_isnumber(tolua_S,2,0,&tolua_err))
   tolua_error(tolua_S,"#vinvalid type in variable assignment.",&tolua_err);
#endif
  self->context = ((int)  tolua_tonumber(tolua_S,2,0))
;
 return 0;
}
#endif //#ifndef TOLUA_DISABLE

/* get function: roleId of class  _MsgGW_PlayerLoginInfo */
#ifndef TOLUA_DISABLE_tolua_get__MsgGW_PlayerLoginInfo_roleId
static int tolua_get__MsgGW_PlayerLoginInfo_roleId(lua_State* tolua_S)
{
  _MsgGW_PlayerLoginInfo* self = (_MsgGW_PlayerLoginInfo*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in accessing variable 'roleId'",NULL);
#endif
  tolua_pushnumber(tolua_S,(lua_Number)self->roleId);
 return 1;
}
#endif //#ifndef TOLUA_DISABLE

/* set function: roleId of class  _MsgGW_PlayerLoginInfo */
#ifndef TOLUA_DISABLE_tolua_set__MsgGW_PlayerLoginInfo_roleId
static int tolua_set__MsgGW_PlayerLoginInfo_roleId(lua_State* tolua_S)
{
  _MsgGW_PlayerLoginInfo* self = (_MsgGW_PlayerLoginInfo*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  tolua_Error tolua_err;
  if (!self) tolua_error(tolua_S,"invalid 'self' in accessing variable 'roleId'",NULL);
  if (!tolua_isnumber(tolua_S,2,0,&tolua_err))
   tolua_error(tolua_S,"#vinvalid type in variable assignment.",&tolua_err);
#endif
  self->roleId = ((int)  tolua_tonumber(tolua_S,2,0))
;
 return 0;
}
#endif //#ifndef TOLUA_DISABLE

/* get function: gatewayId of class  _MsgGW_PlayerLoginInfo */
#ifndef TOLUA_DISABLE_tolua_get__MsgGW_PlayerLoginInfo_gatewayId
static int tolua_get__MsgGW_PlayerLoginInfo_gatewayId(lua_State* tolua_S)
{
  _MsgGW_PlayerLoginInfo* self = (_MsgGW_PlayerLoginInfo*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in accessing variable 'gatewayId'",NULL);
#endif
  tolua_pushnumber(tolua_S,(lua_Number)self->gatewayId);
 return 1;
}
#endif //#ifndef TOLUA_DISABLE

/* set function: gatewayId of class  _MsgGW_PlayerLoginInfo */
#ifndef TOLUA_DISABLE_tolua_set__MsgGW_PlayerLoginInfo_gatewayId
static int tolua_set__MsgGW_PlayerLoginInfo_gatewayId(lua_State* tolua_S)
{
  _MsgGW_PlayerLoginInfo* self = (_MsgGW_PlayerLoginInfo*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  tolua_Error tolua_err;
  if (!self) tolua_error(tolua_S,"invalid 'self' in accessing variable 'gatewayId'",NULL);
  if (!tolua_isnumber(tolua_S,2,0,&tolua_err))
   tolua_error(tolua_S,"#vinvalid type in variable assignment.",&tolua_err);
#endif
  self->gatewayId = ((int)  tolua_tonumber(tolua_S,2,0))
;
 return 0;
}
#endif //#ifndef TOLUA_DISABLE

/* get function: hClientLink of class  _MsgGW_PlayerLoginInfo */
#ifndef TOLUA_DISABLE_tolua_get__MsgGW_PlayerLoginInfo_unsigned_hClientLink
static int tolua_get__MsgGW_PlayerLoginInfo_unsigned_hClientLink(lua_State* tolua_S)
{
  _MsgGW_PlayerLoginInfo* self = (_MsgGW_PlayerLoginInfo*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in accessing variable 'hClientLink'",NULL);
#endif
  tolua_pushnumber(tolua_S,(lua_Number)self->hClientLink);
 return 1;
}
#endif //#ifndef TOLUA_DISABLE

/* set function: hClientLink of class  _MsgGW_PlayerLoginInfo */
#ifndef TOLUA_DISABLE_tolua_set__MsgGW_PlayerLoginInfo_unsigned_hClientLink
static int tolua_set__MsgGW_PlayerLoginInfo_unsigned_hClientLink(lua_State* tolua_S)
{
  _MsgGW_PlayerLoginInfo* self = (_MsgGW_PlayerLoginInfo*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  tolua_Error tolua_err;
  if (!self) tolua_error(tolua_S,"invalid 'self' in accessing variable 'hClientLink'",NULL);
  if (!tolua_isnumber(tolua_S,2,0,&tolua_err))
   tolua_error(tolua_S,"#vinvalid type in variable assignment.",&tolua_err);
#endif
  self->hClientLink = (( unsigned int)  tolua_tonumber(tolua_S,2,0))
;
 return 0;
}
#endif //#ifndef TOLUA_DISABLE

/* get function: roleId of class  _MsgGW_PlayerLogoutInfo */
#ifndef TOLUA_DISABLE_tolua_get__MsgGW_PlayerLogoutInfo_roleId
static int tolua_get__MsgGW_PlayerLogoutInfo_roleId(lua_State* tolua_S)
{
  _MsgGW_PlayerLogoutInfo* self = (_MsgGW_PlayerLogoutInfo*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in accessing variable 'roleId'",NULL);
#endif
  tolua_pushnumber(tolua_S,(lua_Number)self->roleId);
 return 1;
}
#endif //#ifndef TOLUA_DISABLE

/* set function: roleId of class  _MsgGW_PlayerLogoutInfo */
#ifndef TOLUA_DISABLE_tolua_set__MsgGW_PlayerLogoutInfo_roleId
static int tolua_set__MsgGW_PlayerLogoutInfo_roleId(lua_State* tolua_S)
{
  _MsgGW_PlayerLogoutInfo* self = (_MsgGW_PlayerLogoutInfo*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  tolua_Error tolua_err;
  if (!self) tolua_error(tolua_S,"invalid 'self' in accessing variable 'roleId'",NULL);
  if (!tolua_isnumber(tolua_S,2,0,&tolua_err))
   tolua_error(tolua_S,"#vinvalid type in variable assignment.",&tolua_err);
#endif
  self->roleId = ((int)  tolua_tonumber(tolua_S,2,0))
;
 return 0;
}
#endif //#ifndef TOLUA_DISABLE

/* get function: reason of class  _MsgGW_PlayerLogoutInfo */
#ifndef TOLUA_DISABLE_tolua_get__MsgGW_PlayerLogoutInfo_reason
static int tolua_get__MsgGW_PlayerLogoutInfo_reason(lua_State* tolua_S)
{
  _MsgGW_PlayerLogoutInfo* self = (_MsgGW_PlayerLogoutInfo*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in accessing variable 'reason'",NULL);
#endif
  tolua_pushnumber(tolua_S,(lua_Number)self->reason);
 return 1;
}
#endif //#ifndef TOLUA_DISABLE

/* set function: reason of class  _MsgGW_PlayerLogoutInfo */
#ifndef TOLUA_DISABLE_tolua_set__MsgGW_PlayerLogoutInfo_reason
static int tolua_set__MsgGW_PlayerLogoutInfo_reason(lua_State* tolua_S)
{
  _MsgGW_PlayerLogoutInfo* self = (_MsgGW_PlayerLogoutInfo*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  tolua_Error tolua_err;
  if (!self) tolua_error(tolua_S,"invalid 'self' in accessing variable 'reason'",NULL);
  if (!tolua_isnumber(tolua_S,2,0,&tolua_err))
   tolua_error(tolua_S,"#vinvalid type in variable assignment.",&tolua_err);
#endif
  self->reason = ((int)  tolua_tonumber(tolua_S,2,0))
;
 return 0;
}
#endif //#ifndef TOLUA_DISABLE

/* get function: roleId of class  _MsgWG_PlayerLogin_ResultInfo */
#ifndef TOLUA_DISABLE_tolua_get__MsgWG_PlayerLogin_ResultInfo_roleId
static int tolua_get__MsgWG_PlayerLogin_ResultInfo_roleId(lua_State* tolua_S)
{
  _MsgWG_PlayerLogin_ResultInfo* self = (_MsgWG_PlayerLogin_ResultInfo*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in accessing variable 'roleId'",NULL);
#endif
  tolua_pushnumber(tolua_S,(lua_Number)self->roleId);
 return 1;
}
#endif //#ifndef TOLUA_DISABLE

/* set function: roleId of class  _MsgWG_PlayerLogin_ResultInfo */
#ifndef TOLUA_DISABLE_tolua_set__MsgWG_PlayerLogin_ResultInfo_roleId
static int tolua_set__MsgWG_PlayerLogin_ResultInfo_roleId(lua_State* tolua_S)
{
  _MsgWG_PlayerLogin_ResultInfo* self = (_MsgWG_PlayerLogin_ResultInfo*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  tolua_Error tolua_err;
  if (!self) tolua_error(tolua_S,"invalid 'self' in accessing variable 'roleId'",NULL);
  if (!tolua_isnumber(tolua_S,2,0,&tolua_err))
   tolua_error(tolua_S,"#vinvalid type in variable assignment.",&tolua_err);
#endif
  self->roleId = ((int)  tolua_tonumber(tolua_S,2,0))
;
 return 0;
}
#endif //#ifndef TOLUA_DISABLE

/* get function: result of class  _MsgWG_PlayerLogin_ResultInfo */
#ifndef TOLUA_DISABLE_tolua_get__MsgWG_PlayerLogin_ResultInfo_result
static int tolua_get__MsgWG_PlayerLogin_ResultInfo_result(lua_State* tolua_S)
{
  _MsgWG_PlayerLogin_ResultInfo* self = (_MsgWG_PlayerLogin_ResultInfo*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in accessing variable 'result'",NULL);
#endif
  tolua_pushnumber(tolua_S,(lua_Number)self->result);
 return 1;
}
#endif //#ifndef TOLUA_DISABLE

/* set function: result of class  _MsgWG_PlayerLogin_ResultInfo */
#ifndef TOLUA_DISABLE_tolua_set__MsgWG_PlayerLogin_ResultInfo_result
static int tolua_set__MsgWG_PlayerLogin_ResultInfo_result(lua_State* tolua_S)
{
  _MsgWG_PlayerLogin_ResultInfo* self = (_MsgWG_PlayerLogin_ResultInfo*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  tolua_Error tolua_err;
  if (!self) tolua_error(tolua_S,"invalid 'self' in accessing variable 'result'",NULL);
  if (!tolua_isnumber(tolua_S,2,0,&tolua_err))
   tolua_error(tolua_S,"#vinvalid type in variable assignment.",&tolua_err);
#endif
  self->result = ((int)  tolua_tonumber(tolua_S,2,0))
;
 return 0;
}
#endif //#ifndef TOLUA_DISABLE

/* method: Instance of class  CUnitConfig */
#ifndef TOLUA_DISABLE_tolua_api4lua_CUnitConfig_Instance00
static int tolua_api4lua_CUnitConfig_Instance00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertable(tolua_S,1,"CUnitConfig",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  {
   CUnitConfig& tolua_ret = (CUnitConfig&)  CUnitConfig::Instance();
    tolua_pushusertype(tolua_S,(void*)&tolua_ret,"CUnitConfig");
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'Instance'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: initPropSet of class  CUnitConfig */
#ifndef TOLUA_DISABLE_tolua_api4lua_CUnitConfig_initPropSet00
static int tolua_api4lua_CUnitConfig_initPropSet00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"CUnitConfig",0,&tolua_err) ||
     !tolua_isnumber(tolua_S,2,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,3,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  CUnitConfig* self = (CUnitConfig*)  tolua_tousertype(tolua_S,1,0);
  int cls = ((int)  tolua_tonumber(tolua_S,2,0));
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'initPropSet'", NULL);
#endif
  {
   self->initPropSet(cls);
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'initPropSet'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: addProperty of class  CUnitConfig */
#ifndef TOLUA_DISABLE_tolua_api4lua_CUnitConfig_addProperty00
static int tolua_api4lua_CUnitConfig_addProperty00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"CUnitConfig",0,&tolua_err) ||
     !tolua_isnumber(tolua_S,2,0,&tolua_err) ||
     !tolua_isstring(tolua_S,3,0,&tolua_err) ||
     !tolua_isstring(tolua_S,4,0,&tolua_err) ||
     !tolua_isnumber(tolua_S,5,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,6,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  CUnitConfig* self = (CUnitConfig*)  tolua_tousertype(tolua_S,1,0);
  int cls = ((int)  tolua_tonumber(tolua_S,2,0));
  const char* type = ((const char*)  tolua_tostring(tolua_S,3,0));
  const char* def = ((const char*)  tolua_tostring(tolua_S,4,0));
  int isPublic = ((int)  tolua_tonumber(tolua_S,5,0));
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'addProperty'", NULL);
#endif
  {
   int tolua_ret = (int)  self->addProperty(cls,type,def,isPublic);
   tolua_pushnumber(tolua_S,(lua_Number)tolua_ret);
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'addProperty'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: Create of class  CoEntity */
#ifndef TOLUA_DISABLE_tolua_api4lua_CoEntity_Create00
static int tolua_api4lua_CoEntity_Create00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertable(tolua_S,1,"CoEntity",0,&tolua_err) ||
     !tolua_isnumber(tolua_S,2,0,&tolua_err) ||
     !tolua_isnumber(tolua_S,3,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,4,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  EntityType type = ((EntityType) (int)  tolua_tonumber(tolua_S,2,0));
  EntityPropType propType = ((EntityPropType) (int)  tolua_tonumber(tolua_S,3,0));
  {
   CoEntity* tolua_ret = (CoEntity*)  CoEntity::Create(type,propType);
    tolua_pushusertype(tolua_S,(void*)tolua_ret,"CoEntity");
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'Create'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: correctMovePath of class  CoEntity */
#ifndef TOLUA_DISABLE_tolua_api4lua_CoEntity_correctMovePath00
static int tolua_api4lua_CoEntity_correctMovePath00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"CoEntity",0,&tolua_err) ||
     !tolua_isnumber(tolua_S,2,0,&tolua_err) ||
     !tolua_isnumber(tolua_S,3,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,4,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  CoEntity* self = (CoEntity*)  tolua_tousertype(tolua_S,1,0);
  short x = ((short)  tolua_tonumber(tolua_S,2,0));
  short y = ((short)  tolua_tonumber(tolua_S,3,0));
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'correctMovePath'", NULL);
#endif
  {
   short tolua_ret = (short)  self->correctMovePath(x,y);
   tolua_pushnumber(tolua_S,(lua_Number)tolua_ret);
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'correctMovePath'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: correctFollowMovePath of class  CoEntity */
#ifndef TOLUA_DISABLE_tolua_api4lua_CoEntity_correctFollowMovePath00
static int tolua_api4lua_CoEntity_correctFollowMovePath00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"CoEntity",0,&tolua_err) ||
     !tolua_isnumber(tolua_S,2,0,&tolua_err) ||
     !tolua_isnumber(tolua_S,3,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,4,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  CoEntity* self = (CoEntity*)  tolua_tousertype(tolua_S,1,0);
  short refIdx = ((short)  tolua_tonumber(tolua_S,2,0));
  short refPathLen = ((short)  tolua_tonumber(tolua_S,3,0));
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'correctFollowMovePath'", NULL);
#endif
  {
   short tolua_ret = (short)  self->correctFollowMovePath(refIdx,refPathLen);
   tolua_pushnumber(tolua_S,(lua_Number)tolua_ret);
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'correctFollowMovePath'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: getPathLen of class  CoEntity */
#ifndef TOLUA_DISABLE_tolua_api4lua_CoEntity_getPathLen00
static int tolua_api4lua_CoEntity_getPathLen00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"const CoEntity",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  const CoEntity* self = (const CoEntity*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'getPathLen'", NULL);
#endif
  {
   short tolua_ret = (short)  self->getPathLen();
   tolua_pushnumber(tolua_S,(lua_Number)tolua_ret);
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'getPathLen'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: moveByPath of class  CoEntity */
#ifndef TOLUA_DISABLE_tolua_api4lua_CoEntity_moveByPath00
static int tolua_api4lua_CoEntity_moveByPath00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"CoEntity",0,&tolua_err) ||
     !tolua_isusertype(tolua_S,2,"_PropPosData",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,3,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  CoEntity* self = (CoEntity*)  tolua_tousertype(tolua_S,1,0);
  lua_State* pState =  tolua_S;
  _PropPosData* pPropPosData = ((_PropPosData*)  tolua_tousertype(tolua_S,2,0));
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'moveByPath'", NULL);
#endif
  {
   self->moveByPath(pState,pPropPosData);
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'moveByPath'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: move of class  CoEntity */
#ifndef TOLUA_DISABLE_tolua_api4lua_CoEntity_move00
static int tolua_api4lua_CoEntity_move00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"CoEntity",0,&tolua_err) ||
     !tolua_isnumber(tolua_S,2,1,&tolua_err) ||
     !tolua_isnumber(tolua_S,3,1,&tolua_err) ||
     !tolua_isnumber(tolua_S,4,1,&tolua_err) ||
     !tolua_isnoobj(tolua_S,5,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  CoEntity* self = (CoEntity*)  tolua_tousertype(tolua_S,1,0);
  short x = ((short)  tolua_tonumber(tolua_S,2,0));
  short y = ((short)  tolua_tonumber(tolua_S,3,0));
  int flags = ((int)  tolua_tonumber(tolua_S,4,0x10));
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'move'", NULL);
#endif
  {
   bool tolua_ret = (bool)  self->move(x,y,flags);
   tolua_pushboolean(tolua_S,(bool)tolua_ret);
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'move'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: moveFollowEntity of class  CoEntity */
#ifndef TOLUA_DISABLE_tolua_api4lua_CoEntity_moveFollowEntity00
static int tolua_api4lua_CoEntity_moveFollowEntity00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"CoEntity",0,&tolua_err) ||
     !tolua_isnumber(tolua_S,2,0,&tolua_err) ||
     !tolua_isusertype(tolua_S,3,"_PropPosData",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,4,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  CoEntity* self = (CoEntity*)  tolua_tousertype(tolua_S,1,0);
  lua_State* pState =  tolua_S;
  short offset = ((short)  tolua_tonumber(tolua_S,2,0));
  _PropPosData* pPropPosData = ((_PropPosData*)  tolua_tousertype(tolua_S,3,0));
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'moveFollowEntity'", NULL);
#endif
  {
   self->moveFollowEntity(pState,offset,pPropPosData);
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'moveFollowEntity'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: stopMove of class  CoEntity */
#ifndef TOLUA_DISABLE_tolua_api4lua_CoEntity_stopMove00
static int tolua_api4lua_CoEntity_stopMove00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"CoEntity",0,&tolua_err) ||
     !tolua_isnumber(tolua_S,2,1,&tolua_err) ||
     !tolua_isnumber(tolua_S,3,1,&tolua_err) ||
     !tolua_isnoobj(tolua_S,4,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  CoEntity* self = (CoEntity*)  tolua_tousertype(tolua_S,1,0);
  short x = ((short)  tolua_tonumber(tolua_S,2,0));
  short y = ((short)  tolua_tonumber(tolua_S,3,0));
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'stopMove'", NULL);
#endif
  {
   self->stopMove(x,y);
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'stopMove'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: isInView of class  CoEntity */
#ifndef TOLUA_DISABLE_tolua_api4lua_CoEntity_isInView00
static int tolua_api4lua_CoEntity_isInView00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"CoEntity",0,&tolua_err) ||
     !tolua_isnumber(tolua_S,2,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,3,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  CoEntity* self = (CoEntity*)  tolua_tousertype(tolua_S,1,0);
  unsigned int hand = (( unsigned int)  tolua_tonumber(tolua_S,2,0));
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'isInView'", NULL);
#endif
  {
   bool tolua_ret = (bool)  self->isInView(hand);
   tolua_pushboolean(tolua_S,(bool)tolua_ret);
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'isInView'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: setDBID of class  CoEntity */
#ifndef TOLUA_DISABLE_tolua_api4lua_CoEntity_setDBID00
static int tolua_api4lua_CoEntity_setDBID00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"CoEntity",0,&tolua_err) ||
     !tolua_isnumber(tolua_S,2,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,3,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  CoEntity* self = (CoEntity*)  tolua_tousertype(tolua_S,1,0);
  int dbId = ((int)  tolua_tonumber(tolua_S,2,0));
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'setDBID'", NULL);
#endif
  {
   self->setDBID(dbId);
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'setDBID'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: getHandle of class  CoEntity */
#ifndef TOLUA_DISABLE_tolua_api4lua_CoEntity_getHandle00
static int tolua_api4lua_CoEntity_getHandle00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"CoEntity",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  CoEntity* self = (CoEntity*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'getHandle'", NULL);
#endif
  {
   unsigned int tolua_ret = ( unsigned int)  self->getHandle();
   tolua_pushnumber(tolua_S,(lua_Number)tolua_ret);
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'getHandle'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: enterScene of class  CoEntity */
#ifndef TOLUA_DISABLE_tolua_api4lua_CoEntity_enterScene00
static int tolua_api4lua_CoEntity_enterScene00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"CoEntity",0,&tolua_err) ||
     !tolua_isusertype(tolua_S,2,"CoScene",0,&tolua_err) ||
     !tolua_isnumber(tolua_S,3,0,&tolua_err) ||
     !tolua_isnumber(tolua_S,4,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,5,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  CoEntity* self = (CoEntity*)  tolua_tousertype(tolua_S,1,0);
  CoScene* pScene = ((CoScene*)  tolua_tousertype(tolua_S,2,0));
  short x = ((short)  tolua_tonumber(tolua_S,3,0));
  short y = ((short)  tolua_tonumber(tolua_S,4,0));
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'enterScene'", NULL);
#endif
  {
   bool tolua_ret = (bool)  self->enterScene(pScene,x,y);
   tolua_pushboolean(tolua_S,(bool)tolua_ret);
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'enterScene'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: quitScene of class  CoEntity */
#ifndef TOLUA_DISABLE_tolua_api4lua_CoEntity_quitScene00
static int tolua_api4lua_CoEntity_quitScene00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"CoEntity",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  CoEntity* self = (CoEntity*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'quitScene'", NULL);
#endif
  {
   bool tolua_ret = (bool)  self->quitScene();
   tolua_pushboolean(tolua_S,(bool)tolua_ret);
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'quitScene'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: send_MsgWG_PlayerLogin_ResultInfo of class  CWorld */
#ifndef TOLUA_DISABLE_tolua_api4lua_CWorld_send_MsgWG_PlayerLogin_ResultInfo00
static int tolua_api4lua_CWorld_send_MsgWG_PlayerLogin_ResultInfo00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"CWorld",0,&tolua_err) ||
     !tolua_isnumber(tolua_S,2,0,&tolua_err) ||
     !tolua_isnumber(tolua_S,3,0,&tolua_err) ||
     !tolua_isnumber(tolua_S,4,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,5,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  CWorld* self = (CWorld*)  tolua_tousertype(tolua_S,1,0);
  unsigned int hLink = (( unsigned int)  tolua_tonumber(tolua_S,2,0));
  int roleId = ((int)  tolua_tonumber(tolua_S,3,0));
  int result = ((int)  tolua_tonumber(tolua_S,4,0));
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'send_MsgWG_PlayerLogin_ResultInfo'", NULL);
#endif
  {
   int tolua_ret = (int)  self->send_MsgWG_PlayerLogin_ResultInfo(hLink,roleId,result);
   tolua_pushnumber(tolua_S,(lua_Number)tolua_ret);
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'send_MsgWG_PlayerLogin_ResultInfo'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* get function: g_world */
#ifndef TOLUA_DISABLE_tolua_get_g_world
static int tolua_get_g_world(lua_State* tolua_S)
{
   tolua_pushusertype(tolua_S,(void*)&g_world,"CWorld");
 return 1;
}
#endif //#ifndef TOLUA_DISABLE

/* set function: g_world */
#ifndef TOLUA_DISABLE_tolua_set_g_world
static int tolua_set_g_world(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
  tolua_Error tolua_err;
  if ((tolua_isvaluenil(tolua_S,2,&tolua_err) || !tolua_isusertype(tolua_S,2,"CWorld",0,&tolua_err)))
   tolua_error(tolua_S,"#vinvalid type in variable assignment.",&tolua_err);
#endif
  g_world = *((CWorld*)  tolua_tousertype(tolua_S,2,0))
;
 return 0;
}
#endif //#ifndef TOLUA_DISABLE

/* get function: x of class  GridVct */
#ifndef TOLUA_DISABLE_tolua_get_GridVct_x
static int tolua_get_GridVct_x(lua_State* tolua_S)
{
  GridVct* self = (GridVct*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in accessing variable 'x'",NULL);
#endif
  tolua_pushnumber(tolua_S,(lua_Number)self->x);
 return 1;
}
#endif //#ifndef TOLUA_DISABLE

/* set function: x of class  GridVct */
#ifndef TOLUA_DISABLE_tolua_set_GridVct_x
static int tolua_set_GridVct_x(lua_State* tolua_S)
{
  GridVct* self = (GridVct*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  tolua_Error tolua_err;
  if (!self) tolua_error(tolua_S,"invalid 'self' in accessing variable 'x'",NULL);
  if (!tolua_isnumber(tolua_S,2,0,&tolua_err))
   tolua_error(tolua_S,"#vinvalid type in variable assignment.",&tolua_err);
#endif
  self->x = ((short)  tolua_tonumber(tolua_S,2,0))
;
 return 0;
}
#endif //#ifndef TOLUA_DISABLE

/* get function: y of class  GridVct */
#ifndef TOLUA_DISABLE_tolua_get_GridVct_y
static int tolua_get_GridVct_y(lua_State* tolua_S)
{
  GridVct* self = (GridVct*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in accessing variable 'y'",NULL);
#endif
  tolua_pushnumber(tolua_S,(lua_Number)self->y);
 return 1;
}
#endif //#ifndef TOLUA_DISABLE

/* set function: y of class  GridVct */
#ifndef TOLUA_DISABLE_tolua_set_GridVct_y
static int tolua_set_GridVct_y(lua_State* tolua_S)
{
  GridVct* self = (GridVct*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  tolua_Error tolua_err;
  if (!self) tolua_error(tolua_S,"invalid 'self' in accessing variable 'y'",NULL);
  if (!tolua_isnumber(tolua_S,2,0,&tolua_err))
   tolua_error(tolua_S,"#vinvalid type in variable assignment.",&tolua_err);
#endif
  self->y = ((short)  tolua_tonumber(tolua_S,2,0))
;
 return 0;
}
#endif //#ifndef TOLUA_DISABLE

/* method: Create of class  CoScene */
#ifndef TOLUA_DISABLE_tolua_api4lua_CoScene_Create00
static int tolua_api4lua_CoScene_Create00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertable(tolua_S,1,"CoScene",0,&tolua_err) ||
     !tolua_isnumber(tolua_S,2,0,&tolua_err) ||
     !tolua_isnumber(tolua_S,3,0,&tolua_err) ||
     !tolua_isstring(tolua_S,4,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,5,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  SceneType type = ((SceneType) (int)  tolua_tonumber(tolua_S,2,0));
  short mapId = ((short)  tolua_tonumber(tolua_S,3,0));
  char* fname = ((char*)  tolua_tostring(tolua_S,4,0));
  {
   CoScene* tolua_ret = (CoScene*)  CoScene::Create(type,mapId,fname);
    tolua_pushusertype(tolua_S,(void*)tolua_ret,"CoScene");
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'Create'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: PosValidate of class  CoScene */
#ifndef TOLUA_DISABLE_tolua_api4lua_CoScene_PosValidate00
static int tolua_api4lua_CoScene_PosValidate00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertable(tolua_S,1,"CoScene",0,&tolua_err) ||
     !tolua_isnumber(tolua_S,2,0,&tolua_err) ||
     !tolua_isnumber(tolua_S,3,0,&tolua_err) ||
     !tolua_isnumber(tolua_S,4,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,5,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  short mapId = ((short)  tolua_tonumber(tolua_S,2,0));
  int x = ((int)  tolua_tonumber(tolua_S,3,0));
  int y = ((int)  tolua_tonumber(tolua_S,4,0));
  {
   bool tolua_ret = (bool)  CoScene::PosValidate(mapId,x,y);
   tolua_pushboolean(tolua_S,(bool)tolua_ret);
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'PosValidate'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: FindRandomTile of class  CoScene */
#ifndef TOLUA_DISABLE_tolua_api4lua_CoScene_FindRandomTile00
static int tolua_api4lua_CoScene_FindRandomTile00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertable(tolua_S,1,"CoScene",0,&tolua_err) ||
     !tolua_isnumber(tolua_S,2,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,3,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  int mapId = ((int)  tolua_tonumber(tolua_S,2,0));
  {
   GridVct tolua_ret = (GridVct)  CoScene::FindRandomTile(mapId);
   {
#ifdef __cplusplus
    void* tolua_obj = Mtolua_new((GridVct)(tolua_ret));
     tolua_pushusertype(tolua_S,tolua_obj,"GridVct");
    tolua_register_gc(tolua_S,lua_gettop(tolua_S));
#else
    void* tolua_obj = tolua_copy(tolua_S,(void*)&tolua_ret,sizeof(GridVct));
     tolua_pushusertype(tolua_S,tolua_obj,"GridVct");
    tolua_register_gc(tolua_S,lua_gettop(tolua_S));
#endif
   }
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'FindRandomTile'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* Open function */
TOLUA_API int tolua_api4lua_open (lua_State* tolua_S)
{
 tolua_open(tolua_S);
 tolua_reg_types(tolua_S);
 tolua_module(tolua_S,NULL,1);
 tolua_beginmodule(tolua_S,NULL);
  tolua_constant(tolua_S,"ePlayerNone",ePlayerNone);
  tolua_constant(tolua_S,"ePlayerLoading",ePlayerLoading);
  tolua_constant(tolua_S,"ePlayerNormal",ePlayerNormal);
  tolua_constant(tolua_S,"ePlayerFight",ePlayerFight);
  tolua_constant(tolua_S,"ePlayerInactive",ePlayerInactive);
  tolua_constant(tolua_S,"ePlayerClosing",ePlayerClosing);
  tolua_constant(tolua_S,"ePlayerClosed",ePlayerClosed);
  tolua_constant(tolua_S,"MSG_W_G_PLAYER_LOGIN",MSG_W_G_PLAYER_LOGIN);
  tolua_constant(tolua_S,"MSG_W_G_PLAYER_LOGOUT",MSG_W_G_PLAYER_LOGOUT);
  tolua_cclass(tolua_S,"AppMsg","AppMsg","",NULL);
  tolua_beginmodule(tolua_S,"AppMsg");
   tolua_variable(tolua_S,"msgLen",tolua_get_AppMsg_unsigned_msgLen,tolua_set_AppMsg_unsigned_msgLen);
   tolua_variable(tolua_S,"msgFlags",tolua_get_AppMsg_unsigned_msgFlags,tolua_set_AppMsg_unsigned_msgFlags);
   tolua_variable(tolua_S,"msgCls",tolua_get_AppMsg_unsigned_msgCls,tolua_set_AppMsg_unsigned_msgCls);
   tolua_variable(tolua_S,"msgId",tolua_get_AppMsg_unsigned_msgId,tolua_set_AppMsg_unsigned_msgId);
   tolua_variable(tolua_S,"context",tolua_get_AppMsg_context,tolua_set_AppMsg_context);
  tolua_endmodule(tolua_S);
  tolua_cclass(tolua_S,"_MsgGW_PlayerLoginInfo","_MsgGW_PlayerLoginInfo","AppMsg",NULL);
  tolua_beginmodule(tolua_S,"_MsgGW_PlayerLoginInfo");
   tolua_variable(tolua_S,"roleId",tolua_get__MsgGW_PlayerLoginInfo_roleId,tolua_set__MsgGW_PlayerLoginInfo_roleId);
   tolua_variable(tolua_S,"gatewayId",tolua_get__MsgGW_PlayerLoginInfo_gatewayId,tolua_set__MsgGW_PlayerLoginInfo_gatewayId);
   tolua_variable(tolua_S,"hClientLink",tolua_get__MsgGW_PlayerLoginInfo_unsigned_hClientLink,tolua_set__MsgGW_PlayerLoginInfo_unsigned_hClientLink);
  tolua_endmodule(tolua_S);
  tolua_cclass(tolua_S,"_MsgGW_PlayerLogoutInfo","_MsgGW_PlayerLogoutInfo","AppMsg",NULL);
  tolua_beginmodule(tolua_S,"_MsgGW_PlayerLogoutInfo");
   tolua_variable(tolua_S,"roleId",tolua_get__MsgGW_PlayerLogoutInfo_roleId,tolua_set__MsgGW_PlayerLogoutInfo_roleId);
   tolua_variable(tolua_S,"reason",tolua_get__MsgGW_PlayerLogoutInfo_reason,tolua_set__MsgGW_PlayerLogoutInfo_reason);
  tolua_endmodule(tolua_S);
  tolua_cclass(tolua_S,"_MsgWG_PlayerLogin_ResultInfo","_MsgWG_PlayerLogin_ResultInfo","AppMsg",NULL);
  tolua_beginmodule(tolua_S,"_MsgWG_PlayerLogin_ResultInfo");
   tolua_variable(tolua_S,"roleId",tolua_get__MsgWG_PlayerLogin_ResultInfo_roleId,tolua_set__MsgWG_PlayerLogin_ResultInfo_roleId);
   tolua_variable(tolua_S,"result",tolua_get__MsgWG_PlayerLogin_ResultInfo_result,tolua_set__MsgWG_PlayerLogin_ResultInfo_result);
  tolua_endmodule(tolua_S);
  tolua_constant(tolua_S,"PROP_PRIVATE",PROP_PRIVATE);
  tolua_constant(tolua_S,"PROP_PUBLIC",PROP_PUBLIC);
  tolua_cclass(tolua_S,"CUnitConfig","CUnitConfig","",NULL);
  tolua_beginmodule(tolua_S,"CUnitConfig");
   tolua_function(tolua_S,"Instance",tolua_api4lua_CUnitConfig_Instance00);
   tolua_function(tolua_S,"initPropSet",tolua_api4lua_CUnitConfig_initPropSet00);
   tolua_function(tolua_S,"addProperty",tolua_api4lua_CUnitConfig_addProperty00);
  tolua_endmodule(tolua_S);
  tolua_constant(tolua_S,"UNIT_STATUS",UNIT_STATUS);
  tolua_constant(tolua_S,"UNIT_POS",UNIT_POS);
  tolua_constant(tolua_S,"UNIT_MOVE_SPEED",UNIT_MOVE_SPEED);
  tolua_constant(tolua_S,"UNIT_BASE",UNIT_BASE);
  tolua_constant(tolua_S,"eLogicNone",eLogicNone);
  tolua_constant(tolua_S,"eLogicPlayer",eLogicPlayer);
  tolua_constant(tolua_S,"eLogicNpc",eLogicNpc);
  tolua_constant(tolua_S,"eLogicPet",eLogicPet);
  tolua_constant(tolua_S,"eLogicMonster",eLogicMonster);
  tolua_constant(tolua_S,"eLogicFollow",eLogicFollow);
  tolua_constant(tolua_S,"eLogicMineNpc",eLogicMineNpc);
  tolua_constant(tolua_S,"eLogicMpw",eLogicMpw);
  tolua_constant(tolua_S,"eLogicMagic",eLogicMagic);
  tolua_constant(tolua_S,"eLogicFarmLand",eLogicFarmLand);
  tolua_constant(tolua_S,"eLogicCrop",eLogicCrop);
  tolua_constant(tolua_S,"MAX_LOGIC_TYPE",MAX_LOGIC_TYPE);
  tolua_constant(tolua_S,"eClsTypeNone",eClsTypeNone);
  tolua_constant(tolua_S,"eClsTypePlayer",eClsTypePlayer);
  tolua_constant(tolua_S,"eClsTypeNpc",eClsTypeNpc);
  tolua_constant(tolua_S,"eClsTypePet",eClsTypePet);
  tolua_constant(tolua_S,"eClsTypeMpw",eClsTypeMpw);
  tolua_constant(tolua_S,"eClsTypeMagic",eClsTypeMagic);
  tolua_constant(tolua_S,"eClsTypeFarmLand",eClsTypeFarmLand);
  tolua_constant(tolua_S,"eClsTypeCrop",eClsTypeCrop);
  tolua_constant(tolua_S,"MAX_CLASS_TYPE",MAX_CLASS_TYPE);
  tolua_cclass(tolua_S,"CoEntity","CoEntity","",NULL);
  tolua_beginmodule(tolua_S,"CoEntity");
   tolua_function(tolua_S,"Create",tolua_api4lua_CoEntity_Create00);
   tolua_function(tolua_S,"correctMovePath",tolua_api4lua_CoEntity_correctMovePath00);
   tolua_function(tolua_S,"correctFollowMovePath",tolua_api4lua_CoEntity_correctFollowMovePath00);
   tolua_function(tolua_S,"getPathLen",tolua_api4lua_CoEntity_getPathLen00);
   tolua_function(tolua_S,"moveByPath",tolua_api4lua_CoEntity_moveByPath00);
   tolua_function(tolua_S,"move",tolua_api4lua_CoEntity_move00);
   tolua_function(tolua_S,"moveFollowEntity",tolua_api4lua_CoEntity_moveFollowEntity00);
   tolua_function(tolua_S,"stopMove",tolua_api4lua_CoEntity_stopMove00);
   tolua_function(tolua_S,"isInView",tolua_api4lua_CoEntity_isInView00);
   tolua_function(tolua_S,"setDBID",tolua_api4lua_CoEntity_setDBID00);
   tolua_function(tolua_S,"getHandle",tolua_api4lua_CoEntity_getHandle00);
   tolua_function(tolua_S,"enterScene",tolua_api4lua_CoEntity_enterScene00);
   tolua_function(tolua_S,"quitScene",tolua_api4lua_CoEntity_quitScene00);
  tolua_endmodule(tolua_S);
  tolua_cclass(tolua_S,"CWorld","CWorld","",NULL);
  tolua_beginmodule(tolua_S,"CWorld");
   tolua_function(tolua_S,"send_MsgWG_PlayerLogin_ResultInfo",tolua_api4lua_CWorld_send_MsgWG_PlayerLogin_ResultInfo00);
  tolua_endmodule(tolua_S);
  tolua_variable(tolua_S,"g_world",tolua_get_g_world,tolua_set_g_world);
  tolua_constant(tolua_S,"ScriptTimerNormal",ScriptTimerNormal);
  tolua_constant(tolua_S,"ScriptTimerExpire",ScriptTimerExpire);
  tolua_constant(tolua_S,"ScriptTimerStop",ScriptTimerStop);
  tolua_constant(tolua_S,"ePublicScene",ePublicScene);
  tolua_constant(tolua_S,"ePrivateScene",ePrivateScene);
  #ifdef __cplusplus
  tolua_cclass(tolua_S,"GridVct","GridVct","",tolua_collect_GridVct);
  #else
  tolua_cclass(tolua_S,"GridVct","GridVct","",NULL);
  #endif
  tolua_beginmodule(tolua_S,"GridVct");
   tolua_variable(tolua_S,"x",tolua_get_GridVct_x,tolua_set_GridVct_x);
   tolua_variable(tolua_S,"y",tolua_get_GridVct_y,tolua_set_GridVct_y);
  tolua_endmodule(tolua_S);
  tolua_cclass(tolua_S,"CoScene","CoScene","",NULL);
  tolua_beginmodule(tolua_S,"CoScene");
   tolua_function(tolua_S,"Create",tolua_api4lua_CoScene_Create00);
   tolua_function(tolua_S,"PosValidate",tolua_api4lua_CoScene_PosValidate00);
   tolua_function(tolua_S,"FindRandomTile",tolua_api4lua_CoScene_FindRandomTile00);
  tolua_endmodule(tolua_S);
 tolua_endmodule(tolua_S);
 return 1;
}


#if defined(LUA_VERSION_NUM) && LUA_VERSION_NUM >= 501
 TOLUA_API int luaopen_api4lua (lua_State* tolua_S) {
 return tolua_api4lua_open(tolua_S);
};
#endif

