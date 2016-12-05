/**
 * filename : ScriptTimer.cpp
 */

#ifndef __SCRIPTTIMER_H_
#define __SCRIPTTIMER_H_

#include "PriorityQueue.h"
#include <map>

using namespace std;

enum ScriptTimerState
{
	ScriptTimerNormal, //正常
	ScriptTimerExpire, //过期
	ScriptTimerStop, //被注销
};

struct ScriptTimerInfo
{
public:
	ScriptTimerInfo(long long llTimeId, long long llElapse, long long llPeriod):
	uiPeriod(llPeriod), sn(llTimeId), m_isValid(1)
	{
		dwLastTime = GetTickCount();
		dwNextTime = dwLastTime + llElapse;
	}

	~ScriptTimerInfo()
	{
	}

	long long dwLastTime;			// 上一次调度时刻
	long long dwNextTime;			// 下一次调度时刻
	long long uiPeriod;				// 触发周期
	long long sn;					// 定时器ID
	int m_isValid;					//定时器是否有效,用于删除

	struct _Less
	{
		bool operator()(const ScriptTimerInfo* l, const ScriptTimerInfo* r) const
		{
			// 如果两者都在同一个时间轮回，大者愈小
			if( ( l->dwNextTime >= l->dwLastTime && r->dwNextTime >= r->dwLastTime ) ||
				( l->dwNextTime < l->dwLastTime && r->dwNextTime < r->dwLastTime ) )
			{
				return ( l->dwNextTime > r->dwNextTime ) || 
					( l->dwNextTime == r->dwNextTime && l->sn > r->sn );
			}

			if(l->dwNextTime < l->dwLastTime)
				return ( r->dwNextTime >= 0x80000000 ) ? true : ( l->dwNextTime > r->dwNextTime );
			else
				return ( l->dwNextTime >= 0x80000000 ) ? false : ( l->dwNextTime > r->dwNextTime );
		}
	};
};


class ScriptTimer{
public:
	static int init(lua_State* pState);
	static int release();
	static int RegTimer(lua_State* pState);
	static int UnregTimer(lua_State* pState);
	static int OnTimeClick();
	static int toluaScriptTimerOpen(lua_State* pState);
public:
	static ScriptTimer* s_pScriptTimer;
	static lua_State* s_pLuaState;

private:
	ScriptTimer():m_timerCount(0){};
public:
	int addTimer(ScriptTimerInfo* p);
	int delTimer(long long llTimeId);
public:
	typedef PriorityQueue<ScriptTimerInfo*, ScriptTimerInfo::_Less> _PriQueue;
	_PriQueue m_timerQueue;
private:
	typedef map<long long, ScriptTimerInfo*> _TimerMap;
	_TimerMap m_timerMap;
	int m_timerCount;
};

int getLuaTick();
#endif