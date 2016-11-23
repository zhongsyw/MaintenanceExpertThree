//
//  Regex.h
//  MaintenanceExpert
//
//  Created by koka on 16/11/21.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Regex : NSObject

+ (BOOL) isMobile:(NSString *)mobileNumbel;

+ (BOOL)isAvailableEmail:(NSString *)email;
@end
