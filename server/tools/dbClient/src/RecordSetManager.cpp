#include "stdafx.h"
#include "RecordSetManager.h"
#include "RecordSet.h"
#include <algorithm>

CRecordSetManager::CRecordSetManager():m_nCurRecSet(0),INIT_THREAD_SAFETY_MEMBER_FAST(RecordSet)
{
	
}

CRecordSetManager::~CRecordSetManager()
{
	ENTER_CRITICAL_SECTION_MEMBER(RecordSet);
	MAPRECSET::iterator iter = m_mapRecSetManager.begin();
	for(; iter != m_mapRecSetManager.end(); iter++){
		_deleteRecordSet(*iter);
	}
	m_mapRecSetManager.clear();
	LEAVE_CRITICAL_SECTION_MEMBER;
}

IRecordSet* CRecordSetManager::newRecordSet(int* pIndex/*out*/)
{
	ENTER_CRITICAL_SECTION_MEMBER(RecordSet);
	IRecordSet* pRecordSet=new CRecordSet();
	m_mapRecSetManager.insert(std::make_pair(m_nCurRecSet,pRecordSet));
	*pIndex=m_nCurRecSet;
	m_nCurRecSet++;
	return pRecordSet;
	LEAVE_CRITICAL_SECTION_MEMBER;
}
bool CRecordSetManager::deleteRecordSet(int index)
{
	ENTER_CRITICAL_SECTION_MEMBER(RecordSet);
	MAPRECSET::iterator iter=m_mapRecSetManager.find(index);
	if (iter!=m_mapRecSetManager.end())
	{
		if(iter->second) 
		{
			delete iter->second;
			m_mapRecSetManager.erase(iter);
			return true;
		}
	}
	return false;
	LEAVE_CRITICAL_SECTION_MEMBER;
}

bool CRecordSetManager::_deleteRecordSet(MAPRECSETPAIR ipair)
{
	if (ipair.second)
	{
		delete ipair.second;
		return true;
	}
	return false;
}
IRecordSet* CRecordSetManager::findRecordSet(int index)
{
	ENTER_CRITICAL_SECTION_MEMBER(RecordSet);
	MAPRECSET::iterator iter=m_mapRecSetManager.find(index);
	if (iter==m_mapRecSetManager.end()) return NULL;
	return iter->second;
	LEAVE_CRITICAL_SECTION_MEMBER;
}
