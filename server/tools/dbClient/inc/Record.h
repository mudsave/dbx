#pragma once
#include "IDBARecordSet.h"
#include <map>

class CRecord : public IRecord {
public:
	typedef std::map<int,int> MAPATTRITYPE;
	typedef std::map<int,void*> MAPATTRIVALUE;
	typedef std::map<int,char*> MAPATTRINAME;
	
	typedef std::pair<int,int> MAPATTRIPAIR;
	typedef std::pair<int,void*> MAPATTRVALUEIPAIR;
	typedef std::pair<int,char*> MAPATTRINAMEPAIR;
	CRecord();
	virtual ~CRecord();
	void* readAttribute(int index, int* AttributeType /*out*/, char** name/*out*/);  
	bool writeAttribute(int index, int AttributeType, void* pAttribute , char* name/*in*/);
	bool newAttribute(int AttributeType, void* pAttribute, int* pIndex/*out*/, char* name/*in*/);
	int getRecordSize(void);
	int getAttriNameSize(void);
	int getAttributeCount(void);
private:
	DECLARE_THREAD_SAFETY_MEMBER(AttrType);
	DECLARE_THREAD_SAFETY_MEMBER(AttrName);
	DECLARE_THREAD_SAFETY_MEMBER(AttrValue);
	void getAttributeSize(MAPATTRIPAIR iter,int* pSize);
	void getAttributeNameSize(MAPATTRINAMEPAIR iter,int* pSize);
	void _deleteAttriValue(MAPATTRVALUEIPAIR ipair);
	void _deleteAttriName(MAPATTRINAMEPAIR ipair);
	MAPATTRITYPE	m_mapAttriType;
	MAPATTRIVALUE	m_mapAttriValue;
	MAPATTRINAME	m_mapAttriName;
	int				m_nCurAttri;
};