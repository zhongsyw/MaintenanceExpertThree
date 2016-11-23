//
//  NSBundle+TZImagePicker.m
//  TZImagePickerController
//
//  Created by 谭真 on 16/08/18.
//  Copyright © 2016年 谭真. All rights reserved.
//

#import "NSBundle+TZImagePicker.h"
#import "TZImagePickerController.h"

@implementation NSBundle (TZImagePicker)

+ (instancetype)tz_imagePickerBundle {
    static NSBundle *tzBundle = nil;
    if (tzBundle == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"TZImagePickerController" ofType:@"bundle"];
        if (!path) {
            path = [[NSBundle mainBundle] pathForResource:@"TZImagePickerController" ofType:@"bundle" inDirectory:@"Frameworks/TZImagePickerController.framework/"];
        }
        tzBundle = [NSBundle bundleWithPath:path];
    }
    return tzBundle;
}

+ (NSString *)tz_localizedStringForKey:(NSString *)key {
    return [self tz_localizedStringForKey:key value:@""];
}

+ (NSString *)tz_localizedStringForKey:(NSString *)key value:(NSString *)value {
    static NSBundle *bundle = nil;
    if (bundle == nil) {
        NSString *language = [NSLocale preferredLanguages].firstObject;
        if ([language rangeOfString:@"zh-Hans"].location != NSNotFound) {
            language = @"zh-Hans";
        } else {
            language = @"en";
        }
        bundle = [NSBundle bundleWithPath:[[NSBundle tz_imagePickerBundle] pathForResource:language ofType:@"lproj"]];
    }
    NSString *value1 = [bundle localizedStringForKey:key value:value table:nil];
    return value1;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated;{
    
    
    
    //修复裁剪图片时出现导航栏的bug
    if ([viewController isKindOfClass:NSClassFromString(@"TZImagePickerController")]) {
        
        [navigationController setNavigationBarHidden:YES animated:NO];
    }else{
        
        if ([viewController isKindOfClass:NSClassFromString(@"TZImagePickerController")]) {
            return;
        }
        [navigationController setNavigationBarHidden:YES animated:NO];
        
    }
}

//- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    //修复裁剪图片时出现导航栏的bug
//    if ([viewController isKindOfClass:NSClassFromString(@"TZImagePickerController")]) {
//        
//        [navigationController setNavigationBarHidden:YES animated:NO];
//    }else{
//        
//        if ([viewController isKindOfClass:NSClassFromString(@"TZImagePickerController")]) {
//            return;
//        }
//        [navigationController setNavigationBarHidden:YES animated:NO];
//
//}
//}
@end
