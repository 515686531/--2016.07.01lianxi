

#import "NetWorkRequestManager.h"


@implementation NetWorkRequestManager



//实现请求数据的方法
+ (void)requestType:(NSString *)typeStr
          UrlString:(NSString *)urlString
         bodyString:(NSString *)bodyString
              Param:(NSDictionary *)param
          Successed:(successedBlock)successedBlock
             Failed:(failedBlock)failedBlock
{
    //实例化会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    
    //创建url
    NSURL *url = nil;
    url = [NSURL URLWithString:urlString];
        
    //创建request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = typeStr;
    if ([@"POST" isEqualToString:typeStr]) {
        NSData *data = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
        request.HTTPBody = data;
        
    }
    
    
    //创建dataTask任务
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        //请求数据完成(注意plist文件里面需要加NSAppTransportSecurity 和 NSAllowsArbitraryLoads)
        if (error) {
            
            NSLog(@"请求movie数据不成功%@", error);
            failedBlock(error);
        }else{
            
            NSLog(@"请求movie数据成功！！");
            successedBlock(data);
            
        }
        
    }];
        //执行任务
        [task resume];
    
}



//单例的实现
singleton_implementaton(NetWorkRequestManager)


@end
