/**
 * filename : PlayerMgr.cpp
 * desc : 角色管理
 */

#include "lindef.h"
#include "Sock.h"
#include "MsgLinksImpl.h"
#include "PlayerMgr.h"
#include "LinkContext.h"
#include "gateway.h"

void PlayerInfo::_Timeout()
{
	g_playerMgr.unregPlayer(roleId);
	LinkContext_Client* pClient = g_gateway.getClientLink(hLink);
	if ( pClient )
		pClient->_Close(CLOSE_RELEASE);
	return;
}

void PlayerInfo::_SwitchStatus(int s)
{
	if ( status == s )
		return;

	if ( hStatusTimer != NULL )
	{
		pThreadsPool->UnregTimer(hStatusTimer);
		hStatusTimer = NULL;
	}

	int interval = -1;
	if ( s == PLAYER_STATUS_INIT )				interval = ePlayerInitInterval;
	else if ( s == PLAYER_STATUS_VERIFYING )	interval = ePlayerVerifyingInterval;
	else if ( s == PLAYER_STATUS_LOADING )		interval = ePlayerLoadingInterval;
	else if ( s == PLAYER_STATUS_LOADED )		interval = ePlayerLoadedInterval;
	else if ( s == PLAYER_STATUS_UNLOADING )	interval = ePlayerUnloadingInterval;
	else if ( s == PLAYER_STATUS_UNLOADED )		interval = ePlayerUnloadedInterval;

	if ( interval != -1 )
		hStatusTimer = pThreadsPool->RegTimer( this, (HANDLE)s, 0, interval, 0, "Player Info state timer" );

	status = s;
	return;
}

HRESULT PlayerInfo::Do(HANDLE hContext)
{
	int state = (int)(long)(hContext);
	switch ( state )
	{
		case PLAYER_STATUS_VERIFYING:
			{
				_Timeout();
				TRACE1_L2("timeout(state PLAYER_STATUS_VERIFYING) of Player(%i) comes..\n", roleId);
			}
			break;
		case PLAYER_STATUS_LOADING:
			{
				_Timeout();
				TRACE1_L2("timeout(state PLAYER_STATUS_LOADING) of Player(%i) comes..\n", roleId);
			}
			break;
		case PLAYER_STATUS_UNLOADING:
			{
				g_gateway.send_MsgGS_UserLogoutInfo(this, 0, LOGOUT_REASON_EXCEPTION);
				_Timeout();
				TRACE1_L2("timeout(state PLAYER_STATUS_UNLOADING) of Player(%i) comes..\n", roleId);
			}
		default:
			{
				TRACE2_L2("timeout(error state %i) of Player(%i) comes..\n", state, roleId);
			}
			break;
	}
	return S_OK;
}

PlayerInfo* PlayerMgr::regPlayer(int roleId)
{
	std::pair< PlayerMapIter, bool > retPair = m_players.insert( PlayerMap::value_type(roleId, PlayerInfo(roleId)) );
	PlayerMapIter iter		= retPair.first;
	bool bFlag				= retPair.second;
	if ( bFlag )
		return &(iter->second);
	else
		return NULL;
}

bool PlayerMgr::unregPlayer(int roleId)
{
	PlayerMapIter iter = m_players.find(roleId);
	if ( iter != m_players.end() )
	{
		PlayerInfo& player = iter->second;
		if ( player.hLink != 0 )
		{
			LinkContext_Client* pClient = g_gateway.getClientLink(player.hLink);
			pClient->pPlayer = NULL;
		}
		m_players.erase(iter);
		return true;
	}
	return false;
}

PlayerInfo* PlayerMgr::getPlayerInfo(int roleId)
{
	PlayerMapIter iter = m_players.find(roleId);
	if ( iter != m_players.end() )
	{
		return &(iter->second);
	}
	return NULL;
}

void PlayerMgr::onLinkClosed(PlayerInfo* player)
{
	if ( !player ) return;
	player->hLink = 0;
	if ( player->status == PLAYER_STATUS_LOADED )
	{
		g_gateway.send_MsgGW_PlayerLogoutInfo(player, LOGOUT_REASON_CLIENT_FORCE);
	}
	TRACE0_L2("PlayerMgr::onLinkClosed(), the status of player\n");
	TRACE1_L2("\troleId = %i\t", player->roleId);
	TRACE1_L2("\tstatus = %i\t", player->status);
	TRACE1_L2("\tlogout = %i\t", player->logoutReason);
	return;
}

PlayerMgr g_playerMgr;
