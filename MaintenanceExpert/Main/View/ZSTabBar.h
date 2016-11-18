//
//  ZSTabBar.h
//  MaintenanceExpert
//
//  Created by koka on 16/10/18.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZSTabBar;

@protocol ZSTabBarDelegate <NSObject>
- (void)tabBarPlusBtnClick:(ZSTabBar *)tabBar;

@end

@interface ZSTabBar : UITabBar
/** tabbar的代理 */
@property (nonatomic, weak) id<ZSTabBarDelegate> myDelegate ;

@end
