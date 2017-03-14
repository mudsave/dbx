#include "lindef.h"
#include "vsdef.h"
#include "world.h"
#include "lua.h"
#include "lauxlib.h"
#include <stdlib.h>

#include <iconv.h>
#include "errno.h"

#define ICONV_TYPENAME		  "iconv_t"


#if LUA_VERSION_NUM < 502
 #define lua_rawlen(L, i)   lua_objlen(L, i)
#endif

#define BOXPTR(L, p)   (*(void**)(lua_newuserdata(L, sizeof(void*))) = (p))
#define UNBOXPTR(L, i) (*(void**)(lua_touserdata(L, i)))

#define ERROR_NO_MEMORY	 1
#define ERROR_INVALID	   2
#define ERROR_INCOMPLETE	3
#define ERROR_UNKNOWN	   4
#define ERROR_FINALIZED	 5



static void push_iconv_t(lua_State *L, iconv_t cd) {
	BOXPTR(L, cd);
	luaL_getmetatable(L, ICONV_TYPENAME);
	lua_setmetatable(L, -2);
}


static iconv_t get_iconv_t(lua_State *L, int i) {
	if (luaL_checkudata(L, i, ICONV_TYPENAME) != NULL) {
		iconv_t cd = UNBOXPTR(L, i);
		return cd;  /* May be NULL. This must be checked by the caller. */
	}
	luaL_argerror(L, i, lua_pushfstring(L, ICONV_TYPENAME " expected, got %s",
		luaL_typename(L, i)));
	return NULL;
}


static int Liconv_open(lua_State *L) {
	const char *tocode = luaL_checkstring(L, 1);
	const char *fromcode = luaL_checkstring(L, 2);
	iconv_t cd = iconv_open(tocode, fromcode);
	if (cd != (iconv_t)(-1))
		push_iconv_t(L, cd);	/* ok */
	else
		lua_pushnil(L);		 /* error */
	return 1;
}

#define CONV_BUF_SIZE 256

static int Liconv(lua_State *L) {
	iconv_t cd = get_iconv_t(L, 1);
	size_t ibleft = lua_rawlen(L, 2);
	char *inbuf = (char*) luaL_checkstring(L, 2);
	char *outbuf;
	char *outbufs;
	size_t obsize = (ibleft > CONV_BUF_SIZE) ? ibleft : CONV_BUF_SIZE; 
	size_t obleft = obsize;
	size_t ret = -1;
	int hasone = 0;

	if (cd == NULL) {
		lua_pushstring(L, "");
		lua_pushnumber(L, ERROR_FINALIZED);
		return 2;
	}

	outbuf = (char*) malloc(obsize * sizeof(char));
	if (outbuf == NULL) {
		lua_pushstring(L, "");
		lua_pushnumber(L, ERROR_NO_MEMORY);
		return 2;
	}
	outbufs = outbuf;

	do {
		ret = iconv(cd, &inbuf, &ibleft, &outbuf, &obleft);
		if (ret == (size_t)(-1)) {
			lua_pushlstring(L, outbufs, obsize - obleft);
			if (hasone == 1)
				lua_concat(L, 2);
			hasone = 1;
			if (errno == EILSEQ) {
				lua_pushnumber(L, ERROR_INVALID);
				free(outbufs);
				return 2;   /* Invalid character sequence */
			} else if (errno == EINVAL) {
				lua_pushnumber(L, ERROR_INCOMPLETE);
				free(outbufs);
				return 2;   /* Incomplete character sequence */
			} else if (errno == E2BIG) {
				obleft = obsize;	
				outbuf = outbufs;
			} else {
				lua_pushnumber(L, ERROR_UNKNOWN);
				free(outbufs);
				return 2; /* Unknown error */
			}
		}
	} while (ret != (size_t) 0);

	lua_pushlstring(L, outbufs, obsize - obleft);
	if (hasone == 1)
		lua_concat(L, 2);
	free(outbufs);
	return 1;   /* Done */
}

static int Liconv_close(lua_State *L) {
	iconv_t cd = get_iconv_t(L, 1);
	if (cd != NULL && iconv_close(cd) == 0) {
		/* Mark the pointer as freed, preventing interpreter crashes
		  if the user forces __gc to be called twice. */
		void **ptr = (void **)lua_touserdata(L, 1);
		if(ptr) {
			*( const void **)ptr = (void *)0;
		}
		lua_pushboolean(L, 1);  /* ok */
	}
	else
		lua_pushnil(L);		 /* error */
	return 1;
}

int lua_iconv_open(lua_State *L){
	lua_newtable(L);
	lua_pushcfunction(L,Liconv);
	lua_setfield(L,-2,"iconv");

	lua_pushcfunction(L,Liconv_open);
	lua_setfield(L,-2,"new");

	lua_pushinteger(L,ERROR_NO_MEMORY);
	lua_setfield(L,-2,"ERROR_NO_MEMORY");

	lua_pushinteger(L,ERROR_INVALID);
	lua_setfield(L,-2,"ERROR_INVALID");

	lua_pushinteger(L,ERROR_INCOMPLETE);
	lua_setfield(L,-2,"ERROR_INCOMPLETE");

	lua_pushinteger(L,ERROR_FINALIZED);
	lua_setfield(L,-2,"ERROR_FINALIZED");

	lua_pushinteger(L,ERROR_UNKNOWN);
	lua_setfield(L,-2,"ERROR_UNKNOWN");

	luaL_newmetatable(L, ICONV_TYPENAME);

	lua_pushliteral(L, "__index");
	lua_pushvalue(L, -3);
	lua_settable(L, -3);

	lua_pushliteral(L, "__gc");
	lua_pushcfunction(L, Liconv_close);
	lua_settable(L, -3);

	lua_pop(L, 1);


	lua_setglobal(L,"iconv");
	return 0;
}
