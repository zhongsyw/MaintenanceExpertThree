//
//  ZSDetailOrderModel.m
//  MaintenanceExpert
//
//  Created by koka on 16/11/3.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSDetailOrderModel.h"

@implementation ZSDetailOrderModel

static ZSDetailOrderModel *_detailorderModel;

+(ZSDetailOrderModel *)shareDetailOrder {
    
    if (_detailorderModel == nil) {
        _detailorderModel = [[super alloc]init];
    }
    return _detailorderModel;
}

- (instancetype)init {
    
    if (self = [super init]) {
                                
    }
    return self;
}

@end
