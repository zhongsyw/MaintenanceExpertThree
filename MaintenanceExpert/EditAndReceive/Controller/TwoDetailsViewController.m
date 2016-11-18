//
//  TwoDetailsViewController.m
//  MaintenanceExpert
//
//  Created by xpc on 16/11/7.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "TwoDetailsViewController.h"
#import "TwoPayTypeViewController.h"

@interface TwoDetailsViewController ()<UIAlertViewDelegate>


{
    UIView *headerView;
    UIView *btnBackView;
}


@end

@implementation TwoDetailsViewController

- (void)viewWillAppear:(BOOL)animated {
    
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    
    self.navigationController.navigationBarHidden = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"订单详情";
    
    
    [self creatDetailsUI];
    [self creatPayButton];
}



- (void)creatDetailsUI {
    
    //  标 题
    UILabel *title = [[UILabel alloc] init];
    title.backgroundColor = [UIColor magentaColor];
    title.text = @"标 题";
    [self.view addSubview:title];
    title.sd_layout.leftSpaceToView(self.view, 15)
    .rightSpaceToView(self.view, 15)
    .topSpaceToView(self.view, 0)
    .heightIs(20);
    
    UILabel *detailsTitle = [[UILabel alloc] init];
    detailsTitle.backgroundColor = [UIColor cyanColor];
    detailsTitle.text = @"这里是标题，再看也是标题，从前边传过来的";
    [self.view addSubview:detailsTitle];
    detailsTitle.sd_layout.leftEqualToView(title)
    .rightEqualToView(title)
    .topSpaceToView(title, 0)
    .heightIs(30);
    
    
    //  描 述
    UILabel *title2 = [[UILabel alloc] init];
    title2.backgroundColor = [UIColor magentaColor];
    title2.text = @"描 述";
    [self.view addSubview:title2];
    title2.sd_layout.leftEqualToView(title)
    .rightEqualToView(title)
    .topSpaceToView(detailsTitle, 0)
    .heightIs(20);
    
    UITextView *detailDescript = [[UITextView alloc] init];
    detailDescript.backgroundColor = [UIColor cyanColor];
    detailDescript.text = @"这里是描述，再看也是描述，从前边传过来的---这里是描述，再看也是描述，从前边传过来的---这里是描述，再看也是描述，从前边传过来的---这里是描述，再看也是描述，从前边传过来的---这里是描述，再看也是描述，从前边传过来的";
    detailDescript.font = [UIFont systemFontOfSize:15];
    detailDescript.editable = NO;
    [self.view addSubview:detailDescript];
    detailDescript.sd_layout.leftEqualToView(title)
    .rightEqualToView(title)
    .topSpaceToView(title2, 0)
    .heightIs(120);
    
#warning UIView上添加两个控件
    
    //  图 片
    UIView *imgView = [[UIView alloc] init];
    imgView.backgroundColor = [UIColor redColor];
    imgView.hidden = NO;
    [self.view addSubview:imgView];
    imgView.sd_layout.leftEqualToView(title)
    .rightEqualToView(title)
    .topSpaceToView(detailDescript, 0)
    .heightIs(90);
    
    //  地 址
    UILabel *title3 = [[UILabel alloc] init];
    title3.backgroundColor = [UIColor magentaColor];
    title3.text = @"地址";
    [self.view addSubview:title3];
    title3.sd_layout.leftEqualToView(title)
    .rightEqualToView(title)
    .topSpaceToView(imgView, 0)
    .heightIs(20);
    
    UILabel *detailsAddress = [[UILabel alloc] init];
    detailsAddress.backgroundColor = [UIColor cyanColor];
    detailsAddress.text = @"这里是描述，再看也是描述，从前边传过来的";
    [self.view addSubview:detailsAddress];
    detailsAddress.sd_layout.leftEqualToView(title)
    .rightEqualToView(title)
    .topSpaceToView(title3, 0)
    .heightIs(30);
    
    
    //  一口价/
    UILabel *OneMouce = [[UILabel alloc] init];
    OneMouce.backgroundColor = [UIColor magentaColor];
    OneMouce.text = @"一口价";
    OneMouce.hidden = NO;
    [self.view addSubview:OneMouce];
    OneMouce.sd_layout.leftEqualToView(title)
    .rightEqualToView(title)
    .topSpaceToView(detailsAddress, 0)
    .heightIs(30);
    
    //  待技术勘察
    UILabel *daiKanCha = [[UILabel alloc] init];
    daiKanCha.backgroundColor = [UIColor magentaColor];
    daiKanCha.text = @"待技术勘察";
    daiKanCha.hidden = YES;
    [self.view addSubview:daiKanCha];
    daiKanCha.sd_layout.leftEqualToView(title)
    .rightEqualToView(title)
    .topSpaceToView(detailsAddress, 0)
    .heightIs(30);
    
    //  协商价
    UILabel *xieShang = [[UILabel alloc] init];
    xieShang.backgroundColor = [UIColor magentaColor];
    xieShang.text = @"待协商价";
    xieShang.hidden = YES;
    [self.view addSubview:xieShang];
    xieShang.sd_layout.leftEqualToView(title)
    .rightEqualToView(title)
    .topSpaceToView(detailsAddress, 0)
    .heightIs(30);
    
    //  类型
    UILabel *title4 = [[UILabel alloc] init];
    title4.backgroundColor = [UIColor cyanColor];
    title4.text = @"类 型";
    [self.view addSubview:title4];
    title4.sd_layout.leftEqualToView(title)
    .rightEqualToView(title)
    .topSpaceToView(xieShang, 0)
    .heightIs(20);
    
    UILabel *type = [[UILabel alloc] init];
    type.backgroundColor = [UIColor cyanColor];
    type.text = @"维 护";
    [self.view addSubview:type];
    type.sd_layout.leftEqualToView(title)
    .rightEqualToView(title)
    .topSpaceToView(title4, 0)
    .heightIs(30);
    
    
}



//  确定订单按钮
- (void)creatPayButton {
    
    btnBackView = [[UIView alloc] init];
    btnBackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:btnBackView];
    btnBackView.sd_layout.leftSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .heightIs(60);
    
    UIButton *payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    payBtn.frame = CGRectMake(10, 10, KScreenWidth - 20, 40);
    [payBtn setTitle:@"确认订单" forState:UIControlStateNormal];
    [payBtn.titleLabel setFont:[UIFont systemFontOfSize:17]];
    [payBtn addTarget:self action:@selector(payButtonClick) forControlEvents:UIControlEventTouchDown];
    payBtn.backgroundColor = [UIColor colorWithRed:253.0/255.0 green:217.0/255.0 blue:85.0/255.0 alpha:1];
    [btnBackView addSubview:payBtn];
}

- (void)payButtonClick {
    
    
    //    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"订单已提交，感谢您对我公司的支持，我们会尽快为您服务" delegate:self cancelButtonTitle:@"前往付款" otherButtonTitles:@"取消", nil];
    //
    //    [alertView show];
    
    
    NSString *title = @"提示";
    NSString *message = @"订单已提交，感谢您对我公司的支持，我们会尽快为您服务";
    NSString *cancelButtonTitle = NSLocalizedString(@"取消", nil);
    NSString *otherButtonTitle = NSLocalizedString(@"前往付款", nil);
    
    UIAlertController *alertContr = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"取消---");
    }];
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        NSLog(@"前往付款---");
        
        TwoPayTypeViewController *payType = [[TwoPayTypeViewController alloc] init];
        
        [self.navigationController pushViewController:payType animated:YES];
        
    }];
    
    // Add the actions.
    [alertContr addAction:cancelAction];
    [alertContr addAction:otherAction];
    
    [self presentViewController:alertContr animated:YES completion:nil];
    
    
    
    NSLog(@"前往--付款");
    
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
