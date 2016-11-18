//
//  ZSAlertView.m
//  MaintenanceExpert
//
//  Created by koka on 16/11/3.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSAlertView.h"
#define  LGLAlertShowTime 1.0

@implementation ZSAlertView
// 单个或多个按钮

+ (void)showAlertViewWith:(UIViewController *)viewController imagename:(NSString *)imagename title:(NSString *)title message:(NSString *)message CallBackBlock:(CallBackBlock)block cancelButtonTitle:(NSString *)cancelBtnTitle destructiveButtonTitle:(NSString *)destructiveBtnTitle otherButtonTitles:(NSString *)otherBtnTitles,... {
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIImageView *image = [[UIImageView alloc]init];
    image.frame = CGRectMake(0, 0, 270, 84);
    image.backgroundColor = [UIColor blueColor];
    image.image = [UIImage imageNamed:imagename];
    image.layer.cornerRadius = 13;
    image.layer.masksToBounds = YES;
    image.contentMode = UIViewContentModeScaleAspectFill;
    [alertController.view addSubview:image];
    NSLog(@"%f,%f",image.frame.size.width,image.frame.size.height);
    
    //添加按钮
    if (cancelBtnTitle.length) {
        UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:cancelBtnTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            block(0);
        }];
        [alertController addAction:cancelAction];
    }

    if (otherBtnTitles.length) {
        UIAlertAction *otherActions = [UIAlertAction actionWithTitle:otherBtnTitles style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            (!cancelBtnTitle.length && !destructiveBtnTitle.length) ? block(0) : (((cancelBtnTitle.length && !destructiveBtnTitle.length) || (!cancelBtnTitle.length && destructiveBtnTitle.length)) ? block(1) : block(2));
        }];
        [alertController addAction:otherActions];
        
        va_list args;
        va_start(args, otherBtnTitles);
        if (otherBtnTitles.length) {
            NSString * otherString;
            int index = 2;
            (!cancelBtnTitle.length && !destructiveBtnTitle.length) ? (index = 0) : ((cancelBtnTitle.length && !destructiveBtnTitle.length) || (!cancelBtnTitle.length && destructiveBtnTitle.length) ? (index = 1) : (index = 2));
            while ((otherString = va_arg(args, NSString*))) {
                index ++ ;
                UIAlertAction * otherActions = [UIAlertAction actionWithTitle:otherString style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    block(index);
                }];

                [alertController addAction:otherActions];
            }
        }
        va_end(args);
    }
    

    
    [viewController presentViewController:alertController animated:YES completion:nil];
    
    //如果没有按钮，自动延迟消失
    if (!cancelBtnTitle.length &&  !otherBtnTitles) {
        //此时self指本类
        [self performSelector:@selector(dismissAlertController:) withObject:alertController afterDelay:1.0];
    }
}
// 有输入框

+ (void)showAlertTextFieldViewWith:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message TextFeildCallBackBlock:(TextFieldCallBackBlock)textBlock cancelButtonTitle:(NSString *)cancelBtnTitle otherButtonTitles:(NSString *)otherBtnTitle {
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"请输入昵称";
        
    }];
    if (cancelBtnTitle.length) {
        UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:cancelBtnTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            [self dismissAlertController:alertController];
        }];
        [alertController addAction:cancelAction];
    }
    if (otherBtnTitle.length) {
        UIAlertAction * otherAction = [UIAlertAction actionWithTitle:otherBtnTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            textBlock([alertController.textFields firstObject].text);
        }];
        [alertController addAction:otherAction];
    }
    [viewController presentViewController:alertController animated:YES completion:nil];
    //如果没有按钮，自动延迟消失
    if (!cancelBtnTitle.length && !otherBtnTitle.length) {
        //此时self指本类
        [self performSelector:@selector(dismissAlertController:) withObject:alertController afterDelay:LGLAlertShowTime];
    }
    
}

// ======================================================================== ----- AlertView end----- ==================================================================================
#pragma mark ==== 点击事件 ======
+ (void)dismissAlertController:(UIAlertController *)alert {
    [alert dismissViewControllerAnimated:YES completion:nil];
}


@end
