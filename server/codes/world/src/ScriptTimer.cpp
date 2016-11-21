/**
 * filename : ScriptTimer.cpp
 */

#include "lindef.h"
#include "LuaFunctor.h"
#include "LuaEngine.h"
#include "ScriptTimer.h"

ScriptTimer* ScriptTimer::s_pScriptTimer = NULL;
lua_State* ScriptTimer::s_pLuaState = NULL;
// 每一帧，处理定时器队列的时间限制
const unsigned int SCRIPT_FARME_TICK_TIMER = 500;

int ScriptTimer::init(lua_State* pState)
{
	s_pScriptTimer = new ScriptTimer();
	s_pLuaState = pState;
	toluaScriptTimerOpen(s_pLuaState);
	return 0;
}

int ScriptTimer::release()
{
	delete s_pScriptTimer;
	s_pScriptTimer = NULL;
	return 0;
}

int ScriptTimer::RegTimer(lua_State* pState)
{
	long long llTimeId = tolua_tonumber(pState, 1, 0);
	long long llElapse = tolua_tonumber(pState, 2, 0);
	long long llPeriod = tolua_tonumber(pState, 3, 0);
	ASSERT_(llTimeId >= 0);
	if (llTimeId <= 0)
		return -1;
	ScriptTimerInfo* pTimer = new ScriptTimerInfo(llTimeId, llElapse, llPeriod);
	if(s_pScriptTimer->addTimer(pTimer) == -1)
	{
		delete pTimer;
		return -1;
	}
	return 0;
}

int ScriptTimer::UnregTimer(lua_State* pState)
{
	long long llTimeId = tolua_tonumber(pState, 1, 0);
	if(s_pScriptTimer->delTimer(llTimeId) == -1)
		return -1;
	return 0;
}

int ScriptTimer::OnTimeClick(){
	_PriQueue& timerQueue = s_pScriptTimer->m_timerQueue;
	long long bt = GetTickCount();
	int count = 0;

	ScriptTimerInfo* p = NULL;
	while(!timerQueue.empty())
	{
		p = timerQueue.top();
		if(p->m_isValid == -1)
		{
			static LuaFunctor<TypeNull, long long, int> timerStop(s_pLuaState, "ManagedApp.timerFired");
			if (!timerStop(TypeNull::nil(), p->sn, ScriptTimerStop))
				TRACE1_L0("%s\n", timerStop.getLastError());
			delete p;
			timerQueue.pop();
			TRACE1_L4("--ScriptTimer::OnTimeClick(), canceled, queue size=%i\n", timerQueue.size());
			continue;
		}

		long long dwCurrent = GetTickCount();
		if(p->dwNextTime > dwCurrent)
		{
			break;
		}

		if(p->uiPeriod > 0)
		{
			p->dwLastTime = dwCurrent;
			p->dwNextTime = dwCurrent + p->uiPeriod;
			timerQueue.AdjustTop();
		}

		static LuaFunctor<TypeNull, long long, int> timerFired(s_pLuaState, "ManagedApp.timerFired");
		if (!timerFired(TypeNull::nil(), p->sn, ScriptTimerNormal))
			TRACE1_L0("%s\n", timerFired.getLastError());
		count++;

		if(p->uiPeriod <= 0)
		{
			static LuaFunctor<TypeNull, long long, int> timerExpire(s_pLuaState, "ManagedApp.timerFired");
			if (!timerExpire(TypeNull::nil(), p->sn, ScriptTimerExpire))
				TRACE1_L0("%s\n", timerExpire.getLastError());
			delete p;
			timerQueue.pop();
			s_pScriptTimer->m_timerCount--;
			TRACE1_L2("--ScriptTimer::OnTimeClick(), remove once timer, count=%i\n", s_pScriptTimer->m_timerCount);
		}
	}
	long long span = GetTickCount() - bt;
	if(span > SCRIPT_FARME_TICK_TIMER)
	{
		TRACE2_L0("--ScriptTimer::OnTimeClick(), handling %d timers for a rather long time in a timer frame: %dms\n",count, span);
	}
	return span;
}

int ScriptTimer::addTimer(ScriptTimerInfo* p)
{
	if(m_timerMap[p->sn])
		return -1;
	m_timerQueue.push(p);
	//m_timerMap.insert(map<long long, ScriptTimerInfo*>::value_type(p->sn, p));
	m_timerMap[p->sn] = p;
	s_pScriptTimer->m_timerCount++;
	return 0;
}

int ScriptTimer::delTimer(long long llTimeId)
{
	if(!m_timerMap[llTimeId])
		return -1;
	m_timerMap[llTimeId]->m_isValid = -1;
	m_timerMap.erase(llTimeId);
	return 0;
}

int ScriptTimer::toluaScriptTimerOpen(lua_State* pState)
{
	tolua_open(pState);
	tolua_usertype(pState,"ScriptTimer");
	tolua_module(pState, NULL, 0);
	tolua_beginmodule(pState, NULL);
	tolua_cclass(pState,"ScriptTimer", "ScriptTimer", "", NULL);
	tolua_beginmodule(pState, "ScriptTimer");
	tolua_function(pState, "RegTimer", RegTimer);
	tolua_function(pState, "UnregTimer", UnregTimer);
	tolua_endmodule(pState);
	tolua_endmodule(pState);
	return 1;
}
