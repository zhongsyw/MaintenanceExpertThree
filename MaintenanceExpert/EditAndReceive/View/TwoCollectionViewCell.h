//
//  TwoCollectionViewCell.h
//  MaintenanceExpert
//
//  Created by xpc on 16/10/18.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol shanchudelegate <NSObject>

- (void)shanchudelegate:(UICollectionViewCell *)cell;

@end

@interface TwoCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) UIImageView *imgView;
@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) UIButton *delBtn;
@property (nonatomic, weak)id<shanchudelegate>delegate;

@end
