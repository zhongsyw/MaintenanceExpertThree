//
//  MineInfModel.m
//  MaintenanceExpert
//
//  Created by koka on 16/10/28.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "MineInfModel.h"
#import "ZSLoginViewController.h"

@implementation MineInfModel

//static MineInfModel *_MineInfoModel;

//+(MineInfModel *)shareDetailInfo {
//    
//    if (_MineInfoModel == nil) {
//        _MineInfoModel = [[super alloc]init];
//    }
//    return _MineInfoModel;
//}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.username forKey:@"username"];
    [aCoder encodeObject:self.usericon forKey:@"usericon"];
    [aCoder encodeObject:self.moneynum forKey:@"moneynum"];
    [aCoder encodeObject:self.beizannum forKey:@"beizannum"];
    [aCoder encodeObject:self.guanzhunum forKey:@"guanzhunum"];
    [aCoder encodeObject:self.fensinum forKey:@"fensinum"];
    [aCoder encodeObject:self.Ordernum forKey:@"Ordernum"];
    [aCoder encodeObject:self.Mymoney forKey:@"Mymoney"];
    [aCoder encodeObject:self.MineInformation forKey:@"MineInformation"];
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super init]) {
        self.username = [aDecoder decodeObjectForKey:@"username"];
        self.usericon = [aDecoder decodeObjectForKey:@"usericon"];
        self.moneynum = [aDecoder decodeObjectForKey:@"moneynum"];
        self.beizannum = [aDecoder decodeObjectForKey:@"beizannum"];
        self.guanzhunum = [aDecoder decodeObjectForKey:@"guanzhunum"];
        self.fensinum = [aDecoder decodeObjectForKey:@"fensinum"];
        self.Ordernum = [aDecoder decodeObjectForKey:@"Ordernum"];
        self.Mymoney = [aDecoder decodeObjectForKey:@"Mymoney"];
        self.MineInformation = [aDecoder decodeObjectForKey:@"MineInformation"];


    }
    return self;
}

@end
