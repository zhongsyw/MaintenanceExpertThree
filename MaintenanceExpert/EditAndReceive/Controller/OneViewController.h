//
//  OneViewController.h
//  XWPopMenuVCDemo
//
//  Created by koka on 16/10/18.
//  Copyright © 2016年 ZSYW. All rights reserved.

#import <UIKit/UIKit.h>

//2.block传值  typedef void(^returnBlock)();
typedef void(^dismissBlock) ();

@interface OneViewController : UIViewController
{
    UIImageView *addview;
    NSInteger  currenttag;
}
-(void)Clickup:(NSInteger)tag;
-(NSInteger)getblank:(NSInteger)tag;
-(CAAnimation*)moveanimation:(NSInteger)tag number:(NSInteger)num;


@property (nonatomic,assign)NSInteger integer;
//block
//block声明属性
@property (nonatomic, copy) dismissBlock mDismissBlock;


//block声明方法
-(void)toDissmissSelf:(dismissBlock)block;

//@property (nonatomic,copy)UITextField *Area;

@end
