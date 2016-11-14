#include <map>

struct AppMsg;

class CINT
{
public:
	CINT(int sessionId):m_nSessionId(sessionId),m_nTempObjId(0)
	{
		static int temp=0;
		m_nCurTime=temp;
		temp=temp+1;
	}
	~CINT()
	{

	}
	bool operator < (const CINT &cint)const
	{
		return m_nCurTime<cint.m_nCurTime?true:false;
	}
	int m_nCurTime;
	int m_nSessionId;
	int m_nTempObjId;
};
typedef std::multimap<CINT,AppMsg*> MAPMSG;
typedef std::pair<CINT,AppMsg*> MAPMSGPAIR;
template<class T>
class CMsgParse
{
public:
	
	
	inline int OnRecv(long lSize, BYTE* pData ,T * pSession,CINT &sessionId,MAPMSG* pMapMsg )
	{
		if (!pSession) return 0;
		DECLARE_THREAD_SAFETY_STATIC_MEMBER(MapMsg);
		int ret = 0;
		BYTE *buf;
		AppMsg* pMsg=NULL;
		while(ret + (long)sizeof(AppMsg) <= lSize)
		{
			if(pData)
			{
				pMsg = reinterpret_cast<AppMsg*>(pData + ret);
				if(ret + pMsg->msgLen > lSize) break;
				buf=(BYTE*)malloc(pMsg->msgLen);
				memcpy(buf,pMsg,pMsg->msgLen);
				pMsg = (AppMsg*)buf;
			}
			else
			{
				buf=(BYTE*)malloc(lSize);  //由客户销毁
				if (!buf) 
				{
					DBAPRINT0(C_LOCAL,this,ParseMsg,0,DBAERROR,"CMsgParse OnRecv malloc failed!");
					break;
				}
				pMsg=reinterpret_cast<AppMsg*>(buf);
				HRESULT res=pSession->Peek(buf, sizeof(WORD));
				if((ret + pMsg->msgLen > lSize)||(res==E_FAIL)) 
				{
					free(buf);
					break;
				}
				pSession->Recv(buf, pMsg->msgLen);				
			}
			ENTER_CRITICAL_SECTION_MEMBER(MapMsg);
			pMapMsg->insert(std::make_pair(sessionId,pMsg));
			LEAVE_CRITICAL_SECTION_MEMBER;
			ret += pMsg->msgLen;
		}
		if(pData)
		{
			free(pData);
			pData=NULL;
		}
		return ret;
	}
	inline  void ParseMsg(AppMsg* pMsg)
	{
		return;
	}
	inline  bool ValidateMsg(AppMsg* pMsg)
	{
		return false;
	}
	inline void RepeatMsg(AppMsg* pMsg)
	{
		return;
	}
};
