
#ifndef _SqlOuter_h
#define _SqlOuter_h
#include "mysql.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "DBScheme.h"
#include "DBObject.h"
#include "DBShare.h"

extern DBScheme g_scheme;

#define PARAMSNUM 20
class CSqlOuter {
public:
	CSqlOuter();
	~CSqlOuter();
	void Init();
	bool IsAlive();
	int Execute( CDBObject* pobj );
	int Execute_sp( CDBObject* pobj );
	int Execute_sql( CDBObject* pobj );
	int FetchOutputParams(CDBObject* pobj);
	void FillFields(int, MYSQL_FIELD*, CDBObject*, int);
	
	MYSQL m_mysql;
};

#endif

