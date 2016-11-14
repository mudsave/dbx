#pragma once
class IMsgEventHandler;
class IMsgEvent;
class IRecord
{
public:
	virtual bool newAttribute(int AttributeType,void* pAttribute,int* pIndex/*out*/,char* name/*in*/)=0;
	virtual void* readAttribute(int index,int* AttributeType /*out*/,char** name/*out*/)=0;  
	virtual bool writeAttribute(int index,int AttributeType,void* pAttribute ,char* name/*in*/)=0;
	virtual int getRecordSize(void)=0;
	virtual int getAttributeCount(void)=0;
	virtual int getAttriNameSize(void)=0;
	virtual ~IRecord(){}
};

class IRecordSet
{
public:
	virtual IRecord* newRecord(int* pIndex/*out*/)=0;
	virtual IRecord* readRecord(int index)=0;
	virtual bool writeRecord(IRecord* pRecord,int index)=0;
	virtual int getRecordSetSize(void)=0;
	virtual int getRecordCount(void)=0;
	virtual ~IRecordSet(){}
};

class IRecordSetManager
{
public:
	virtual IRecordSet* newRecordSet(int* pIndex/*out*/)=0;
	virtual bool deleteRecordSet(int index)=0;
	virtual IRecordSet* findRecordSet(int index)=0;
	virtual ~IRecordSetManager(){}
};

class IInitDBARecordSet
{
public:
	virtual IRecordSetManager* getIRecordSetManager(void)=0;
};

#ifdef WIN32

#ifdef DBARECORDSET_EXPORTS
#define DBARECORDSET_API __declspec(dllexport)
#else
#define DBARECORDSET_API __declspec(dllimport)
#endif

#else
#define DBARECORDSET_API 

#endif


DBARECORDSET_API IInitDBARecordSet* CreateDBARecordSet();
