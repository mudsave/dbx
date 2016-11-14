#include "stdafx.h"
#include "RecordSet.h"
#include "Record.h"
#include <algorithm>

CRecordSet::CRecordSet():m_nCurRec(0),INIT_THREAD_SAFETY_MEMBER_FAST(Record)
{

}
CRecordSet::~CRecordSet()
{
	ENTER_CRITICAL_SECTION_MEMBER(Record);
	
	MAPREC::iterator iter = m_mapRecSet.begin();
	for(; iter != m_mapRecSet.end(); iter++){
		_deleteRecord(*iter);
	}
	LEAVE_CRITICAL_SECTION_MEMBER;
}

IRecord* CRecordSet::readRecord(int index)
{
	ENTER_CRITICAL_SECTION_MEMBER(Record);
	MAPREC::iterator iter=m_mapRecSet.find(index);
	if (iter==m_mapRecSet.end()) return NULL;
	return iter->second;
	LEAVE_CRITICAL_SECTION_MEMBER;
}

bool CRecordSet::writeRecord(IRecord* pRecord,int index)
{
	return false;
}

IRecord* CRecordSet::newRecord(int* pIndex/*out*/)
{
	ENTER_CRITICAL_SECTION_MEMBER(Record);
	IRecord* pRecord=new CRecord();
	m_mapRecSet.insert(std::make_pair(m_nCurRec,pRecord));
	*pIndex=m_nCurRec;
	m_nCurRec++;
	return pRecord;
	LEAVE_CRITICAL_SECTION_MEMBER;
}

int CRecordSet::getRecordSetSize(void)
{
	ENTER_CRITICAL_SECTION_MEMBER(Record);
	int totalSize=0;
	if (m_mapRecSet.begin()==m_mapRecSet.end()) return 0;
	
	MAPREC::iterator iter = m_mapRecSet.begin();
	for(; iter != m_mapRecSet.begin(); iter++){
		getRecordSetSize(*iter, &totalSize);
	}
	return totalSize;
	LEAVE_CRITICAL_SECTION_MEMBER;
}

void CRecordSet::getRecordSetSize(MAPPAIR ipair,int* pSize)
{
	*pSize=*pSize+(int)ipair.second->getRecordSize();
}

void CRecordSet::_deleteRecord(MAPPAIR ipair)
{
	if (ipair.second)
	{
		delete ipair.second;
	}
}
int CRecordSet::getRecordCount(void)
{
	ENTER_CRITICAL_SECTION_MEMBER(Record);
	return (int)m_mapRecSet.size();
	LEAVE_CRITICAL_SECTION_MEMBER;
}
