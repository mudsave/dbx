#pragma once
#include "IDBARecordSet.h"
#include <map>
class CRecordSet :public IRecordSet
{
public:
	CRecordSet();
	virtual ~CRecordSet();
	typedef std::map<int,IRecord*> MAPREC;
	typedef std::pair<int,IRecord*> MAPPAIR;
	IRecord* readRecord(int index);
	bool writeRecord(IRecord* pRecord,int index);
	IRecord* newRecord(int* pIndex/*out*/);
	int getRecordSetSize(void);
	int getRecordCount(void);
private:
	DECLARE_THREAD_SAFETY_MEMBER(Record);
	void _deleteRecord(MAPPAIR ipair);
	void getRecordSetSize(MAPPAIR ipair,int* pSize);
	MAPREC	m_mapRecSet;
	int		m_nCurRec;
};