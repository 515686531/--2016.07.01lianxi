//
//  ImageDownloader.m
//  DouBanProject
//
//  Created by 王佩 on 16/5/9.
//  Copyright © 2016年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "ImageDownloader.h"

@implementation ImageDownloader


+ (instancetype)imageDownloaderWithImageUrlString:(NSString *)imageUrlStr delegate:(id<ImageDownloaderDelegate>)dele
{
    return [[[self class] alloc] initWithImageUrlString:imageUrlStr delegate:dele];
}

- (instancetype)initWithImageUrlString:(NSString *)imageUrlStr delegate:(id<ImageDownloaderDelegate>)dele
{
    if (self = [super init]) {
        
       __weak  typeof(ImageDownloader) * downloader = self;
        //1.准备url对象
        NSURL * url = [NSURL URLWithString:imageUrlStr];
        //2.创建request请求对象
        NSURLRequest * request = [NSURLRequest requestWithURL:url];
        //3.创建会话
        NSURLSession *session = [NSURLSession sharedSession];
        //4.创建请求任务
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            //4.将图片传值
            UIImage * image = [UIImage imageWithData:data];
            //5.代理执行协议中的方法，将图片作为参数传过去
            dispatch_async(dispatch_get_main_queue(), ^{
                [dele imageDownloader:downloader didFinishedLoading:image];
            });

            
        }];
        //执行任务
        [task resume];
        
    }
    
        return self;
}










@end
