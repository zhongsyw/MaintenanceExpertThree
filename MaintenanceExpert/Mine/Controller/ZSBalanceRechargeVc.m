//
//  ZSBalanceRechargeVc.m
//  MaintenanceExpert
//
//  Created by xpc on 16/11/22.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSBalanceRechargeVc.h"

@interface ZSBalanceRechargeVc ()

@end

@implementation ZSBalanceRechargeVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"提现页面";
    self.view.backgroundColor = [UIColor cyanColor];
    
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
    
    UIView *BGView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, KScreenWidth, KScreenHeight * 0.4)];
    BGView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:BGView];
    
    
    UILabel *bankCard = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 60, 30)];
    bankCard.text = @"银行卡";
    bankCard.font = [UIFont systemFontOfSize:18];
    [BGView addSubview:bankCard];
    
    UILabel *cardNumb = [[UILabel alloc] initWithFrame:CGRectMake(KScreenWidth * 0.33, 10, KScreenWidth * 0.5, 30)];
    cardNumb.text = @"中国银行储蓄卡(8888)";
    cardNumb.font = [UIFont systemFontOfSize:16];
    [BGView addSubview:cardNumb];
    
    UILabel *xianZhi = [[UILabel alloc] initWithFrame:CGRectMake(KScreenWidth * 0.33, 50, KScreenWidth * 0.5, 20)];
    xianZhi.text = @"单日交易限额¥20000.00";
    xianZhi.textColor = [UIColor grayColor];
    xianZhi.font = [UIFont systemFontOfSize:14];
    [BGView addSubview:xianZhi];
    
    
    UIView *lianView = [[UIView alloc] initWithFrame:CGRectMake(10, 80, KScreenWidth - 20, 1)];
    lianView.backgroundColor = BACK_GROUND_COLOR;
    [BGView addSubview:lianView];
    
    
    
}


/*
 使用新卡支付 ： 1。 充值仅支持储蓄卡
 
 
 
 
 */





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
