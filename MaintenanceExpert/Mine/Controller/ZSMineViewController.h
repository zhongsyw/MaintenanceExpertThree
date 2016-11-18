//
//  ZSMineViewController.h
//  MaintenanceExpert
//
//  Created by koka on 16/10/18.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ZSMineViewController : UIViewController
/** 头像 */
@property (nonatomic, strong) UIImageView *icon;

@property (nonatomic, strong) UILabel *fensinum;
@property (nonatomic, strong) UILabel *guanzhunum;
@property (nonatomic, strong) UILabel *beizannum;
@property (nonatomic, strong) UILabel *moneyLabel;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, copy) NSString *username;



@end
