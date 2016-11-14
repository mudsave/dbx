// vsdef.h :
#pragma once

#pragma pack(push, 1)

//#include "HandleMgr.h"

typedef long NUMBER_TYPE;
typedef unsigned char byte;
typedef unsigned char			uchar;
typedef unsigned short			ushort;
typedef unsigned int			uint;
typedef long long				int64;
typedef int						int32;
typedef short					int16;
typedef char					int8;
typedef unsigned long long		uint64;
typedef unsigned int			uint32;
typedef unsigned short			uint16;
typedef unsigned char			uint8;

#define MAX_PATH_LEN 16  //客户端与服务器同步路径最大步数，如果一次行走大于该步数，需要分段同步。（原来为512步，未做分段同步） aric xu 2009-12-23
#define RECONNECT_DELAY		(2 * 1000)
#define HEART_BEAT_PERIOD 5
#define GRID_DISTANCE_MAX	512
#define MAX_GATEWAY_COUNT	128
#define MAX_SCENE_SVR_COUNT	256
#define MAX_APP_MSG_LEN			(8 * 1024)
#define MAX_SINK_MSG_LEN		(MAX_APP_MSG_LEN - 12)
#define MAX_MAP_COUNT			1024
#define MAX_MAP_LOAD_CLS_COUNT	64
#define MAX_WLD_COUNT			1024
#define MAX_PROP_COUNT			256
#define MAX_WORLD_ID			50
#define MIN_FIGHT_SERVER_ID		51
#define MAX_FIGHT_SERVER_ID		99
#define FREE_WORLD_ID			100
#define SOCIAL_WORLD_ID			101
///Kirk: DBID is a database allocated ID for any entity needs to be persistant
#define INVALID_WLD_ID			-1
#define INVALID_DB_ID              -1
#define INVALID_ENTITY_ID    -1
#define INVALID_ARRIDX			-1
//#define INVALID_HANDLE		((HANDLE)0)
#define INVALID_MAP_ID			-1
#define _IP_ADDR_LEN	16


#pragma pack(pop)
