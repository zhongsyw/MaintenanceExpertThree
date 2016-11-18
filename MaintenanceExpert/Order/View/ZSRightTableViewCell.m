//
//  ZSRightTableViewCell.m
//  MaintenanceExpert
//
//  Created by xpc on 16/10/31.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSRightTableViewCell.h"

#define BGVIEW_HEIGHT 160

@interface ZSRightTableViewCell ()

@property(strong, nonatomic)UIView *bgView;

@end


@implementation ZSRightTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1];
        
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self creatUI];
        [self creatView];
        
    }
    return self;
}


- (void)creatUI {
    
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, [[UIScreen mainScreen] bounds].size.width - 20, BGVIEW_HEIGHT)];
    _bgView.backgroundColor = [UIColor whiteColor];
    
    //  为边框设置阴影
    _bgView.layer.shadowOffset = CGSizeMake(1, 1);
    _bgView.layer.shadowOpacity = 0.3;
    _bgView.layer.shadowColor = [UIColor blackColor].CGColor;
    [self.contentView addSubview:_bgView];
}

- (void)creatView {
    
    //  类型  图片
    _imgType = [[UIImageView alloc] init];
    _imgType.backgroundColor = [UIColor cyanColor];
    [_imgType setImage:[UIImage imageNamed:@"weixiu"]];
    [_bgView addSubview:_imgType];
    _imgType.sd_layout.topSpaceToView(_bgView, 13)
    .leftSpaceToView(_bgView, 10)
    .widthIs(80)
    .heightEqualToWidth(_imgType);
    
    //  地址
    _address = [[UILabel alloc] init];
    _address.backgroundColor = [UIColor cyanColor];
    _address.text = @"青岛市敦化路325号青岛银行机房建设建设建设建设建设";
    [_address setFont:[UIFont systemFontOfSize:15]];
    [_bgView addSubview:_address];
    _address.sd_layout.leftSpaceToView(_imgType, 10)
    .topEqualToView(_imgType)
    .rightSpaceToView(_bgView, 20)
    .heightIs(20);
    
    //  价格
    _money = [[UILabel alloc] init];
    _money.backgroundColor = [UIColor cyanColor];
    _money.text = @"¥5000.00/次*12";
    [_money setFont:[UIFont systemFontOfSize:14]];
    _money.textColor = [UIColor redColor];
    [_bgView addSubview:_money];
    _money.sd_layout.leftEqualToView(_address)
    .topSpaceToView(_address, 5)
    .widthIs(120)
    .heightIs(20);
    
    //  巡检/故障 图片
    _imgXunJian = [[UIImageView alloc] init];
    _imgXunJian.backgroundColor = [UIColor cyanColor];
    [_imgXunJian setImage:[UIImage imageNamed:@"xunjian"]];
    [_bgView addSubview:_imgXunJian];
    _imgXunJian.sd_layout.leftEqualToView(_money)
    .bottomEqualToView(_imgType)
    .widthIs(80)
    .heightIs(20);
    
    //  横线
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1];
    [_bgView addSubview:line];
    line.sd_layout.leftSpaceToView(_bgView, 0)
    .topSpaceToView(_bgView, (_bgView.frame.size.height / 3)*2)
    .rightSpaceToView(_bgView, 0)
    .heightIs(1);
    
    //  发布日期
    _releaseTime = [[UILabel alloc] init];
    _releaseTime.backgroundColor = [UIColor cyanColor];
    _releaseTime.text = @"发布日期:2016年09月01日";
    _releaseTime.textColor = [UIColor grayColor];
    [_releaseTime setFont:[UIFont systemFontOfSize:8]];
    [_bgView addSubview:_releaseTime];
    _releaseTime.sd_layout.rightSpaceToView(_bgView, 8)
    .bottomEqualToView(_imgXunJian)
    .widthIs(100)
    .heightIs(10);
    
    //  剩余时间
//    _timeShengYu = [[UILabel alloc] init];
//    _timeShengYu.backgroundColor = [UIColor cyanColor];
//    _timeShengYu.text = @"还剩7天1小时";
//    _timeShengYu.textColor = [UIColor grayColor];
//    [_timeShengYu setFont:[UIFont systemFontOfSize:8]];
//    [_bgView addSubview:_timeShengYu];
//    _timeShengYu.sd_layout.bottomSpaceToView(_releaseTime, 1)
//    .rightEqualToView(_releaseTime)
//    .widthIs(60)
//    .heightIs(10);
    
    
    //  下次巡检时间/发布日期
    _nextXunJian = [[UILabel alloc] init];
    _nextXunJian.backgroundColor = [UIColor cyanColor];
    _nextXunJian.text = @"完成日期:2016年10月28日";
    _nextXunJian.textColor = [UIColor grayColor];
    [_nextXunJian setFont:[UIFont systemFontOfSize:8]];
    [_bgView addSubview:_nextXunJian];
    _nextXunJian.sd_layout.rightSpaceToView(_bgView, 8);
    _nextXunJian.sd_layout.bottomSpaceToView(_releaseTime, 1)
    .rightEqualToView(_releaseTime)
    .widthIs(100)
    .heightIs(10);
    
    //  联系客户
    _relation = [[UIButton alloc] init];
    _relation.backgroundColor = [UIColor cyanColor];
    [_relation setBackgroundImage:[UIImage imageNamed:@"lianxi"] forState:UIControlStateNormal];
    [_relation addTarget:self action:@selector(relationButtonClick) forControlEvents:UIControlEventTouchDown];
    [_bgView addSubview:_relation];
    _relation.sd_layout.leftEqualToView(_imgType)
    .topSpaceToView(line, 15)
    .widthIs(80)
    .heightIs(25);
    
    //  更多
    _another = [[UIButton alloc] init];
    _another.backgroundColor = [UIColor cyanColor];
    [_another setTitle:@"● ● ●" forState:UIControlStateNormal];
    [_another setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_another.titleLabel setFont:[UIFont systemFontOfSize:10]];
    [_another addTarget:self action:@selector(anotherButtonClick) forControlEvents:UIControlEventTouchDown];
    [_bgView addSubview:_another];
    _another.sd_layout.rightSpaceToView(_bgView, 10)
    .topSpaceToView(line, 10)
    .widthIs(33)
    .heightIs(33);
    
    
    //  查看评价
    _appraisal = [[UIButton alloc] init];
    _appraisal.backgroundColor = [UIColor cyanColor];
    [_appraisal setTitle:@"查看评价" forState:UIControlStateNormal];
    [_appraisal setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_appraisal.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [_appraisal addTarget:self action:@selector(appraisalButtonClick) forControlEvents:UIControlEventTouchDown];
    [_bgView addSubview:_appraisal];
    _appraisal.sd_layout.rightSpaceToView(_another, 10)
    .topEqualToView(_another)
    .widthIs(90)
    .heightIs(33);
    
    
}


- (void)btnClick {
    
    NSLog(@"按钮被点击");
}


//  联系客户 按钮
- (void)relationButtonClick {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"联系客户" delegate:self cancelButtonTitle:@"电话" otherButtonTitles:@"短信", nil];
    
    [alertView show];
    
    NSLog(@"联系客户");
}

//  查看评价 按钮
- (void)appraisalButtonClick {
    NSLog(@"查看评价");
}

//  更多 按钮
- (void)anotherButtonClick {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"更多" message:@"删除订单" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"删除", nil];
    
    [alertView show];
    
    NSLog(@"更多");
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
