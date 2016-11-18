//
//  ZSRightTableViewCell.h
//  MaintenanceExpert
//
//  Created by xpc on 16/10/31.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZSRightTableViewCell : UITableViewCell


//  类型(维护/修理)
@property (strong, nonatomic) UIImageView *imgType;
//  地址
@property (strong, nonatomic) UILabel *address;
//  多少钱
@property (strong, nonatomic) UILabel *money;
//  巡检/维修
@property (strong, nonatomic) UIImageView *imgXunJian;
//  下次巡检时间
@property (strong, nonatomic) UILabel *nextXunJian;
//  剩余时间
@property (strong, nonatomic) UILabel *timeShengYu;
//  发布时间
@property (strong, nonatomic) UILabel *releaseTime;
//  联系客户
@property (strong, nonatomic) UIButton *relation;
//  查看评价
@property (strong, nonatomic) UIButton *appraisal;
//  更多
@property (strong, nonatomic) UIButton *another;

@end
