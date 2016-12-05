#include "GUID.h"
#include "lindef.h"
#include "thread.h"
#include <ctime>
#include <cstring>

#define MAX_ENTITY_TYPE		16
#define MAX_SERIAL_NUMBER	0xFFFFF

static time_t	s_tStart;
static DWORD	s_uLast;
static DWORD	s_uvSerials[MAX_ENTITY_TYPE];

static Mutex	s_mtxGuid;

static void init_guid_data()
{
	struct tm t;
	t.tm_year	= 2016 - 1900;
	t.tm_mon	= 1;
	t.tm_mday	= 1;
	t.tm_hour	= 23;
	t.tm_min	= 59;
	t.tm_sec	= 59;

	s_tStart = mktime(&t);
	memset(&s_uvSerials,0,sizeof(DWORD) * MAX_ENTITY_TYPE);
}

uint64 new_guid(short world,short type)
{
	DWORD serial;
	uint64 guid = 0;

	if(type < 0)
		type = 0;
	else if(type > MAX_ENTITY_TYPE)
		type = MAX_ENTITY_TYPE;
	{
		ResGuard<> guard(s_mtxGuid);

		if(s_tStart == 0)
			init_guid_data();
		DWORD ts = (DWORD)difftime(time(0),s_tStart);
		printf("时间:%X\n",ts);
		if(ts - s_uLast > 100)
		{
			serial = 0;
			s_uvSerials[type] = 0;
			s_uLast = ts;
		}
		else
		{
			serial = ++s_uvSerials[type];
			if(serial >= MAX_SERIAL_NUMBER)
			{
				serial = 0;
				s_uvSerials[type] = 0;
			}
		}
		guid = MAKE_GUID(world,type,serial,ts);
	}
	return guid;
}

const char *new_guid_lua(short world,short type)
{
	return uint64_to_string(new_guid(world,type));
}

static const char *xcodes= "0123456789ABCDEF";
static char xresults[17];

const char *uint64_to_string(uint64 value)
{
	BYTE *p = (BYTE *)&value;
	for(int i=0;i<8;i++)
	{
		xresults[i*2]	= xcodes[p[i] >> 4];
		xresults[i*2+1]= xcodes[p[i] & 0x0F];
	}
	xresults[16] = 0;
	return xresults;
}

uint64 string_to_uint64(const char *str)
{
	if(str && strlen(str) == 16)
	{
		uint64 guid;
		BYTE *p = (BYTE *)&guid;
		for(int i=0;i<8;i++)
		{
			BYTE h = (BYTE)str[i * 2];
			BYTE l = (BYTE)str[i * 2 + 1];

			h = (h<'A')?(h-'0'):(h-'A'+10);
			l = (l<'A')?(l-'0'):(l-'A'+10);

			p[i] = (h << 4) + l;
		}
		return guid;
	}
	return 0;
}
