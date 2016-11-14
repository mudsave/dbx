
#pragma once

#include "IDBEngine.h"
#include "MsgDefine.h"


const char* g_translate6[MODULEEND]=
{
	"",
	"DBASESSION",
	"DBARECORDSET",
	"DBAACCESS",
	"DBAMSGSERVER",
	"DBALOGSERVER",
	"DBASERVER",
	"DBAENGINE",
	"","",
	"DBACLIENT"
};

const char* g_translate7[DBALOGTYPEEND]=
{
	"",
	"INFO",
	"DEBUG",
	"ERROR"
};

int g_translate8[-DATATYPEEND]=
{
	PARAM_DATATYPE_CHAR,
	PARAM_DATATYPE_INT,
	PARAM_DATATYPE_BOOL,
	PARAM_DATATYPE_FLOAT
};



#ifdef TICKCOUNT
int g_TickCount[MAXTICKCOUNT]=
{
};
#endif