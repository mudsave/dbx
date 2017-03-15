#pragma once
#include <list>
#include "DBThread.h"
#include "MsgParse.h"
//#define UseMutiThread //从DB返回使用单独一个线程
class CPlayer;
class CClient;
class AppMsg;
class CCommandClient :
	public CThread 
{
public:

	CCommandClient(void);
	static CCommandClient* getCommandClient();
	void doFunciton(void);
	void OnRecv(AppMsg* pMsg);
	
	void ParseMsg(AppMsg* pMsg);
	bool ValidateMsg(AppMsg* pMsg);
	void RepeatMsg(AppMsg* pMsg);
	void running();
	DECLARE_THREAD_SAFETY_MEMBER(MapMsg);
public:
	~CCommandClient(void);
private:
	
	void parseMsg(MAPMSGPAIR iter);
	CPlayer* callLoad(int index,AppMsg* pMsg);
	bool setResult(int index,AppMsg* pMsg);
	MAPMSG m_mapMsg;
	
};
