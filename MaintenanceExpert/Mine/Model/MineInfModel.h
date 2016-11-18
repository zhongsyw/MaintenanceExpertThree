//
//  MineInfModel.h
//  MaintenanceExpert
//
//  Created by koka on 16/10/28.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MineInfModel : NSObject<NSCoding>

@property(nonatomic,copy)UIImage *usericon;
@property(nonatomic,copy)NSString *username;
@property(nonatomic,copy)NSString *moneynum;
@property(nonatomic,copy)NSString *beizannum;
@property(nonatomic,copy)NSString *guanzhunum;
@property(nonatomic,copy)NSString *fensinum;

@property(nonatomic,copy)NSString *Ordernum;
@property(nonatomic,copy)NSString *Mymoney;

@property(nonatomic,copy)NSString *MineInformation;


@end
