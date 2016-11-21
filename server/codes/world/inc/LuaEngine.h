#ifndef __LUA_ENGINE_H
#define __LUA_ENGINE_H

#include "lua.hpp"
#include <string>
#include <cstring>
#include <cstdio>
#define MaxPrintBuffLength 10*1024
class CLuaEngine{
	public:
		/*
		 * 创建lua环境并初始化
		 */
		bool Create(void){
			m_pState = lua_open();
			if(m_pState){
				luaL_openlibs(m_pState);
				lua_checkstack(m_pState,1024);
				registerUtilsFunction();
				return true;
			}
			return false;
		}

		/*
		 * 释放lua环境，
		 * 加载的C++模块能正确释放吗?
		 */
		void Release(void){
			if(m_pState){
				lua_close(m_pState);
				m_pState = 0;
			}
		}

		/*
		 * 执行一个脚本文件
		 */
		bool LoadLuaFile(const char *szFileName){
			if(!szFileName || !m_pState){
				return false;
			}
			int top = lua_gettop(m_pState);
			bool b_success = false;
			do{
				if(luaL_dofile(m_pState,szFileName)){
					m_sLastErr = lua_tostring(m_pState,-1);
					break;
				}
				b_success = true;
			}while(false);
			lua_settop(m_pState,top);
			if(!b_success){
				fprintf(stderr,"load file %s failed:%s\n",szFileName,m_sLastErr.c_str());
			}
			return b_success;
		}

		/*
		 * 执行脚本字符串
		*/
		bool RunMemoryLua(const char *pLuaData,size_t nDataLen){
			if(!pLuaData || !m_pState){
				return false;
			}
			if(nDataLen < 1){
				nDataLen = strlen(pLuaData);
			}
			if(nDataLen < 1){
				return false;
			}
			int top = lua_gettop(m_pState);
			bool b_success = false;
			do{
				if(luaL_loadbuffer(m_pState,pLuaData,nDataLen,"?") ||
						lua_pcall(m_pState,0,0,0)){
					m_sLastErr = lua_tostring(m_pState,-1);
					break;
				}
				b_success = true;
			}while(false);
			lua_settop(m_pState,top);
			if(!b_success){
				fprintf(stderr,"run memory luafailed:%s\n",m_sLastErr.c_str());
			}
			return b_success;
		}

		/*
		 * 获得lua环境
		 */
		lua_State *GetLuaState(void){
			return m_pState;
		}

		/*
		 * 取得最后一次的lua错误
		 * lua的字符串的指针在lua字符串从栈中移除后可能无效
		 */
		const char *GetError(void){
			return m_sLastErr.c_str();
		}

		/*
		 * 构造函数
		 */
		CLuaEngine(void):m_pState(0),m_sLastErr(""){
		}

		/*
		 * 析构函数
		 */
		~CLuaEngine(void){
			Release();
		}

		/*
		 * 创建lua环境封装
		 */
		static CLuaEngine *CreateLuaEngineProc(void){
			static CLuaEngine s_LuaEngine;
			if(!s_LuaEngine.m_pState){
				if(!s_LuaEngine.Create()){
					s_LuaEngine.Release();
					return 0;
				}
			}
			return &s_LuaEngine;
		}
		static int luaA_Trace(lua_State *L)
		{
			int n = lua_gettop(L);  /* 参数个数 */
			int i;
			lua_getglobal(L, "tostring");
			static char buff[MaxPrintBuffLength]={0};
			int count = 0;
			if(buff[0] == '\0')memcpy(buff,"[lua:]",7);
			memset(buff+6,0,MaxPrintBuffLength-6);
			count = 6;
			for (i=1; i<=n; i++) {
				const char *s;
				lua_pushvalue(L, -1);  /* function to be called */
				lua_pushvalue(L, i);   /* value to print */
				lua_call(L, 1, 1);
				s = lua_tostring(L, -1);  /* get result */
				
				if (s == NULL)
					return luaL_error(L, "`tostring' must return a string to `print'");

				int len = strlen(s);
				if ((count + len + 1)> MaxPrintBuffLength)
				{
					return luaL_error(L, "`tostring' length too long!");
				}
				
				if (i>1) 
				{
					
					strcat(buff,"\t");
				}
				strcat(buff,s);
				count = count + len + 1;
				lua_pop(L, 1);  /* pop result */
			}
			if ((count + 1)> MaxPrintBuffLength)
			{
				return luaL_error(L, "`tostring' length too long!");
			}
			else
			{
				strcat(buff,"\n");
			}
			TRACE0_L2(buff);
			return 0;
		}
	private:
		void registerUtilsFunction()
		{
			lua_register(m_pState, "print", luaA_Trace);
		}
		
	private:
		lua_State *		m_pState;		//lua环境
		std::string		m_sLastErr;		//最后一次出错信息
};

#endif
