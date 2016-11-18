//
//  ZSBalanceViewController.m
//  MaintenanceExpert
//
//  Created by 中数 on 16/11/14.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSBalanceViewController.h"

@interface ZSBalanceViewController ()

{
    UIImageView *_moneyimageview;
    UILabel *_moneynum;
}

@end

@implementation ZSBalanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    self.navigationController.navigationBarHidden = NO;
    
    [self creatUI];
    
    
}


- (void)creatUI {
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth / 3 - 3, KScreenWidth / 4 - 3, KScreenWidth / 3 + 6, KScreenWidth / 3 + 6)];
    image.backgroundColor = [UIColor blackColor];
    image.clipsToBounds = YES;
    image.layer.cornerRadius = image.frame.size.width / 2;
    [self.view addSubview:image];
    
    _moneyimageview = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth / 3, KScreenWidth / 4, KScreenWidth / 3, KScreenWidth / 3)];
    _moneyimageview.backgroundColor = [UIColor yellowColor];
    _moneyimageview.image = [UIImage imageNamed:@"51be27f1aeddc4ce0b9d246f38e0ef07"];
    [self.view addSubview:_moneyimageview];
    _moneyimageview.clipsToBounds = YES;
    _moneyimageview.layer.cornerRadius = _moneyimageview.frame.size.width / 2;
    
    [self creatlabel];
    [self createButton];
}

- (void)creatlabel {
    
    UILabel *moneylabel = [[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth / 3, _moneyimageview.frame.origin.y + _moneyimageview.frame.size.height + 10, KScreenWidth / 3, _moneyimageview.frame.size.height / 3)];
    moneylabel.textAlignment = NSTextAlignmentCenter;
    moneylabel.text = @"余      额";
    [self.view addSubview:moneylabel];
    moneylabel.font = [UIFont systemFontOfSize:28 weight:5];
    
    _moneynum = [[UILabel alloc]initWithFrame:CGRectMake(0, moneylabel.frame.origin.y + moneylabel.frame.size.height - 5, KScreenWidth, moneylabel.frame.size.height)];
    _moneynum.textAlignment = NSTextAlignmentCenter;
    NSString *str = @"1000000.00";
    _moneynum.text = [NSString stringWithFormat:@"￥%@",str];
    [self.view addSubview:_moneynum];
    _moneynum.font = [UIFont systemFontOfSize:30 weight:5];
}

- (void)createButton {
    
    UIButton *tixianbtn = [[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth / 3, _moneynum.frame.origin.y + _moneynum.frame.size.height + 50, KScreenWidth / 3, 40)];
    tixianbtn.backgroundColor = [UIColor greenColor];
    [tixianbtn setTitle:@"提    现" forState:UIControlStateNormal];
    tixianbtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    tixianbtn.titleLabel.font = [UIFont systemFontOfSize:20 weight:3];
    tixianbtn.titleLabel.textColor = [UIColor blackColor];
    tixianbtn.layer.cornerRadius = 10;
    [self.view addSubview:tixianbtn];
    [tixianbtn addTarget:self action:@selector(tixianclick) forControlEvents:UIControlEventTouchDown];
    
    UIButton *chongzhibtn = [[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth / 3, tixianbtn.frame.origin.y + tixianbtn.frame.size.height + 10, KScreenWidth / 3, 40)];
    chongzhibtn.backgroundColor = [UIColor greenColor];
    [chongzhibtn setTitle:@"充    值" forState:UIControlStateNormal];
    chongzhibtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    chongzhibtn.titleLabel.font = [UIFont systemFontOfSize:20 weight:3];
    chongzhibtn.titleLabel.textColor = [UIColor blackColor];
    chongzhibtn.layer.cornerRadius = 10;
    [self.view addSubview:chongzhibtn];
    [chongzhibtn addTarget:self action:@selector(chongzhiclick) forControlEvents:UIControlEventTouchDown];
    
}

- (void)tixianclick {
    NSLog(@"提现");
}

- (void)chongzhiclick {
    NSLog(@"充值");
    
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
