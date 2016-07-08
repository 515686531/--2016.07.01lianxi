

#import <Foundation/Foundation.h>
#import "Singleton.h"

//请求数据成功活着失败回调的block
typedef void(^successedBlock)(id data);
typedef void(^failedBlock)(NSError * error);


@interface NetWorkRequestManager : NSObject

/**
 *  网络请求
 *
 *  @param type           请求方式（使用枚举类型或者字符串都可以，本类用大写的字符串，例如@"POST",@"GET"）
 *  @param urlString      URL(如果是GET，就是整个链接；如果是POST，就是网址链接前半段到？)
 *  @param bodyString     URL(如果是POST就是网址链接？后面的部分，其他的nil)
 *  @param param          请求参数
 *  @param successedBlock 请求成功执行的block
 *  @param failedBlock    请求失败执行的block
 
 *  创建三个宏文件，方便使用（可用可不用）Color_marco.h(颜色宏)  Main_marco.h（链接宏）   Singleton.h（单例宏）
 **/



//声明请求数据的方法
+ (void)requestType:(NSString *)typeStr
          UrlString:(NSString *)urlString
         bodyString:(NSString *)bodyString
              Param:(NSDictionary *)param
          Successed:(successedBlock)successedBlock
             Failed:(failedBlock)failedBlock;


//声明单例方法
singleton_interface(NetWorkRequestManager);




@end
