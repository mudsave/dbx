/*
** Lua binding: api4lua
** Generated automatically by tolua++-1.0.92 on Sat Nov 12 16:42:17 2016.
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
#include "Entity.h"

/* function to register type */
static void tolua_reg_types (lua_State* tolua_S)
{
 tolua_usertype(tolua_S,"_MsgGW_PlayerLogoutInfo");
 tolua_usertype(tolua_S,"AppMsg");
 tolua_usertype(tolua_S,"EntityPropType");
 tolua_usertype(tolua_S,"_PropPosData");
 tolua_usertype(tolua_S,"EntityType");
 tolua_usertype(tolua_S,"CoEntity");
 tolua_usertype(tolua_S,"_MsgWG_PlayerLogin_ResultInfo");
 tolua_usertype(tolua_S,"_MsgGW_PlayerLoginInfo");
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

/* method: Create of class  CoEntity */
#ifndef TOLUA_DISABLE_tolua_api4lua_CoEntity_Create00
static int tolua_api4lua_CoEntity_Create00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertable(tolua_S,1,"CoEntity",0,&tolua_err) ||
     (tolua_isvaluenil(tolua_S,2,&tolua_err) || !tolua_isusertype(tolua_S,2,"EntityType",0,&tolua_err)) ||
     (tolua_isvaluenil(tolua_S,3,&tolua_err) || !tolua_isusertype(tolua_S,3,"EntityPropType",0,&tolua_err)) ||
     !tolua_isnoobj(tolua_S,4,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  EntityType type = *((EntityType*)  tolua_tousertype(tolua_S,2,0));
  EntityPropType propType = *((EntityPropType*)  tolua_tousertype(tolua_S,3,0));
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

/* Open function */
TOLUA_API int tolua_api4lua_open (lua_State* tolua_S)
{
 tolua_open(tolua_S);
 tolua_reg_types(tolua_S);
 tolua_module(tolua_S,NULL,0);
 tolua_beginmodule(tolua_S,NULL);
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
  tolua_endmodule(tolua_S);
 tolua_endmodule(tolua_S);
 return 1;
}


#if defined(LUA_VERSION_NUM) && LUA_VERSION_NUM >= 501
 TOLUA_API int luaopen_api4lua (lua_State* tolua_S) {
 return tolua_api4lua_open(tolua_S);
};
#endif

