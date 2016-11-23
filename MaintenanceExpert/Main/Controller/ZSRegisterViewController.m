//
//  ZSRegisterViewController.m
//  MaintenanceExpert
//
//  Created by xpc on 16/10/20.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSRegisterViewController.h"
#import "ZSRegisterCustomerVC.h"
#import "ZHBtnSelectView.h"
#import "ZHCustomBtn.h"

#import <SMS_SDK/SMSSDK.h>

@interface ZSRegisterViewController ()<ZHBtnSelectViewDelegate,UIAlertViewDelegate>{
    
    UIButton* msgBtn;
}
@property (nonatomic,weak)ZHCustomBtn *currentkindBtn;
@property (nonatomic,weak)ZHBtnSelectView *btnkindView;


@property (nonatomic,strong)NSArray *kindArr;
@end


@implementation ZSRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"注册帐号";
    self.navigationController.navigationBarHidden = NO;
    
    [self creatView];
    
}

- (void)creatView {
    
    [self phoneNumber];
    [self messageNumber];
    [self passwordNumber];
    [self nextStepOfBtn];
    [self createkindbtn];
}



//  手机号
- (void)phoneNumber {
    
    //  手机号  top 50  zishen 40  left 20
    //  图
    UIImageView* imageV = [[UIImageView alloc] init];
    imageV.backgroundColor = [UIColor yellowColor];
    imageV.image = [UIImage imageNamed:@"icon_signin_phone"];
    [self.view addSubview:imageV];
    
    imageV.sd_layout
    .topSpaceToView(_textViewType, 40)
    .leftSpaceToView(self.view, 30)
    .widthIs(30)
    .heightIs(40);
    //  输入框
    _phoneTF = [[UITextField alloc] init];
    _phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    _phoneTF.placeholder = @"请输入手机号";
    [self.view addSubview:_phoneTF];
    _phoneTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _phoneTF.sd_layout
    .topEqualToView(imageV)
    .leftSpaceToView(imageV, 5)
    .rightSpaceToView(self.view, 30)
    .heightIs(40);
    //  横线
    UIView* line = [[UIView alloc] init];
    line.backgroundColor = [UIColor grayColor];
    [self.view addSubview:line];
    
    line.sd_layout
    .leftSpaceToView(self.view, 30)
    .topSpaceToView(imageV, 1)
    .rightSpaceToView(self.view, 30)
    .heightIs(1);
    
}

//  验证码
- (void)messageNumber {
    
    //  验证码
    //  图
    UIImageView* imageV = [[UIImageView alloc] init];
    imageV.backgroundColor = [UIColor yellowColor];
    imageV.image = [UIImage imageNamed:@"alert_login_yzm"];
    [self.view addSubview:imageV];
    
    imageV.sd_layout
    .topSpaceToView(_phoneTF, 20)
    .leftSpaceToView(self.view, 30)
    .widthIs(30)
    .heightIs(40);
    //  输入框
    _messageTF = [[UITextField alloc] init];
    _messageTF.keyboardType = UIKeyboardTypeNumberPad;
    _messageTF.placeholder = @"请输入验证码";
    [self.view addSubview:_messageTF];
    _messageTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _messageTF.sd_layout
    .topEqualToView(imageV)
    .leftSpaceToView(imageV, 5)
    .rightSpaceToView(self.view, 150)
    .heightIs(40);
#warning 验证码按钮！！！！！！！！！！！！！！！！！！！！ 调用的 获取验证码的 方法
    //  获取验证码
    msgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    msgBtn.backgroundColor = [UIColor orangeColor];
    [msgBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    msgBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [msgBtn addTarget:self action:@selector(startTime) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:msgBtn];
    
    msgBtn.sd_layout
    .leftSpaceToView(_messageTF, 10)
    .topEqualToView(_messageTF)
    .rightSpaceToView(self.view, 30)
    .widthIs(90)
    .heightIs(40);
    //  横线
    UIView* line = [[UIView alloc] init];
    line.backgroundColor = [UIColor grayColor];
    [self.view addSubview:line];
    
    line.sd_layout
    .leftSpaceToView(self.view, 30)
    .topSpaceToView(imageV, 1)
    .rightSpaceToView(self.view, 30)
    .heightIs(1);
    
}

//  密码
- (void)passwordNumber {
    
    //  密码
    //  图
    UIImageView* imageV = [[UIImageView alloc] init];
    imageV.backgroundColor = [UIColor yellowColor];
    imageV.image = [UIImage imageNamed:@"alert_login_pass"];
    [self.view addSubview:imageV];
    
    imageV.sd_layout
    .topSpaceToView(_messageTF, 20)
    .leftSpaceToView(self.view, 30)
    .widthIs(30)
    .heightIs(40);
    //  输入框
    _passwordTF = [[UITextField alloc] init];
    _passwordTF.clearButtonMode = UITextFieldViewModeWhileEditing;

    _passwordTF.placeholder = @"请输入密码";
    [self.view addSubview:_passwordTF];
    
    _passwordTF.sd_layout
    .topEqualToView(imageV)
    .leftSpaceToView(imageV, 5)
    .rightSpaceToView(self.view, 30)
    .heightIs(40);
    //  横线
    UIView* line = [[UIView alloc] init];
    line.backgroundColor = [UIColor grayColor];
    [self.view addSubview:line];
    
    line.sd_layout
    .leftSpaceToView(self.view, 30)
    .topSpaceToView(imageV, 1)
    .rightSpaceToView(self.view, 30)
    .heightIs(1);
    
   }

//  客户还是工程师
- (void)createkindbtn {
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth / 2 - 105, 210, 50, 40)];
    [self.view addSubview:label];
    
    label.text = @"我  是";
    
    self.kindArr = [[NSArray alloc]initWithObjects:@"客户",@"工程师", nil];
    // 自动计算view的高度
    ZHBtnSelectView *btnView = [[ZHBtnSelectView alloc] initWithFrame:CGRectMake(label.frame.origin.x + 60, label.frame.origin.y + 3, 150, 0)
                                                               titles:self.kindArr column:2];
    [self.view addSubview:btnView];
    btnView.verticalMargin = 10;
    btnView.delegate = self;
    self.btnkindView = btnView;

}

- (void)btnSelectView:(ZHBtnSelectView *)btnSelectView selectedBtn:(ZHCustomBtn *)btn {
    self.btnkindView.selectType = BtnSelectTypeSingleChoose;
    self.currentkindBtn.btnSelected = NO;
    self.currentkindBtn = btn;
    btn.btnSelected = YES;
   
}


//  注册按钮
- (void)nextStepOfBtn {
    
    //  注册按钮
    _nextStepBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextStepBtn.backgroundColor = [UIColor cyanColor];
    [_nextStepBtn setTitle:@"注   册" forState:UIControlStateNormal];
    [_nextStepBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_nextStepBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    
#warning 单击并移出按钮范围 进入工程师界面，单击 进入客户界面
    
    [_nextStepBtn addTarget:self action:@selector(tabButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_nextStepBtn];
    
    _nextStepBtn.sd_layout
    .leftSpaceToView(self.view, 78)
    .rightSpaceToView(self.view, 78)
    .topSpaceToView(_passwordTF, 60)
    .heightIs(35);
}

//  获取 验证码
//  点击 获取验证码后 倒计时、并按钮变灰
- (void)startTime {
    /**
     *  验证码获取
     */
    [self getRegisterCode];
    
    __block int timeout= 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(timeout<=0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示 根据自己需求设置
                
                [msgBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                
                msgBtn.userInteractionEnabled = YES;
            });
            
        }else{
            
            //            int minutes = timeout / 60;
            int seconds = timeout % 60;
            
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示 根据自己需求设置
                
                [UIView beginAnimations:nil context:nil];
                
                [UIView setAnimationDuration:1];
                
                [msgBtn setTitle:[NSString stringWithFormat:@"%@秒后重发",strTime] forState:UIControlStateNormal];
                
                [UIView commitAnimations];
                
                msgBtn.userInteractionEnabled = NO;
                
            });
            
            timeout--;
        }
    });
    
    dispatch_resume(_timer);
}

#pragma - mark 申请验证码
- (void)getRegisterCode {
    
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_phoneTF.text zone:@"86" customIdentifier:@"yanzhengma" result:^(NSError *error) {
        
        if (!error) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"成功" message:[NSString stringWithFormat:@"已像%@的发送验证码",_phoneTF.text]  delegate:self cancelButtonTitle:@"确定"  otherButtonTitles:nil, nil];
            [alert show];
        }else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"codesenderrtitle", nil) message:[NSString stringWithFormat:@"错误描述：%@",error.debugDescription]  delegate:self cancelButtonTitle:@"确定"  otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
}


//  注 册 按 钮 方法
//  One

- (void)tabButtonTapped{
    
    [self commitverifyCode];
    
//    ZSRegisterCustomerVC* custormerVC = [[ZSRegisterCustomerVC alloc] init];
//    [self.navigationController pushViewController:custormerVC animated:YES];
}

#pragma - mark 提交验证码
- (void)commitverifyCode {
    [SMSSDK commitVerificationCode:_messageTF.text phoneNumber:_phoneTF.text zone:@"86" result:^(SMSSDKUserInfo *userInfo, NSError *error) {
        if (!error) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"成功" message:@"验证码验证成功"  delegate:self cancelButtonTitle:@"确定"  otherButtonTitles:nil, nil];
            [alert show];
            /**
             验证成功后进入注册界面
             
            */
            ZSRegisterCustomerVC* custormerVC = [[ZSRegisterCustomerVC alloc] init];
            [self.navigationController pushViewController:custormerVC animated:YES];
            
        }else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"codesenderrtitle", nil) message:[NSString stringWithFormat:@"错误描述：%@",error.debugDescription]  delegate:self cancelButtonTitle:@"确定"  otherButtonTitles:nil, nil];
            NSLog(@"%@",error.debugDescription);
            [alert show];
        }
    }];
    
    
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
    
    BOOL phoneright = [[Regex class] isMobile:_phoneTF.text];
    if (phoneright == 1) {
        [_phoneTF resignFirstResponder];
    }else {
        UIAlertView *aler = [[UIAlertView alloc]initWithTitle:@"提示" message:@"手机号码输入错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        aler.alertViewStyle = UIAlertViewStyleDefault;
        [aler show];

    }
   
    [_messageTF resignFirstResponder];
    [_passwordTF resignFirstResponder];
}

////移动UIView
//-(void)transformView:(NSNotification *)aNSNotification
//{
//    //获取键盘弹出前的Rect
//    NSValue *keyBoardBeginBounds=[[aNSNotification userInfo]objectForKey:UIKeyboardFrameBeginUserInfoKey];
//    CGRect beginRect=[keyBoardBeginBounds CGRectValue];
//    
//    //获取键盘弹出后的Rect
//    NSValue *keyBoardEndBounds=[[aNSNotification userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey];
//    CGRect  endRect=[keyBoardEndBounds CGRectValue];
//    
//    //获取键盘位置变化前后纵坐标Y的变化值
//    CGFloat deltaY=endRect.origin.y-beginRect.origin.y;
//    NSLog(@"看看这个变化的Y值:%f",deltaY);
//    
//    //在0.25s内完成self.view的Frame的变化，等于是给self.view添加一个向上移动deltaY的动画
//    [UIView animateWithDuration:0.25f animations:^{
//        [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+deltaY, self.view.frame.size.width, self.view.frame.size.height)];
//    }];
//}


#pragma mark - 屏幕上弹
//-(void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    //键盘高度216
//    
//    //滑动效果（动画）
//    NSTimeInterval animationDuration = 0.30f;
//    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
//    [UIView setAnimationDuration:animationDuration];
//    
//    //将视图的Y坐标向上移动，以使下面腾出地方用于软键盘的显示
//    self.view.frame = CGRectMake(0, -100, self.view.frame.size.width, self.view.frame.size.height);//64-216
//    
//    [UIView commitAnimations];
//}
//
//#pragma mark -屏幕恢复
//-(void)textFieldDidEndEditing:(UITextField *)textField
//{
//    //滑动效果
//    NSTimeInterval animationDuration = 0.30f;
//    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
//    [UIView setAnimationDuration:animationDuration];
//    
//    //恢复屏幕
//    self.view.frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);//64-216
//    
//    [UIView commitAnimations];
//}
//

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
@end
