
#import "CustomTabbar.h"

@interface CustomTabbar ()

@property (nonatomic, strong) PublishButton *button;

@end

@implementation CustomTabbar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        self.button = [PublishButton createPublishButton];
//        [self addSubview:_button];
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    //设置button（最好设置添加一次）
    self.button = [PublishButton createPublishButton];
    [self addSubview:_button];
    
    //设置几个item的位置
    CGFloat barWidth = self.frame.size.width;
    CGFloat barHeight = self.frame.size.height;
    CGFloat buttonW = barWidth/5;
    CGFloat buttonH = barHeight - 2;
    CGFloat buttonY = 1;
    
    self.button.center = CGPointMake(barWidth*0.5, barHeight*0.3);
    NSInteger index = 0;
    //tabbar上有很多view 我们要重新布局的只是点击的几个button，不是这些比如UITabBarBackgroundView等，所以需要遍历找到UITabBarButton的进行设置
    for (UIView *view in self.subviews) {
        NSString * viewClass = NSStringFromClass([view class]);
        if ([viewClass isEqualToString:@"UITabBarButton"]) {
            CGFloat buttonX = index * buttonW;
            if (index >=2) {
                buttonX += buttonW;
            }
            view.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
            index++;
        }
        
        
    }
    
    
    
    
    
    
}


/*
 **当按钮超过了父视图范围，点击是没有反应的。因为消息的传递是从最下层的父视图开始调用hittest方法。
   [objc] view plain copy print?
    - (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
   UIView *view = [super hitTest:point withEvent:event];
     return view;
    }
 
 **当存在view时才会传递对应的event，现在点击了父视图以外的范围，自然返回的是nil。所以当子视图（比如按钮btn）因为一些原因超出了父视图范围，就要重写hittest方法，让其返回对应的子视图，来接收事件。即：点击的点在自视图范围内（self.button）就返回self.button此时就会执行self.button的点击事件
 
 */

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    //先执行父类的方法返回响应对象
    UIView *view = [super hitTest:point withEvent:event];
    //点击了父类以外的地方 所以返回nil
    if (view == nil) {
        //点转化成在self.button内的坐标
        CGPoint tempoint = [self.button convertPoint:point fromView:self];
        //判断是不是在self.button.bounds的范围内 如果是就响应事件
        if (CGRectContainsPoint(self.button.bounds, tempoint))
        {
            view = self.button;
        }
    }
    return view;
}



@end
