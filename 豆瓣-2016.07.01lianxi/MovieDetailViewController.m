
#import "MovieDetailViewController.h"
#import "Main_marco.h"
#import "NetWorkRequestManager.h"
#import "ImageDownloader.h"
#import "Movie.h"

@interface MovieDetailViewController ()<ImageDownloaderDelegate>

//设置需要关联控件的属性
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *movieImageView;
@property (weak, nonatomic) IBOutlet UILabel *gradeLabel;

@property (weak, nonatomic) IBOutlet UILabel *pubdateLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieTypeLabel;

@property (weak, nonatomic) IBOutlet UILabel *movieCountryLabel;

@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;

//可视化编程就不需要手动label高度自适应
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeight;

@end

@implementation MovieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSLog(@"-----%@", _movie.ID);
    //请求数据
    [self sendRequestGetData];
    

}

- (void)sendRequestGetData
{
    
    __weak MovieDetailViewController * movieDetailVC = self;
    
    //拼接网址(中间拼接ID，属性传值需要传过来的ID)
    NSString * urlString = [NSString stringWithFormat:@"%@%@%@",MOVIE_INFO_URL_1,_movie.ID,MOVIE_INFO_URL_2];
    
    [NetWorkRequestManager requestType:@"GET" UrlString:urlString bodyString:nil Param:nil Successed:^(id data) {
        //解析数据
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
#warning mark ---最好打印一下字典，看看自己要的数据的格式，还有最好下面使用的时候做非空判断，安全性
        //转成模型对象
        Movie * movie = [Movie new];
        [movie setValuesForKeysWithDictionary:dict];
        //进行显示
        dispatch_async(dispatch_get_main_queue(), ^{
            //将数据显示在控件上
            [movieDetailVC showInfoToSubviews:movie];
        });
    } Failed:^(NSError *error) {
        
    }];
    
    
}

#pragma mark ---将请求下来的数据显示在空间上
//注意：需要在movie里面添加电影详情界面需要的其他的属性，然后再设置
- (void)showInfoToSubviews:(Movie *)movie
{
    //请求图片
    [ImageDownloader imageDownloaderWithImageUrlString:movie.images[@"large"] delegate:self];
    
    //显示电影相关属性
    _gradeLabel.text = [NSString stringWithFormat:@"评分：%@ （%@评论）",movie.rating[@"average"],movie.comments_count];
    _pubdateLabel.text = movie.pubdate;
    
    //需要将数据中的数据拼接成一个字符串显示在label上
    _movieTimeLabel.text = [self getStringWithArray:movie.durations];
    _movieTypeLabel.text = [self getStringWithArray:movie.genres];
    _movieCountryLabel.text = [self getStringWithArray:movie.countries];
    _summaryLabel.text = movie.summary;
    
    //计算高度，做自适应
    /*
    CGRect frame = _summaryLabel.frame;
    frame.size.height = [self calculateTextHeightWithMovie:movie];
    _summaryLabel.frame = frame;
    //设置contentView的高度
    CGSize size = CGSizeMake(_scrollView.frame.size.width, 190+_summaryLabel.frame.size.height);
    
    self.contentViewHeight.constant = size.height;
    */
}
#pragma mark- 方法
#pragma mark -- 计算文本高度（计算高度，做自适应-代码编程时使用）
- (CGFloat)calculateTextHeightWithMovie:(Movie *)movie
{
    CGSize size = CGSizeMake(_summaryLabel.frame.size.width, 1000000);
    NSDictionary * dic = @{NSFontAttributeName:[UIFont systemFontOfSize:24.0f]};
    
    CGRect frame = [movie.summary boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return  frame.size.height;
    
}

#pragma mark ---数组转换为字符串
- (NSString *)getStringWithArray:(NSArray *)array
{
    NSMutableString * str = [NSMutableString string];
    for (NSString * obj in array) {
        [str appendFormat:@"%@ ",obj];
    }
    return str;
}
#pragma mark--实现 ImagedownloaderDelegate 协议
- (void)imageDownloader:(ImageDownloader *)downloader didFinishedLoading:(UIImage *)image
{
    _movieImageView.image = image;
}
@end
