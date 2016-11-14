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
inline bool PopResult(lua_State *L,int &result){
	bool b_success = false;
	if(lua_isnumber(L,-1)){
		result = (int)lua_tointeger(L,-1);
		b_success = true;
	}
	lua_pop(L,1);
	return b_success;
}

//从lua栈中弹出短整形数
template<>
inline bool PopResult(lua_State *L,short &result){
	bool b_success = false;
	if(lua_isnumber(L,-1)){
		result = (short)lua_tointeger(L,-1);
		b_success = true;
	}
	lua_pop(L,1);
	return b_success;
}

//从lua栈中弹出字节
template<>
inline bool PopResult(lua_State *L,unsigned char &result){
	bool b_success = false;
	if(lua_isnumber(L,-1)){
		result = (unsigned char)lua_tointeger(L,-1);
		b_success = true;
	}
	lua_pop(L,1);
	return b_success;
}

//从lua栈中弹出一个handle
template<>
inline bool PopResult(lua_State *L,handle &result){
	bool b_success = false;
	if(lua_isnumber(L,-1)){
		result = (handle)lua_tointeger(L,-1);
		b_success = true;
	}
	return b_success;
}

//从lua栈中弹出布尔值
template<>
inline bool PopResult(lua_State *L,bool &result){
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
inline bool PopResult(lua_State *L,NumberVector &result){
	if(lua_istable(L,-1)){
		return GetLuaTable(L,-1,result);
	}
	return false;
}

//从lua栈中弹出一个字符串数组
template<>
inline bool PopResult(lua_State *L,StringVector &result){
	if(lua_istable(L,-1)){
		return GetLuaTable(L,-1,result);
	}
	return false;
}

//弹出lua栈中的一个表到暂存区
template<>
inline bool PopResult(lua_State *L,TypeTable &result){
	if(lua_istable(L,-1)){
		result.self = luaL_ref(L,LUA_REGISTRYINDEX);
		return true;
	}else{
		lua_pop(L,1);
		return false;
	}
}

//弹出lua栈中的一个自定义数据
template<>
inline bool PopResult(lua_State *L,TypeUser &result){
	lua_pop(L,1);
	return false;
}

//lua退栈工具...
template<class T>
class ResultPoper{
public:
	static bool Pop(lua_State *L,T &result){
		return PopResult(L,result);
	}
};


class LuaHelper{
private:
	static std::string &lastError(){
		static std::string s_sLastError;
		return s_sLastError;
	}
public:
	static void setLastError(const char *szFmt,...){
		static char buff[256];
		va_list args;
		va_start(args,szFmt);
		vsprintf(buff,szFmt,args);
		lastError() = buff;
	}
	static const std::string &getLastError(){
		return lastError();
	}
};

//从全局环境中搜索一个函数
inline bool FindMethod(lua_State *L,const std::string &funcName){
	int top = lua_gettop(L);
	std::string::size_type i = funcName.find_first_of('.');
	if(i != std::string::npos){
		std::vector<std::string> parts;
		std::string::size_type start = 0;
		do{
			parts.push_back(funcName.substr(start,i - start));
			start = i + 1;
			i = funcName.find_first_of('.',start);
		}while(i!=std::string::npos);
		parts.push_back(funcName.substr(start));

		lua_getglobal(L,parts[0].c_str());
		if(!lua_istable(L,-1)){
			lua_settop(L,top);
			goto FuncNotFound;
		}

		std::vector<std::string>::size_type visz = parts.size();
		if(visz-- > 2){
			std::vector<std::string>::size_type vi = 1;
			while(vi < visz){
				lua_pushstring(L,parts[vi].c_str());
				lua_gettable(L,-2);
				if(!lua_istable(L,-1)){
					goto FuncNotFound;
				}vi++;
			}
		}

		lua_pushstring(L,parts[visz].c_str());
		lua_gettable(L,-2);
		lua_remove(L,-2);
	}else{
		lua_getglobal(L,funcName.c_str());
	}

	if(!lua_isfunction(L,-1)){
		goto FuncNotFound;
	}else{
		return true;
	}
FuncNotFound:
	LuaHelper::setLastError("can not locate global function %s",funcName.c_str());
	lua_settop(L,top);
	return false;
}

//获得一个函数，并将这个函数放置到注册环境中
inline int PushMethod(lua_State *L,const std::string &funcName){
	if(FindMethod(L,funcName)){
		return luaL_ref(L,LUA_REGISTRYINDEX);
	}else{
		return LUA_NOREF;
	}
}

template<class R=TypeNull,class A=TypeNull,class B=TypeNull,class C=TypeNull,class D=TypeNull>
class LuaFunctor{
	private:
		LuaFunctor& operator=(const LuaFunctor &functor){
		}
	public:
		//从栈中获得函数
		LuaFunctor(lua_State *L, int func):m_pState(L),m_iFunc(func),m_bNeedAttain(false){
		}
		//通过函数名初始化这个函数
		LuaFunctor(lua_State *L, const std::string &func):m_pState(L),m_iFunc(LUA_NOREF),m_bNeedAttain(true),m_sFuncName(func){
		}
		//拷贝函数
		LuaFunctor(const LuaFunctor &functor):m_pState(functor.m_pState),m_iFunc(functor.m_iFunc),m_bNeedAttain(functor.m_bNeedAttain),m_sFuncName(m_sFuncName){
		}
		~LuaFunctor(){
			if(LUA_NOREF != m_iFunc){
				luaL_unref(m_pState,LUA_REGISTRYINDEX,m_iFunc);
				m_iFunc = LUA_NOREF;
			}
		}
		//重载调用运算符，使得封装了lua函数的类可以作为函数调用
		bool operator()(R& result=TypeNull::nil(),const A& a=TypeNull::nil(),const B& b=TypeNull::nil(),
				const C& c=TypeNull::nil(),const D& d=TypeNull::nil())
		{
			if(m_bNeedAttain){
				m_iFunc = PushMethod(m_pState,m_sFuncName);
				if(LUA_NOREF == m_iFunc){
					return false;
				}
				m_bNeedAttain = false;
			}
			//从暂存区取得函数
			lua_rawgeti(m_pState, LUA_REGISTRYINDEX, m_iFunc);
			int args = 0;//参数个数
			ParamPusher<A,B,C,D>::Push(m_pState, args, a, b, c, d);
			if( lua_pcall(m_pState, args, IsNull(result) ? 0 : 1, 0) ){
				LuaHelper::setLastError("call lua function %s failed:\n%s",m_sFuncName.c_str(),lua_tostring(m_pState,-1));
				lua_pop(m_pState,1);
				return false;
			}
			if(!IsNull(result)){
				return ResultPoper<R>::Pop(m_pState, result);
			}
			return true;
		}
		static bool Call(lua_State *L,const std::string& szFuncName,R& result=TypeNull::nil(),const A& a=TypeNull::nil(),const B& b=TypeNull::nil(),
				const C& c=TypeNull::nil(),const D& d=TypeNull::nil()){
			if(!FindMethod(L,szFuncName)){
				return false;
			}
			int args = 0;	
			ParamPusher<A,B,C,D>::Push(L,args,a,b,c,d);
			if( lua_pcall(L,args,IsNull(result)?0:1,0) ){
				LuaHelper::setLastError("call lua function %s failed:\n%s",szFuncName.c_str(),lua_tostring(L,-1));
				lua_pop(L,1);
				return false;
			}
			if(!IsNull(result)){
				return ResultPoper<R>::Pop(L,result);
			}
			return true;
		}
		static const char* getLastError(){
			return LuaHelper::getLastError().c_str();
		}
	private:
		lua_State *m_pState;
		int m_iFunc;
		bool m_bNeedAttain;
		std::string m_sFuncName;
};

//于未知的恐惧，于傲慢而无知的恐惧
#endif
