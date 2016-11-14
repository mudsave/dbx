/*
** Lua binding: api4lua
** Generated automatically by tolua++-1.0.92 on Tue Nov  8 11:35:30 2016.
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

/* function to register type */
static void tolua_reg_types (lua_State* tolua_S)
{
 tolua_usertype(tolua_S,"_MsgGW_PlayerLoginInfo");
 tolua_usertype(tolua_S,"AppMsg");
 tolua_usertype(tolua_S,"_MsgGW_PlayerLogoutInfo");
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
 tolua_endmodule(tolua_S);
 return 1;
}


#if defined(LUA_VERSION_NUM) && LUA_VERSION_NUM >= 501
 TOLUA_API int luaopen_api4lua (lua_State* tolua_S) {
 return tolua_api4lua_open(tolua_S);
};
#endif

