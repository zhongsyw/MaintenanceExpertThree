//
//  TwoCollectionViewCell.m
//  MaintenanceExpert
//
//  Created by xpc on 16/10/18.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "TwoCollectionViewCell.h"

@implementation TwoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        //self.backgroundColor = [UIColor blueColor];
        
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self addSubview:_imgView];
        
//        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, (_imgView.frame.size.height / 3 * 2), _imgView.frame.size.width, _imgView.frame.size.height / 3)];
//        _label.backgroundColor = [UIColor yellowColor];
//        _label.text = @"主图";
//        _label.textColor = [UIColor blackColor];
//        _label.textAlignment = NSTextAlignmentCenter;
//        [self addSubview:_label];
        
        _delBtn = [[UIButton alloc] initWithFrame:CGRectMake(-5, -5, 20, 20)];
        [_delBtn setImage:[UIImage imageNamed:@"X"] forState:UIControlStateNormal];
        
        [_delBtn addTarget:self action:@selector(delBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_delBtn];
        
        
    }
    return self;
}

- (void)delBtnAction{
    
    [self.delegate shanchudelegate:self];
}




@end
