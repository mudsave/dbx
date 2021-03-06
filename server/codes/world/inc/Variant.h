#ifndef __VARIENT_H__
#define __VARIENT_H__

#include "lindef.h"

// 使用这两个宏的时候，确保p是char *指针
#define auxWrite(p,type,value) *(type *)p = (type)(value),p+=sizeof(type)
#define auxRead(lv,type,p) lv = *(type *)p,p+=sizeof(type)			//lv 左值

enum VariantType{
	VAR_NULL,
	VAR_BYTE,
	VAR_SHORT,
	VAR_INT,
	VAR_LONGLONG,
	VAR_FLOAT,
	VAR_STRING,
	VAR_DATA,
	VAR_VECTOR,
};

struct Variant{
	union{
		char cVal;
		short sVal;
		int iVal;
		long long llVal;
		double fVal;
		void* dataVal;
		Variant* vctVal;
	};
	char type;
	size_t length;
public:
	Variant():llVal(0),type(VAR_NULL),length(0){}
	Variant(char c):cVal(c),type(VAR_BYTE){}
	Variant(short s):sVal(s),type(VAR_SHORT){}
	Variant(int i):iVal(i),type(VAR_INT){}
	Variant(float f):fVal(f),type(VAR_FLOAT){}
	Variant(const char *pStr,size_t len = 0):dataVal(0),type(VAR_STRING){
		ASSERT_(pStr);
		Set(pStr,len);
	}
	Variant(const void *pData,size_t len):dataVal(0),type(VAR_DATA){
		ASSERT_(pData);
		Set(pData,len);
	}
	Variant(const Variant &src){
		Copy(src);
	}
	~Variant(){
		Clear(true);
	}
	Variant &operator=(const Variant &src){
		if(this != &src){
			Clear(true);
			Copy(src);
		}
		return *this;
	}
	bool IsEqual(const char *pStr,int len=-1) const{
		ASSERT_( VAR_STRING == type );
		return VAR_STRING == type && strcmp((const char *)dataVal,pStr)==0;
	}
	bool IsEqual(const void *pData,size_t len) const{
		ASSERT_( VAR_DATA == type && len>0 );
		if( len != length ){
			return false;
		}
		return VAR_DATA== type && memcpy(dataVal,pData,len)==0;
	}
	void Clear(bool bClearType){
		switch(type){
			case VAR_STRING:
			case VAR_DATA:
				if(dataVal && length>0){
					delete[] (char *)dataVal;
					dataVal = 0;
					length = 0;
				}
				break;
			case VAR_VECTOR:
				ASSERT_(vctVal);
				if(length>0){
					delete[] vctVal;
					vctVal = 0;
					length = 0;
				}
				break;
		}
		if(bClearType){
			type = VAR_NULL;
		}
	}
	void Copy(const Variant& src){
		Clear(false);
		type = src.type;
		switch(type){
			case VAR_NULL:
				break;
			case VAR_STRING:
			case VAR_DATA:
				length = src.length;
				dataVal = memcpy(new char[length],src.dataVal,length);
				break;
			case VAR_VECTOR:
				length = src.length;
				ASSERT_( length > 0 );
				vctVal = new Variant[length];
				for(unsigned i=0;i<length;i++){
					vctVal[i].Copy(src.vctVal[i]);
				}
				break;
			case VAR_BYTE:
				cVal = src.cVal;
				break;
			case VAR_SHORT:
				sVal = src.sVal;
				break;
			case VAR_INT:
				iVal = src.iVal;
				break;
			case VAR_FLOAT:
				fVal = src.fVal;
				break;
			case VAR_LONGLONG:
				llVal = src.llVal;
				break;
			default:
				ASSERT_(0);
		}
	}
	int Save(void *pBuff,size_t len,bool bSaveType = false){
		ASSERT_( len >= sizeof(long long) && pBuff );
		char *p = (char *)pBuff;
		if(bSaveType){
			auxWrite(p,char,type);
		}
		switch(type){
			case VAR_NULL:
				break;
			case VAR_BYTE:
				auxWrite(p,char,cVal);
				break;
			case VAR_SHORT:
				auxWrite(p,short,sVal);
				break;
			case VAR_INT:
				auxWrite(p,int,iVal);
				break;
			case VAR_LONGLONG:
				auxWrite(p,long long,llVal);
				break;
			case VAR_FLOAT:
				auxWrite(p,float,fVal);
				break;
			case VAR_STRING:{
					int slen = strlen( (const char *)dataVal );
					ASSERT_(len >= slen + sizeof(short));
					auxWrite(p,short,slen);
					memcpy(p,dataVal,slen);
					p+=slen;
				}
				break;
			case VAR_DATA:
				ASSERT_( len >= length + sizeof(short) );
				auxWrite(p,short,length);
				memcpy(p,dataVal,length);
				p+=length;
				break;
			default:
				ASSERT_(0);
		}
		return (int)(p - (char *)pBuff);
	}
	int Load(const void *pData,size_t len,bool bTypeSaved = false){
		Clear(bTypeSaved);
		const char *p = (char *)pData;
		if(bTypeSaved){
			auxRead(type,char,p);	
		}
		switch(type){
			case VAR_NULL:
				break;
			case VAR_BYTE:
				auxRead(cVal,char,p);
				break;
			case VAR_SHORT:
				auxRead(sVal,short,p);
				break;
			case VAR_INT:
				auxRead(iVal,int,p);
				break;
			case VAR_LONGLONG:
				auxRead(llVal,long long,p);
				break;
			case VAR_STRING:
				auxRead(length,short,p);
				ASSERT_(length > 0 && len >= length + sizeof(short) );
				dataVal = memcpy(new char[length + 1],p,length);
				*((char *)dataVal + length) = 0;
				p += length;
				break;
			case VAR_DATA:
				auxRead(length,short,p);
				ASSERT_(length > 0 && len >= length + sizeof(short));
				dataVal = memcpy(new char[length],p,length);
				p += length;
				break;
			case VAR_VECTOR:
				auxRead(length,short,p);
				ASSERT_(length > 0 && len > sizeof(short));
				vctVal = new Variant[length];
				for(unsigned i=0;i<length;i++){
					 p += vctVal[i].Load(p,len - (int)(p - (const char *)pData),bTypeSaved);
				}
				break;
			default:
				ASSERT_(0);
		}
		return (int)(p - (const char *)pData);
	}
	void Set(const char *pStr,size_t len=0){
		ASSERT_(VAR_STRING == type && pStr);
		size_t size = len < 1 ? strlen(pStr) : len;
		if(length < size + 1){
			Clear(false);
			dataVal = new char[size + 1];
			length = size + 1;
		}
		memcpy(dataVal,pStr,size);
		*((char *)(dataVal) + size) = 0;
	}
	int Get(char *pBuf,size_t len){
		ASSERT_(VAR_STRING == type && pBuf);
		size_t size = strlen((const char *)dataVal);
		if(len + 1 < size){
			return -1;
		}
		memcpy(pBuf,dataVal,size);
		return size;
	}
	void Set(const void *pData,size_t len = 0){
		ASSERT_(VAR_DATA == type && pData);
		if(len > length) {	
			Clear(false);
			dataVal = new char[len];
			length = len;
		}
		ASSERT_(dataVal && length>0);
		memcpy(dataVal,pData,len>0?len:length);
	}
	int Get(void *pBuf,size_t len){
		ASSERT_(VAR_DATA == type);
		size_t size = length>len?len:length;//支持分段读取
		memcpy(pBuf,dataVal,size);
		return size;
	}
};

//lalalalala

#endif
