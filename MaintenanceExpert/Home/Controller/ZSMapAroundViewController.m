//
//  ZSMapAroundViewController.m
//  MaintenanceExpert
//
//  Created by xpc on 16/11/11.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSMapAroundViewController.h"
#import "ZSHomeTableViewCell.h"

@interface ZSMapAroundViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation ZSMapAroundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"地图周边";
    
    [self creatTableView];
}


- (void)creatTableView {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - 64) style:UITableViewStylePlain];
    //    _tableView.bounces = NO;  // 禁止下拉、上拉的弹性
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return KScreenHeight * 0.09;
}



#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 20;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"homeTableViewCell";
    
    ZSHomeTableViewCell *homeCell = (ZSHomeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!homeCell) {
        
        homeCell = [[ZSHomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        //  UITableViewCell选中不变色
        //        homeCell.selectionStyle = UITableViewCellSelectionStyleNone;
        homeCell.selectionStyle = UITableViewCellSelectionStyleDefault; //  默认
        
    }
    
    return homeCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSLog(@"机房位置Cell被点击");
    
    
    
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
