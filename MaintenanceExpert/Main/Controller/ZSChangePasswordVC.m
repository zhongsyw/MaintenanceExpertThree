//
//  ZSChangePasswordVC.m
//  MaintenanceExpert
//
//  Created by koka on 16/10/21.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSChangePasswordVC.h"


@implementation ZSChangePasswordVC 


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor cyanColor];
    
    [self createUI];
    
    [self.navigationItem setTitle:@"修改密码"];
    
    self.navigationController.navigationBarHidden = NO;
    
}

/**
 *  搭建UI
 */
- (void)createUI {
    
    /**
     手机号码输入框
     */
    UITextField *phoneTF = [[UITextField alloc]init];
     _phone= phoneTF;
    [self.view addSubview:phoneTF];
    
    phoneTF.sd_layout.leftSpaceToView(self.view,30)
                     .topSpaceToView(self.view,30 )
                     .rightSpaceToView(self.view,30)
                     .heightIs(40);
    
    phoneTF.placeholder = @"请输入手机号";
    [phoneTF setValue:[UIColor colorWithRed:85.0 / 255.0 green:85.0 / 255.0 blue:85.0 / 255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [phoneTF setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    phoneTF.clearButtonMode = UITextFieldViewModeAlways;
    phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    UIView *lineView = [[UIView alloc]init];
    [self.view addSubview:lineView];
    lineView.sd_layout.leftEqualToView(phoneTF)
                      .rightEqualToView(phoneTF)
                      .topSpaceToView(phoneTF,1)
                      .heightIs(1);
    lineView.backgroundColor = [UIColor blackColor];
    
    
    /**
     验证码输入框
     */
    
    UITextField *yzmTF = [[UITextField alloc]init];
    _yzm = yzmTF;
    [self.view addSubview:yzmTF];
    
    yzmTF.sd_layout.leftEqualToView(phoneTF)
                   .topSpaceToView(phoneTF,20)
                   .rightSpaceToView(self.view,30 + 110)
                   .heightIs(40);
    yzmTF.placeholder = @"请输入验证码";
    [yzmTF setValue:[UIColor colorWithRed:85.0 / 255.0 green:85.0 / 255.0 blue:85.0 / 255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [yzmTF setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    yzmTF.clearButtonMode = UITextFieldViewModeAlways;
    yzmTF.keyboardType = UIKeyboardTypeNumberPad;
#warning 获取验证码
    /**
     验证码按钮
     */
    UIButton *yzmbtn = [[UIButton alloc]init];
    _yzmbtn = yzmbtn;
    [self.view addSubview:yzmbtn];
    
    [yzmbtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    
    yzmbtn.sd_layout.leftSpaceToView(yzmTF,10)
                    .rightEqualToView(phoneTF)
                    .topEqualToView(yzmTF)
                    .bottomEqualToView(yzmTF);
    
    yzmbtn.backgroundColor = [UIColor colorWithRed:41.0 / 255.0 green:182.0 / 255.0 blue:246.0 / 255.0 alpha:1];

    [yzmbtn addTarget:self action:@selector(startTime) forControlEvents:UIControlEventTouchDown];
    
    UIView *lineView1 = [[UIView alloc]init];
    [self.view addSubview:lineView1];
    lineView1.sd_layout.leftEqualToView(phoneTF)
                       .rightEqualToView(phoneTF)
                       .topSpaceToView(yzmTF,1)
                       .heightIs(1);
    lineView1.backgroundColor = [UIColor blackColor];
    
    
    /**
     新密码框
     */
    UITextField *newpassword = [[UITextField alloc]init];
    _newpassword = newpassword;
    [self.view addSubview:newpassword];
    
    newpassword.sd_layout.leftEqualToView(phoneTF)
                         .topSpaceToView(yzmTF,20)
                         .rightEqualToView(phoneTF)
                         .heightIs(40);
    
    newpassword.placeholder = @"请输入新密码";
    [newpassword setValue:[UIColor colorWithRed:85.0 / 255.0 green:85.0 / 255.0 blue:85.0 / 255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [newpassword setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    newpassword.clearButtonMode = UITextFieldViewModeAlways;
    
    UIView *lineView2 = [[UIView alloc]init];
    [self.view addSubview:lineView2];
    lineView2.sd_layout.leftEqualToView(newpassword)
                       .rightEqualToView(newpassword)
                       .topSpaceToView(newpassword,1)
                       .heightIs(1);
    lineView2.backgroundColor = [UIColor blackColor];
    
    /**
     确认按钮
     */
    UIButton *confirmBtn = [[UIButton alloc]init];
    
    [self.view addSubview:confirmBtn];
    
    confirmBtn.sd_layout.leftSpaceToView(self.view,100)
                        .rightSpaceToView(self.view,100)
                        .topSpaceToView(lineView2,50)
                        .heightIs(40);
    
    confirmBtn.backgroundColor = [UIColor orangeColor];
    [confirmBtn setTitle:@"确        认" forState:UIControlStateNormal];
    
    
    [confirmBtn addTarget:self action:@selector(returnloginvc) forControlEvents:UIControlEventTouchDown];
}

/**
 *  修改完毕，跳转登录页面
 */
- (void)returnloginvc {
    
      [self.navigationController popViewControllerAnimated:YES];
    
}

/**
 *  验证码的计时器
 */
- (void)startTime {
    
    BOOL phoneright = [[Regex class] isMobile:_phone.text];
    if (phoneright == 1) {
        __block int timeout= 59; //倒计时时间
        
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        
        dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        
        dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
        
        dispatch_source_set_event_handler(_timer, ^{
            
            if(timeout<=0){ //倒计时结束，关闭
                
                dispatch_source_cancel(_timer);
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    //设置界面的按钮显示
                    
                    [_yzmbtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                    
                    _yzmbtn.userInteractionEnabled = YES;
                    
                });
                
            }else{
                
                //            int minutes = timeout / 60;
                
                int seconds = timeout % 60;
                
                NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    //设置界面的按钮显示
                    
                    [UIView beginAnimations:nil context:nil];
                    
                    [UIView setAnimationDuration:1];
                    
                    [_yzmbtn setTitle:[NSString stringWithFormat:@"%@秒后重发",strTime] forState:UIControlStateNormal];
                    
                    [UIView commitAnimations];
                    
                    _yzmbtn.userInteractionEnabled = NO;
                    
                });
                
                timeout--;
                
                
                
            }
            
        });
        
        dispatch_resume(_timer);
        
    }else {
        UIAlertView *aler = [[UIAlertView alloc]initWithTitle:@"提示" message:@"手机号码输入错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        aler.alertViewStyle = UIAlertViewStyleDefault;
        [aler show];
        
    }

   
   
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
    [_yzm resignFirstResponder];
    [_newpassword resignFirstResponder];
}


#pragma mark - 屏幕上弹
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    //键盘高度216
    
    //滑动效果（动画）
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动，以使下面腾出地方用于软键盘的显示
    self.view.frame = CGRectMake(0.0f, -100.0f, self.view.frame.size.width, self.view.frame.size.height);//64-216
    
    [UIView commitAnimations];
}

#pragma mark -屏幕恢复
-(void)textFieldDidEndEditing:(UITextField *)textField
{
  
    //滑动效果
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //恢复屏幕
    self.view.frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);//64-216
    
    [UIView commitAnimations];
}

@end
