//
//  ZSDetailOrderModel.h
//  MaintenanceExpert
//
//  Created by koka on 16/11/3.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZSDetailOrderModel : NSObject

@property(nonatomic,assign) NSInteger FirstIndex;//一级分类
@property(nonatomic,assign) NSInteger SecondIndex;//二级分类
@property(nonatomic,copy) NSString *NavTitle;//下单页面的导航标题
@property(nonatomic,assign) NSInteger KindIndex;//维修/安装 ，0/1

/**
 *  维修
 */
@property(nonatomic,copy) NSMutableArray *MTsystemKindMuArr;//维修系统种类（多选）
@property(nonatomic,assign) NSInteger ProblemNum;//故障点
@property(nonatomic,assign) BOOL HighWork;//高空作业
@property(nonatomic,assign) BOOL Counties;//郊县
/**
 *  安装
 *
 */

+(ZSDetailOrderModel *)shareDetailOrder;

@end
