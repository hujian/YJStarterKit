/*
 * @brief:  单例的方便宏
 * @author: Hj
 * @date:   2015-10-09
 */

// 头文件interface里面调用一下AS_SINGLETON， implement里面调用一下DEF_SINGLETON

#undef	AS_SINGLETON

#define AS_SINGLETON( __class ) \
- (__class *)sharedInstance; \
+ (__class *)sharedInstance;

#undef	DEF_SINGLETON

#define DEF_SINGLETON( __class ) \
- (__class *)sharedInstance \
{ \
return [__class sharedInstance]; \
} \
+ (__class *)sharedInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[[self class] alloc] init]; } ); \
return __singleton__; \
}
