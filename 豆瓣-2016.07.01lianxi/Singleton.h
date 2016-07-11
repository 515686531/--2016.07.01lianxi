
//设置单例的宏定义文件

#ifndef Singleton_h
#define Singleton_h
//单例声明
#define singleton_interface(className) \
+ (instancetype)shared##className

//单例实现
#define singleton_implementaton(className)\
static className * manager;\
+ (instancetype)shared##className\
{\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
        manager = [[[self class] alloc] init];\
    });\
    return manager;\
}















#endif /* Singleton_h */
