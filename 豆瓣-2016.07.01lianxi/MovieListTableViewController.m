

#import "MovieListTableViewController.h"
#import "MovieCell.h"
#import "NetWorkRequestManager.h"
#import "Main_marco.h"

@interface MovieListTableViewController ()

@property (nonatomic, strong)NSMutableArray * allMoviesArray;//存放所有电影

@end

@implementation MovieListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //进行网络请求
    [self requestData];
    
}

/**
 *  使用懒加载方式初始化数组
 */
- (NSMutableArray *)allMoviesArray
{
    if (!_allMoviesArray ) {
        _allMoviesArray = [NSMutableArray array];
    }
    return _allMoviesArray;
}

#pragma mark --网络请求
- (void)requestData
{
    __weak typeof(self) movieTVC = self;

    [NetWorkRequestManager requestType:@"GET" UrlString:MOVIE_LIST_URL bodyString:nil Param:nil Successed:^(id data) {
        NSMutableDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        //判断有多少条数据
        if ([dic[@"total"] intValue] != 0) {
            NSArray * allDataArray = dic[@"entries"];
            for (NSDictionary * dict in allDataArray) {
                
                Movie * movie = [Movie new];
                [movie setValuesForKeysWithDictionary:dict];
                [movieTVC.allMoviesArray addObject:movie];
                [_allMoviesArray sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                    Movie * movie1 = (Movie *)obj1;
                    Movie * movie2 = (Movie *)obj2;
                    return [movie2.pubdate compare:movie1.pubdate];
                }];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            //刷新页面
            [movieTVC.tableView reloadData];
        });

        
    } Failed:^(NSError *error) {
        NSLog(@"---movieError----%@", error);
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.allMoviesArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_movie" forIndexPath:indexPath];
    
    //设置cell显示的内容
    Movie * movie = self.allMoviesArray[indexPath.row];
    cell.movie = movie;
    
#warning mark ---- 使用KVO 监听图片加载情况，成功显示。需要准备封装请求图片类ImageDownloader 还需要在movie里面添加加载图片的方法，以及代理方法（也可以用第三方SDWebImage）
    if (movie.image != nil) {
        cell.movieImageView.image = movie.image;
    }else{
        [movie loadImage];
        //使用KVO添加监听事件
        [movie addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:(void *)CFBridgingRetain(indexPath)];
    }

    return cell;
}

#pragma mark ---实现监听属性值变化执行的方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    //获取图片
    UIImage * image = change[NSKeyValueChangeNewKey];
    
    //获取cell位置
    NSIndexPath * indexPath = (__bridge NSIndexPath *)(context);
    //获取当前所有正在显示的cell
    NSArray * indexPathsArray = [self.tableView indexPathsForVisibleRows];
    if ([indexPathsArray containsObject:indexPath]) {
        //获取当前cell
        MovieCell * cell = [self.tableView cellForRowAtIndexPath:indexPath];
        cell.movieImageView.image = image;
        
    }
    CFBridgingRelease((__bridge CFTypeRef _Nullable)(indexPath));
    //移除观察者
    [object removeObserver:self forKeyPath:@"image" context:context];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}


@end
