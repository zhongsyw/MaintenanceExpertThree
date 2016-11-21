//
//  ZSRegisterCustomerVC.m
//  MaintenanceExpert
//
//  Created by xpc on 16/10/20.
//  Copyright © 2016年 ZSYW. All rights reserved.
//
//  客户注册界面

#import "ZSRegisterCustomerVC.h"
#import "ZHBtnSelectView.h"
#import "ZHCustomBtn.h"
#import "STPickerDate.h"
#import "STPickerArea.h"
#import "UIViewController+SelectPhotoIcon.h"


@interface ZSRegisterCustomerVC () <UITextFieldDelegate,ZHBtnSelectViewDelegate,STPickerAreaDelegate,STPickerDateDelegate>
{
    UIScrollView *_scrollview;
    UILabel *_titlelabel;
    NSMutableArray *_titlearray;
    
    UITextField *_nametextfield;
    UITextField *_phonetextfield;
    UITextField *_emailtextfield;
    UITextField *_companytextfield;
    UITextField *_workchangjiatextfield;
    
    UITextField *_textArea;
    UITextField *_date;
    
    UIImageView *_identitycard;
    UIImage *_identitycardimage;
}

@property (nonatomic,weak)ZHCustomBtn *currentGenderBtn;
@property (nonatomic,weak)ZHBtnSelectView *btnGenderView;

@property (nonatomic,weak)ZHCustomBtn *currentcompletealoneBtn;
@property (nonatomic,weak)ZHBtnSelectView *btncompletealoneView;

@property (nonatomic,weak)ZHCustomBtn *currentworkmodeBtn;
@property (nonatomic,weak)ZHBtnSelectView *btnworkmodeView;

@property (nonatomic,weak)ZHCustomBtn *currentservicemodeBtn;
@property (nonatomic,weak)ZHBtnSelectView *btnservicemodeView;

@property (nonatomic,weak)ZHCustomBtn *currentskillBtn;
@property (nonatomic,weak)ZHBtnSelectView *btnskillmodeView;

@property (nonatomic,strong)NSMutableArray *titleArr;
@property (nonatomic,strong)NSArray *kindArr;
@end

@implementation ZSRegisterCustomerVC

- (void)viewWillAppear:(BOOL)animated {
    [self createidentitycard];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"工程师";
    self.view.backgroundColor = [UIColor cyanColor];
    
    
    /**
     scrollview初始化
     */
    _scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 5, KScreenWidth, KScreenHeight - 64 )];
    _scrollview.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:_scrollview];
    _scrollview.showsVerticalScrollIndicator = YES;
    _scrollview.showsHorizontalScrollIndicator = YES;
    _scrollview.contentSize = CGSizeMake(0, 940);
    
    _titlearray = [[NSMutableArray alloc]initWithObjects:@"姓名:",@"性别:",@"出生日期:",@"现居住地:",@"手机:",@"电子邮件:",@"能否独立完成维保服务:",@"工作模式:",@"服务模式:\n(用户需求)",@"你的专业:",@"目前工作单位:",@"是否是厂家工程师:",@"相关技能证书:",@"手持身份证照片:", nil];
    self.titleArr = @[].mutableCopy;
    
    [self createtitlelabel];
    [self createsubview];
    
    
}


/**
 *  项目，label
 */
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

- (void)createsubview {
    
    [self createnameTF];
    [self createGender];
    [self createdate];
    [self createarea];
    [self createphone];
    [self createmail];
    [self createcompletealone];
    [self createworkmode];
    [self createservicemode];
    [self createprofession];
    
    [self createcompany];
    [self createifengineer];
    
    //[self createidentitycard];
}

/**
 *  各个控件
 */
//姓名
- (void)createnameTF {
    _nametextfield = [[UITextField alloc]initWithFrame:CGRectMake(KScreenWidth / 2 , 6, KScreenWidth / 2 - 15, 30)];
    _nametextfield.placeholder = @"请输入姓名";
    _nametextfield.backgroundColor = [UIColor cyanColor];
    _nametextfield.returnKeyType = UIReturnKeyDone;
    _nametextfield.delegate = self;
    [_scrollview addSubview:_nametextfield];
    _nametextfield.textAlignment = NSTextAlignmentRight;
}
//性别
- (void)createGender {
    
    self.kindArr = [[NSArray alloc]initWithObjects:@"男",@"女", nil];
    // 自动计算view的高度
    ZHBtnSelectView *btnView = [[ZHBtnSelectView alloc] initWithFrame:CGRectMake(KScreenWidth / 2  , 48, KScreenWidth / 2 , 0)
                                                               titles:self.kindArr column:2];
    [_scrollview addSubview:btnView];
    btnView.verticalMargin = 10;
    btnView.delegate = self;
    btnView.tag  = 1;
    self.btnGenderView.tag = btnView.tag;
    self.btnGenderView = btnView;
}
//出生日期
- (void)createdate {
    
    _date = [[UITextField alloc]initWithFrame:CGRectMake(KScreenWidth / 2  , 88 + 4, KScreenWidth / 2 - 15 , 30)];
    _date.delegate  = self;
    _date.textAlignment = NSTextAlignmentRight;
    _date.placeholder = @"请选择时间";
    [_scrollview addSubview:_date];
    
}
//现居住地
- (void)createarea {
    _textArea = [[UITextField alloc]initWithFrame:CGRectMake(KScreenWidth / 2  , 132 + 4, KScreenWidth / 2 - 15 , 30)];
    _textArea.placeholder = @"请选择地址";
    _textArea.textAlignment = NSTextAlignmentRight;
    _textArea.delegate = self;
    [_scrollview addSubview:_textArea];
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(textField == _date) {
        [_date resignFirstResponder];
        
        STPickerDate *pickerDate = [[STPickerDate alloc]init];
        [pickerDate setDelegate:self];
        [pickerDate show];
    }else  if (textField == _textArea) {
        [_textArea resignFirstResponder];
        STPickerArea *pickerArea = [[STPickerArea alloc]init];
        [pickerArea setDelegate:self];
        [pickerArea setContentMode:STPickerContentModeBottom];
        [pickerArea show];
    }    
}

- (void)pickerDate:(STPickerDate *)pickerDate year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    NSString *text = [NSString stringWithFormat:@"%ld年%ld月%ld日", year, month, day];
    _date.text = text;
}
- (void)pickerArea:(STPickerArea *)pickerArea province:(NSString *)province city:(NSString *)city area:(NSString *)area
{
    NSString *text = [NSString stringWithFormat:@"%@ %@ %@", province, city, area];
    _textArea.text = text;
}
//手机
- (void)createphone {
    _phonetextfield = [[UITextField alloc]initWithFrame:CGRectMake(KScreenWidth / 2 , 6 + 176, KScreenWidth / 2 - 15, 30)];
    _phonetextfield.placeholder = @"请输入手机号";
    _phonetextfield.backgroundColor = [UIColor cyanColor];
    _phonetextfield.returnKeyType = UIReturnKeyDone;
    _phonetextfield.delegate = self;
    [_scrollview addSubview:_phonetextfield];
    _phonetextfield.textAlignment = NSTextAlignmentRight;
}

//电子邮件
- (void)createmail {
    _emailtextfield = [[UITextField alloc]initWithFrame:CGRectMake(KScreenWidth / 2 , 6 + 220, KScreenWidth / 2 - 15, 30)];
    _emailtextfield.placeholder = @"请输入邮箱";
    _emailtextfield.backgroundColor = [UIColor cyanColor];
    _emailtextfield.returnKeyType = UIReturnKeyDone;
    _emailtextfield.delegate = self;
    [_scrollview addSubview:_emailtextfield];
    _emailtextfield.textAlignment = NSTextAlignmentRight;

}

//能否独立完成你专业的维保服务
- (void)createcompletealone {
    self.kindArr = [[NSArray alloc]initWithObjects:@"是",@"否", nil];
    // 自动计算view的高度
    ZHBtnSelectView *btnView = [[ZHBtnSelectView alloc] initWithFrame:CGRectMake(KScreenWidth / 2 , 268, KScreenWidth / 2, 0)
                                                               titles:self.kindArr column:2];
    [_scrollview addSubview:btnView];
    btnView.verticalMargin = 10;
    btnView.delegate = self;
    btnView.tag  = 2;
    self.btncompletealoneView.tag = btnView.tag;
    self.btncompletealoneView = btnView;
    
}
//工作模式
- (void)createworkmode {
    
    self.kindArr = [[NSArray alloc]initWithObjects:@"兼职",@"全职", nil];
    // 自动计算view的高度
    ZHBtnSelectView *btnView = [[ZHBtnSelectView alloc] initWithFrame:CGRectMake(KScreenWidth / 2 , 4 + 308, KScreenWidth / 2, 0)
                                                               titles:self.kindArr column:2];
    [_scrollview addSubview:btnView];
    btnView.verticalMargin = 10;
    btnView.delegate = self;
    btnView.tag  = 3;
    self.btnworkmodeView.tag = btnView.tag;
    self.btnworkmodeView = btnView;

}

#warning 按钮文字的frame需要调整
//服务模式（用户需求）
- (void)createservicemode {
    self.kindArr = [[NSArray alloc]initWithObjects:@"现场值守",@"定期巡检",@"即时上门", nil];
    // 自动计算view的高度
    ZHBtnSelectView *btnView = [[ZHBtnSelectView alloc] initWithFrame:CGRectMake(KScreenWidth  / 2 - 40, 4 + 352, KScreenWidth / 2, 0)
                                                               titles:self.kindArr column:2];
    [_scrollview addSubview:btnView];
    btnView.verticalMargin = 10;
    btnView.delegate = self;
    self.btnservicemodeView = btnView;
    btnView.tag  = 4;
    self.btnservicemodeView.tag = btnView.tag;
    
}
//你的专业
- (void)createprofession {
    self.kindArr = [[NSArray alloc]initWithObjects:@"UPS",@"机房配电",@"电力工程师",@"发电机",@"机房空调",@"门禁",@"视频监控",@"动力环境监控",@"机房网络",@"消防", nil];
    // 自动计算view的高度
    ZHBtnSelectView *btnView = [[ZHBtnSelectView alloc] initWithFrame:CGRectMake(KScreenWidth  / 2  - 40, 8 + 418, KScreenWidth / 2, 0)
                                                               titles:self.kindArr column:2];
    [_scrollview addSubview:btnView];
    btnView.verticalMargin = 10;
    btnView.delegate = self;
    self.btnskillmodeView = btnView;
    btnView.tag  = 5;
    self.btnskillmodeView.tag = btnView.tag;

}
//当前从事的工作单位名称
- (void)createcompany {
    _companytextfield = [[UITextField alloc]initWithFrame:CGRectMake(KScreenWidth / 2 , 6 + 583, KScreenWidth / 2 - 15, 30)];
    _companytextfield.placeholder = @"请输入单位名称";
    _companytextfield.backgroundColor = [UIColor cyanColor];
    _companytextfield.returnKeyType = UIReturnKeyDone;
    _companytextfield.delegate = self;
    [_scrollview addSubview:_companytextfield];
    _companytextfield.textAlignment = NSTextAlignmentRight;
}
//是否是厂家工程师
- (void)createifengineer {
    _workchangjiatextfield = [[UITextField alloc]initWithFrame:CGRectMake(KScreenWidth / 2 , 6 + 627, KScreenWidth / 2 - 15, 30)];
    _workchangjiatextfield.placeholder = @"是的话请填写厂家";
    _workchangjiatextfield.backgroundColor = [UIColor cyanColor];
    _workchangjiatextfield.returnKeyType = UIReturnKeyDone;
    _workchangjiatextfield.delegate = self;
    [_scrollview addSubview:_workchangjiatextfield];
    _workchangjiatextfield.textAlignment = NSTextAlignmentRight;
}
//相关技能证书
- (void)createskillcertificate {
    
}
//手持身份证照片
- (void)createidentitycard {
    _identitycard = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth - 15 - 80, 751 + 5, 70, 70)];

    _identitycard.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"add.jpg"]];
    _identitycard.image = _identitycardimage;
    [_scrollview addSubview:_identitycard];
    
    UITapGestureRecognizer *gest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addIDcard)];
    _identitycard.userInteractionEnabled = YES;
    [_identitycard addGestureRecognizer:gest];
}

- (void)addIDcard {
    
    [self showActionSheet];
    
}


//TODO:身份证照片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info;{
    
    //获得编辑后的图片
    UIImage *editedImage = (UIImage *)info[UIImagePickerControllerEditedImage];
    _identitycardimage= editedImage;    
    
    [picker dismissViewControllerAnimated:NO completion:nil];
}

// view的代理方法
- (void)btnSelectView:(ZHBtnSelectView *)btnSelectView selectedBtn:(ZHCustomBtn *)btn {
    btnSelectView.selectType = BtnSelectTypeMultiChoose;
    
    if ((btnSelectView.tag == 1)) {
        self.btnGenderView.selectType = BtnSelectTypeSingleChoose;
        self.currentGenderBtn.btnSelected = NO;
        self.currentGenderBtn = btn;
        btn.btnSelected = YES;
    }if ((btnSelectView.tag == 2)) {
        self.btncompletealoneView.selectType = BtnSelectTypeSingleChoose;
        self.currentcompletealoneBtn.btnSelected = NO;
        self.currentcompletealoneBtn = btn;
        btn.btnSelected = YES;
    }if ((btnSelectView.tag == 3)) {
        self.btnworkmodeView.selectType = BtnSelectTypeSingleChoose;
        self.currentworkmodeBtn.btnSelected = NO;
        self.currentworkmodeBtn = btn;
        btn.btnSelected = YES;
    }if ((btnSelectView.tag == 4)) {
        self.btnservicemodeView.selectType = BtnSelectTypeMultiChoose;
        btn.btnSelected = !btn.btnSelected;
        if (btn.btnSelected) {
            [self.titleArr addObject:btn.titleLabel.text];
        } else {
            [self.titleArr removeObject:btn.titleLabel.text];
        }
    }if ((btnSelectView.tag == 5)) {
        self.btnskillmodeView.selectType = BtnSelectTypeMultiChoose;
        btn.btnSelected = !btn.btnSelected;
        if (btn.btnSelected) {
            [self.titleArr addObject:btn.titleLabel.text];
        } else {
            [self.titleArr removeObject:btn.titleLabel.text];
        }
    }
    
}
/**
 *  键盘响应
 *
 */
/**
 *  键盘响应
 *
 */
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_nametextfield resignFirstResponder];
    [_phonetextfield resignFirstResponder];
    [_emailtextfield resignFirstResponder];
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
