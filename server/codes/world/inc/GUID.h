#ifndef __GUID_H__
#define __GUID_H__

typedef unsigned long long uint64;

uint64 new_guid(short world,short type);
const char *new_guid_lua(short world,short type);
const char *uint64_to_string(uint64 value);
uint64 string_to_uint64(const char *str);

#define MAKE_GUID(w,t,s,ts) (uint64(s)|(uint64(ts)<<20)|(uint64(t)<<52)|(uint64(w)<<56))

#define NEW_GUID(worldId,type) new_guid(worldId,type)
#define NEW_GUID_LUA(worldId,type) new_guid_lua(worldId,type)

#define GUID2STR(guid) uint64_to_string(guid)
#define STR2GUID(str) string_to_uint64(str)

#define IS_EMPTY_GUID(guid) (0 == guid)

#define GUID_WORLD(guid) (DWORD)((guid >> 56) & 0xFF)
#define GUID_TYPE(guid) (DWORD)((guid >> 52) & 0xF)
#define GUID_TIMESTAMP(guid) (DWORD)((guid>>20)&0xFFFFFFFF)
#define GUID_SERIAL(guid) (DWORD)(guid & 0xFFFFF)


#endif
