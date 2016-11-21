//
//  ZSHomeViewController.m
//  MaintenanceExpert
//
//  Created by xpc on 16/10/25.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSHomeViewController.h"
#import "XRCarouselView.h"
#import "ZSHomeTableViewCell.h"
#import "ZSHomeMapView.h"
#import "ZSMapAroundViewController.h"

@interface ZSHomeViewController ()<UITableViewDelegate, UITableViewDataSource,XRCarouselViewDelegate>

{
    UIButton *leftTitleBtn;
    UIButton *rightTitltBtn;
    UIBarButtonItem *rightBarBtn;
    UIButton *refreshBtn;   //  刷新位置
    ZSHomeMapView *mapView;
}

@property (strong, nonatomic) XRCarouselView *carouselView;
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation ZSHomeViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

//  二级页面 显示 NavigationBar
//- (void)viewWillDisappear:(BOOL)animated {
//
//    [super viewWillDisappear:animated];
//
//    if ( self.navigationController.childViewControllers.count > 1 ) {
//        [self.navigationController setNavigationBarHidden:NO animated:YES];
//    }
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.navigationController.navigationBarHidden = NO;
    
    [self creatNavigationView];
    
    [self creatScrollHeaderView];
    
    [self AroundMessage];
    
    //    [self creatMapView];
    
    [self creatTableView];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //获取Documents路径
    //    NSArray*paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    //    NSString*path=[paths objectAtIndex:0];
    //    NSLog(@"path:%@",path);
    
}


#warning 这里 差两个 图片没添加
//  发现、我的、 搜索按钮
- (void)creatNavigationView {
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth/3, 44)];
    //    titleView.backgroundColor = [UIColor cyanColor];
    
#warning 选择  发现/我的 被选中的字体变大，有背景图---
    
    //  发现
    leftTitleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, titleView.frame.size.width/2, 44)];
    //    leftTitleBtn.backgroundColor = [UIColor redColor];
    [leftTitleBtn setTitle:@"发现" forState:UIControlStateNormal];
    //    [leftTitleBtn setBackgroundImage:[UIImage imageNamed:@"home_navigationBar_btn"] forState:UIControlStateNormal];
    leftTitleBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [leftTitleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftTitleBtn addTarget:self action:@selector(leftTitleBtnClick) forControlEvents:UIControlEventTouchDown];
    [titleView addSubview:leftTitleBtn];
    
    //  我的
    rightTitltBtn = [[UIButton alloc] initWithFrame:CGRectMake(titleView.frame.size.width/2, 0, titleView.frame.size.width/2, 44)];
    //    rightTitltBtn.backgroundColor = [UIColor yellowColor];
    [rightTitltBtn setTitle:@"我的" forState:UIControlStateNormal];
    [rightTitltBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    rightTitltBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [rightTitltBtn addTarget:self action:@selector(rightTitltBtnClick) forControlEvents:UIControlEventTouchDown];
    [titleView addSubview:rightTitltBtn];
    
    self.navigationItem.titleView = titleView;
    
    
    //  搜索
    rightBarBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"SearchIcon"] style:UIBarButtonItemStylePlain target:self action:@selector(searchButtonClick)];
    self.navigationItem.rightBarButtonItem = rightBarBtn;
    
}


- (void)creatTableView {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, KScreenHeight * 0.509 + 30, KScreenWidth, KScreenHeight * 0.491 - 143) style:UITableViewStylePlain];
    _tableView.showsVerticalScrollIndicator = NO;   //  关闭侧边滚动条
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //    _tableView.bounces = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;  //  设置分割线
    [self.view addSubview:_tableView];
}

//  轮播图
- (void)creatScrollHeaderView {
    
    NSArray *imageArr = @[
                          @"http://img2.3lian.com/2014/c7/12/d/77.jpg",
                          @"http://img2.pconline.com.cn/pconline/0706/19/1038447_34.jpg",
                          @"http://img3.iqilu.com/data/attachment/forum/201308/21/192654ai88zf6zaa60zddo.jpg",
                          @"http://img06.tooopen.com/images/20160724/tooopen_sy_171572235394.jpg"
                          ];
    
    //    NSArray *describeArray = @[@"网络图片", @"本地图片", @"网络动态图", @"本地动态图"];
    
    self.carouselView = [[XRCarouselView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight*0.21)];
    
    //  设置占位图，需在设置数组图片之前设置，不设置则为默认占位图
    _carouselView.placeholderImage = [UIImage imageNamed:@"XRPlaceholder"];
    
    //  设置图片数组以及图片描述文字
    _carouselView.imageArray = imageArr;
    //    _carouselView.describeArray = describeArray;
    
    
    //  用代理处理图片点击
    _carouselView.delegate = self;
    
    //  设置图片的停留时间，默认为5s，最少为2s
    _carouselView.time = 2;
    
    //  设置分页控件的图片，不设置则为系统默认的
    [_carouselView setPageImage:[UIImage imageNamed:@"pageControlDot"] andCurrentPageImage:[UIImage imageNamed:@"pageControlCurrentDot"]];
    
    //  设置分页控件的位置，默认为PositionBottomCenter
    _carouselView.pagePosition = PositionBottomCenter;
    
    
    /**
     *  修改图片描述控件的外观，不需要修改的传nil
     *
     *  参数一 字体颜色，默认为白色
     *  参数二 字体，默认为13号字体
     *  参数三 背景颜色，默认为黑色半透明
     */
    //    UIColor *bgColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
    //    UIFont *font = [UIFont systemFontOfSize:15];
    //    UIColor *textColor = [UIColor greenColor];
    [_carouselView setDescribeTextColor:nil font:nil bgColor:nil];
    
    [self.view addSubview:_carouselView];
    
    
}


//  附近的信息
- (void)AroundMessage {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, KScreenHeight*0.209, 150, 30)];
    label.text = @"附近的信息";
    [label setFont:[UIFont systemFontOfSize:15]];
    [self.view addSubview:label];
    
    //  刷新位置按钮
    
    refreshBtn = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth - 40, KScreenHeight*0.209, 30, 30)];
    [refreshBtn setImage:[UIImage imageNamed:@"home_header_refresh"] forState:UIControlStateNormal];
    [refreshBtn addTarget:self action:@selector(refreshButtonClick) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:refreshBtn];
    
    //  当前位置
    
    UILabel *nowAddress = [[UILabel alloc] initWithFrame:CGRectMake(KScreenWidth / 2 - 40, KScreenHeight*0.209, KScreenWidth / 2, 30)];
    nowAddress.text = @"敦化路160号华仁丶欧典商苑";
    nowAddress.textColor = [UIColor grayColor];
    [nowAddress setFont:[UIFont systemFontOfSize:12]];
    nowAddress.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:nowAddress];
    
    
}


//  加载地图
- (void)creatMapView {
    
    mapView = [[ZSHomeMapView alloc] initWithFrame:CGRectMake(0, KScreenHeight * 0.209 + 30, self.view.frame.size.width, KScreenHeight * 0.3)];
    [self.view addSubview:mapView];
    
}



- (void)leftTitleBtnClick {
    
    NSLog(@"发   现----");
}

- (void)rightTitltBtnClick {
    
    NSLog(@"我   的----");
}

- (void)searchButtonClick {
    
    ZSMapAroundViewController *mapAroundVC = [[ZSMapAroundViewController alloc] init];
    
    [self.navigationController pushViewController:mapAroundVC animated:YES];
    
    NSLog(@"搜   索----");
}


//  刷新 当前位置     点击开始旋转
- (void)refreshButtonClick {
    
    NSLog(@"刷新当前位置------");
    
    CABasicAnimation * rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"]; //让其在z轴旋转
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];//旋转角度
    rotationAnimation.duration = 2; //旋转周期
    rotationAnimation.cumulative = YES;//旋转累加角度
    rotationAnimation.repeatCount = 10;//旋转次数
    [refreshBtn.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
}


//  数据请求结束  动画停止
-(void)stopRotate {
    [refreshBtn.layer removeAllAnimations];
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.row == 3) {
        
        NSLog(@"查看更多");
        
        ZSMapAroundViewController *mapAroundVC = [[ZSMapAroundViewController alloc] init];
        
        [self.navigationController pushViewController:mapAroundVC animated:YES];
        
        
    }
    
    NSLog(@"cell 被点击");
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 3) {
        return  KScreenHeight * 0.09 * 0.7;
    }else {
        return KScreenHeight * 0.09;
    }
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"TableVieCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        if (indexPath.row < 3){
            
            
            cell = [[ZSHomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            
            //  查看更多
        }else if (indexPath.row == 3){
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight * 0.044)];
            label.text = @"更多";
            label.textAlignment = NSTextAlignmentCenter;
            [cell addSubview:label];
            
        }
    }
    
    return cell;
}


#pragma mark - XRCarouselViewDelegate

- (void)carouselView:(XRCarouselView *)carouselView clickImageAtIndex:(NSInteger)index {
    
    
    NSLog(@"点击了第%ld张图",index);
    
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
