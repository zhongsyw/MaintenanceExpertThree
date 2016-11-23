//
//  ZSBalanceCashVc.m
//  MaintenanceExpert
//
//  Created by xpc on 16/11/22.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSBalanceCashVc.h"

@interface ZSBalanceCashVc ()

@end

@implementation ZSBalanceCashVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"充值页面";
    self.view.backgroundColor = [UIColor magentaColor];
    
    [self creatView];
}


/** 视图完全显示 */
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 弹出键盘
    [self.view becomeFirstResponder];
}

/** 视图将要消失 */
- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    //  移除键盘
    [self.view resignFirstResponder];
}


- (void)creatView {
    
    UIView *BGView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, KScreenWidth, KScreenHeight * 0.2)];
    BGView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:BGView];
    
    
    
    
    
}


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
