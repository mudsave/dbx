/**
 * filename : PlayerMgr.h
 * desc : 角色管理
 */

#ifndef __PLAYER_MGR_H_
#define __PLAYER_MGR_H_

#include <map>

enum _PlayerStatus
{
	PLAYER_STATUS_INIT,
	PLAYER_STATUS_VERIFYING,
	PLAYER_STATUS_LOADING,
	PLAYER_STATUS_LOADED,
	PLAYER_STATUS_UNLOADING,
	PLAYER_STATUS_UNLOADED
};

enum _PlayerStatusIntervals
{
	ePlayerInitInterval			= -1,
	ePlayerVerifyingInterval	= 1000,
	ePlayerLoadingInterval		= 1000,
	ePlayerLoadedInterval		= -1,
	ePlayerUnloadingInterval	= 1000,
	ePlayerUnloadedInterval		= -1
};

struct PlayerInfo : public ITask
{
	int		accountId;
	int		roleId;
	int		gatewayId;
	int		worldId;
	int		status;
	int		logoutReason;
	handle	hLink;
	handle	hWorldLink;
	HANDLE	hStatusTimer;
	IThreadsPool*   pThreadsPool;

public:
	PlayerInfo() : accountId(-1), roleId(-1),
		gatewayId(-1), worldId(-1),
		status(ePlayerInitInterval),
		logoutReason(LOGOUT_REASON_INIT),
		hLink(0), hWorldLink(0),
		hStatusTimer(NULL),
		pThreadsPool(NULL)
	{
		pThreadsPool = GlobalThreadsPool();
	}

	PlayerInfo(int rId) : accountId(-1), roleId(rId),
		gatewayId(-1), worldId(-1),
		status(ePlayerInitInterval),
		logoutReason(LOGOUT_REASON_INIT),
		hLink(0), hWorldLink(0),
		hStatusTimer(NULL),
		pThreadsPool(NULL)
	{
		pThreadsPool = GlobalThreadsPool();
	}

	~PlayerInfo(){}

public:
	void _Timeout();

	void _SwitchStatus(int s);

public:
	virtual HRESULT Do(HANDLE hContext);
};

class PlayerMgr
{
public:
	PlayerMgr(){};

	~PlayerMgr(){};

public:
	PlayerInfo* regPlayer(int roleId);

	bool unregPlayer(int roleId);

	PlayerInfo* getPlayerInfo(int roleId);

public:
	void onLinkClosed(PlayerInfo* player);

public:
	typedef std::map<int, PlayerInfo> PlayerMap;
	typedef PlayerMap::iterator PlayerMapIter;

public:
	PlayerMapIter begin() { return m_players.begin(); }

	PlayerMapIter end() { return m_players.end(); }

private:
	PlayerMap		m_players;
};

extern PlayerMgr g_playerMgr;

#endif
