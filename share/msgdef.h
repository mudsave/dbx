/**
 * filename : msgdef.h
 * desc : message definitions
 */

#ifndef __MSG_DEF_H_
#define __MSG_DEF_H_

#define _SHOWPARTS_LEN		8
#define _IP_ADDR_LEN		16
#define _PLAYER_NAME_LEN	64
#define _REMOULDATTR_LEN	64
#define _USER_ACCOUNT_LEN	64
#define _USER_PASSWD_LEN	64
#define _MaxMsgLength		65536

typedef unsigned int handle;

const int MAX_WORLDS		= 256;
const int MAX_GATEWAYS		= 128;

enum _LoginError
{
	LOGIN_SUCCESS,
	LOGIN_FAILED_PASSWD_ERROR,
	LOGIN_FAILED_PROCESSING,
};

enum _LogoutReason
{
	LOGOUT_REASON_INIT				= -2,		// the value of init
	LOGOUT_REASON_EXCEPTION			= -1,		// exception
	LOGOUT_REASON_CLIENT_NORMAL,				// normal from client
	LOGOUT_REASON_CLIENT_FORCE,					// force from client
	LOGOUT_REASON_SESSION_KICK,					// kick from session
	LOGOUT_REASON_WORLD_KICK,					// kick form world
	LOGOUT_REASON_WORLD_KICK_ALL,				// kick all player form world
	LOGOUT_REASON_WORLD_HEART,					// heart from world
	LOGOUT_REASON_RELOGIN_OTHER_GATE,			// relogin from other gateway
	LOGOUT_REASON_CLIENT_LITTLEBACK,			// littleback from client
};

enum _AppMsgClass
{
	MSG_CLS_DEFAULT = 0,
	MSG_CLS_STARTUP,
	MSG_CLS_LOGIN,
	MSG_CLS_PROP,
	MSG_CLS_SCENE_RPC,
	MSG_CLS_WORLD_RPC,
	MSG_CLS_LOGIC,
	MSG_CLS_OFFLINE,
	MSG_CLASS_MAX = 255
};

enum _AppMsgID
{
	MSG_S_BASE = 0,
	MSG_S_G_SYN_GATEWAY_INFO,
	MSG_S_G_UPDATE_GATEWAY_STATE,
	MSG_S_W_SYN_WORLD_INFO,
	MSG_S_W_UPDATE_WORLD_STATE,
	MSG_S_C_CHANGE_SESSION_STATE,

	MSG_S_C_CHECK_VERSION,
	MSG_S_C_USER_LOGIN,
	MSG_S_C_CHOOSE_ROLE,
	MSG_S_G_USER_VERIFY,
	MSG_S_G_USER_LOADED,
	MSG_S_G_USER_LOGOUT,

	MSG_S_C_USER_CREATE,
	MSG_S_C_ROLE_CREATE,
	MSG_S_C_ROLE_DELETE,
	MSG_S_C_CHECK_NAME,
	MSG_S_C_FIGHT_RECONNECT,

	MSG_S_W_FIGHT_SERVER_LOAD,


	MSG_G_BASE = 100,
	MSG_G_S_ACK_GATEWAY_INFO,
	MSG_G_W_SYN_WORLD_INFO,
	MSG_G_W_ACK_GATEWAY_INFO,

	MSG_G_S_KICK_ACCOUNT,
	MSG_G_S_ACK_USER_VERIFY,
	MSG_G_C_PLAYER_LOGIN,
	MSG_G_C_PLAYER_LOGOUT,
	MSG_G_C_PLAYER_LITTLEBACK,
	MSG_G_W_ACK_PLAYER_LOGIN,
	MSG_G_W_ACK_PLAYER_LOGOUT,
	MSG_G_W_SINK_PEER,
	MSG_G_W_SINK_PEERS,
	MSG_G_W_SINK_WORLD_PEERS,
	MSG_G_W_SINK_WORLD,

	MSG_G_S_OFFLINE_IN_FIGHT,

	MSG_W_BASE = 200,
	MSG_W_S_ACK_WORLD_INFO,
	MSG_W_S_UPDATE_GATEWAY_LIST,
	MSG_W_G_SYN_GATEWAY_INFO,

	MSG_W_G_PLAYER_LOGIN,
	MSG_W_G_PLAYER_LOGOUT,
	MSG_W_G_WORLD_PLAYERS_LOGOUT,

	MSG_W_G_OFFLINE_IN_FIGHT,
	MSG_W_S_CLEAR_OFF_FIGHT,
	MSG_W_S_START_FIGHT,
	MSG_W_S_STOP_FIGHT,


	MSG_C_BASE = 300,
	MSG_C_S_ACK_WORLD_LIST,
	MSG_C_S_ACK_USER_LOGIN,
	MSG_C_S_ACK_CHOOSE_ROLE,
	MSG_C_S_ACCOUNT_KICKED,
	MSG_C_G_ACK_PLAYER_LOGIN,
	MSG_C_G_ACK_PLAYER_LOGOUT,

	MSG_C_W_PROPSET_BIND,
	MSG_C_W_PROPSET_UNBIND,
	MSG_C_W_PROPSET_ENTER,
	MSG_C_W_PROPSET_EXIT,
	MSG_C_W_PROPS_UPDATE,
	MSG_C_W_SCENE_SWITCH,

	MSG_C_S_ACK_VERSION_CHECK,
	MSG_C_S_ACK_USER_CREATE,
	MSG_C_S_ACK_ROLE_CREATE,
	MSG_C_S_ACK_ROLE_DELETE,
	MSG_C_S_ACK_ROLE_CHECK,
	MSG_C_S_ACK_STATE_CHANGED,
};

#pragma pack(push, 1)

struct AppMsg
{
	unsigned short msgLen;          // message length
	unsigned char msgFlags;         // message reserved flag
	unsigned char msgCls;           // message class
	unsigned short msgId;           // message id
	int context;					// compatible with db
};

/////////////////////////////////////////////
/// msg for MSG_CLS_STARTUP
struct _MsgGS_SYN_GatewayInfo : public AppMsg
{
	short		gatewayId;
	char		addr_client[_IP_ADDR_LEN];
	short		port_client;
	char		addr_world[_IP_ADDR_LEN];
	short		port_world;
};

struct _MsgSG_ACK_GatewayInfo : public AppMsg
{
};

struct _MsgGS_UP_GatewayState : public AppMsg
{
	short clientCount;
	short worldCount;
	short worldIds[];
};

struct _MsgWS_SYN_WorldInfo : public AppMsg
{
	short		worldId;
};

struct _MsgSW_ACK_WorldInfo : public AppMsg
{
};

struct _MsgWS_UP_WorldState : public AppMsg
{
	short		playerCount;
};

struct _Gateway_Element
{
	short		gatewayId;
	char		addr[_IP_ADDR_LEN];
	short		port;
};

struct _MsgSW_UP_GatewayList : public AppMsg
{
	short				gatewayCount;
	_Gateway_Element	gateElements[];
};

struct _MsgWG_SYN_WorldInfo : public AppMsg
{
	short		worldId;
};

struct _MsgGW_SYN_GatewayInfo : public AppMsg
{
	short		gatewayId;
};

struct _MsgWG_ACK_GatewayInfo : public AppMsg
{
};

/////////////////////////////////////////////
/// msg for MSG_CLS_LOGIN
struct _World_Element
{
	int				worldId;
	int				playerCount;
};

struct _MsgSC_WorldListInfo : public AppMsg
{
	short			worldCount;
	_World_Element	worldList[];
};

struct _MsgCS_UserLoginInfo : public AppMsg
{
	char			accountName[_USER_ACCOUNT_LEN];
	char			passwd[_USER_PASSWD_LEN];
};

struct _Role_Element
{
	int				roleId;
	int				modelId;
	short			school;
	int				weaponID;
	char			showPart[_SHOWPARTS_LEN];
	short			level;
	char			name[_PLAYER_NAME_LEN];
	char			remouldAttr[_REMOULDATTR_LEN];
	int				showDrama;

};

struct _MsgSC_Login_ResultInfo : public AppMsg
{
	int				accountId;
	short			result;		/// 0 login succeed, 1 login failed
	short			reason;		/// number of roles, or the reason of failure
	_Role_Element	roleList[];
};

struct _MsgCS_ChooseRoleInfo : public AppMsg
{
	int			roleId;
	short		worldId;
};

struct _MsgSC_ChooseRole_ResultInfo : public AppMsg
{
	int			accountId;
	handle		hLink;
	short		gatewayId;
	char		addr[_IP_ADDR_LEN];
	short		port;
	int			version;
};

struct _MsgGS_UserVerifyInfo : public AppMsg
{
	handle		hLink;
	int			accountId;
	int			roleId;
	short		gatewayId;
	short		worldId;
	int			version;
};

struct _MsgSG_UserVerify_ResultInfo : public AppMsg
{
	int			roleId;
	int			result;
	int			version;
};

struct _MsgCG_PlayerLoginInfo : public AppMsg
{
	handle		hLink;
	int			accountId;
	int			roleId;
	short		gatewayId;
	short		worldId;
	int			version;
};

struct _MsgGC_PlayerLogin_ResultInfo : public AppMsg
{
	int			result;
};

struct _MsgCG_PlayerLogoutInfo : public AppMsg
{
	int			roleId;
};

struct _MsgGC_PlayerLogout_ResultInfo : public AppMsg
{
	int			roleId;
	int			result;
	int			reason;
};

struct _MsgGW_PlayerLoginInfo : public AppMsg
{
	int			roleId;
	int			gatewayId;
	handle		hClientLink;
	int			version;
};

struct _MsgWG_PlayerLogin_ResultInfo : AppMsg
{
	int			roleId;
	int			result;
	int			version;
};

struct _MsgGW_PlayerLogoutInfo : public AppMsg
{
	int			roleId;
	int			reason;
	int			version;
};

struct _MsgWG_PlayerLogout_ResultInfo : AppMsg
{
	int			roleId;
	int			result;
	int			reason;
	int			version;
};

struct _MsgWG_WorldPlayersLogout_ResultInfo : AppMsg
{
	short		worldId;
};

struct _MsgGS_UserLoginInfo : public AppMsg
{
	int			accountId;
	int			roleId;
	int			result;
	int			version;
};

struct _MsgGS_UserLogoutInfo : public AppMsg
{
	int			accountId;
	int			roleId;
	int			result;
	int			reason;
	int 		version;
};


struct _MsgSC_AccountKickedInfo : public AppMsg
{
};

struct _MsgSG_KickAccountInfo : public AppMsg
{
	int			accountId;
	int			roleId;
	int		 	version;
};

struct _MsgCS_LittleBackInfo :public AppMsg
{
	int 			roleId;
};

struct _MsgCS_StateChanged_Info : public AppMsg
{
	char 		accountName[_USER_ACCOUNT_LEN];
	char		passwd[_USER_PASSWD_LEN];
	bool		roleList;
};

struct _MsgSC_StateChanged_ResultInfo : public AppMsg
{
	bool ret;
};


/////////////////////////////////////////////
/// msg for MSG_CLS_LOGIN (create and delete)
struct _MsgCS_CreateUserInfo : public AppMsg
{
	char 		accountName[_USER_ACCOUNT_LEN];
	char		passwd[_USER_PASSWD_LEN];
};

struct _MsgSC_CreateUser_ResultInfo :public AppMsg
{
	int 			accountId;
	bool			ret;
	char			accountName[_USER_ACCOUNT_LEN];
};

struct _MsgCS_CreateRoleInfo : public AppMsg
{
	unsigned short 	school;
	unsigned short 	sex;
	unsigned short 	modelId;
	char 			roleName[_PLAYER_NAME_LEN];
	char 			showParts[_SHOWPARTS_LEN];
};

struct _MsgSC_CreateRole_ResultInfo : public AppMsg
{
	int 			roleId;
	bool			ret;
};

struct _MsgCS_DeleteRoleInfo :public AppMsg
{
	int 			roleId;
};

struct _MsgSC_DeleteRole_ResultInfo :public AppMsg
{
	int 			roleId;
	bool 			ret;
};

struct _MsgCS_CheckNameInfo : public AppMsg
{
	char			roleName[_PLAYER_NAME_LEN];
};

struct _MsgSC_CheckName_ResultInfo : public AppMsg
{
	bool 			ret;
};

/////////////////////////////////////////////
/// msg for MSG_CLS_DEFAULT
struct _MsgWG_SinkPeer : public AppMsg
{
	unsigned int	hClient;
};

struct PeerHandle
{
	unsigned int	hGate;
	unsigned int	hClient;
	short			gatewayId;
};

struct _MsgWG_SinkPeers : public AppMsg
{
	short			count;
	PeerHandle		hPeers[];
};

struct _MsgWG_SinkWorldPeers : public AppMsg
{
	short			worldId;
};

struct _MsgWG_SinkWorld : public AppMsg
{
	short			worldId;
};

/////////////////////////////////////////////
/// msg for MSG_CLS_PROP( Entity Msg )
struct _MsgWC_PropSetEnter : public AppMsg
{
	char			isMe;
	unsigned int	unitId;
	int				dbId;
	_PropSceneData	scene;
	GridVct			pos;
	char			dir;
	char			status;
	char			entityType;
	char			propSetId;
	short			propCount;
};

struct _MsgWC_PropSetExit : public AppMsg
{
	short			unitCount;
	unsigned int	units[];
};

struct _MsgWC_PropsUpdate : public AppMsg
{
	unsigned int	unitId;
	short			propCount;
};

struct _MsgWC_PropSetBind : public AppMsg
{
	unsigned int	unitId;
	char			entityType;
	char			propSetId;
	short			propCount;
};

struct _MsgWC_PropSetUnbind : public AppMsg
{
	unsigned int	unitId;
};

struct _MsgWC_SceneSwitch : public AppMsg
{
	int				unitId;
	_PropSceneData	scene;
	GridVct			pos;
	char			dir;
	char			status;
};

/// msg for fight server load status

struct FightServerLoad
{
	short serverId;
	int load;
};

struct _MsgSW_FightServerLoad: public AppMsg
{
	short count;
	FightServerLoad loads[];
};


//msg for MSG_CLS_OFFLINE

struct _MsgWG_OfflineInFight: public AppMsg
{
	int roleId;
	int version;
};

struct _MsgGS_OfflineInFight: public AppMsg
{
	int	accountId;
	int roleId;
	int version;
};

struct _MsgSC_OffFightReConnect : public AppMsg
{
	handle		hLink;
	int			accountId;
	int			roleId;
	short		worldId;
	short		gatewayId;
	char		addr[_IP_ADDR_LEN];
	short		port;
	int			version;
};

//msg for fight state

struct _MsgWS_StartFight: public AppMsg
{
	int accountId;
	int version;
};

struct _MsgWS_StopFight: public AppMsg
{
	int accountId;
	int version;
};

//msg for version check
struct _MsgCS_VersionCheck : public AppMsg
{
	int		version;
};

struct _MsgSC_VersionCheck_ResultInfo : public AppMsg
{
	bool		ret;
};

struct _MsgWS_ClearOffFightInfo : public AppMsg
{
	int accountId;
	int version;
};

#pragma pack(pop)

#endif
