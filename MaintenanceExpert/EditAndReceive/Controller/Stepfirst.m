//
//  Stepfirst.m
//  MaintenanceExpert
//
//  Created by koka on 16/11/3.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "Stepfirst.h"
#import "STPickerArea.h"
#import "ZSDetailOrderModel.h"
#import "Stepsecond.h"

@interface Stepfirst()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,STPickerAreaDelegate>
{
    UITableView *_tableview;
    NSMutableArray *_detailArray;
}
@property (strong,nonatomic)UITextField *textArea;
@property (strong,nonatomic)UITextField *textdetailArea;
@property (strong,nonatomic)UITextField *textcontact;
@property (strong,nonatomic)UITextField *textcontactTel;

@end

@implementation Stepfirst

- (void)viewWillAppear:(BOOL)animated {
    
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.title = [NSString stringWithFormat:@"%@(1/3)",self.title];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self settitle];
    
   
    self.view.backgroundColor = [UIColor greenColor];
    self.textArea = [[UITextField alloc]init];
    self.textdetailArea = [[UITextField alloc]init];
    self.textdetailArea.delegate = self;
    self.textcontact = [[UITextField alloc]init];
    self.textcontact.delegate = self;
    self.textcontactTel = [[UITextField alloc]init];
    self.textcontactTel.delegate = self;
    
    
    _tableview = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableview.bounces = NO;
    _tableview.delegate = self;
    _tableview.dataSource = self;
    UIImageView *image = [[UIImageView alloc]initWithFrame:self.view.frame];
    image.image = [UIImage imageNamed:@"121"];
    [_tableview setBackgroundView:image];
    
    [self.view addSubview:_tableview];
    
    [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self nextstepbtn];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBG:)];
    [self.view addGestureRecognizer:tapGesture];
}

- (void)tapBG:(UITapGestureRecognizer *)gesture {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    
}
/**
 *  导航标题
 */
- (void)settitle {
    
    self.integerone = [ZSDetailOrderModel shareDetailOrder].FirstIndex;//1000....1003
    self.integertwo = [ZSDetailOrderModel shareDetailOrder].SecondIndex;//2 3 4 5 6....
    
    NSMutableArray *array0 = [[NSMutableArray alloc]initWithObjects:@"闭门监控系统",@"防盗报警系统",@"门禁管理系统",@"停车场管理系统",@"电子巡更系统", nil];
    NSMutableArray *array1 = [[NSMutableArray alloc]initWithObjects:@"UPS主机电池安装",@"UPS更换电池",@"UPS系统维护", nil];
    NSMutableArray *array2 = [[NSMutableArray alloc]initWithObjects:@"音视频系统",@"多媒体投影系统",@"会议系统",@"舞台幕布系统",@"智能灯光系统", nil];
    NSMutableArray *array3 = [[NSMutableArray alloc]initWithObjects:@"立柱屏安装维护",@"室外挂墙屏安装维护",@"室内挂墙屏安装维护", nil];
    
    _detailArray = [[NSMutableArray alloc]initWithObjects:array0,array1,array2,array3, nil];
    self.title = [NSString stringWithFormat:@"%@",_detailArray[self.integerone - 1000][self.integertwo - 2]];
    [ZSDetailOrderModel shareDetailOrder].NavTitle = self.title;
}

/**
 *  下一步按钮
 */
- (void)nextstepbtn {
    
    UIButton *nextbtn = [[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth / 3, 260, KScreenWidth / 3, 40)];
    [nextbtn setTitle:@"下 一 步" forState:UIControlStateNormal];
    nextbtn.layer.cornerRadius = 10;
    nextbtn.backgroundColor = [UIColor cyanColor];
    [_tableview addSubview:nextbtn];
    [nextbtn addTarget:self action:@selector(clickToSteptwo) forControlEvents:UIControlEventTouchDown];
}

- (void)clickToSteptwo {
    
    Stepsecond *ss = [[Stepsecond alloc]init];
    [self.navigationController pushViewController:ss animated:YES];
    
}


/**
 *
 *  @param tableView tabledelegate
 *
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    
    if (indexPath.row == 0) {
        
        cell.textLabel.text = @"* 请选择区域:";
        self.textArea.frame = CGRectMake(KScreenWidth / 3, 10, KScreenWidth/2, 30);
        self.textArea.placeholder = @"请选择地址:";
        self.textArea.textAlignment = NSTextAlignmentRight;
        self.textArea.delegate = self;
        [cell addSubview:self.textArea];
        
    }else if (indexPath.row == 1){
        
        cell.textLabel.text = @"* 详细地址:";
        self.textdetailArea.frame = CGRectMake(KScreenWidth / 3, 10, KScreenWidth/2, 30);
        self.textdetailArea.placeholder = @"请输入详细地址:";
        self.textdetailArea.textAlignment = NSTextAlignmentRight;
        self.textdetailArea.returnKeyType = UIReturnKeyDone;
        [cell addSubview:self.textdetailArea];
        
    }else if (indexPath.row == 2){
        
        cell.textLabel.text = @"* 联系人:";
        self.textcontact.frame = CGRectMake(KScreenWidth / 3, 10, KScreenWidth/2, 30);
        self.textcontact.placeholder = @"请输入联系人:";
        self.textcontact.textAlignment = NSTextAlignmentRight;
        self.textcontact.returnKeyType = UIReturnKeyDone;
        [cell addSubview:self.textcontact];
        
    }else if (indexPath.row == 3){
        
        cell.textLabel.text = @"* 联系电话:";
        self.textcontactTel.frame = CGRectMake(KScreenWidth / 3, 10, KScreenWidth/2, 30);
        self.textcontactTel.placeholder = @"请输入联系人电话:";
        self.textcontactTel.textAlignment = NSTextAlignmentRight;
        self.textcontactTel.returnKeyType = UIReturnKeyDone;
        self.textcontactTel.keyboardType = UIKeyboardTypeNumberPad;
        
        [cell addSubview:self.textcontactTel];
        
    }else {
        
        cell.textLabel.text = @"* 请选择服务类别:";
        NSArray *array = [[NSArray alloc]initWithObjects:@"维修",@"安装", nil];
        UISegmentedControl *segmentcontrol = [[UISegmentedControl alloc]initWithItems:array];
        segmentcontrol.frame = CGRectMake((KScreenWidth *5 / 6) - 100 , 10, 100, 30);
        segmentcontrol.selectedSegmentIndex = 2;
        segmentcontrol.tintColor = [UIColor blueColor];

//        // 在指定索引插入一个选项并设置图片
//        [segmentcontrol insertSegmentWithImage:[UIImage imageNamed:@"mei.png"] atIndex:0 animated:NO];
//        // 在指定索引插入一个选项并设置题目
//        [segmentcontrol insertSegmentWithTitle:@"insert" atIndex:1 animated:NO];
        // 设置在点击后是否恢复原样
        segmentcontrol.momentary = NO;
        [segmentcontrol setTitle:@"维修" forSegmentAtIndex:0];//设置指定索引的题目
        [segmentcontrol setTitle:@"安装" forSegmentAtIndex:1];
        // 设置指定索引选项的宽度
        [segmentcontrol setWidth:50.0 forSegmentAtIndex:0];
        [segmentcontrol addTarget:self action:@selector(didClicksegmentedControlAction:) forControlEvents:UIControlEventValueChanged];
        [cell addSubview:segmentcontrol];
        
    }
    return cell;
}


- (void)didClicksegmentedControlAction:(UISegmentedControl *)Seg {
    
    [ZSDetailOrderModel shareDetailOrder].KindIndex = Seg.selectedSegmentIndex;
    
}

#pragma mark - --- delegate 视图委托 ---

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if (textField == self.textArea) {
        [self.textArea resignFirstResponder];
        STPickerArea *pickerArea = [[STPickerArea alloc]init];
        [pickerArea setDelegate:self];
        [pickerArea setContentMode:STPickerContentModeCenter];
        [pickerArea show];
    }
}

/**
 *  地址选择器
 *

 */
- (void)pickerArea:(STPickerArea *)pickerArea province:(NSString *)province city:(NSString *)city area:(NSString *)area
{
    NSString *text = [NSString stringWithFormat:@"%@ %@ %@", province, city, area];
    self.textArea.text = text;
}
/**
 *  键盘响应
 *
 */

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textArea resignFirstResponder];
    [self.textdetailArea resignFirstResponder];
    [self.textcontact resignFirstResponder];
    [self.textcontactTel resignFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
    self.navigationItem.title = @"上一步";
}




@end
