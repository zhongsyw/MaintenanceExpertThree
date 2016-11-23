//
//  ZSMineViewController.m
//  MaintenanceExpert
//
//  Created by koka on 16/10/18.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSMineViewController.h"
#import "ZSLoginViewController.h"
#import "UIView+ZSExtension.h"
#import "ZSSettingViewController.h"
#import "MineInfModel.h"
#import "ZSBalanceViewController.h"

#define XLColor(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

@interface ZSMineViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UIView *_HeaderView;
    UIImageView *_HeardrViewimage;
    MineInfModel *_Model;
    
    NSString *_ordernum;
    NSString *_mymoney;
}

@property (nonatomic, strong) UITableView *tableView;

/** 数据数组 */
@property (nonatomic, strong) NSArray *dataList;

/** 记录清空缓存的index */
@property (nonatomic, strong) NSIndexPath *path;
/** 赚了多少钱 */
//@property (nonatomic, assign) UILabel *moneyLabel;
/** 去分享 */
@property (nonatomic, strong) UILabel *shareLabel;

@property (nonatomic, strong) UIButton *Loginbtn;

/** 被赞 */
@property (nonatomic, strong) UILabel *beizan;

/** 被关注 */
@property (nonatomic, strong) UILabel *guanzhu;

/** 粉丝 */
@property (nonatomic, strong) UILabel *fensi;


@property (nonatomic,strong) UIView *lineView;

@end

@implementation ZSMineViewController


- (NSArray *)dataList{
    if (!_dataList) {
        NSMutableDictionary *dengji = [NSMutableDictionary dictionary];
        dengji[@"title"] = nil;
        dengji[@"icon"] = nil;
        
        NSMutableDictionary *dingdan = [NSMutableDictionary dictionary];
        dingdan[@"title"] = @"我的订单";
        dingdan[@"icon"] = @"share_platform_qqfriends";
        
        //要跳转到的控制器
        //dingdan[@"controller"] = [ZSLoginViewController class];
        
        NSMutableDictionary *yue = [NSMutableDictionary dictionary];
        yue[@"title"] = @"我的余额";
        yue[@"icon"] = @"share_platform_qqfriends";
        yue[@"controller"] = [ZSBalanceViewController class];
        
        NSMutableDictionary *cleanCache = [NSMutableDictionary dictionary];
        cleanCache[@"title"] = @"清空缓存";
        cleanCache[@"icon"] = @"share_platform_qqfriends";
        
        NSMutableDictionary *setting = [NSMutableDictionary dictionary];
        setting[@"title"] = @"设置";
        setting[@"icon"] = @"share_platform_qqfriends";
        setting[@"controller"] = [ZSSettingViewController class];
        NSArray *section0 = @[dengji];
        NSArray *section1 = @[dingdan, yue];
       // NSArray *section2 = @[zsfamily, help];
        NSArray *section2 = @[cleanCache];
        NSArray *section3 = @[setting];
        
        _dataList = [NSArray arrayWithObjects:section0,section1, section2, section3, nil];
    }
    return _dataList;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth , KScreenHeight + 64) style:UITableViewStyleGrouped];
        _tableView.y = -20;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.bounces = NO;
        
        _tableView.tableHeaderView = _HeaderView;
        _tableView.tableHeaderView.userInteractionEnabled = YES;
        [self.view addSubview:_tableView];
    }
    
    return _tableView;
}

//刷新tableview
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.navigationController.navigationBarHidden = YES;
    
    _username =  [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];

    if (_username == nil) {
        self.Loginbtn.hidden = NO;
        
    }else {
        self.Loginbtn.hidden = YES;
        
    }
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSData *data = [user objectForKey:@"USER"];
    MineInfModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    _Model = model;
    
    [self userinfor];

    [self.tableView reloadData];
    
   
}


#pragma mark - life cycle...

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupHeaderView];
    
    
}

- (void)userinfor {
    
    if (_username != nil) {

        _moneyLabel.text = [NSString stringWithFormat:@"赚了%@元",_Model.moneynum];
        _icon.image = _Model.usericon;
        _nameLabel.text = _Model.username;
        _beizannum.text = _Model.beizannum;
        _guanzhunum.text = _Model.guanzhunum;
        _fensinum.text = _Model.fensinum;
        _ordernum = _Model.Ordernum;

        _mymoney = _Model.Mymoney;
    } else {
        _icon.image = [UIImage imageNamed:@"share_platform_qqfriends"];
        _nameLabel.text = @"";
        _moneyLabel.text = @"赚了0.00元";
        _icon = nil;
        _beizannum.text = @"0";
        _guanzhunum.text = @"0";
        _fensinum.text = @"0";
        _ordernum = @"0";
        _mymoney = @"0";
    }

    
}

- (void)setupHeaderView {
    _HeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight / 3)];
    _HeaderView.userInteractionEnabled = YES;
    _HeardrViewimage = [[UIImageView alloc]initWithFrame:_HeaderView.frame];
    _HeardrViewimage.image = [UIImage imageNamed:@"93S58PICcXy_1024.jpg"];
    _HeardrViewimage.contentMode = UIViewContentModeScaleAspectFill;
    [_HeaderView addSubview:_HeardrViewimage];
    
    [self createsubview];
}

- (void)createsubview {
    
    [self createnamelabel];
    [self createmoneylabel];
    [self createicon];
    [self createsharelabel];
    
    [self createbeizan];
    [self createbeizannum];
    
    [self createguanzhu];
    [self createguanzhunum];
    
    [self createfensi];
    [self createfensinum];
    
    [self createline];
    
    
}


/**
 *
 * 个人信息控件
 */
- (void)createnamelabel {
    
    _nameLabel = [[UILabel alloc] init];
    
    _nameLabel.numberOfLines = 0;

    _nameLabel.textColor = [UIColor whiteColor];
    
    [_HeardrViewimage addSubview:_nameLabel];
    
    _nameLabel.sd_layout.leftSpaceToView(_HeardrViewimage,KScreenWidth / 10)
    .topSpaceToView(_HeardrViewimage,44)
    .heightIs(40)
    .widthIs(200);
    _nameLabel.font = [UIFont systemFontOfSize:30];
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    _nameLabel.userInteractionEnabled = YES;
    
//    _Loginbtn = [[UIButton alloc]initWithFrame:CGRectMake( KScreenWidth / 10, 44, 100, 40)];
//
//    [_Loginbtn setTitle:@"登 录" forState:UIControlStateNormal];
//    _Loginbtn.titleLabel.textAlignment = NSTextAlignmentLeft;
//    [_Loginbtn.titleLabel setFont:[UIFont systemFontOfSize:30 weight:5]];
//    [_Loginbtn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchDown];
//    _Loginbtn.backgroundColor = [UIColor clearColor];
//    [_HeaderView addSubview:_Loginbtn];
  
}
- (void)createmoneylabel {
    _moneyLabel = [[UILabel alloc]init];
    _moneyLabel.textAlignment = NSTextAlignmentLeft;
    _moneyLabel.numberOfLines = 0;

    _moneyLabel.textColor = [UIColor whiteColor];
    [_HeaderView addSubview:_moneyLabel];
    
    _moneyLabel.sd_layout.leftSpaceToView(_HeaderView,KScreenWidth / 10)
    .topSpaceToView(_HeaderView,84)
    .heightIs(30)
    .widthIs(130);
    _moneyLabel.font = [UIFont systemFontOfSize:15];

}
- (void)createicon {
    
    _icon = [[UIImageView alloc] init];
    _icon.height = _icon.width = KScreenWidth/5;
    _icon.layer.cornerRadius = _icon.width * 0.5;
    _icon.layer.masksToBounds = YES;
    _icon.contentMode = UIViewContentModeScaleAspectFill;
    [_HeaderView addSubview:_icon];
    _icon.sd_layout.topSpaceToView(_HeaderView,44)
                    .rightSpaceToView(_HeaderView,KScreenWidth / 10)
                    .heightIs(KScreenWidth/5)
                    .widthIs(KScreenWidth/5);
    
    
}
- (void)createsharelabel {
    _shareLabel = [[UILabel alloc]init];
    _shareLabel.text = @"去炫耀";
    _shareLabel.textColor = [UIColor blueColor];
    _shareLabel.font = [UIFont systemFontOfSize:15];
    
    [_HeaderView addSubview:_shareLabel];
    //[shareBtn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchDown];
    _shareLabel.sd_layout.leftSpaceToView(self.moneyLabel,0)
    .topEqualToView(self.moneyLabel)
    .bottomEqualToView(self.moneyLabel)
    .rightSpaceToView(self.icon,0);

}

- (void)createbeizan {
    _beizan = [[UILabel alloc] init];
    
    _beizan.numberOfLines = 0;
    
    _beizan.text = @"被赞数";
    _beizan.textColor = [UIColor whiteColor];
    
    [_HeaderView addSubview:_beizan];
    
    _beizan.sd_layout.leftSpaceToView(_HeaderView,KScreenWidth / 10)
    .bottomSpaceToView(_HeaderView,5)
    .heightIs(25)
    .widthIs(KScreenWidth * 0.8 /3);
    _beizan.font = [UIFont systemFontOfSize:18];
    _beizan.textAlignment = NSTextAlignmentCenter;
}
- (void)createbeizannum{
    _beizannum = [[UILabel alloc] init];
    
    _beizannum.numberOfLines = 0;
    
    _beizannum.text = _Model.beizannum;
    
    _beizannum.textColor = [UIColor blackColor];
    
    [_HeaderView addSubview:_beizannum];
    
    _beizannum.sd_layout.leftEqualToView(self.beizan)
    .bottomSpaceToView(self.beizan,0)
    .heightIs(40)
    .widthIs(KScreenWidth * 0.8 /3);
    _beizannum.font = [UIFont systemFontOfSize:18];
    _beizannum.textAlignment = NSTextAlignmentCenter;
}

- (void)createguanzhu {
    _guanzhu = [[UILabel alloc] init];
    
    _guanzhu.numberOfLines = 0;
    _guanzhu.text = @"关注数";
    _guanzhu.textColor = [UIColor whiteColor];
    
    [_HeaderView addSubview:_guanzhu];
    
    _guanzhu.sd_layout.leftSpaceToView(self.beizan, 0)
    .bottomEqualToView(self.beizan)
    .topEqualToView(self.beizan)
    .widthIs(KScreenWidth * 0.8 /3);
    _guanzhu.font = [UIFont systemFontOfSize:18];
    _guanzhu.textAlignment = NSTextAlignmentCenter;
}
- (void)createguanzhunum{
    _guanzhunum = [[UILabel alloc] init];
    
    _guanzhunum.numberOfLines = 0;
    
    _guanzhunum.text = _Model.guanzhunum;
    
    _guanzhunum.textColor = [UIColor blackColor];
    
    [_HeaderView addSubview:_guanzhunum];
    
    _guanzhunum.sd_layout.leftSpaceToView(self.beizannum,0)
    .bottomEqualToView(self.beizannum)
    .topEqualToView(self.beizannum)
    .widthIs(KScreenWidth * 0.8 /3);
    _guanzhunum.font = [UIFont systemFontOfSize:18];
    _guanzhunum.textAlignment = NSTextAlignmentCenter;

}

- (void)createfensi {
    _fensi = [[UILabel alloc] init];
    
    _fensi.numberOfLines = 0;
    _fensi.text = @"粉丝数";
    _fensi.textColor = [UIColor whiteColor];
    
    [_HeaderView addSubview:_fensi];
    
    _fensi.sd_layout.leftSpaceToView(self.guanzhu, 0).bottomEqualToView(self.beizan).topEqualToView(self.beizan).widthIs(KScreenWidth * 0.8 /3);
    _fensi.font = [UIFont systemFontOfSize:18];
    _fensi.textAlignment = NSTextAlignmentCenter;

}
- (void)createfensinum {
    _fensinum = [[UILabel alloc] init];
    
    _fensinum.numberOfLines = 0;
    
    _fensinum.text = _Model.fensinum;
    
    _fensinum.textColor = [UIColor blackColor];
    
    [_HeaderView addSubview:_fensinum];
    
    _fensinum.sd_layout.leftSpaceToView(self.guanzhunum,0).bottomEqualToView(self.beizannum).topEqualToView(self.beizannum).widthIs(KScreenWidth * 0.8 /3);
    _fensinum.font = [UIFont systemFontOfSize:18];
    _fensinum.textAlignment = NSTextAlignmentCenter;

}

- (void)createline {
    _lineView = [[UIView alloc]init];
    _lineView.backgroundColor = [UIColor grayColor];
    [_HeaderView addSubview:_lineView];
    _lineView.sd_layout.leftEqualToView(self.beizannum)
    .rightEqualToView(self.fensinum)
    .bottomSpaceToView(self.beizannum,1)
    .heightIs(1);
    
}
/**
 *
 *  @param taps 个人界面的 分享按钮
 */
- (void)share:(UITapGestureRecognizer *)taps {
    NSLog(@"去炫耀");
    
    
}

//- (void)click {
//    
//    ZSLoginViewController *zslogin = [[ZSLoginViewController alloc]init];
//    [self.tabBarController addChildViewController:zslogin];
//    //[self presentViewController:zslogin animated:YES completion:nil];
//    //self.hidesBottomBarWhenPushed=YES;
//    [self.navigationController pushViewController:zslogin animated:YES];
//    //self.hidesBottomBarWhenPushed=NO;
//    
//    
//    
//}




#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataList.count ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 90;
    }else {
        return 50;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataList[section] count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *ID = @"mineCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    NSDictionary *dict = self.dataList[indexPath.section][indexPath.row];
    cell.textLabel.text = dict[@"title"];
    cell.imageView.image = [UIImage imageNamed:dict[@"icon"]];
    
    if (indexPath.section == 0) {
        
        UIImageView *im = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, KScreenWidth, 80)];
        im.image = [UIImage imageNamed:@"E53C392C-4434-4D0F-8E14-74E6DEF83AA7"];
        im.contentMode = UIViewContentModeScaleAspectFill;
        
        [cell addSubview:im];
        } else
        {
        cell.layer.cornerRadius = 10;
        NSDictionary *dict = self.dataList[indexPath.section][indexPath.row];
        cell.textLabel.text = dict[@"title"];
        cell.imageView.image = [UIImage imageNamed:dict[@"icon"]];
    }

        switch (indexPath.section) {
            case 1:
            
                if (indexPath.row == 0) {
                    cell.detailTextLabel.text = _ordernum;
                }
                if (indexPath.row == 1) {
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"￥%@",_mymoney];
                }
                break;
                
            default:
                break;
        }
    
    
    cell.selected = YES;
    
    if ([cell.textLabel.text isEqualToString:@"清空缓存"]){
        
        cell.accessoryView = [[UIView alloc] init];
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.dataList[indexPath.section][indexPath.row][@"controller"]){
        UIViewController *vc = [[self.dataList[indexPath.section][indexPath.row][@"controller"] alloc] init];
        
        
            vc.title = self.dataList[indexPath.section][indexPath.row][@"title"];
        

        [self.navigationController pushViewController:vc animated:YES];

        
        
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return !section ? 1 : CGFLOAT_MIN;
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
