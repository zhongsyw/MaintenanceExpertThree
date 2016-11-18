//
//  TwoViewController.h
//  XWPopMenuVCDemo
//
//  Created by xpc on 16/10/18.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZSFitterControl.h"

//2.block传值  typedef void(^returnBlock)();
typedef void(^dismissBlock) ();

@interface TwoViewController : UIViewController

//  滑动条
@property(nonatomic,strong) ZSFitterControl *filter;
//  标题
@property (strong, nonatomic) UITextField *titleTF;
//  描述
@property (strong, nonatomic) UITextView *descriptTV;
//  地址
@property (strong, nonatomic) UILabel *addressLabel;
//  手动输入地址
@property (strong, nonatomic) UITextField *addressTF;

//  滑动按钮

//  价格
@property (strong, nonatomic) UITextField *priceTF;
//  分类
@property (strong, nonatomic) UILabel *categoryLabel;
//  维护Maintain、
@property (strong, nonatomic) UIButton *maintainBtn;
//  安装Install
@property (strong, nonatomic) UIButton *installBtn;


//block
//block声明属性
@property (nonatomic, copy) dismissBlock mDismissBlock;
//block声明方法
-(void)toDissmissSelf:(dismissBlock)block;

@end
