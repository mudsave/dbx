// DBARecordSet.cpp : Defines the entry point for the DLL application.
//

#include "stdafx.h"
#include "IDBARecordSet.h"
#include "RecordSetManager.h"

class CDBARecordSet :public IInitDBARecordSet
{
public:
	IRecordSetManager* getIRecordSetManager(void);
};

IRecordSetManager* CDBARecordSet::getIRecordSetManager()
{
	static CRecordSetManager s_RecordSetManager;
	return reinterpret_cast<IRecordSetManager*>(&s_RecordSetManager);
}

// This is an example of an exported function.
DBARECORDSET_API IInitDBARecordSet* CreateDBARecordSet()
{
	static CDBARecordSet s_DBARecordSet;
	return reinterpret_cast<IInitDBARecordSet*>(&s_DBARecordSet);
}


