//
//  UIbutton.m
//  MaintenanceExpert
//
//  Created by koka on 16/10/20.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "UIbutton.h"

@implementation UIbutton

#pragma mark 添加按钮
- (UIButton *)addButtonWithImage:(NSString *)image highImage:(NSString *)highImage disableImage:(NSString *)disableImage frame:(CGRect)frame tag:(NSInteger)tag action:(SEL)action
{
    // 创建按钮
    UIButton *btn = [[UIButton alloc] init];
    // 设置背景图片
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [btn setBackgroundImage:[UIImage imageNamed:disableImage] forState:UIControlStateDisabled];
    
    
    // 设置位置和尺寸
    btn.frame = frame;
    // 监听按钮点击
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    // 绑定tag标记
    btn.tag = tag;
    // 添加按钮
    [self addSubview:btn];
    
    return btn;
}

@end
