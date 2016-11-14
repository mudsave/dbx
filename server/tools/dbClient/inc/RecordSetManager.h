#pragma once
#include "IDBARecordSet.h"
#include <map>

class CRecordSetManager :public IRecordSetManager
{
public:
	typedef std::map<int,IRecordSet*> MAPRECSET;
	typedef std::pair<int,IRecordSet*> MAPRECSETPAIR;
	CRecordSetManager();
	virtual ~CRecordSetManager();
	IRecordSet* newRecordSet(int* pIndex/*out*/);
	bool deleteRecordSet(int index);
	IRecordSet* findRecordSet(int index);
private:
	DECLARE_THREAD_SAFETY_MEMBER(RecordSet);
	bool _deleteRecordSet(MAPRECSETPAIR ipair);
	MAPRECSET	m_mapRecSetManager;
	int			m_nCurRecSet;
};