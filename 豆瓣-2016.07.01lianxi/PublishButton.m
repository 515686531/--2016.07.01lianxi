


#import "PublishButton.h"

@implementation PublishButton

//初始化方法
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]){
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

//类方法
+ (instancetype)createPublishButton
{
    PublishButton * button = [[PublishButton alloc] init];
    [button setImage:[UIImage imageNamed:@"post_normal"] forState:UIControlStateNormal];
    //设置按钮文字
    [button setTitle:@"发布" forState:UIControlStateNormal];
    //设置文字颜色
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:9.5];
    [button sizeToFit];
    //添加事件
    [button addTarget:button action:@selector(clickPublishButton) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)clickPublishButton
{
    NSLog(@"点击了发布按钮");
}

//将button上的image和titleLabel进行上下结构
- (void)layoutSubviews
{
    [super layoutSubviews];
    //设置控件大小，间距
    CGFloat imageViewSize = self.bounds.size.width*0.6;
    CGFloat center = self.bounds.size.width*0.5;
    //设置imageView和label的间距
    //获取label的高度
    CGFloat labelHeight = self.titleLabel.font.lineHeight;
    CGFloat verticalMargin = (self.bounds.size.height-labelHeight-imageViewSize)/2.0;
    //imageView和titleLabel 中心的Y值
    CGFloat centerYOfImageView = verticalMargin + imageViewSize*0.5;
    CGFloat centerYOfTitleLabel = verticalMargin + imageViewSize +labelHeight*0.5;
    //确定最终位置
    self.imageView.bounds = CGRectMake(0, 0, imageViewSize, imageViewSize);
    self.imageView.center = CGPointMake(center, centerYOfImageView);
    //    self.titleLabel.bounds = CGRectMake(0,0 , self, <#CGFloat height#>);
    self.titleLabel.center = CGPointMake(center, centerYOfTitleLabel);
    
}

@end
