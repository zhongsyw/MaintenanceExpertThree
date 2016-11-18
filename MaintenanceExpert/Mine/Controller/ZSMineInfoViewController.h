//
//  ZSMineInfoViewController.h
//  MaintenanceExpert
//
//  Created by koka on 16/10/27.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ZSMineInfoViewController : UIViewController


@property (nonatomic, strong) NSArray<ZLSelectPhotoModel *> *lastSelectMoldels;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *arrDataSources;
@property (strong, nonatomic) NSMutableArray *mutableArray;
@end
