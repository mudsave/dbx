#include "stdafx.h"
#include "Record.h"
#include <algorithm>

CRecord::CRecord():m_nCurAttri(0),INIT_THREAD_SAFETY_MEMBER_FAST(AttrName),INIT_THREAD_SAFETY_MEMBER_FAST(AttrType),INIT_THREAD_SAFETY_MEMBER_FAST(AttrValue)
{

}
CRecord::~CRecord()
{
	ENTER_CRITICAL_SECTION_MEMBER(AttrValue);
	MAPATTRIVALUE::iterator iter = m_mapAttriValue.begin();
	for(; iter != m_mapAttriValue.end(); iter++){
		_deleteAttriValue(*iter);
	}
	m_mapAttriValue.clear();
	LEAVE_CRITICAL_SECTION_MEMBER;
	ENTER_CRITICAL_SECTION_MEMBER(AttrName);
	MAPATTRINAME::iterator iter_name = m_mapAttriName.begin();
	for(; iter_name != m_mapAttriName.end(); iter_name++){
		_deleteAttriName(*iter_name);
	}	
	m_mapAttriName.clear();
	LEAVE_CRITICAL_SECTION_MEMBER;
	ENTER_CRITICAL_SECTION_MEMBER(AttrType);
	m_mapAttriType.clear();
	LEAVE_CRITICAL_SECTION_MEMBER;
}

void* CRecord::readAttribute(int index, int* AttributeType /*out*/,char** name/*out*/)
{
	ENTER_CRITICAL_SECTION_MEMBER(AttrType);
	MAPATTRITYPE::iterator typeiter=m_mapAttriType.find(index);
	if (typeiter==m_mapAttriType.end())	
	{
		*AttributeType=0;
		return NULL;
	}
	
	*AttributeType=typeiter->second;
	LEAVE_CRITICAL_SECTION_MEMBER;
	ENTER_CRITICAL_SECTION_MEMBER(AttrName);
	MAPATTRINAME::iterator  nameiter=m_mapAttriName.find(index);
	*name=nameiter->second;
	LEAVE_CRITICAL_SECTION_MEMBER;
	ENTER_CRITICAL_SECTION_MEMBER(AttrValue);
	MAPATTRIVALUE::iterator valueiter=m_mapAttriValue.find(index);
	return valueiter->second;
	LEAVE_CRITICAL_SECTION_MEMBER;
}
bool CRecord::writeAttribute(int index,int AttributeType,void* pAttribute ,char* name/*in*/)
{
	return false;
}

bool CRecord::newAttribute(int AttributeType,void* pAttribute,int* pIndex/*out*/,char* name/*in*/)
{
	void* pTemp=NULL;
	ENTER_CRITICAL_SECTION_MEMBER(AttrType);
	m_mapAttriType.insert(std::make_pair(m_nCurAttri,AttributeType));
	
	pTemp=(void*)malloc(ObjDoMsg::getTypeSize(AttributeType));
	memcpy(pTemp,pAttribute,ObjDoMsg::getTypeSize(AttributeType));
	LEAVE_CRITICAL_SECTION_MEMBER;

	ENTER_CRITICAL_SECTION_MEMBER(AttrValue);
	m_mapAttriValue.insert(std::make_pair(m_nCurAttri,pTemp));
	LEAVE_CRITICAL_SECTION_MEMBER;

	ENTER_CRITICAL_SECTION_MEMBER(AttrName);
	char* pAttriName=(char*)malloc(strlen(name)+1);
	memcpy(pAttriName,name,strlen(name)+1);
	m_mapAttriName.insert(std::make_pair(m_nCurAttri,pAttriName));
	LEAVE_CRITICAL_SECTION_MEMBER;

	*pIndex=m_nCurAttri;
	m_nCurAttri++;
	return true;
}

int CRecord::getRecordSize(void)
{
	ENTER_CRITICAL_SECTION_MEMBER(AttrType);
	int totalSize=0;
	if (m_mapAttriType.begin()==m_mapAttriType.end()) return 0;
	
	MAPATTRITYPE::iterator iter = m_mapAttriType.begin();
	for(; iter != m_mapAttriType.end(); iter++){
		getAttributeSize(*iter, &totalSize);
	}
	return totalSize;
	LEAVE_CRITICAL_SECTION_MEMBER;
}

void CRecord::getAttributeSize(MAPATTRIPAIR iter,int* pSize)
{
	*pSize=*pSize+ObjDoMsg::getTypeSize(iter.second);
}

int CRecord::getAttributeCount(void)
{
	ENTER_CRITICAL_SECTION_MEMBER(AttrType);
	return (int)m_mapAttriType.size();
	LEAVE_CRITICAL_SECTION_MEMBER;
}

int CRecord::getAttriNameSize(void)
{
	ENTER_CRITICAL_SECTION_MEMBER(AttrName);
	int totalSize=0;
	if (m_mapAttriName.begin()==m_mapAttriName.end()) return 0;
	
	MAPATTRINAME::iterator iter = m_mapAttriName.begin();
	for(; iter != m_mapAttriName.end(); iter++){
		getAttributeNameSize(*iter, &totalSize);
	}
	return totalSize;
	LEAVE_CRITICAL_SECTION_MEMBER;
}

void CRecord::getAttributeNameSize(MAPATTRINAMEPAIR iter,int* pSize)
{
	*pSize=*pSize+(int)strlen(iter.second);
}


void CRecord::_deleteAttriValue(MAPATTRVALUEIPAIR ipair)
{
	if (ipair.second)
	{
		delete (char*)ipair.second;
	}
}
void CRecord::_deleteAttriName(MAPATTRINAMEPAIR ipair)
{
	if (ipair.second)
	{
		delete ipair.second;
	}
}