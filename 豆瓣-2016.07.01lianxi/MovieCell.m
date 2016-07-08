//
//  MovieCell.m
//  DouBanProject
//
//  Created by 王佩 on 16/5/9.
//  Copyright © 2016年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "MovieCell.h"

@implementation MovieCell

- (void)setMovie:(Movie *)movie
{
    if (movie != _movie) {
        _movie = nil;
        _movie = movie;
        
        _movieNameLabel.text = _movie.title;
        _movieStarsLabel.text = _movie.stars;
        _pubdateLabel.text = _movie.pubdate;
    }
}






- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
