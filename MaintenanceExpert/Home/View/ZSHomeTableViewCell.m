//
//  ZSHomeTableViewCell.m
//  MaintenanceExpert
//
//  Created by xpc on 16/11/4.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSHomeTableViewCell.h"

@implementation ZSHomeTableViewCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
//        self.backgroundColor = [UIColor cyanColor];
        
        [self creatCellView];
        
    }
    
    return self;
}


- (void)creatCellView {
    
    _homeImgType = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, KScreenHeight * 0.09 - 10, KScreenHeight * 0.09 - 10)];
    _homeImgType.backgroundColor = [UIColor cyanColor];
    [self addSubview:_homeImgType];
    
    //  机房位置
    _homeCellAddress = [[UILabel alloc] init];
    _homeCellAddress.backgroundColor = [UIColor cyanColor];
    _homeCellAddress.text = @"青岛市北区政府";
    [_homeCellAddress setFont:[UIFont systemFontOfSize:14]];
    [self addSubview:_homeCellAddress];
    _homeCellAddress.sd_layout.leftSpaceToView(_homeImgType, 8)
    .topEqualToView(_homeImgType)
    .widthIs(KScreenWidth / 3)
    .heightRatioToView(_homeImgType, 0.5);
    
    //  分类
    _homeCellType = [[UILabel alloc] init];
    _homeCellType.backgroundColor = [UIColor magentaColor];
    _homeCellType.text = @"故障分类:机房供电";
    [_homeCellType setFont:[UIFont systemFontOfSize:10]];
    [self addSubview:_homeCellType];
    _homeCellType.sd_layout.leftEqualToView(_homeCellAddress)
    .topSpaceToView(_homeCellAddress, 2)
    .widthIs(90)
    .heightRatioToView(_homeImgType, 0.25);
    
    //  机房等级
    _homeCellGrades = [[UILabel alloc] init];
    _homeCellGrades.backgroundColor = [UIColor cyanColor];
    _homeCellGrades.text = @"机房等级:A";
    [_homeCellGrades setFont:[UIFont systemFontOfSize:10]];
    [self addSubview:_homeCellGrades];
    _homeCellGrades.sd_layout.topSpaceToView(_homeCellType, 0)
    .leftEqualToView(_homeCellType)
    .widthIs(KScreenWidth * 0.23)
    .heightRatioToView(_homeImgType, 0.25);
    
    //  距离
    _homeCellDistance = [[UILabel alloc] init];
    _homeCellDistance.backgroundColor = [UIColor cyanColor];
    _homeCellDistance.text = @"889m";
    _homeCellDistance.textAlignment = NSTextAlignmentRight;
    [_homeCellDistance setFont:[UIFont systemFontOfSize:12]];
    [self addSubview:_homeCellDistance];
    _homeCellDistance.sd_layout.topEqualToView(_homeImgType)
    .rightSpaceToView(self, 10)
    .widthIs(50)
    .heightRatioToView(_homeImgType, 0.5);
    
    //  发布日期
    _homeCellTime = [[UILabel alloc] init];
    _homeCellTime.backgroundColor = [UIColor cyanColor];
    _homeCellTime.text = @"发布日期:2016/11/11";
    _homeCellTime.textAlignment = NSTextAlignmentRight;
    [_homeCellTime setFont:[UIFont systemFontOfSize:10]];
    [self addSubview:_homeCellTime];
    _homeCellTime.sd_layout.topEqualToView(_homeCellGrades)
    .rightEqualToView(_homeCellDistance)
    .widthIs(100)
    .heightRatioToView(_homeImgType, 0.25);
    
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
