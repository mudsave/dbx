/**
 * filename : trace.cpp
 */

#include "lindef.h"
#include <fstream>

#define MAX_TRACE_MSG_SIZE 1024 

bool g_bOutputDebugWnd = true;

std::ofstream g_outputFile;

extern "C" HRESULT InitTraceServer(bool bOutputDebugWnd, const char* pszOutputFile)
{
	g_bOutputDebugWnd = bOutputDebugWnd;

	if(pszOutputFile && strlen(pszOutputFile) > 0)
	{
		g_outputFile.open(pszOutputFile, std::ios::out | std::ios::trunc);
		if(!g_outputFile) return E_FAIL;
	}
	
	return S_OK;
}

extern "C" void _Trace(int iClass, const char* pszFormat, ...)
{
	char bufTime[64] = {0};
	time_t t = time(NULL);
	struct tm* local = localtime(&t);
	strftime(bufTime, 64, "[%H:%M:%S] ", local);

#if DEBUG_L >= 1
	int iParamNum = iClass >> 16;
	if(iParamNum > 0)
	{
		iParamNum -= 1;
		int n = 0;
		int i = 0;
		while(pszFormat[i])
		{
			if(pszFormat[i] == '%')
			{
				n++;
				if(pszFormat[i + 1] == '%')
				{
					n--; i++;
				}
			}
			i++;
		}

		if(n != iParamNum)
		{
			char strbuf[1024] = {0};
			sprintf(strbuf, "Trace参数格式与格式不匹配(%s : %d)\n", pszFormat, iParamNum);
			_QUERY(strbuf);
		}
	}
	iClass &= 0xffff;
#endif

	va_list args;
	va_start(args, pszFormat);
	char buf[MAX_TRACE_MSG_SIZE * 2];
	vsprintf(buf, pszFormat, args);
	va_end(args);

    if(g_bOutputDebugWnd)
	{
        printf("%s%s", bufTime, buf);
		fflush(stdout);
    }

	if(g_outputFile.is_open())
	{
		g_outputFile << bufTime << buf;
		g_outputFile.flush();
	}
}
