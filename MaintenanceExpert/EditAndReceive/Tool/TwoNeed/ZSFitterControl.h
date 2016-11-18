//
//  ZSFitterControl.h
//  MaintenanceExpert
//
//  Created by xpc on 16/11/3.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZSFitterControl : UIControl

- (id) initWithFrame:(CGRect) frame Titles:(NSArray *) titles;
- (void) setSelectedIndex:(int)index;
- (void) setTitlesFont:(UIFont *)font;

@property(nonatomic, strong) UIButton *handler;
@property(nonatomic, strong) UIColor *progressColor;
@property(nonatomic, strong) UIColor *TopTitlesColor;
@property(nonatomic, readonly) int SelectedIndex;

@end
