#ifndef __DataChunk_H__
#define __DataChunk_H__

#include "lindef.h"

class DataChunk
{
public:
	struct SectionChunk
	{
	public:
		SectionChunk(DWORD dwType);

		SectionChunk(DWORD dwType, DWORD dwSize, DWORD dwDataSize,void* pData, SectionChunk* pChild, SectionChunk* pSibling);

		~SectionChunk();

	public:
		DWORD		m_dwType;	//类型

		DWORD		m_dwSize;

		DWORD		m_dwDataSize;

		char		*m_pData;	//数据

		SectionChunk	*m_pChild;

		SectionChunk	*m_pSibling;
	};

public:
	DataChunk();

	~DataChunk();

	void Close();

	SectionChunk* BeginChunk(FILE* pFile);

	SectionChunk* NextChunk(FILE* pFile);

private:
	typedef void (DataChunk::*pRecursiveFunc)(SectionChunk* ,void*);

	void	RecursiveFunc(pRecursiveFunc pFunc,SectionChunk *pChunk, void* pData);

	void	Close_Helper(SectionChunk* pChunk,void* pData);

	SectionChunk* ReadChunk(FILE* pFile);

private:
	SectionChunk* m_pChunk;

	SectionChunk* m_pCurrentChunk;
};
#endif
