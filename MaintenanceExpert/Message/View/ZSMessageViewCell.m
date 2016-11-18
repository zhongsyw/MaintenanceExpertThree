//
//  ZSMessageViewCell.m
//  MaintenanceExpert
//
//  Created by koka on 16/10/28.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSMessageViewCell.h"

@implementation ZSMessageViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareUI];
    }
    return self;
    
}
- (void)prepareUI
{
    
    _iconview = [[UIImageView alloc]initWithFrame:CGRectMake(5, 20, 70, 70)];
    
    
    self.iD = [[UILabel alloc]initWithFrame:CGRectMake(10 + _iconview.frame.size.width + 5, 20, 50, 25)];
    _iD.backgroundColor = [UIColor clearColor];
    _iD.font = [UIFont systemFontOfSize:16 weight:2];
    self.iD.tintColor = [UIColor blackColor];
    
    self.news = [[UILabel alloc]initWithFrame:CGRectMake(10 + _iconview.frame.size.width + 5, 55 , 200, 20)];
    self.news.tintColor = [UIColor colorWithRed:85.0/255.0 green:85.0/255.0 blue:85.0/255.0 alpha:1.0];
    _news.font = [UIFont systemFontOfSize:14];
    
    self.image = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width * 4 / 5, 25, 50, 50)];
    

    [self addSubview:_iconview];
    [self addSubview:_iD];
    [self addSubview:_news];
    [self addSubview:_image];

    
}


@end
