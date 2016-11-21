//
//  ZSTabBarController.m
//  MaintenanceExpert
//
//  Created by koka on 16/10/18.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSTabBarController.h"
#import "ZSNavigationController.h"
#import "ZSHomeViewController.h"
#import "ZSOrderViewController.h"
#import "ZSEditAndReceiveViewController.h"
#import "ZSMessageViewController.h"
#import "ZSMineViewController.h"
#import "ZSLoginViewController.h"

#import "XWPopMenuController.h"
#import "UIImage+XW.h"
#import "ZSTabBar.h"
#import "UIImage+Image.h"

@interface ZSTabBarController ()<ZSTabBarDelegate>
{
    ZSNavigationController *_nav;
}
@end

@implementation ZSTabBarController

#pragma mark - 第一次使用当前类的时候对设置UITabBarItem的主题
+ (void)initialize
{
    UITabBarItem *tabBarItem = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
    
    NSMutableDictionary *dictNormal = [NSMutableDictionary dictionary];
    dictNormal[NSForegroundColorAttributeName] = [UIColor grayColor];
    dictNormal[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    
    NSMutableDictionary *dictSelected = [NSMutableDictionary dictionary];
    dictSelected[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    dictSelected[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    
    [tabBarItem setTitleTextAttributes:dictNormal forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:dictSelected forState:UIControlStateSelected];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpAllChildVc];
    //创建自己的tabbar，然后用kvc将自己的tabbar和系统的tabBar替换下
    ZSTabBar *tabBar = [[ZSTabBar alloc]init];
    tabBar.myDelegate = self;
     //kvc实质是修改了系统的_tabBar
    [self setValue:tabBar forKeyPath:@"tabBar"];
    
    
}

#pragma mark - ------------------------------------------------------------------
#pragma mark - 初始化tabBar上除了中间按钮之外所有的按钮



- (void)setUpAllChildVc
{
    
    
    ZSHomeViewController *HomeVC = [[ZSHomeViewController alloc] init];
    [self setUpOneChildVcWithVc:HomeVC Image:@"home_normal" selectedImage:@"home_highlight" title:@"首页"];
    
    ZSOrderViewController *OrderVC = [[ZSOrderViewController alloc] init];
    [self setUpOneChildVcWithVc:OrderVC Image:@"fish_normal" selectedImage:@"fish_highlight" title:@"订单"];
    
    ZSMessageViewController *MessageVC = [[ZSMessageViewController alloc] init];
    [self setUpOneChildVcWithVc:MessageVC Image:@"message_normal" selectedImage:@"message_highlight" title:@"消息"];
    
    ZSMineViewController *MineVC = [[ZSMineViewController alloc] init];
    [self setUpOneChildVcWithVc:MineVC Image:@"account_normal" selectedImage:@"account_highlight" title:@"我的"];
    
    
}

#pragma mark - 初始化设置tabBar上面单个按钮的方法

/**
 *  @author li bo, 16/05/10
 *
 *  设置单个tabBarButton
 *
 *  @param Vc            每一个按钮对应的控制器
 *  @param image         每一个按钮对应的普通状态下图片
 *  @param selectedImage 每一个按钮对应的选中状态下的图片
 *  @param title         每一个按钮对应的标题
 */
- (void)setUpOneChildVcWithVc:(UIViewController *)Vc Image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title
{
    _nav = [[ZSNavigationController alloc] initWithRootViewController:Vc];
    
    UIImage *myImage = [UIImage imageNamed:image];
    myImage = [myImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //tabBarItem，是系统提供模型，专门负责tabbar上按钮的文字以及图片展示
    Vc.tabBarItem.image = myImage;
    
    UIImage *mySelectedImage = [UIImage imageNamed:selectedImage];
    mySelectedImage = [mySelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    Vc.tabBarItem.selectedImage = mySelectedImage;
    
    Vc.tabBarItem.title = title;
    
    Vc.navigationItem.title = title;
    
    [self addChildViewController:_nav];
    
}

#pragma mark - ------------------------------------------------------------------
#pragma mark - ZSTabBarDelegate
- (void)tabBarPlusBtnClick:(ZSTabBar *)tabBar {

    XWPopMenuController *vc = [[XWPopMenuController alloc]init];
    [self.tabBarController addChildViewController:vc];
    
    //虚化背景
    UIImage *image = [UIImage imageWithCaputureView:self.view];
    vc.backImg = image;
    
    //[self presentViewController:vc animated:NO completion:nil];
    [self.navigationController pushViewController:vc animated:NO];
    
    
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
