//
//  ZSRegisterCustomerVC.m
//  MaintenanceExpert
//
//  Created by xpc on 16/10/20.
//  Copyright © 2016年 ZSYW. All rights reserved.
//
//  客户注册界面

#import "ZSRegisterCustomerVC.h"


@interface ZSRegisterCustomerVC () 
{
    UIScrollView *_scrollview;
    UILabel *_titlelabel;
    NSMutableArray *_titlearray;
}
@end

@implementation ZSRegisterCustomerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"工程师";
    self.view.backgroundColor = [UIColor cyanColor];
    _scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 5, KScreenWidth, KScreenHeight - 64 )];
    _scrollview.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:_scrollview];
    _scrollview.showsVerticalScrollIndicator = YES;
    _scrollview.showsHorizontalScrollIndicator = YES;
    _scrollview.contentSize = CGSizeMake(0, 940);
    
    _titlearray = [[NSMutableArray alloc]initWithObjects:@"姓名:",@"性别:",@"出生日期:",@"现居住地:",@"手机:",@"电子邮件:",@"能否独立完成维保服务:",@"工作模式:",@"服务模式:\n(用户需求)",@"你的专业:",@"目前工作单位:",@"是否是厂家工程师:",@"相关技能证书:",@"手持身份证照片:", nil];
    
    [self createtitlelabel];
}

- (void)createtitlelabel {
    
    
    for (int i = 0; i < 14; i++) {
        _titlelabel = [[UILabel alloc]init];
        
        if (i < 8) {
            
            _titlelabel.frame = CGRectMake(10, i * 44, 100, 40);
            if (i == 6) {
                _titlelabel.frame = CGRectMake(10, 6 * 44, 200, 40);
            }
            
        }else if ( i == 8 ){
            
            _titlelabel.frame = CGRectMake(10, 8 * 44, 120, 33 * 2 - 2);
        
        }else if (i == 9) {
            
            _titlelabel.frame = CGRectMake(10, 8 * 44 + 33 * 2, 100, 33 * 5 - 2);
            
        }else if (i < 12 && i > 9) {
            
            _titlelabel.frame = CGRectMake(10, 8 * 44 + 33 * 7 + (i - 10) * 44, 150, 40);
            
        }else if (i < 14 && i > 11) {
                
                _titlelabel.frame = CGRectMake(10, 10 * 44 + 33 * 7 + (i - 12) * 80 , 150, 80 - 2);
            
        }
    
        
        _titlelabel.text = [NSString stringWithFormat:@"%@",_titlearray[i]];
        _titlelabel.numberOfLines = 2;
        _titlelabel.backgroundColor = [UIColor cyanColor];
        UIImageView *lineview = [[UIImageView alloc]initWithFrame:CGRectMake(10, _titlelabel.frame.origin.y + _titlelabel.frame.size.height, KScreenWidth - 20, 1)];
        lineview.backgroundColor = [UIColor grayColor];
        [_scrollview addSubview:lineview];
        
        [_scrollview addSubview:_titlelabel];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
