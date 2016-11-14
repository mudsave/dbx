#ifndef __LUAARRAY_H_
#define __LUAARRAY_H_

#include "MsgDefine.h"
#include <map>

class CLuaArray
{
public:
	CLuaArray(CSCResultMsg* pData = NULL)
	{
		if (pData)
		{
			if (pData->msgLen>0)
			{
				m_pData=(CSCResultMsg*)malloc(pData->msgLen);
				memcpy(m_pData,pData,pData->msgLen);
				m_pData->getInit();
			}
		}
		else
			m_pData=NULL;
		m_nCount=0;
		m_pValue=NULL;
		m_pTypeList=NULL;
	}

	CLuaArray(CLuaArray &obj)
	{
		*this=obj;
	}
	~CLuaArray()
	{
		if (m_pData)
		{
			free(m_pData);
			m_pData=NULL;
			m_nCount=0;
		}
		release();
	}
	CSCResultMsg* getResMsg()
	{
		return m_pData;
	}
	static CLuaArray* createLuaArray()
	{
		CLuaArray* p_LuaArray=new CLuaArray(NULL);
		return p_LuaArray;
	}
	static int createLuaArray(lua_State* pState)
	{  
		tolua_pushusertype(pState,(CLuaArray*)createLuaArray(),"CLuaArray");
		return 1;
	}
	static int destroyLuaArray(lua_State* pState)
	{
		CLuaArray* pSelf = (CLuaArray*) tolua_tousertype(pState, 1, 0);
		if(!pSelf) pSelf= (CLuaArray*)tolua_tousertype(pState,2,0);
		if (pSelf)
		{
			destroyLuaArray(pSelf);
			tolua_pushnumber(pState, 1);  	
		}
		else
			tolua_pushnumber(pState, 0); 
		return 1;
	}
	static void destroyLuaArray(CLuaArray *pSelf)
	{
		if (pSelf) delete pSelf;
	}
	static int getSize(int* pTypeList,int nCount)
	{
		int nSize=0;
		for (int i=0;i<nCount;i++)
		{
			nSize=nSize+ObjDoMsg::getTypeSize(pTypeList[i]);
		}
		return nSize;
	}


	static int getResultofArray(lua_State* pState)
	{
		int tolua_index;
		tolua_Error tolua_err;
		CLuaArray** self=NULL;
		self= (CLuaArray**) tolua_tousertype(pState, 1, 0);
		if(!self)
		{
			self=(CLuaArray**)tolua_tousertype(pState,2,0);
			if (!tolua_isnumber(pState,3,0,&tolua_err))
				tolua_error(pState,"#vinvalid type in array indexing.",&tolua_err);
			tolua_index = (int)tolua_tonumber(pState,3,0);

		}
		else
		{
			if (!tolua_isnumber(pState,2,0,&tolua_err))
				tolua_error(pState,"#vinvalid type in array indexing.",&tolua_err);
			tolua_index = (int)tolua_tonumber(pState,2,0);

		}
		
		if (self==NULL) 
		{
			lua_pushnil(pState);
			return 1;
		}

		
		if (self[tolua_index]==NULL)
		{
			lua_pushnil(pState);
			return 1;
		}
		else
		{
			if (self[tolua_index]->m_pData==NULL)
			{
				lua_pushnil(pState);
				return 1;
			}
		}

		tolua_pushusertype(pState,(void*)self[tolua_index],"CLuaArray");
		return 1;
	}

	static int getResult(lua_State* pState)
	{

		CLuaArray* self = (CLuaArray*) tolua_tousertype(pState, 1, 0);
		if(!self) self=(CLuaArray*)tolua_tousertype(pState,2,0);

		if (self==NULL) 
		{
			lua_pushnil(pState);
			return 1;
		}
	

		if (self->m_pData==NULL)
		{
			lua_pushnil(pState);
			return 1;
		}
		char* pTemp=(char*)self->m_pData; unused(pTemp);
		int resCount=self->m_pData->getResCount();
		int resAttriNameCount=self->m_pData->m_nAttriNameCount;
		char* pAttriName=NULL;
		int valueType;
		void* pValue=NULL;
		lua_checkstack(pState,-1);
#ifndef MULTIRESULT
		lua_newtable(pState);
#endif
		
		for (int i=0;i<resCount;i++)
		{
 			lua_newtable(pState);	
			for (int j=0;j<resAttriNameCount;j++)
 			{
 				pValue=self->m_pData->getAttribute(&pAttriName,&valueType,j,i);
				lua_pushlstring(pState,(char*)pAttriName,strlen(pAttriName));
				switch(valueType)
				{
				case PARAMINT:
					lua_pushnumber(pState,*(int*)pValue);
					break;
				case PARAMBOOL:
					lua_pushboolean(pState,*(bool*)pValue);
					break;
				case PARAMFLOAT:
					lua_pushnumber(pState,*(float*)pValue);
					break;
				default:
					if (valueType>=0)
					{
						lua_pushlstring(pState,(char*)pValue,valueType);
					}
				}
 				lua_rawset(pState, -3);
  				if (pAttriName!=NULL) free( pAttriName);
 			}
#ifndef MULTIRESULT
			lua_rawseti(pState, -2,i+1);
#endif
			
 		}
#ifndef MULTIRESULT
		return 1;
#else
		return resCount;
#endif

	}
	static int setResult(lua_State* pState)
	{
	
		CLuaArray* self = (CLuaArray*) tolua_tousertype(pState, 1, 0);
		if(!self) self=(CLuaArray*)tolua_tousertype(pState,2,0);

		if (self==NULL) 
		{
			lua_pushnil(pState);
			return 1;
		}
		int spId = (int) lua_tonumber(pState, 3);

		/*
		#define LUA_TNIL		0
		#define LUA_TBOOLEAN		1
		#define LUA_TLIGHTUSERDATA	2
		#define LUA_TNUMBER		3
		#define LUA_TSTRING		4
		#define LUA_TTABLE		5
		#define LUA_TFUNCTION		6
		#define LUA_TUSERDATA		7
		#define LUA_TTHREAD		8
		*/
		int nResCount=0;
		int nCount=0;
		int AttrNameSize=0;
		if(lua_istable(pState,-1))
		{
			lua_pushnil(pState);
			while (lua_next(pState, -2))
			{
				int key = (int) lua_tonumber(pState, -2); unused(key);
				if(lua_istable(pState,-1))
				{
					lua_pushnil(pState);
					while (lua_next(pState, -2))
					{
						if (!nResCount) nCount++;
						size_t nSize=0;
						const char* value =lua_tolstring(pState, -2, &nSize); unused(value);
						AttrNameSize = AttrNameSize + static_cast<int>(nSize);
						lua_pop(pState, 1);
					}
				}
				nResCount++;
				lua_pop(pState, 1);
			}
		}
		self->release();
		self->create(nCount*nResCount, 0);
		if(lua_istable(pState,-1))
		{
			int j=0;
			lua_pushnil(pState);
			while (lua_next(pState, -2))
			{
				int key = (int) lua_tonumber(pState, -2); unused(key);
				if(lua_istable(pState,-1))
				{
					lua_pushnil(pState);
					int i=0;
					while (lua_next(pState, -2))
					{	switch(lua_type(pState, -1))
						{
						case LUA_TBOOLEAN:
							self->m_pTypeList[j+i]=PARAMBOOL;
							break;
						case LUA_TNUMBER:
							{
								float value = lua_tonumber(pState, -1);
								float res=0;
								if (!(res=(value-(int)value)))
									self->m_pTypeList[j+i]=PARAMINT;
								else
									self->m_pTypeList[j+i]=PARAMFLOAT;
								break;
							}
						case LUA_TSTRING:{
							size_t size_int_t = 0;
							lua_tolstring(pState, -1, &size_int_t);
							self->m_pTypeList[j+i] = static_cast<int>(size_int_t);
							break;
						}
						default:
							self->m_pTypeList[j+1]=0;
							lua_pushnil(pState);
							return 1;
						}
						lua_pop(pState, 1);
						i++;
					}
					j=j+i;
				}
				lua_pop(pState, 1);
			}
		}
		int dataSize=0;
		for(int i=0;i<nResCount;i++)
		{
			dataSize=dataSize+getSize(self->m_pTypeList+(nCount*i),nCount);
		}
		int msgLen=sizeof(CSCResultMsg)+(nResCount+1)*nCount*sizeof(int)+dataSize+AttrNameSize;
		if (msgLen<0)
		{
			lua_pushnil(pState);
			return 1;
		}
		if(self->m_pData) free(self->m_pData);			//kirk
		self->m_pData=(CSCResultMsg*) malloc(msgLen);
		memset(self->m_pData,0,msgLen);
		self->m_pData->msgLen=msgLen;
		self->m_pData->init();
		self->m_pData->initAttribute();
		self->m_pData->m_spId=spId;
		if(lua_istable(pState,-1))
		{
			int j=0;
			lua_pushnil(pState);
			while (lua_next(pState, -2))
			{
				int key = (int) lua_tonumber(pState, -2);
				if(lua_istable(pState,-1))
				{
					lua_pushnil(pState);
					int i=0;
					while (lua_next(pState, -2))
					{
						char* pTemp=NULL;
						size_t size_int_t = 0;
						const char* value = lua_tolstring(pState, -2, &size_int_t);
						int nSize = static_cast<int>(size_int_t);
						nSize=ObjDoMsg::getTypeSize(self->m_pTypeList[j+i]);
						if (nSize<0) continue;
						pTemp=(char*)malloc(nSize);
						memset(pTemp,0,nSize);

						switch(self->m_pTypeList[j+i])
						{
						case PARAMINT:
							{
								int value = lua_tonumber(pState, -1);
								*(int*)pTemp=value;
							}
							break;
						case PARAMBOOL:
							{
								int value = lua_toboolean(pState, -1);
								*(bool*)pTemp=(bool)value;
							}
							break;
						case PARAMFLOAT:
							{
								float value = lua_tonumber(pState, -1);
								*(float*)pTemp=(float)value;
							}
							break;
						default :
							if (self->m_pTypeList[j+i]>=0)
							{
								size_t size_int_t = 0;
								const char* value = lua_tolstring(pState, -1, &size_int_t);
								self->m_pTypeList[j+i] = static_cast<int>(size_int_t);
								memcpy(pTemp, value, self->m_pTypeList[j+i]);
							}
							break;
						}
						lua_pop(pState, 1);
						if(key==1) 
							self->m_pData->setAttribute(const_cast<char*>(value),pTemp,self->m_pTypeList[j+i]);
						else
							self->m_pData->setAttribute(NULL,pTemp,self->m_pTypeList[j+i]);
						if (pTemp) 
						{
							free(pTemp);
							pTemp=NULL;
						}
						i++;
					}
					j=j+i;
				}
				lua_pop(pState, 1);
			}
		}
		tolua_pushnumber(pState, 1);  
		return 1;
	}

	static int tolua_CLuaArray_open(lua_State* pState)
	{
		tolua_open(pState);

		tolua_usertype(pState,"CLuaArray");
		tolua_module(pState, NULL, 0);
		tolua_beginmodule(pState, NULL);
		tolua_cclass(pState,"CLuaArray", "CLuaArray", "", NULL);
		tolua_beginmodule(pState, "CLuaArray");
		tolua_function(pState, "getResult",getResult);
		tolua_function(pState, "setResult",setResult);
		tolua_function(pState, "createLuaArray",createLuaArray);
		tolua_function(pState, "destroyLuaArray",destroyLuaArray);
		tolua_function(pState, "getResultofArray",getResultofArray);
		tolua_endmodule(pState);
		tolua_endmodule(pState);

		return 1;
	}

private:
	void create(int nCount,int nSize)
	{
		if (nCount>0)
		{
			this->m_nCount=nCount;
			this->m_pTypeList=(int*)malloc(nCount*sizeof(int));
		}
		if (nSize>0) this->m_pValue=(void*)malloc(nSize);
	}
	void release()
	{
		if (m_pValue)
		{
			free(m_pValue);	
			m_pValue=NULL;
			m_nCount=0;
		}
		if (m_pTypeList)
		{
			free(m_pTypeList);
			m_pTypeList=NULL;
			m_nCount=0;
		}

	}

	static char* transferFirstChar(char* str)
	{
		if ((*str) >= 'a' )
			if(*(str+1)>='a')
				(*str)-='a'-'A';
		return str;
	}

private:
	int m_nCount;
	void* m_pValue;
	int* m_pTypeList;
	CSCResultMsg* m_pData;


	struct userValue
	{
		int valueType;
		void* value;
	};

	typedef std::map<int,std::string> KEYATTRI;
	typedef std::map<std::string,userValue> ATTRIVALUE;
	typedef std::map<int,ATTRIVALUE> ATTRIVALUESET;
	typedef std::map<int,KEYATTRI> KEYATTRISET;
	
};



#endif
