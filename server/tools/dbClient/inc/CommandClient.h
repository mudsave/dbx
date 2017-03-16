#pragma once

class AppMsg;

class CCommandClient
{
public:
	static CCommandClient* getCommandClient();

	void OnRecv(AppMsg* pMsg);
	
	

private:
	bool setResult(int index,AppMsg* pMsg);
	
    void ParseMsg(AppMsg* pMsg);
};
