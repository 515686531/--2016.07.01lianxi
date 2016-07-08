

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface Movie : NSObject
#pragma mark - 属性
@property (nonatomic, copy) NSString *collection;       //
@property (nonatomic, copy) NSString *ID;               // id
@property (nonatomic, strong) NSDictionary *images;     // 图片数组
@property (nonatomic, copy) NSString *original_title;   //
@property (nonatomic, copy) NSString *orignal_title;    //
@property (nonatomic, copy) NSString *pubdate;          // 上映时间
@property (nonatomic, strong) NSDictionary *rating;           // 评分
@property (nonatomic, copy) NSString *stars;            // 星级
@property (nonatomic, copy) NSString *title;            // 标题
@property (nonatomic, copy) NSString *wish;             //

@property (nonatomic, strong) UIImage *image;           // 图片

//获取到的图片链接 需要进行二次请求才能获取到
- (void)loadImage;





@end
