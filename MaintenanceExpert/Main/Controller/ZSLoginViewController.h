//
//  ZSLoginViewController.h
//  MaintenanceExpert
//
//  Created by koka on 16/10/20.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIbutton.h"

@interface ZSLoginViewController : UIViewController

@property(nonatomic,strong)UIButton *loginbtn;
@property(nonatomic,strong)UIButton *otherBtn;
@property(nonatomic,strong)UITextField *phone;
@property(nonatomic,strong)UITextField *secret;

@property(nonatomic,strong)UITextField *messageTF;
@property(nonatomic,strong)UIButton *messageBtn;
/**
 *  第三方登录，每种登录的button的tag值来区分
 */


@end
