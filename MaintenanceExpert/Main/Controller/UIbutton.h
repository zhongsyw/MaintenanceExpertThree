//
//  UIbutton.h
//  MaintenanceExpert
//
//  Created by koka on 16/10/20.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIbutton : UIView

- (UIButton *)addButtonWithImage:(NSString *)image highImage:(NSString *)highImage disableImage:(NSString *)disableImage frame:(CGRect)frame tag:(NSInteger)tag action:(SEL)action;

@end
