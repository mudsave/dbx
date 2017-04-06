// A simple profile tool
#ifndef __PROFILE_H__
#define __PROFILE_H__
#include <string>

class IProfile {
public:
	struct CallInfo {
		std::string name;
		DWORD times;
		DWORD total;
		DWORD min;
		DWORD max;
	};

	struct EnterCall {
		std::string name;
		EnterCall(const char *szCallName):name(szCallName) {
			IProfile::Instance().enter(szCallName);
		}
		~EnterCall() {
			IProfile::Instance().exit(name.c_str());
		}
	};

private:
	bool m_bRunning;

public:
	static IProfile &Instance();
	virtual ~IProfile() {}

	void start() {
		m_bRunning = true;
	}
	void stop() {
		m_bRunning = false;
	}
	void enter(const char *szCallName) {
		if(m_bRunning) {
			onEnterCall(szCallName);
		}
	}
	void exit(const char *szCallName=NULL) {
		if(m_bRunning) {
			onExitCall(szCallName);
		}
	}

public:
	virtual const CallInfo *getCallInfo(const char *szCallName)=0 ;
	virtual void dump(const char *szFilName)=0; 
	virtual void clear()=0;

protected:
	virtual void onEnterCall(const char *szCallName)=0;
	virtual void onExitCall(const char *szCallName)=0;
};

#define PP_BY_NAME(name) IProfile::EnterCall __call_info(name)
#define PP_CALL() PP_BY_NAME(__FUNCTION__)

#define PP_ENTER_CALL(name) IProfile::Instance().enter(name)
#define PP_EXIT_CALL(name) IProfile::Instance().exit(name)
#define PP_EXIT() PP_EXIT_CALL(NULL)

#define PP_START() IProfile::Instance().start()
#define PP_STOP() IProfile::Instance().stop()
#define PP_CLEAR() IProfile::Instance().clear()
#define PP_DUMP(name) IProfile::Instance().dump(name)

#endif
