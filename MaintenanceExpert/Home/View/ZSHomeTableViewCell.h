//
//  ZSHomeTableViewCell.h
//  MaintenanceExpert
//
//  Created by xpc on 16/11/4.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZSHomeTableViewCell : UITableViewCell



//  图片类型
@property (strong, nonatomic) UIImageView *homeImgType;
//  位置
@property (strong, nonatomic) UILabel *homeCellAddress;
//  星级
@property (strong, nonatomic) UIImageView *homeCellStars;
//  故障分类 / 运维分类
@property (strong, nonatomic) UILabel *homeCellType;
//  机房等级
@property (strong, nonatomic) UILabel *homeCellGrades;
//  距离
@property (strong, nonatomic) UILabel *homeCellDistance;
//  发布日期
@property (strong, nonatomic) UILabel *homeCellTime;



@end
