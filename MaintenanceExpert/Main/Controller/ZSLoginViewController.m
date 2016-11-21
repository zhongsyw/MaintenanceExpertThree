//
//  ZSLoginViewController.m
//  MaintenanceExpert
//
//  Created by koka on 16/10/20.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSLoginViewController.h"
#import "ZSNavigationController.h"
#import "ZSRegisterViewController.h"
#import "ZSChangePasswordVC.h"
#import "MineInfModel.h"

#import "ZSHomeViewController.h"
#import "ZSNavigationController.h"
#import "ZSTabBarController.h"

#import "UIView+ZSExtension.h"
#import "UIbutton.h"

#define KScreenWidth [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ZSLoginViewController ()
{
    BOOL _yanzhengmalog;
    
}


@end


@implementation ZSLoginViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _loginbtn = [[UIButton alloc]init];
    _otherBtn = [[UIButton alloc]init];
    _phone = [[UITextField alloc]init];
    _secret = [[UITextField alloc]init];
    
    //背景图片
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:self.view.frame];
    imageview.image = [UIImage imageNamed:@"93S58PICcXy_1024_meitu_1"];
    [self.view addSubview:imageview];
   
    [self createUI];
    

}

- (void)createUI {
   
//导航栏的透明
 
//    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//    
//    self.view.contentMode = UIViewContentModeScaleAspectFill;
//    
//    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
//    self.navigationController.navigationBarHidden = NO;
    [self createlogo];
    
    [self createtextfield];
    
    [self createLoginButton];
    
    [self createOtherlogin];
    
    [self createRegisterAndForgetsecret];
    
    
    UIButton *leftButton = [[UIButton alloc]init];
    leftButton.frame = CGRectMake(KScreenWidth - 35 , 24, 25, 25);
    [leftButton setBackgroundImage:[UIImage imageNamed:@"twtr-icn_close"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftButton];
    
}

- (void)back {
    [self.navigationController popToRootViewControllerAnimated:YES];
    //[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)createlogo {
    
    UILabel *logolb = [[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth / 3, KScreenHeight * 0.2, KScreenWidth / 3, (KScreenWidth / 3) / 2 )];
    
    logolb.center = CGPointMake(KScreenWidth / 2, KScreenHeight * 0.2);
    [logolb setTextAlignment:NSTextAlignmentCenter];
    logolb.text = @"运维专家";
    logolb.textColor = [UIColor whiteColor];
    logolb.font = [UIFont systemFontOfSize:30 weight:5];
    
//    UILabel *logolb1 = [[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth / 3, KScreenHeight * 0.2 + logolb.frame.size.height, KScreenWidth / 3, (KScreenWidth / 3) / 2 )];
//    
//    logolb1.center = CGPointMake(KScreenWidth / 2, KScreenHeight * 0.2  + logolb.frame.size.height + (KScreenWidth / 3) / 4 );
//    [logolb1 setTextAlignment:NSTextAlignmentCenter];
//    logolb1.text = @"Maintenance Expert";
//    logolb1.textColor = [UIColor whiteColor];
//    logolb1.font = [UIFont systemFontOfSize:25 weight:4];
//    
//    [self.view addSubview:logolb1];
    [self.view addSubview:logolb];
    
}

/**
 *  手机号和密码 文本框
 */
- (void)createtextfield {
    
    UITextField *phonetextfield = [[UITextField alloc]initWithFrame:CGRectMake(30,KScreenHeight / 2 - 100, KScreenWidth - 60, 40)];
    phonetextfield.placeholder = @"请输入手机号";
    [phonetextfield setValue:[UIColor colorWithRed:85.0 / 255.0 green:85.0 / 255.0 blue:85.0 / 255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [phonetextfield setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    phonetextfield.clearButtonMode = UITextFieldViewModeAlways;
    phonetextfield.keyboardType = UIKeyboardTypePhonePad;
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, phonetextfield.frame.size.height - 1, phonetextfield.frame.size.width , 1)];
    lineView.backgroundColor = [UIColor blackColor];
    [phonetextfield addSubview:lineView];
    
    [self.view addSubview:phonetextfield];
    [self.view addSubview:phonetextfield];
    
    _phone = phonetextfield;
 
    
    
    UITextField *secrettextfield = [[UITextField alloc]initWithFrame:CGRectMake(30,KScreenHeight / 2 - 40, KScreenWidth - 60, 40)];
    secrettextfield.placeholder = @"请输入密码";
    [secrettextfield setValue:[UIColor colorWithRed:85.0 / 255.0 green:85.0 / 255.0 blue:85.0 / 255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [secrettextfield setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    secrettextfield.secureTextEntry = YES;
    secrettextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, secrettextfield.frame.size.height - 1, secrettextfield.frame.size.width, 1)];
    lineView1.backgroundColor = [UIColor blackColor];
    
    [secrettextfield addSubview:lineView1];
    [self.view addSubview:secrettextfield];

    _secret = secrettextfield;
    
    
    _messageTF = [[UITextField alloc]init];
    _messageTF.frame = CGRectMake(secrettextfield.frame.origin.x, secrettextfield.frame.origin.y, secrettextfield.frame.size.width - 120, secrettextfield.frame.size.height);
    _messageTF.placeholder = @"请输入验证码";
    [_messageTF setValue:[UIColor colorWithRed:85.0 / 255.0 green:85.0 / 255.0 blue:85.0 / 255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [_messageTF setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    _messageTF.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:_messageTF];
    
    /**
     验证码按钮
     */
    
    _messageBtn = [[UIButton alloc]initWithFrame:CGRectMake(secrettextfield.frame.origin.x + _messageTF.frame.size.width + 10 ,_messageTF.frame.origin.y, 110, secrettextfield.frame.size.height - 2)];
    [_messageBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    
    _messageBtn.backgroundColor = [UIColor colorWithRed:41.0 / 255.0 green:182.0 / 255.0 blue:246.0 / 255.0 alpha:1];
    
    [_messageBtn addTarget:self action:@selector(startTime) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_messageBtn];
    
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(_messageTF.frame.origin.x, _messageTF.frame.origin.y + _messageTF.frame.size.height - 1, _phone.frame.size.width, 1)];
    lineView2.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:lineView2];
    
    _messageTF.hidden = YES;
    _messageBtn.hidden = YES;
    _secret.hidden = NO;
    
    _yanzhengmalog = YES;
    
}

/**
 *  登录按钮
 */
- (void)createLoginButton {
    
    UIbutton *btn = [[UIbutton alloc]init];
    UIButton *button = [btn addButtonWithImage:nil highImage:nil disableImage:nil frame:CGRectMake(30, KScreenHeight / 2 + 40, KScreenWidth - 60, 40) tag:0 action:@selector(loginclick)];
    
    button.backgroundColor = [UIColor colorWithRed:41.0 / 255.0 green:182.0 / 255.0 blue:246.0 / 255.0 alpha:1];
    button.layer.cornerRadius = 10;
    [ button setTitle:@"登           录" forState:UIControlStateNormal];
    
    _loginbtn = button;
    
    [self.view addSubview:button];
    
}

- (void)loginclick {
    
    if ([self.phone.text isEqualToString:@"1"] && [self.secret.text isEqualToString:@"1"]) {

        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:@"111111" forKey:@"username"];
  
        MineInfModel *model = [[MineInfModel alloc]init];
        model.username = @"老张";
        model.usericon = nil;
        model.moneynum = @"1000";
        model.beizannum = @"6";
        model.guanzhunum = @"6";
        model.fensinum = @"6";
        model.Ordernum = @"4";
        model.Mymoney = @"1000000";
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
        NSUserDefaults *users = [NSUserDefaults standardUserDefaults];
        [users setObject:data forKey:@"USER"];
        
        ZSHomeViewController *home = [[ZSHomeViewController alloc]init];
        ZSTabBarController *tab = [[ZSTabBarController alloc]init];
        
        ZSNavigationController *nav = [[ZSNavigationController alloc]initWithRootViewController:tab];
        self.view.window.rootViewController = nav;
        #warning 这边添加选择种类跳转
        
        [self.navigationController pushViewController:home animated:YES];
        
        
        }else {
        UIAlertView *aler = [[UIAlertView alloc]initWithTitle:@"登录失败" message:@"用户名密码输入错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        aler.alertViewStyle = UIAlertViewStyleDefault;
        [aler show];
    }

    
}

/**
 *  其他登录方式
 *
 */
- (void)createOtherlogin {
    
    /**
     其他登录方式
     */
    UILabel *otherlogin = [[UILabel alloc]initWithFrame:CGRectMake(0, _loginbtn.frame.origin.y + _loginbtn.size.height + 80, KScreenWidth , 10)];
    otherlogin.textAlignment = NSTextAlignmentCenter;
    otherlogin.text = @"其他登录方式";
    otherlogin.textColor = [UIColor colorWithRed:70.0 / 255.0 green:70.0 / 255.0 blue:70.0 / 255.0 alpha:1];
    otherlogin.font = [UIFont systemFontOfSize:14];
    
    //UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(_loginbtn.frame.origin.x, otherlogin.frame.origin.y + 5, _loginbtn.frame.size.width, 1)];
    UIView *lineView = [[UIView alloc]init];
    lineView.sd_layout.widthIs(_loginbtn.frame.size.width).xIs(_loginbtn.frame.origin.x).yIs(otherlogin.frame.origin.y - 5).heightIs(1);
    lineView.backgroundColor = [UIColor colorWithRed:150.0 / 255.0 green:170.0 / 255.0 blue:180.0 / 255.0 alpha:1];
    [self.view addSubview:lineView];
    
    [self.view addSubview:otherlogin];
    
    
    /**
     *  第三方登录
     
     每种登录的button的tag值来区分
     *
     */
    UIbutton *btn = [[UIbutton alloc]init];
    
    UIButton *QQ = [btn addButtonWithImage:@"share_platform_qqfriends-1" highImage:nil disableImage:nil frame:CGRectMake(_loginbtn.frame.origin.x, otherlogin.frame.origin.y + 25, _loginbtn.frame.size.width / 6, _loginbtn.frame.size.width / 6) tag:0 action:@selector(clickQQ)];
    QQ.layer.cornerRadius = 10;
    
    _otherBtn = QQ;
    [self.view addSubview:QQ];
    
    UIButton *weixin = [btn addButtonWithImage:@"share_wechat" highImage:nil disableImage:nil frame:CGRectMake(_loginbtn.frame.origin.x + (_loginbtn.frame.size.width * 5) / 18, otherlogin.frame.origin.y + 25, _loginbtn.frame.size.width / 6, _loginbtn.frame.size.width / 6) tag:1 action:@selector(clickweixin)];
    weixin.layer.cornerRadius = 10;
    
    [self.view addSubview:weixin];
    
    UIButton *weibo = [btn addButtonWithImage:@"share_platform_sina" highImage:nil disableImage:nil frame:CGRectMake(_loginbtn.frame.origin.x + (_loginbtn.frame.size.width * 5) / 9, otherlogin.frame.origin.y + 25, _loginbtn.frame.size.width / 6, _loginbtn.frame.size.width / 6) tag:2 action:@selector(clickweibo)];
    weibo.layer.cornerRadius = 10;
    
    [self.view addSubview:weibo];
    
    UIButton *yanzhengma = [btn addButtonWithImage:@"post_office_icon" highImage:nil disableImage:nil frame:CGRectMake(_loginbtn.frame.origin.x + (_loginbtn.frame.size.width * 5) / 6, otherlogin.frame.origin.y + 25, _loginbtn.frame.size.width / 6, _loginbtn.frame.size.width / 6) tag:3 action:@selector(clickyanzhengma)];
    yanzhengma.layer.cornerRadius = 10;
    
    [self.view addSubview:yanzhengma];
    
    
}

/**
 *  四种第三方登录
 */
- (void)clickQQ {
    
    NSLog(@"QQ");
    
}

- (void)clickweixin {
    
    NSLog(@"weixin");
}

- (void)clickweibo {
    
    NSLog(@"weibo");
}

/**
 *  验证码登录
 */
- (void)clickyanzhengma {
    
    if (_yanzhengmalog == YES) {
        _messageTF.hidden = NO;
        _messageBtn.hidden = NO;
        _secret.hidden = YES;
        _yanzhengmalog = NO;
    }else{
        _messageTF.hidden = YES;
        _messageBtn.hidden = YES;
        _secret.hidden = NO;
        _yanzhengmalog = YES;
    }
    
    
}
/**
 *  验证码的计时器
 */
- (void)startTime {
    
    __block int timeout= 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(timeout<=0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示
                
                [_messageBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                
                _messageBtn.userInteractionEnabled = YES;
                
            });
            
        }else{
            
            //            int minutes = timeout / 60;
            
            int seconds = timeout % 60;
            
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示
                
                [UIView beginAnimations:nil context:nil];
                
                [UIView setAnimationDuration:1];
                
                [_messageBtn setTitle:[NSString stringWithFormat:@"%@秒后重发",strTime] forState:UIControlStateNormal];
                
                [UIView commitAnimations];
                
                _messageBtn.userInteractionEnabled = NO;
                
            });
            
            timeout--;
            
            
            
        }
        
    });
    
    dispatch_resume(_timer);
    
}



/**
 *  注册按钮
 */
- (void)createRegisterAndForgetsecret {
    
    
    UIButton *registerbtn = [[UIButton alloc]init];
    registerbtn.sd_layout.xIs(_loginbtn.frame.origin.x)
                         .widthIs(70)
                         .heightIs(20)
                         .yIs(KScreenHeight - 40);
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:@"注册账号"];
    NSRange titleRange = {0,[title length]};
    [title addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:titleRange];
    [registerbtn setAttributedTitle:title
                      forState:UIControlStateNormal];
    
    registerbtn.tintColor = [UIColor redColor];
    
    registerbtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [registerbtn addTarget:self  action:@selector(registerb) forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview:registerbtn];
    
    
    
    UIButton *ForgetSecret = [[UIButton alloc]init];
    ForgetSecret.sd_layout.widthIs(70)
                .heightIs(20)
                .xIs(_loginbtn.frame.origin.x + _loginbtn.frame.size.width - 70)
                .yIs(registerbtn.frame.origin.y);
    
    NSMutableAttributedString *title1 = [[NSMutableAttributedString alloc] initWithString:@"忘记密码"];
    NSRange titleRange1 = {0,[title length]};
    [title1 addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:titleRange1];
    [ForgetSecret setAttributedTitle:title1
                           forState:UIControlStateNormal];
    
    ForgetSecret.tintColor = [UIColor redColor];
    
    ForgetSecret.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [ForgetSecret addTarget:self  action:@selector(Forget) forControlEvents:UIControlEventTouchDown];

    
    [self.view addSubview:ForgetSecret];
   
}

/**
 *  跳转注册和忘记密码界面
 */
- (void)registerb {
    //NSLog(@"跳转注册");
    
    ZSRegisterViewController *registerVC= [[ZSRegisterViewController alloc]init];

    [self.navigationController pushViewController:registerVC animated:YES];


    //[self presentViewController:registerVC animated:YES completion:nil];

}

- (void)Forget {
    //NSLog(@"跳转改密");
    ZSChangePasswordVC *changeVC = [[ZSChangePasswordVC alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:changeVC animated:YES];
    //[self presentViewController:changeVC animated:YES completion:nil];
}



/**
 *  键盘响应
 *
 */
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_phone resignFirstResponder];
    [_secret resignFirstResponder];
    
}





@end
