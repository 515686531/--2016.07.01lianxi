//
//  ImageDownloader.h
//  DouBanProject
//
//  Created by 王佩 on 16/5/9.
//  Copyright © 2016年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class ImageDownloader;
@protocol ImageDownloaderDelegate <NSObject,UITextFieldDelegate>

//当获取到UIImage数据的时候，代理对象执行这个方法
- (void)imageDownloader:(ImageDownloader *)downloader didFinishedLoading:(UIImage *)image;

@end



@interface ImageDownloader : NSObject



//请求图片的类，获取到图片代理执行协议方法 传回请求下来的图片
#pragma mark-- 实例初始化方法
- (instancetype)initWithImageUrlString:(NSString *)imageUrlStr delegate:(id<ImageDownloaderDelegate>)dele;
#pragma mark-- 遍历构造器方法

+ (instancetype)imageDownloaderWithImageUrlString:(NSString *)imageUrlStr delegate:(id<ImageDownloaderDelegate>)dele;





@end
