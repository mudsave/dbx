#ifndef __LUA_FUNCTOR_H__
#define __LUA_FUNCTOR_H__

/*
 * readme:
 *	LuaFunctor demo:
 *		LuaFunctor<ReturnType,ParamType,...> func(lua_State *L,const char *szFuncName);
 *		bool func(ReturnType &ret,const ParamType &paramOne,...);
 *	current supported input type:
 *		basic value type(long,double,...,etc.),
 *		TypeTable( struct that holds an reference of  lua value [ multi-lua state is not supported ] )
 *		TypeNull( empty param or the end tag of function params )
 *		TypeUser( named pointer,such name mush register in tolua first )
 *	current supported outout type:
 *		basic value type reference(int &,bool &,double &)
 *		TypeTable reference( to keep the ret value )
 *		TypeUser reference( not implemented )
 *		StringVector reference
 *		NumberVector reference

*/

#include "lua.hpp"
#include "tolua++.h"
#include <vector>
#include <string>

//位于暂存区的表
struct TypeTable{
	int self;
	TypeTable(int s):self(s){
	}
	TypeTable():self(LUA_NOREF){
	}
};

//空类型，默认值
struct TypeNull{
	inline static TypeNull& nil(){
		static TypeNull nil;
		return nil;
	}
};

//用户类型
struct TypeUser{
	void *data;
	const char *typeName;
	TypeUser(void *d,const char *n):data(d),typeName(n){
	}
};

//获得lua栈上指定索引的自定义类型数据并赋值给一个指针
template<class T>
inline bool GetLuaValue(lua_State *L,int index,T &value){
	if(lua_isuserdata(L,index)){
		value = (T)tolua_tousertype(L,index,0);
		return true;
	}
	return false;
}

//获得lua栈上的一个字符串
template<>
inline bool GetLuaValue(lua_State *L,int index,const char *&value){
	if(lua_isstring(L,index)){
		value = lua_tostring(L,index);
		return true;
	}
	return false;
}

//获得lua栈上一个字符串
template<>
inline bool GetLuaValue(lua_State *L,int index,std::string &value){
	if(lua_isstring(L,index)){
		value = std::string(lua_tostring(L,index));
		return true;
	}
	return false;
}

//获得lua栈上的一个数字
template<>
inline bool GetLuaValue(lua_State *L,int index,lua_Number &value){
	if(lua_isnumber(L,index)){
		value = lua_tonumber(L,index);
		return true;
	}
	return false;
}

//获得lua栈上的一个表，取得其某种类型的所有数据，并放入到向量容器中
template<class Value>
inline bool GetLuaTable(lua_State *L,int index,std::vector<Value> &result){
	if(!lua_istable(L,index)){
		return false;
	}
	for(int i = 1; ;i++){
		lua_rawgeti(L,index,i);
		if(lua_isnil(L,-1)){
			lua_pop(L,1);
			break;
		}
		Value value;
		if(GetLuaValue(L,-1,value)){
			result.push_back(value);
		}
		lua_pop(L,1);
	}
	return true;
}

//压C++数据到lua栈中
template<class T>
inline void PushParam(lua_State *L,T param){
}

//压C++对象到lua栈
template<>
inline void PushParam(lua_State *L,TypeUser param){
	tolua_pushusertype(L,param.data,param.typeName);
}

//压C++中暂存的lua表到lua栈
template<>
inline void PushParam(lua_State *L,TypeTable param){
	lua_rawgeti(L,LUA_REGISTRYINDEX,param.self);
}

//压入一个字节到lua栈
template<>
inline void PushParam(lua_State *L,unsigned char param){
	lua_pushinteger(L,param);
}

//压入一个整形数字到lua栈
template<>
inline void PushParam(lua_State *L,int param){
	lua_pushinteger(L,param);
}

//压入一个单精度浮点数到lua栈
template<>
inline void PushParam(lua_State *L,float param){
	lua_pushnumber(L,param);
}

//压入一个双精度浮点数到lua栈
template<>
inline void PushParam(lua_State *L,double param){
	lua_pushnumber(L,param);
}

//压入一个短整形数到lua栈
template<>
inline void PushParam(lua_State *L,short param){
	lua_pushinteger(L,param);
}

//压入一个长整型到lua栈
template<>
inline void PushParam(lua_State *L,long long param){
	lua_pushinteger(L,param);
}

//压入一个布尔值到lua栈<注意 lua的布尔类型是数字>
template<>
inline void PushParam(lua_State *L,bool param){
	lua_pushboolean(L,param?1:0);
}

//压入一个handle到lua栈
template<>
inline void PushParam(lua_State *L,handle param){
	lua_pushinteger(L,(lua_Integer)param);
}

//参数入栈工具
template<class A = TypeNull,class B = TypeNull,class C = TypeNull,class D = TypeNull>
class ParamPusher{
	public:
		//将一行不同类型的参数压入栈
		static void Push(lua_State *L, int &index, const A &a = TypeNull::nil(), const B &b = TypeNull::nil(),
				const C &c = TypeNull::nil(),const D &d = TypeNull::nil()){
			PushParam(L, a);//压入第一个参数
			ParamPusher<B,C,D>::Push(L, ++index, b, c, d);//使用迭代
		}
};

//入栈工具的空类型实现
template<>
class ParamPusher<TypeNull,TypeNull,TypeNull>{
	public:
		static void Push(lua_State *L,int &index,const TypeNull &a = TypeNull::nil(),const TypeNull &b = TypeNull::nil(),
				const TypeNull &c = TypeNull::nil(),const TypeNull &d = TypeNull::nil()){
		}
};

//判断类型空
template<class T>
inline bool IsNull(const T& obj){
	return false;//其它类型都不是空
}

template<>
inline bool IsNull(const TypeNull& obj){
	return true;//空类型是空
}

//可以从lua栈中取出的两种类型的数组
typedef std::vector<lua_Number> NumberVector;//数字数组
typedef std::vector<std::string> StringVector;//字符串数组


//从lua栈中弹出某一种类型的数据
template<class T>
inline bool PopResult(lua_State *L,T &result){
	lua_pop(L,1);
	return false;//默认什么也弹不出
}

//从lua栈中弹出字符串 @Warnning 不建议使用
template<>
inline bool PopResult(lua_State *L,const char *&result){
	bool b_success = false;
	if(lua_isstring(L,-1)){
		result = lua_tostring(L,-1);
		b_success = true;
	}
	lua_pop(L,1);//不安全的使用，不能在lua的字符串离栈后保留这个字符串指针！
	return b_success;
}

//从lua栈中弹出字符串
template<>
inline bool PopResult(lua_State *L,std::string &result){
	bool b_success = false;
	if(lua_isstring(L,-1)){
		result = std::string(lua_tostring(L,-1));
		b_success = true;
	}
	lua_pop(L,1);
	return b_success;
}

//从lua栈中弹出双精度浮点数
template<>
inline bool PopResult(lua_State *L,double &result){
	bool b_success = false;
	if(lua_isnumber(L,-1)){
		result = (double)lua_tonumber(L,-1);
		b_success = true;
	}
	lua_pop(L,1);
	return b_success;
}

//从lua栈中弹出单精度浮点数
template<>
inline bool PopResult(lua_State *L,float &result){
	bool b_success = false;
	if(lua_isnumber(L,-1)){
		result = (float)lua_tonumber(L,-1);
		b_success = true;
	}
	lua_pop(L,1);
	return b_success;
}

//从lua栈中弹出长整型数
template<>
inline bool PopResult(lua_State *L,long long &result){
	bool b_success = false;
	if(lua_isnumber(L,-1)){
		result = (long long)lua_tointeger(L,-1);
		b_success = true;
	}
	lua_pop(L,1);
	return b_success;
}

//从lua栈中弹出整形数
template<>
inline bool PopResult(lua_State *L,int &result) {
	bool b_success = false;
	if(lua_isnumber(L,-1)) {
		result = (int)lua_tointeger(L,-1);
		b_success = true;
	}
	lua_pop(L,1);
	return b_success;
}

//从lua栈中弹出短整形数
template<>
inline bool PopResult(lua_State *L,short &result) {
	bool b_success = false;
	if(lua_isnumber(L,-1)) {
		result = (short)lua_tointeger(L,-1);
		b_success = true;
	}
	lua_pop(L,1);
	return b_success;
}

//从lua栈中弹出字节
template<>
inline bool PopResult(lua_State *L,unsigned char &result) {
	bool b_success = false;
	if(lua_isnumber(L,-1)) {
		result = (unsigned char)lua_tointeger(L,-1);
		b_success = true;
	}
	lua_pop(L,1);
	return b_success;
}

//从lua栈中弹出一个handle
template<>
inline bool PopResult(lua_State *L,handle &result) {
	bool b_success = false;
	if(lua_isnumber(L,-1)){
		result = (handle)lua_tointeger(L,-1);
		b_success = true;
	}
	return b_success;
}

//从lua栈中弹出布尔值
template<>
inline bool PopResult(lua_State *L,bool &result) {
	bool b_success = false;
	if(lua_isboolean(L,-1)){
		result = lua_toboolean(L,-1)?true:false;
		b_success = true;
	}
	lua_pop(L,1);
	return b_success;
}

//从lua栈中弹出一个数字数组
template<>
inline bool PopResult(lua_State *L,NumberVector &result) {
	if(lua_istable(L,-1)){
		return GetLuaTable(L,-1,result);
	}
	return false;
}

//从lua栈中弹出一个字符串数组
template<>
inline bool PopResult(lua_State *L,StringVector &result) {
	if(lua_istable(L,-1)){
		return GetLuaTable(L,-1,result);
	}
	return false;
}

//弹出lua栈中的一个表到暂存区
template<>
inline bool PopResult(lua_State *L,TypeTable &result) {
	if(lua_istable(L,-1)) {
		result.self = luaL_ref(L,LUA_REGISTRYINDEX);
		return true;
	}else {
		lua_pop(L,1);
		return false;
	}
}

//弹出lua栈中的一个自定义数据
template<>
inline bool PopResult(lua_State *L,TypeUser &result) {
	lua_pop(L,1);
	return false;
}

//lua退栈工具...
template<class T>
class ResultPoper{
public:
	static bool Pop(lua_State *L,T &result) {
		return PopResult(L,result);
	}
};


class LuaHelper{
public:
	static bool findMethod(lua_State *L,const std::string &funcName){
		std::string cmd = "return "+funcName;
		if( luaL_loadstring(L,cmd.c_str()) || lua_pcall(L,0,1,0) ) {
			// const char *errMsg = lua_tostring(L,-1);
			lua_pop(L,1);
			lua_pushnil(L);
			return false;
		} else if( !lua_isfunction(L,-1) ) {
			return false;
		}
		return true;
	}

	static int pushMethod(lua_State *L,const std::string &funcName) {
		if( !findMethod(L,funcName) ) {
			lua_pop(L,1);
			return LUA_NOREF;
		}
		return lua_ref(L,LUA_REGISTRYINDEX);
	}

	static int getPanic(lua_State *L) {
		static void *panic = 0;
		int top = lua_gettop(L);
		lua_pushlightuserdata(L,&panic);
		lua_rawget(L,LUA_REGISTRYINDEX);
		if( !lua_isfunction(L,-1) ) {
			lua_pop(L,1);
			if( panic ) {
				return 0;
			}
			panic = &panic; // 这样这个函数就只限于在单协程中使用了
			if(!findMethod(L,"ManagedApp.onLuaError")) {
				TRACE0_L0("Error handle function \"ManagedApp.onLuaError()\" not assigned!\n");
				lua_pop(L,1);
				return 0;
			}
			lua_pushlightuserdata(L,&panic);
			lua_pushvalue(L,-2);
			lua_rawset(L,LUA_REGISTRYINDEX);
		}
		return top + 1;
	}
};

template<class R=TypeNull,class A=TypeNull,class B=TypeNull,class C=TypeNull,class D=TypeNull>
class LuaFunctor{
	private:
		LuaFunctor& operator=(const LuaFunctor &functor){
		}
		void setFunc(int index) {
			if( 0 == index ) {
				lua_pushfstring(m_state,"can not locate global function %s",m_path.c_str());
			} else if( lua_isfunction(m_state,index) ) {
				lua_pushvalue(m_state,index);
			} else {
				lua_pushfstring(m_state,"unnamed Functor expected a function,got %s",lua_typename(m_state,lua_type(m_state,index)));
			}
			m_ref = &m_ref;
			lua_pushlightuserdata(m_state,&m_ref);
			lua_insert(m_state,-2);
			lua_rawset(m_state,LUA_REGISTRYINDEX);
		}
	public:
		LuaFunctor(lua_State *L, int index = -1):m_state(L),m_ref(NULL) {
			setFunc(index);
		}
		LuaFunctor(lua_State *L, const std::string &path):m_state(L),m_ref(NULL),m_path(path) {
		}
		~LuaFunctor() {
			if( m_ref ) {
				lua_pushlightuserdata(m_state,&m_ref);
				lua_pushnil(m_state);
				lua_rawset(m_state,LUA_REGISTRYINDEX);
			}
		}

		bool operator()(R& result=TypeNull::nil(),const A& a=TypeNull::nil(),const B& b=TypeNull::nil(),const C& c=TypeNull::nil(),const D& d=TypeNull::nil()) {
			int panic = LuaHelper::getPanic(m_state);
			bool bSuccess = false;
			do {
				lua_pushlightuserdata(m_state,&m_ref);
				lua_rawget(m_state,LUA_REGISTRYINDEX);
				if( !lua_isfunction(m_state,-1) && !m_ref ) {
					lua_pop(m_state,1);
					setFunc(LuaHelper::findMethod(m_state,m_path)?-1:0);
				}
				if( !lua_isfunction(m_state,-1) ) {
					if(!panic) {
						lua_pop(m_state,1); //保留错误信息
					}
					break;
				}
				int args = 0;//参数个数
				ParamPusher<A,B,C,D>::Push(m_state, args, a, b, c, d);
	
				if( lua_pcall( m_state,args,IsNull(result)?0:1,panic ) ) {
					lua_pop(m_state,1);
					break;
				}

				if( !IsNull(result) &&  !ResultPoper<R>::Pop(m_state,result) ) {
					if ( panic ) {
						// 弹出返回值失败,且有出错处理,则添加出错信息
						lua_pushfstring(m_state,"Pop return value of %s failed!",m_path.c_str());
					}
					break;
				}
				bSuccess = true;
			} while(false);
			if(panic) {
				int errs = lua_gettop(m_state) - panic;
				if(errs) {
					if( lua_pcall(m_state,errs,0,0) ) {
						TRACE1_L0("fatal error:execute panic function failed:%s\n",lua_tostring(m_state,-1));
						lua_pop(m_state,1);
					}
				} else {
					lua_remove(m_state,panic);
				}
			}
			return bSuccess;
		}
		static bool Call(lua_State *L,const std::string& szFuncName,R& result=TypeNull::nil(),const A& a=TypeNull::nil(),const B& b=TypeNull::nil(),
				const C& c=TypeNull::nil(),const D& d=TypeNull::nil()){
			int panic = LuaHelper::getPanic(L);
			bool bSuccess = false;
			do {
				if(!LuaHelper::findMethod(L,szFuncName)){
					lua_pop(L,1);
					if( panic ) {
						lua_pushfstring(L,"can not locate global function %s",szFuncName.c_str());
					}
					break;
				}
				int args = 0;
				ParamPusher<A,B,C,D>::Push(L,args,a,b,c,d);
				if( lua_pcall( L,args,IsNull(result)?0:1,panic ) ) {
					lua_pop(L,1);
					break;
				}
				if( !IsNull(result) && !ResultPoper<R>::Pop(L,result) ) {
					if( panic ) {
						lua_pushfstring(L,"Pop return value of %s failed!",szFuncName.c_str());
					}
					break;
				}

				bSuccess = true;
			} while(false);
			if(panic) {
				int errs = lua_gettop(L) - panic;
				if(errs) {
					if( lua_pcall(L,errs,0,0) ) {
						TRACE1_L0("fatal error:execute panic function failed:%s\n",lua_tostring(L,-1));
						lua_pop(L,1);
					}
				} else {
					lua_remove(L,panic);
				}
			}
			return bSuccess;
		}
	private:
		lua_State *m_state;	// lua 状态
		void *m_ref;		// lua 函数在注册表中的键,以地址作为键
		std::string m_path;	// lua 函数的路径
};

//于未知的恐惧，于傲慢而无知的恐惧
#endif
