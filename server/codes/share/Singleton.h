#ifndef __SINGLETON_H_
#define __SINGLETON_H_

#include <stdio.h>

template <typename T> class TSingleton
{
protected:
	static T* s_Singleton;
public:
	static T& Instance(){
		if (!s_Singleton)
		{
			s_Singleton = new T();
		}
		return ( *s_Singleton ); 
	}
	static T* InstancePtr(){ 
		if (!s_Singleton)
		{
			s_Singleton = new T();
		}
		return s_Singleton; 
	}
	static void Release(){
		safeDelete(s_Singleton);
	}
};

template<typename T>
T* TSingleton<T>::s_Singleton = NULL;


#endif  // __SINGLETON_H_