#include "lindef.h"
#include "Profile.h"
#include <map>

static struct timeval stv;

#define GetTimeTick() (gettimeofday(&stv,0),(stv.tv_sec%60)*1000000 + stv.tv_usec)
#define DiffTime(prev,now) (now<prev?now+60*1000000-prev:now-prev) // diff two time slots between one minutes

class CProfile:public IProfile {
public:
	typedef std::map<std::string,CallInfo *> HCallInfo;
	struct CallNode {
		CallNode *	next;
		CallInfo *	info;
		DWORD		when;
	};

private:
	HCallInfo m_hCallInfo;
	CallNode *m_pStack;
	CallNode *m_pNodes;

private:
	CallInfo *
	findCallInfo(const std::string &szCallName) {
		HCallInfo::iterator result = m_hCallInfo.find(std::string(szCallName));
		return m_hCallInfo.end() != result ? result->second : NULL;
	}
	CallInfo *
	makeCallInfo(const std::string &name) {
		CallInfo *info = findCallInfo(name);
		if(!info) {
			info = new CallInfo();
			info->name = name;
			info->total = 0;
			info->min = 0xEFFFFFFF;
			info->max = 0;
			m_hCallInfo.insert(HCallInfo::value_type(name,info));
		}
		return info;
	}

	CallNode *
	newCallNode() {
		CallNode *node = m_pNodes;
		if(node) {
			m_pNodes = node->next;
		} else {
			node = new CallNode();
		}
		return node;
	}
	void 
	freeCallNode(CallNode *node) {
		node->next = m_pNodes;
		m_pNodes = node;
	}
	
	CallNode *
	pushCall(CallInfo *info) {
		CallNode *node = newCallNode();	

		node->info = info;
		node->next = m_pStack;
		node->when = GetTimeTick();
		node->next = m_pStack;

		info->times ++;
		
		m_pStack = node;

		return node;
	}
	void
	popCall(const CallInfo *info) {
		CallNode *node = m_pStack;
		ASSERT_(node);
		if(!node) {
			TRACE0_L0("Pop Call Failed:no call record!\n");
			return;
		}
		ASSERT_(info?node->info==info:true);
		if(info && node->info != info) {
			TRACE2_L0("Pop Wrong Call:%s execepted,got %s\n",info->name.c_str(),node->info->name.c_str());
			return;
		}
		m_pStack = node->next;

		DWORD now = GetTimeTick();
		DWORD duration = DiffTime(node->when,now);
		if(node->info->min > duration) {
			node->info->min = duration;
		}
		if(node->info->max < duration) {
			node->info->max = duration;
		}
		node->info->total += duration;

		freeCallNode(node);
	}
public:
	CProfile():m_pStack(0),m_pNodes(0) {
		start();
	}
	virtual 
	~CProfile() {
		clear();
	}

public:
	virtual void 
	onEnterCall(const char *szCallName) {
		pushCall( makeCallInfo( std::string(szCallName) ) );
	}
	virtual void 
	onExitCall(const char *szCallName) {
		popCall( szCallName?findCallInfo( std::string(szCallName) ):NULL );	
	}
	virtual const CallInfo *
	getCallInfo(const char *szCallName) {
		return findCallInfo( std::string(szCallName) );
	} 
	virtual void
	dump(const char *szFileName) {
		FILE *file = fopen(szFileName,"w");
		if(!file) {
			TRACE1_L0("Can not open %s for writing profile log\n",szFileName);
			return;
		}
		fprintf(file,"Name,Times,Total,Average,Max,Min\n");
		for(HCallInfo::iterator it = m_hCallInfo.begin();it!=m_hCallInfo.end();it++) {
			const CallInfo *info = it->second;
			fprintf(file,
				"%s,%u,%u,%u,%u,%u\n",
				info->name.c_str(),
				info->times,
				info->total,
				info->total / info->times,
				info->max,
				info->min
			);
		}
		fclose(file);
	}
	virtual void
	clear() {
		CallNode *node;

		node = m_pStack;
		while(node) {
			CallNode *prev = node;
			node = node->next;
			delete prev;
		}
		m_pStack = NULL;
		
		node = m_pNodes;
		while(node) {
			CallNode *prev = node;
			node = node->next;
			delete prev;
		}
		m_pNodes = NULL;
		
		for(HCallInfo::iterator it = m_hCallInfo.begin();it!=m_hCallInfo.end();it++) {
			delete it->second;
		}
		m_hCallInfo.clear();
	}
};

IProfile &IProfile::Instance() {
	static CProfile instance;
	return instance;
}
