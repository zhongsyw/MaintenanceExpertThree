//
//  StepthirdCell.m
//  MaintenanceExpert
//
//  Created by koka on 16/11/7.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "StepthirdCell.h"

@implementation StepthirdCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
      
        self.imgView = [[UIImageView alloc]init];
        [self addSubview:self.imgView];
        
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

@end
