#include "DataChunk.h"

DataChunk::SectionChunk::SectionChunk(DWORD dwType) : m_dwType(dwType),
	m_dwSize(0),
	m_dwDataSize(0),
	m_pData(0),
	m_pChild(0),
	m_pSibling(0)
{

}
DataChunk::SectionChunk::SectionChunk(
			 DWORD dwType,
			 DWORD dwSize,
			 DWORD dwDataSize,
			 void *pData,
			 SectionChunk *pChild,
			 SectionChunk *pSibling)
		:m_dwType(dwType),
		m_dwSize(dwSize),
		m_dwDataSize(dwDataSize),
		m_pData((char*)pData),
		m_pChild(pChild),
		m_pSibling(pSibling)
{

}

DataChunk::SectionChunk::~SectionChunk()
{
	if(m_pData) 
	{
		delete[] m_pData;
	}
	m_pData = 0;
}

DataChunk::DataChunk() : m_pChunk(0),m_pCurrentChunk(0)
{

}

DataChunk::~DataChunk()
{
	Close();
}

void DataChunk::Close_Helper(SectionChunk *pChunk,void *p)
{
	if (pChunk)
	{
		delete pChunk;
	}
	pChunk = 0;
}

void DataChunk::Close()
{
	RecursiveFunc(&DataChunk::Close_Helper,m_pChunk,0);
	m_pChunk = 0;
	m_pCurrentChunk = 0;
}

void DataChunk::RecursiveFunc(pRecursiveFunc pFunc, SectionChunk* pChunk,void* pData)
{
	while(pChunk)
	{
		SectionChunk *pSibling = pChunk->m_pSibling;
		SectionChunk *pChild = pChunk->m_pChild;

		(this->*pFunc)(pChunk, pData);

		if(pChild)
		{
			RecursiveFunc(pFunc, pChild, pData);
		}
		pChunk = pSibling;
	}
}

DataChunk::SectionChunk* DataChunk::ReadChunk(FILE* pFile)
{
	if(feof(pFile))
	{
		return 0;
	}
	DWORD dwType = 0;
	DWORD dwSize = 0;
	DWORD dwDataSize = 0;
	BYTE* pChunkData = NULL;
	
	fread(&dwType, sizeof(dwType), 1, pFile);
	fread(&dwDataSize, sizeof(dwDataSize), 1, pFile);

	pChunkData = new BYTE[dwDataSize];
	fread(pChunkData, dwDataSize, 1, pFile);
	dwSize = sizeof(dwType) + sizeof(dwDataSize) + dwDataSize;

	return new SectionChunk(dwType, dwSize, dwDataSize, pChunkData, 0, 0);
}

DataChunk::SectionChunk* DataChunk::BeginChunk(FILE* pFile)
{
	ASSERT_(pFile);
	m_pCurrentChunk = m_pChunk = ReadChunk(pFile);
	return m_pCurrentChunk;
}

DataChunk::SectionChunk* DataChunk::NextChunk(FILE* pFile)
{
	ASSERT_(pFile);
	m_pCurrentChunk->m_pSibling = ReadChunk(pFile);
	m_pCurrentChunk = m_pCurrentChunk->m_pSibling;
	return m_pCurrentChunk;
}
