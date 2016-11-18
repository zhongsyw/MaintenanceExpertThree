//
//  TwoPayTypeViewController.m
//  MaintenanceExpert
//
//  Created by xpc on 16/11/7.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "TwoPayTypeViewController.h"



@interface TwoPayTypeViewController ()<UITableViewDelegate, UITableViewDataSource>

{
    NSArray *_payTypeArr;
}

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation TwoPayTypeViewController

- (void)viewWillAppear:(BOOL)animated {
    
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    
    self.navigationController.navigationBarHidden = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor cyanColor];

    _payTypeArr = [[NSArray alloc] initWithObjects:@"支付宝支付",@"微信支付",@"银行卡支付", nil];
    
    [self creatCancelPayBtn];
    
    [self creatTableView];
}

- (void)creatCancelPayBtn {
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 60, 44);
    
    
    [backBtn setTitle:@"取消" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backToOrderView) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.rightBarButtonItem = backItem;
}


//  返回按钮 返回到订单列表
- (void)backToOrderView {
    
    NSString *title = @"确认要取消支付 ？";
    NSString *message = @"下单后1小时内未成功支付，订单将自动取消，请尽快完成支付";
    NSString *cancelButtonTitle = NSLocalizedString(@"继续支付", nil);
    NSString *otherButtonTitle = NSLocalizedString(@"确认取消", nil);
    
    UIAlertController *alertContr = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    //    __weak typeof(alert) wAlert = alert; [alert ...];
    
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"继续支付---");
    }];
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        NSLog(@"确认取消---");
        
        [self.navigationController popViewControllerAnimated:YES];
#warning 跳转到订单中心界面
        NSLog(@"应该跳转到--订单中心界面！！");
        
        
    }];
    
    // Add the actions.
    [alertContr addAction:cancelAction];
    [alertContr addAction:otherAction];
    
    [self presentViewController:alertContr animated:YES completion:nil];
    
}

- (void)creatTableView {
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - 64) style:UITableViewStylePlain];
    _tableView.bounces = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return _payTypeArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",_payTypeArr[indexPath.row]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
    
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
