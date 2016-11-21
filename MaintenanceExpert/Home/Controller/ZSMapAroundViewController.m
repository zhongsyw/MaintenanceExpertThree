//
//  ZSMapAroundViewController.m
//  MaintenanceExpert
//
//  Created by xpc on 16/11/11.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSMapAroundViewController.h"
#import "ZSHomeTableViewCell.h"


@interface ZSMapAroundViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UITextFieldDelegate>

{
    UIView *headerView;
}

@property (strong, nonatomic) UITableView *tableView;

@property (nonatomic) BOOL isSearch;//判断是否在搜索

@end

@implementation ZSMapAroundViewController


- (void)viewWillAppear:(BOOL)animated {
    
    self.navigationController.navigationBarHidden = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"地图周边";
    
    [self creatNavigationView];
    [self creatSearchBar];
    [self creatTableView];
}


- (void)creatNavigationView {
    
    //  Navigation 发 布
    headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor colorWithRed:253.0/255.0 green:217.0/255.0 blue:85.0/255.0 alpha:1];
    [self.view addSubview:headerView];
    headerView.sd_layout.leftSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .heightIs(64);
    
}



- (void)creatSearchBar {
    
    _searchBar = [[MiSearchBar alloc] initWithFrame:CGRectMake(0, 20, KScreenWidth - 60, 40) placeholder:@"   搜索"];
    _searchBar.delegate = self;
    _searchBar.barTintColor = [UIColor redColor];
    [headerView addSubview:_searchBar];
    _searchText = @"";
    
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(KScreenWidth - 60, 20, 60, 40);
    cancelBtn.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1];
    [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelBtn.titleLabel setFont:[UIFont systemFontOfSize:14.f]];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:cancelBtn];
    
    
    
    _arr = [[NSMutableArray alloc] initWithObjects:@"1",@"12",@"1233",@"21",@"31",@"41",@"55",@"67",@"90",@"1211111",@"900000",@"10", nil];
    _resultArr = [[NSMutableArray alloc]init];
    
}

- (void)creatTableView {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, KScreenWidth, KScreenHeight - 64) style:UITableViewStylePlain];
    //    _tableView.bounces = NO;  // 禁止下拉、上拉的弹性
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
}


//  Cancel  关闭搜索按钮
- (void)cancelBtnClick {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return KScreenHeight * 0.09;
}



#pragma mark - UITableViewDataSource

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//
//    return 20;
//}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    static NSString *identifier = @"homeTableViewCell";
//
//    ZSHomeTableViewCell *homeCell = (ZSHomeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
//
//    if (!homeCell) {
//
//        homeCell = [[ZSHomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//
//        //  UITableViewCell选中不变色
//        //        homeCell.selectionStyle = UITableViewCellSelectionStyleNone;
//        homeCell.selectionStyle = UITableViewCellSelectionStyleDefault; //  默认
//
//    }
//
//    return homeCell;
//}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
//
//    NSLog(@"机房位置Cell被点击");
//
//}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isSearch) {
        return _resultArr.count ;
    }else{
        return _arr.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (self.isSearch) {
        cell.textLabel.text = _resultArr[indexPath.row];
    }else{
        cell.textLabel.text = _arr[indexPath.row];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"index.rew--%ld",indexPath.row);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length == 0) {
        _searchText = @"";
        self.isSearch = NO;
        [self.tableView reloadData];
    }
    NSLog(@" --- %@",searchText);
    [_resultArr removeAllObjects];
    
    for (NSString *searchStr in _arr) {
        if ([searchStr rangeOfString:searchText].location != NSNotFound) {
            [_resultArr addObject:searchStr];
        }
    }
    if (_resultArr.count) {
        self.isSearch = YES;
        [self.tableView reloadData];
    }
}


-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    self.isSearch = NO;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    self.isSearch = NO;
    [self.tableView reloadData];
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
