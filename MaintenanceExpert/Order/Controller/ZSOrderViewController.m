//
//  ZSOrderViewController.m
//  MaintenanceExpert
//
//  Created by xpc on 16/10/27.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSOrderViewController.h"
#import "ZSLeftTableViewCell.h"
#import "ZSRightTableViewCell.h"
#import "ZSDetailsViewController.h"

#define TOP_BUTTON_HEIGHT 50

@interface ZSOrderViewController ()<UITableViewDelegate, UITableViewDataSource>


{
    UIButton *topLeftBtn;
    UIButton *topRightBtn;
    
}

@property(strong, nonatomic) UITableView *leftTableView;
@property(strong, nonatomic) UITableView *rightTableView;

@end

@implementation ZSOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = BACK_GROUND_COLOR;
    
    self.navigationController.navigationBarHidden = NO;
    [self creatTableView];
    [self creatTopBtn];
    
}

//  添加 TableView
- (void)creatTableView {
    
    _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, TOP_BUTTON_HEIGHT, KScreenWidth, KScreenHeight - 64*2 + 15) style:UITableViewStylePlain];
    _leftTableView.backgroundColor = [UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1];
    _leftTableView.showsVerticalScrollIndicator = NO;
    _leftTableView.bounces = NO;
    _leftTableView.hidden = NO;
    _leftTableView.tag = 100;
    _leftTableView.delegate = self;
    _leftTableView.dataSource = self;
    _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;  //  设置分割线
    [self.view addSubview:_leftTableView];
    
    //  --------------
    _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, TOP_BUTTON_HEIGHT, KScreenWidth, KScreenHeight - 162) style:UITableViewStylePlain];
    _rightTableView.backgroundColor = [UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1];
    _rightTableView.showsVerticalScrollIndicator = NO;
    _rightTableView.bounces = NO;
    _rightTableView.hidden = YES;
    _rightTableView.tag = 101;
    _rightTableView.delegate = self;
    _rightTableView.dataSource = self;
    _rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_rightTableView];
}

//  添加 Button
- (void)creatTopBtn {
    
    topLeftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    topLeftBtn.frame = CGRectMake(0, 0, KScreenWidth / 2, TOP_BUTTON_HEIGHT);
    [topLeftBtn setTitle:@"正在进行的订单" forState:UIControlStateNormal];
    [topLeftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //    [topLeftBtn setBackgroundImage:[UIImage imageNamed:@"selectBtn"] forState:UIControlStateNormal];
    [topLeftBtn setBackgroundColor:[UIColor cyanColor]];
    topLeftBtn.tag = 90;
    [topLeftBtn addTarget:self action:@selector(topLeftBtnClick:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:topLeftBtn];
    
    
    topRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    topRightBtn.frame = CGRectMake(KScreenWidth / 2, 0, KScreenWidth / 2, TOP_BUTTON_HEIGHT);
    [topRightBtn setTitle:@"已经完成的订单" forState:UIControlStateNormal];
    [topRightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //    [topRightBtn setBackgroundImage:[UIImage imageNamed:@"nomalBtn"] forState:UIControlStateNormal];
    [topRightBtn setBackgroundColor:[UIColor purpleColor]];
    topRightBtn.tag = 91;
    [topRightBtn addTarget:self action:@selector(topRightBtnClick:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:topRightBtn];
    
}

//  左边的按钮
- (void)topLeftBtnClick:(UIButton *)button {
    
    NSLog(@"leftBtn,%ld",button.tag);
    
    //    button.selected = !button.selected;
    
    _leftTableView.hidden = NO;
    _rightTableView.hidden = YES;
    
    if (_leftTableView.hidden == NO) {
        
        [topLeftBtn setBackgroundColor:[UIColor cyanColor]];
        [topRightBtn setBackgroundColor:[UIColor purpleColor]];
    }
}

//  右边的按钮
- (void)topRightBtnClick:(UIButton *)button {
    
    NSLog(@"rightBtn,%ld",button.tag);
    
    //    button.selected = !button.selected;
    
    _rightTableView.hidden = NO;
    _leftTableView.hidden = YES;
    
    if (_rightTableView.hidden == NO) {
        
        [topLeftBtn setBackgroundColor:[UIColor purpleColor]];
        [topRightBtn setBackgroundColor:[UIColor cyanColor]];
    }
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 20;
}

/*
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
 //static NSString *identifier = @"cell";
 
 ZSOneTableViewCell *cell = [[ZSOneTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
 cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
 
 return cell;
 }
 */

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView.tag == 100) {
        
        static NSString *leftIdentifier = @"cell";
        ZSLeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:leftIdentifier];
        
        if(!cell) {
            cell = [[ZSLeftTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:leftIdentifier];
        }
        return cell;
        
    }else if (tableView == _rightTableView) {
        
        static NSString *rightIndentifier = @"ZSRightTableViewCell";
        ZSRightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:rightIndentifier];
        
        if(nil == cell) {
            cell = [[ZSRightTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rightIndentifier];
        }
        return cell;
    }
    return nil;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
//    if (tableView.tag == 100) {
    
        ZSDetailsViewController *leftDetailsVC = [[ZSDetailsViewController alloc] init];
        
        [self.navigationController pushViewController:leftDetailsVC animated:YES];
        
//        NSLog(@"正在进行的订单");
//    } else if (tableView.tag == 101) {
//        
//        NSLog(@"已完成的订单");
//
    
    NSLog(@"订单 cell 被点击");
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [ZSLeftTableViewCell getHeight] + 10;
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
