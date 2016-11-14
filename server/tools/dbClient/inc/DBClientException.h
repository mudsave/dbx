#pragma once
#include "dbexception.h"





class CDBClientException :
	public CDBException
{
public:
	CDBClientException();
	~CDBClientException();
};
