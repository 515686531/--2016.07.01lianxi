

#import <UIKit/UIKit.h>
#import "Movie.h"
@interface MovieCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *backGroundView; //
@property (weak, nonatomic) IBOutlet UILabel *movieNameLabel;//电影名
@property (weak, nonatomic) IBOutlet UILabel *movieStarsLabel;//电影星级

@property (weak, nonatomic) IBOutlet UILabel *pubdateLabel;//上映时间

@property (weak, nonatomic) IBOutlet UIImageView *movieImageView;//电影封面

//参数用处：获取到model之后需要把model中的需要的属性值一一赋给cell上对应的控件，写成属性的好处就是，把多条赋值操作放到cell本类来做，封装。
@property (nonatomic,strong) Movie * movie;








@end
