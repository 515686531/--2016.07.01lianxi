
//设置借口链接的宏定义文件

#ifndef Main_marco_h
#define Main_marco_h

// 电影列表
#define MOVIE_LIST_URL (@"http://api.douban.com/v2/movie/nowplaying?app_name=doubanmovie&client=e:iPhone4,1%7Cy:iPhoneOS_6.1%7Cs:mobile%7Cf:doubanmovie_2%7Cv:3.3.1%7Cm:PP_market%7Cudid:aa1b815b8a4d1e961347304e74b9f9593d95e1c5&alt=json&city=%E5%8C%97%E4%BA%ACversion=2&start=0&apikey=0df993c66c0c636e29ecbb5344252a4a")


// 电影详情(需要拼接接口)
#define MOVIE_INFO_URL_1 @"http://api.douban.com/v2/movie/subject/"
// 中间拼接id值
#define MOVIE_INFO_URL_2 @"?apikey=0df993c66c0c636e29ecbb5344252a4a&client=e:iPhone4,1%7Cy:iPhoneOS_6.1%7Cs:mobile%7Cf:doubanmovie_2%7Cv:3.3.1%7Cm:PP_market%7Cudid:aa1b815b8a4d1e961347304e74b9f9593d95e1c5&alt=json&city=%E5%8C%97%E4%BA%AC&version=2&app_name=doubanmovie"



#endif /* Main_marco_h */
