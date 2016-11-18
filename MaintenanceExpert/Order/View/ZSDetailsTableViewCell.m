//
//  ZSDetailsTableViewCell.m
//  MaintenanceExpert
//
//  Created by 中数 on 16/11/8.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSDetailsTableViewCell.h"

@implementation ZSDetailsTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor cyanColor];
        //  设置 Cell 点击后 不变灰
        //        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self creatView];
        
    }
    return self;
}


- (void)creatView {
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 7, 200, 30)];
    lab.text = @"订单详情界面 Cell";
    [self addSubview:lab];
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
