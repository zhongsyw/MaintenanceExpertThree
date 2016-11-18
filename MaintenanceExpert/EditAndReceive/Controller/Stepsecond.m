//
//  Stepsecond.m
//  MaintenanceExpert
//
//  Created by koka on 16/11/3.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "Stepsecond.h"
#import "ZSDetailOrderModel.h"
#import "STPickerSingle.h"
#import "STPickerDate.h"
#import "ZHBtnSelectView.h"
#import "ZHCustomBtn.h"
#import "Stepthird.h"

@interface Stepsecond()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,STPickerSingleDelegate,STPickerDateDelegate,ZHBtnSelectViewDelegate>
{
    UITableView *_tableview;
    NSMutableArray *_detailArray;//维修
    NSMutableArray *_detailArray1;//安装
    
    UITableViewCell *_cell;
    
    UITextField *_choosekind;
    UITextField *_date;
    UITextField *_Power;
    UITextField *_HostBrand;
    UITextField *_BatteryPack;
    
    UIButton *_Yesbtn;
    UIButton *_Nobtn;
    
}
//维修
@property (nonatomic,weak)ZHCustomBtn *currentgaokongBtn;
@property (nonatomic,weak)ZHBtnSelectView *btngaokongView;

@property (nonatomic,weak)ZHCustomBtn *currentjiaoxianBtn;
@property (nonatomic,weak)ZHBtnSelectView *btnjiaoxianView;

@property (nonatomic,weak)ZHCustomBtn *currentguzhangnumBtn;
@property (nonatomic,weak)ZHBtnSelectView *btnguzhangnumView;

@property (nonatomic,weak)ZHCustomBtn *currentkindBtn;
@property (nonatomic,weak)ZHBtnSelectView *btnkindView;

//安装
@property (nonatomic,weak)ZHCustomBtn *currentUPSKindBtn;
@property (nonatomic,weak)ZHBtnSelectView *btnUPSKindView;

@property (nonatomic,weak)ZHCustomBtn *currentUPSHostNumBtn;
@property (nonatomic,weak)ZHBtnSelectView *btnUPSHostNumView;

@property (nonatomic,weak)ZHCustomBtn *currentUPSPowerBtn;
@property (nonatomic,weak)ZHBtnSelectView *btnUPSPowerView;

@property (nonatomic,weak)ZHCustomBtn *currentLineBtn;
@property (nonatomic,weak)ZHBtnSelectView *btnLineView;

@property (nonatomic,weak)ZHCustomBtn *currentcountryBtn;
@property (nonatomic,weak)ZHBtnSelectView *btncountryView;


@property (nonatomic,strong)NSMutableArray *titleArr;
@property (nonatomic,strong)NSArray *kindArr;
@end

@implementation Stepsecond


- (void)viewWillAppear:(BOOL)animated {
    
    self.navigationItem.title = [NSString stringWithFormat:@"%@(2/3)",[ZSDetailOrderModel shareDetailOrder].NavTitle];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    _tableview = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableview.bounces = NO;
    _tableview.delegate = self;
    _tableview.dataSource = self;
    UIImageView *image = [[UIImageView alloc]initWithFrame:self.view.frame];
    image.image = [UIImage imageNamed:@"121"];
    [_tableview setBackgroundView:image];
    _tableview.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:_tableview];
    
    [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self initkind];
    
    [self nextstepbtn];
}


- (void)initkind {
    
    self.interone = [ZSDetailOrderModel shareDetailOrder].FirstIndex;//1000 1001 1002 1003
    self.intertwo = [ZSDetailOrderModel shareDetailOrder].SecondIndex;//2 3 4 5 6
    self.interkind = [ZSDetailOrderModel shareDetailOrder].KindIndex;//0维修 1安装
    _cell = [[UITableViewCell alloc]init];

    _detailArray = [[NSMutableArray alloc]initWithObjects:@"维修系统",@"维修时间",@"故障点",@"是否高空作业",@"郊县", nil];
    _detailArray1 =[[NSMutableArray alloc]initWithObjects:@"服务类型",@"服务时间",@"UPS类型",@"功率",@"主机品牌",@"UPS主机台数",@"电池组",@"UPS功率",@"电池主机间连线",@"是否郊县", nil];
    self.titleArr = @[].mutableCopy;
}


/**
 *
 *  @param tableView tabledelegate
 *
 */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.interkind == 0) {
        return _detailArray.count;
    }else{
        return _detailArray1.count;
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //CGFloat index = 0;
    if (self.interkind == 0) {
        if (indexPath.row == 0) {
            return 30 * 4;
        }else{
            if (indexPath.row == 2) {
                return 30 * 3;
            }else {
                return 40;
            }
            
        }

    }else{
        if ((indexPath.row == 4)||(indexPath.row == 7)) {
            return 60;
        }if (indexPath.row == 6 ){
            return 70;
        }else{
            return 40;
        }
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    /**
     *  0维修/1安装
     */
    if (self.interkind == 0) {
        /**
         维修cell
         */
        UITableViewCell *cellone = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cellone = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cellone.selectionStyle = UITableViewCellSelectionStyleDefault;
        _cell = cellone;
        _cell.tag = indexPath.row + 10;
        cellone.backgroundColor = [UIColor clearColor];
        cellone.textLabel.text = [NSString stringWithFormat:@"%@:",_detailArray[indexPath.row]];
        switch (indexPath.row) {
            case 0:
                [self createkindbtn];
                break;
            case 1:
                _date = [[UITextField alloc]initWithFrame:CGRectMake(KScreenWidth / 3 , 12.5, KScreenWidth / 2, 25)];
                _date.delegate  = self;
                _date.textAlignment = NSTextAlignmentRight;
                _date.placeholder = @"请选择时间:";
                [cellone addSubview:_date];
                break;
            case 2:
                [self createguzhangnumbtn];
                break;
            case 3:
                [self creategaokongbtn];
                break;
            case 4:
                [self createjiaoxianbtn];
                
                break;
                
            default:
                break;
        }
        
    }else{
        /**
         安装cell
         */
        UITableViewCell *celltwo = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        celltwo = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        celltwo.selectionStyle = UITableViewCellSelectionStyleNone;
        _cell = celltwo;
        celltwo.textLabel.text = [NSString stringWithFormat:@"%@:",_detailArray1[indexPath.row]];
        celltwo.backgroundColor = [UIColor clearColor];
        switch (indexPath.row) {
            case 0:
                _choosekind = [[UITextField alloc]initWithFrame:CGRectMake(KScreenWidth / 3 , 12.5, KScreenWidth / 2, 25)];
                _choosekind.delegate  = self;
                _choosekind.textAlignment = NSTextAlignmentRight;
                _choosekind.placeholder = @"请选择服务类型:";
                [celltwo addSubview:_choosekind];

                break;
            case 1:
                _date = [[UITextField alloc]initWithFrame:CGRectMake(KScreenWidth / 3 , 12.5, KScreenWidth / 2, 25)];
                _date.delegate  = self;
                _date.textAlignment = NSTextAlignmentRight;
                _date.placeholder = @"请选择时间:";
                [celltwo addSubview:_date];
                break;
            case 2:
                [self createUPSKindbtn];
                break;
            case 3:
                _Power = [[UITextField alloc]initWithFrame:CGRectMake(KScreenWidth / 3 , 12.5, KScreenWidth / 2, 25)];
                _Power.delegate  = self;
                _Power.textAlignment = NSTextAlignmentRight;
                _Power.placeholder = @"请选择功率:";
                [celltwo addSubview:_Power];
                break;
            case 4:
                _HostBrand = [[UITextField alloc]initWithFrame:CGRectMake(KScreenWidth / 3 , 12.5, KScreenWidth / 2, 25)];
                _HostBrand.delegate  = self;
                _HostBrand.textAlignment = NSTextAlignmentRight;
                _HostBrand.placeholder = @"请输入主机品牌:";
                _HostBrand.returnKeyType = UIReturnKeyDone;
                [celltwo addSubview:_HostBrand];
                break;
            case 5:
                [self createUPSHostNum];
                break;
            case 6:
                _BatteryPack = [[UITextField alloc]initWithFrame:CGRectMake(KScreenWidth / 3 , 12.5, KScreenWidth / 2, 25)];
                _BatteryPack.delegate  = self;
                _BatteryPack.textAlignment = NSTextAlignmentRight;
                _BatteryPack.placeholder = @"请输电池个数:";
                _BatteryPack.returnKeyType = UIReturnKeyDone;
                [celltwo addSubview:_BatteryPack];
                
                break;
            case 7:
                [self createUPSPower];
                break;
            case 8:
                [self createLine];
                break;
            case 9:
                [self createCountry];
                break;
            
            default:
                break;
        }
        if (indexPath.row == 6) {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth / 3, 35, KScreenWidth * 5 / 9 , 30)];
            label.text = @"*注：每组电池个数不超过20个，超过按多一组计算。电池个数最大2000个。";
            label.numberOfLines = 2;
            label.textAlignment = NSTextAlignmentLeft;
            label.textColor = [UIColor greenColor];
            label.font = [UIFont systemFontOfSize:12];
            [celltwo addSubview:label];
        }
        
        
    }
    return _cell;
}

#pragma mark - --- 按钮的delegate 视图委托 ---
/**
 *  维修对应的方法
 */
- (void)createkindbtn {
    
    self.kindArr = [[NSArray alloc]initWithObjects:@"闭路监控",@"防盗报警",@"停车场",@"电子巡更",@"防爆安检",@"广播",@"门禁一卡通", nil];
    // 自动计算view的高度
    ZHBtnSelectView *btnView = [[ZHBtnSelectView alloc] initWithFrame:CGRectMake(KScreenWidth  / 3  , 5, KScreenWidth * 2/ 3, 30)
                                                               titles:self.kindArr column:2];
    [_cell addSubview:btnView];
    btnView.verticalMargin = 10;
    btnView.delegate = self;
    self.btnkindView = btnView;
    btnView.tag  = 3;
    self.btnkindView.tag = btnView.tag;
    
}

- (void)createguzhangnumbtn {
    self.kindArr = [[NSArray alloc]initWithObjects:@"1-3",@"4-6",@"7-9",@"10-12",@"> 12", nil];
    // 自动计算view的高度
    ZHBtnSelectView *btnView = [[ZHBtnSelectView alloc] initWithFrame:CGRectMake(KScreenWidth  / 2 , 0, KScreenWidth / 2, 0)
                                                               titles:self.kindArr column:2];
    [_cell addSubview:btnView];
    btnView.verticalMargin = 10;
    btnView.delegate = self;
    self.btnguzhangnumView = btnView;
    btnView.tag  = 2;
    self.btnguzhangnumView.tag = btnView.tag;
}

- (void)creategaokongbtn {
    
    self.kindArr = [[NSArray alloc]initWithObjects:@"是",@"否", nil];
    // 自动计算view的高度
    ZHBtnSelectView *btnView = [[ZHBtnSelectView alloc] initWithFrame:CGRectMake(KScreenWidth  / 2 , 10, KScreenWidth / 2, 0)
                                                               titles:self.kindArr column:2];
    [_cell addSubview:btnView];
    btnView.verticalMargin = 10;
    btnView.delegate = self;
    self.btngaokongView = btnView;
    btnView.tag  = 1;
    self.btngaokongView.tag = btnView.tag;
    
    
}

- (void)createjiaoxianbtn {
    self.kindArr = [[NSArray alloc]initWithObjects:@"是",@"否", nil];
    // 自动计算view的高度
    ZHBtnSelectView *btnView = [[ZHBtnSelectView alloc] initWithFrame:CGRectMake(KScreenWidth  / 2 , 10, KScreenWidth / 2, 0)
                                                               titles:self.kindArr column:2];
    [_cell addSubview:btnView];
    btnView.verticalMargin = 10;
    btnView.delegate = self;
    self.btnjiaoxianView = btnView;
    btnView.tag  = 0;
    self.btnjiaoxianView.tag = btnView.tag;
}

// view的代理方法
- (void)btnSelectView:(ZHBtnSelectView *)btnSelectView selectedBtn:(ZHCustomBtn *)btn {
    btnSelectView.selectType = BtnSelectTypeMultiChoose;
    if ((btnSelectView.tag == 0)) {
        self.btnjiaoxianView.selectType = BtnSelectTypeSingleChoose;
        self.currentjiaoxianBtn.btnSelected = NO;
        self.currentjiaoxianBtn = btn;
        btn.btnSelected = YES;
        if ([self.currentjiaoxianBtn.titleLabel.text isEqualToString:@"是"]) {
            [ZSDetailOrderModel shareDetailOrder].Counties = YES;
        }else{
            [ZSDetailOrderModel shareDetailOrder].Counties = NO;
        }
        NSLog(@"是否是郊县---%d",[ZSDetailOrderModel shareDetailOrder].Counties);
        
    }if ((btnSelectView.tag == 1)) {
        self.btngaokongView.selectType = BtnSelectTypeSingleChoose;
        self.currentgaokongBtn.btnSelected = NO;
        self.currentgaokongBtn = btn;
        btn.btnSelected = YES;
        if ([self.currentgaokongBtn.titleLabel.text isEqualToString:@"是"]) {
            [ZSDetailOrderModel shareDetailOrder].HighWork = YES;
        }else{
            [ZSDetailOrderModel shareDetailOrder].HighWork = NO;
        }
        NSLog(@"是否高空作业---%d",[ZSDetailOrderModel shareDetailOrder].HighWork);
        
    }if ((btnSelectView.tag == 2)) {
        self.btnguzhangnumView.selectType = BtnSelectTypeSingleChoose;
        self.currentguzhangnumBtn.btnSelected = NO;
        self.currentguzhangnumBtn = btn;
        btn.btnSelected = YES;
        if ([self.currentguzhangnumBtn.titleLabel.text isEqualToString:@"1-3"]) {
            [ZSDetailOrderModel shareDetailOrder].ProblemNum = 1;
        }if ([self.currentguzhangnumBtn.titleLabel.text isEqualToString:@"4-6"]) {
            [ZSDetailOrderModel shareDetailOrder].ProblemNum = 2;
        }if ([self.currentguzhangnumBtn.titleLabel.text isEqualToString:@"7-9"]) {
            [ZSDetailOrderModel shareDetailOrder].ProblemNum = 3;
        }if ([self.currentguzhangnumBtn.titleLabel.text isEqualToString:@"10-12"]) {
            [ZSDetailOrderModel shareDetailOrder].ProblemNum = 4;
        }if ([self.currentguzhangnumBtn.titleLabel.text isEqualToString:@"> 12"]) {
            [ZSDetailOrderModel shareDetailOrder].ProblemNum = 5;
        }
        NSLog(@"---%ld",(long)[ZSDetailOrderModel shareDetailOrder].ProblemNum);
        
    }if ((btnSelectView.tag == 3)) {
        self.btnkindView.selectType = BtnSelectTypeMultiChoose;
        btn.btnSelected = !btn.btnSelected;
        if (btn.btnSelected) {
            [self.titleArr addObject:btn.titleLabel.text];
        } else {
            [self.titleArr removeObject:btn.titleLabel.text];
        }
        [ZSDetailOrderModel shareDetailOrder].MTsystemKindMuArr = [NSMutableArray arrayWithArray:self.titleArr];
        
        NSLog(@"--%@--",[ZSDetailOrderModel shareDetailOrder].MTsystemKindMuArr);
    }if ((btnSelectView.tag == 10)) {
        self.btnUPSKindView.selectType = BtnSelectTypeSingleChoose;
        self.currentUPSKindBtn.btnSelected = NO;
        self.currentUPSKindBtn = btn;
        btn.btnSelected = YES;
    }if ((btnSelectView.tag == 12)) {
        self.btnUPSHostNumView.selectType = BtnSelectTypeSingleChoose;
        self.currentUPSHostNumBtn.btnSelected = NO;
        self.currentUPSHostNumBtn = btn;
        btn.btnSelected = YES;
    }if ((btnSelectView.tag == 16)) {
        self.btnUPSPowerView.selectType = BtnSelectTypeSingleChoose;
        self.currentUPSPowerBtn.btnSelected = NO;
        self.currentUPSPowerBtn = btn;
        btn.btnSelected = YES;
    }if ((btnSelectView.tag == 17)) {
        self.btnLineView.selectType = BtnSelectTypeSingleChoose;
        self.currentLineBtn.btnSelected = NO;
        self.currentLineBtn = btn;
        btn.btnSelected = YES;
    }if ((btnSelectView.tag == 18)) {
        self.btncountryView.selectType = BtnSelectTypeSingleChoose;
        self.currentcountryBtn.btnSelected = NO;
        self.currentcountryBtn = btn;
        btn.btnSelected = YES;
    }
}

/**
 *  安装对应的方法
 *
*/

- (void)createUPSKindbtn {
    
    self.kindArr = [[NSArray alloc]initWithObjects:@"单相",@"三相", nil];
    // 自动计算view的高度
    ZHBtnSelectView *btnView = [[ZHBtnSelectView alloc] initWithFrame:CGRectMake(KScreenWidth  / 2 , 10, KScreenWidth / 2, 0)
                                                               titles:self.kindArr column:2];
    [_cell addSubview:btnView];
    btnView.verticalMargin = 10;
    btnView.delegate = self;
    self.btnUPSKindView = btnView;
    btnView.tag  = 10;
    self.btnUPSKindView.tag = btnView.tag;
    
}

- (void)createUPSHostNum {
    self.kindArr = [[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6", nil];
    // 自动计算view的高度
    ZHBtnSelectView *btnView = [[ZHBtnSelectView alloc] initWithFrame:CGRectMake(KScreenWidth  / 2 , 0, KScreenWidth / 2, 0)
                                                               titles:self.kindArr column:3];
    [_cell addSubview:btnView];
    btnView.verticalMargin = 10;
    btnView.delegate = self;
    self.btnUPSHostNumView = btnView;
    btnView.tag  = 12;
    self.btnUPSHostNumView.tag = btnView.tag;
    
}

- (void)createUPSPower {
    
    self.kindArr = [[NSArray alloc]initWithObjects:@"120A/H以下",@"150A/H以上", nil];
    // 自动计算view的高度
    ZHBtnSelectView *btnView = [[ZHBtnSelectView alloc] initWithFrame:CGRectMake(KScreenWidth  / 2 , 0, KScreenWidth / 2, 0)
                                                               titles:self.kindArr column:1];
    [_cell addSubview:btnView];
    btnView.verticalMargin = 10;
    btnView.delegate = self;
    self.btnUPSPowerView = btnView;
    btnView.tag  = 16;
    self.btnUPSPowerView.tag = btnView.tag;
    
}

- (void)createLine {
    self.kindArr = [[NSArray alloc]initWithObjects:@"需要",@"不需要", nil];
    // 自动计算view的高度
    ZHBtnSelectView *btnView = [[ZHBtnSelectView alloc] initWithFrame:CGRectMake(KScreenWidth  / 2 , 10, KScreenWidth / 2, 0)
                                                               titles:self.kindArr column:2];
    [_cell addSubview:btnView];
    btnView.verticalMargin = 10;
    btnView.delegate = self;
    self.btnLineView = btnView;
    btnView.tag  = 17;
    self.btnLineView.tag = btnView.tag;
}

- (void)createCountry {
    self.kindArr = [[NSArray alloc]initWithObjects:@"是",@"否", nil];
    // 自动计算view的高度
    ZHBtnSelectView *btnView = [[ZHBtnSelectView alloc] initWithFrame:CGRectMake(KScreenWidth  / 2 , 0, KScreenWidth / 2, 0)
                                                               titles:self.kindArr column:2];
    [_cell addSubview:btnView];
    btnView.verticalMargin = 10;
    btnView.delegate = self;
    self.btncountryView = btnView;
    btnView.tag  = 18;
    self.btncountryView.tag = btnView.tag;
    
}




#pragma mark - --- delegate 视图委托 ---

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == _choosekind) {
        [_choosekind resignFirstResponder];
        self.which = 1;
        NSMutableArray *arrayData = [[NSMutableArray alloc]initWithObjects:@"安装主机和电池",@"更换主机",@"更换电池",@"维护", nil];
        STPickerSingle *pickerSingle = [[STPickerSingle alloc]init];
        [pickerSingle setArrayData:arrayData];
        [pickerSingle setTitle:@"请选择服务类型"];
        [pickerSingle setContentMode:STPickerContentModeCenter];
        [pickerSingle setDelegate:self];
        [pickerSingle show];

    }if(textField == _date) {
        [_date resignFirstResponder];
        
        STPickerDate *pickerDate = [[STPickerDate alloc]init];
        [pickerDate setDelegate:self];
        [pickerDate show];
    }if(textField == _Power) {
        [_Power resignFirstResponder];
        self.which = 2;
        NSMutableArray *arrayData = [[NSMutableArray alloc]initWithObjects:@"1 KVA",@"2 KVA",@"3 KVA",@"4 KVA",@"6 KVA",@"8 KVA",@"10 KVA",@"45 KVA",@"50 KVA", nil];
        STPickerSingle *pickerSingle = [[STPickerSingle alloc]init];
        [pickerSingle setArrayData:arrayData];
        [pickerSingle setTitle:@"请选择功率"];
        [pickerSingle setContentMode:STPickerContentModeCenter];
        [pickerSingle setDelegate:self];
        [pickerSingle show];
    }

}

- (void)pickerSingle:(STPickerSingle *)pickerSingle selectedTitle:(NSString *)selectedTitle
{
    NSString *text = [NSString stringWithFormat:@"%@", selectedTitle];
    if (self.which == 1) {
        _choosekind.text = text;
    }else
    
    _Power.text = text;
}
- (void)pickerDate:(STPickerDate *)pickerDate year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    NSString *text = [NSString stringWithFormat:@"%ld年%ld月%ld日", year, month, day];
    _date.text = text;
}

/**
 *  下一步按钮
 */
- (void)nextstepbtn {
    
    UIButton *nextbtn = [[UIButton alloc]init];
    if (self.interkind == 0) {
        nextbtn.frame = CGRectMake(KScreenWidth / 3, 370, KScreenWidth / 3, 40);
    }else{
        nextbtn.frame = CGRectMake(KScreenWidth / 3, 470, KScreenWidth / 3, 40);
    }
    [nextbtn setTitle:@"下 一 步" forState:UIControlStateNormal];
    nextbtn.layer.cornerRadius = 10;
    nextbtn.backgroundColor = [UIColor cyanColor];
    [_tableview addSubview:nextbtn];
    [nextbtn addTarget:self action:@selector(clickToSteptwo) forControlEvents:UIControlEventTouchDown];
}

- (void)clickToSteptwo {
    
    Stepthird *third = [[Stepthird alloc]init];
    [self.navigationController pushViewController:third animated:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
    self.navigationItem.title = @"上一步";
}

/**
 *  键盘响应时间
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_HostBrand resignFirstResponder];
    [_BatteryPack resignFirstResponder];
    return YES;
}


@end
