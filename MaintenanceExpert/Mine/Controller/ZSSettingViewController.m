//
//  ZSSettingViewController.m
//  MaintenanceExpert
//
//  Created by koka on 16/10/26.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSSettingViewController.h"
#import "ZSLoginViewController.h"
#import "ZSMineViewController.h"
#import "ZSMineInfoViewController.h"
#import "ZSFamilyViewController.h"
#import "ZSHelpViewController.h"
#import "MineInfModel.h"




@interface ZSSettingViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSString *_username;
    UIButton *_btn;
    MineInfModel *_Model;
}
@property(nonatomic,strong)UITableView *tableview;;


@end

@implementation ZSSettingViewController


- (void)viewWillAppear:(BOOL)animated {
    _username =  [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
//    NSLog(@"%@",_username);
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSData *data = [user objectForKey:@"USER"];
    MineInfModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    _Model = model;
    NSLog(@"%@",_Model.username);
    self.navigationController.navigationBarHidden = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
   //_username =  [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    
    
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(5 , 24 , KScreenWidth - 10, 44 * 3) style:UITableViewStylePlain];
    
    _tableview.backgroundColor = [UIColor cyanColor];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.showsVerticalScrollIndicator = NO;
    _tableview.showsHorizontalScrollIndicator = NO;

    
    [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
  
    self.view.backgroundColor = [UIColor cyanColor];
    _btn = [[UIButton alloc]initWithFrame:CGRectMake(10, _tableview.frame.size.height + 42, KScreenWidth - 20, 40)];
    
    _btn.layer.cornerRadius = 10;
    

    _btn.tintColor = [UIColor whiteColor];
    _btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    _btn.backgroundColor = [UIColor orangeColor];
    
    [self.view addSubview:_btn];
    [self.view addSubview:_tableview];
   

}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"修改资料";

        if (_username == nil) {
            cell.textLabel.text = @"修改资料 (请先登录)";
            [_btn setTitle:@"您还未登录" forState:UIControlStateNormal];
        }else {
            cell.textLabel.text = @"修改资料";
            [_btn setTitle:@"退出登录" forState:UIControlStateNormal];
            [_btn addTarget:self action:@selector(outlogin) forControlEvents:UIControlEventTouchDown];
        }
    }else if (indexPath.row == 1) {
        cell.textLabel.text = @"关于中数运维";
    }else{
        cell.textLabel.text = @"帮助与反馈";
    }
    
   
    cell.layer.cornerRadius = 5;
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        if (_username != nil) {
            ZSMineInfoViewController *zsm = [[ZSMineInfoViewController alloc]init];
            [self.navigationController pushViewController:zsm animated:YES];
        }else {
            
        }
    }else if (indexPath.row == 1) {
        ZSFamilyViewController *zsf = [[ZSFamilyViewController alloc]init];
        [self.navigationController pushViewController:zsf animated:YES];
    }else {
        ZSHelpViewController *zsh = [[ZSHelpViewController alloc]init];
        [self.navigationController pushViewController:zsh animated:YES];

    }
        
        [tableView deselectRowAtIndexPath:indexPath animated:NO]; 
   
}




- (void)outlogin {

    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"username"];
        
    //[self.navigationController popViewControllerAnimated:YES];
    //[self.navigationController popToRootViewControllerAnimated:YES];
    
    ZSLoginViewController *login = [[ZSLoginViewController alloc]init];
    [self.navigationController pushViewController:login animated:YES];
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
