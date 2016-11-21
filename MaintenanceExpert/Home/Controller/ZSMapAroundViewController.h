//
//  ZSMapAroundViewController.h
//  MaintenanceExpert
//
//  Created by xpc on 16/11/11.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MiSearchBar.h"

@interface ZSMapAroundViewController : UIViewController

@property (nonatomic,strong) MiSearchBar *searchBar;
@property (nonatomic,strong) NSString *searchText;

@property (nonatomic,retain) NSMutableArray *arr;
@property (nonatomic,retain) NSMutableArray *resultArr;


@end
