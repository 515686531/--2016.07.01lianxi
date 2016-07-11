
#import "Movie.h"
#import "ImageDownloader.h"

@interface Movie ()<ImageDownloaderDelegate>

@end
@implementation Movie

/**
 *  重写setValue:forUndefineKey
 */

- (void)setValue:(id)value forKey:(NSString *)key
{
    key = [key isEqualToString:@"id"]?@"ID":key;
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


//根据请求图片
- (void)loadImage
{
    NSString * imageUrlStr = self.images[@"medium"];
    [ImageDownloader imageDownloaderWithImageUrlString:imageUrlStr delegate:self];
}

#pragma mark - 实现ImageDownloaderDelegate
- (void)imageDownloader:(ImageDownloader *)downloader didFinishedLoading:(UIImage *)image
{
    //请求到了图片进行赋值给image属性 控制器里面使用（通过KVO的形式监听image的值的变化）
    self.image = image;
}







@end
