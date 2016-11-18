//
//  ThreeViewController.h
//  XWPopMenuVCDemo
//
//  Created by koka on 16/10/18.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import <UIKit/UIKit.h>

//2.block传值  typedef void(^returnBlock)();
typedef void(^dismissBlock) ();

@interface ThreeViewController : UIViewController

//block
//block声明属性
@property (nonatomic, copy) dismissBlock mDismissBlock;
//block声明方法
-(void)toDissmissSelf:(dismissBlock)block;

@end
