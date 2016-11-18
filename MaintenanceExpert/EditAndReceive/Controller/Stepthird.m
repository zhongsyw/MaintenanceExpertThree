//
//  Stepthird.m
//  MaintenanceExpert
//
//  Created by koka on 16/11/3.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "Stepthird.h"
#import "ZSDetailOrderModel.h"
#import "StepthirdCell.h"
#import "ZHBtnSelectView.h"
#import "ZHCustomBtn.h"

@interface Stepthird ()<UITextViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,ZHBtnSelectViewDelegate>

{
    UITextView *_Textview;
    UICollectionView *_Collectionview;
    NSMutableArray *_PhotoArray;
}
@property (nonatomic,weak)ZHCustomBtn *currentServiceBtn;
@property (nonatomic,weak)ZHBtnSelectView *btnServiceView;

@property (nonatomic,weak)ZHCustomBtn *currentOrderModelBtn;
@property (nonatomic,weak)ZHBtnSelectView *btnOrderModelView;

@property (nonatomic,strong)NSArray *kindArr;
@end


@implementation Stepthird

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.title = [NSString stringWithFormat:@"%@(3/3)",[ZSDetailOrderModel shareDetailOrder].NavTitle];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.which = [ZSDetailOrderModel shareDetailOrder].KindIndex;
    [self createUI];
}


- (void)initeverying {
    
    _Textview = [[UITextView alloc]init];
    if (self.which == 0) {
        _Textview.frame = CGRectMake(20, 20, KScreenWidth - 40, KScreenHeight / 3);
    }else{
        _Textview.frame = CGRectMake(20, 151, KScreenWidth - 40, KScreenHeight / 3 - 20);
    }
    _Textview.textColor = [UIColor blackColor];
    _Textview.font = [UIFont fontWithName:@"Arial" size:16];
    _Textview.delegate = self;
    _Textview.backgroundColor = [UIColor grayColor];
    _Textview.scrollEnabled = YES;
    _Textview.autoresizingMask= UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_Textview];
    _Textview.returnKeyType = UIReturnKeyDone;
    
    _PhotoArray = [NSMutableArray array];
    
    
}

- (void)createUI {
    
    [self initeverying];
    
    if (self.which == 0) {
        //维修
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 20)];
        label.text = @"     问题描述:";
        label.textColor = [UIColor brownColor];
        label.backgroundColor = [UIColor cyanColor];
        [self.view addSubview:label];
        label.font = [UIFont systemFontOfSize:15];
        
        UILabel *photolabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _Textview.frame.size.height * 2 / 3 + label.frame.size.height, KScreenWidth, 20)];
        photolabel.text = @"     添加照片:";
        photolabel.textColor = [UIColor brownColor];
        photolabel.backgroundColor = [UIColor cyanColor];
        photolabel.font = [UIFont systemFontOfSize:15];
        [self.view addSubview:photolabel];
        
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(70, 70);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.estimatedItemSize = CGSizeMake(KScreenWidth, 0);
        _Collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(20, photolabel.frame.origin.y + 20, KScreenWidth - 40, 90)collectionViewLayout:layout];
        _Collectionview.backgroundColor = [UIColor clearColor];
        _Collectionview.delegate = self;
        _Collectionview.dataSource =self;
        [_Collectionview registerClass:[StepthirdCell class] forCellWithReuseIdentifier:@"cell"];
        [self.view addSubview:_Collectionview];

    }else {
        //安装
        UILabel *Service = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, KScreenWidth / 3, 25)];
        Service.textAlignment = NSTextAlignmentLeft;
        Service.text = @"服务名义:";
        Service.font = [UIFont systemFontOfSize:15];
        [self.view addSubview:Service];
        UILabel *Serviceadd = [[UILabel alloc]initWithFrame:CGRectMake(20, 38, KScreenWidth - 40, 40)];
        Serviceadd.text = @"(温馨提示：填写公司名称后，我们的工程师将以该公司的名义的上门服务)";
        Serviceadd.numberOfLines = 2;
        Serviceadd.textAlignment = NSTextAlignmentLeft;
        Serviceadd.textColor = [UIColor greenColor];
        Serviceadd.font = [UIFont systemFontOfSize:11];
        [self.view addSubview:Serviceadd];
        
        UILabel *OrderModel = [[UILabel alloc]initWithFrame:CGRectMake(20, 77, KScreenWidth / 3, 25)];
        OrderModel.textAlignment = NSTextAlignmentLeft;
        OrderModel.text = @"工单报告模板:";
        OrderModel.font = [UIFont systemFontOfSize:15];
        [self.view addSubview:OrderModel];
        UILabel *Orderadd = [[UILabel alloc]initWithFrame:CGRectMake(20, 98, KScreenWidth - 40, 40)];
        Orderadd.text = @"(温馨提示：上传公司专用工单模板后，我们的工程师上门将打印该公司的模板进行服务)";
        Orderadd.numberOfLines = 2;
        Orderadd.textAlignment = NSTextAlignmentLeft;
        Orderadd.textColor = [UIColor greenColor];
        Orderadd.font = [UIFont systemFontOfSize:11];
        [self.view addSubview:Orderadd];
        
        self.kindArr = [[NSArray alloc]initWithObjects:@"以中数运维名义",@"其他", nil];
        // 自动计算view的高度
        ZHBtnSelectView *btnView = [[ZHBtnSelectView alloc] initWithFrame:CGRectMake(KScreenWidth  / 2 , 0, KScreenWidth / 2, 0)
                                                                   titles:self.kindArr column:1];
        [self.view addSubview:btnView];
        btnView.verticalMargin = 5;
        btnView.delegate = self;
        self.btnServiceView = btnView;
        btnView.tag  = 1;
        self.btnServiceView.tag = btnView.tag;
        
        NSArray *array = [[NSArray alloc]initWithObjects:@"中数运维旗下模板",@"其他", nil];
        // 自动计算view的高度
        ZHBtnSelectView *btnView1 = [[ZHBtnSelectView alloc] initWithFrame:CGRectMake(KScreenWidth  / 2 , 60, KScreenWidth  / 2, 0)
                                                                   titles:array column:1];
        [self.view addSubview:btnView1];
        btnView1.verticalMargin = 5;
        btnView1.delegate = self;
        self.btnOrderModelView = btnView1;
        btnView1.tag  = 2;
        self.btnOrderModelView.tag = btnView1.tag;

        UILabel *problem = [[UILabel alloc]initWithFrame:CGRectMake(0, 131, KScreenWidth, 20)];
        problem.text = @"     安装说明:";
        problem.textColor = [UIColor brownColor];
        problem.backgroundColor = [UIColor cyanColor];
        problem.font = [UIFont systemFontOfSize:15];
        [self.view addSubview:problem];

        
        
    }
   
    /**
     *  价格目录
     *
     */
    
    UILabel *pricelabel = [[UILabel alloc]init];
    if (self.which == 0) {
        pricelabel.frame = CGRectMake(0, _Collectionview.frame.origin.y + _Collectionview.frame.size.height, KScreenWidth, 20);
    }else {
        pricelabel.frame = CGRectMake(0, _Textview.frame.origin.y + _Textview.frame.size.height * 2 / 3 , KScreenWidth, 20);
    }
    pricelabel.text = @"     价格估算:";
    pricelabel.textColor = [UIColor brownColor];
    pricelabel.backgroundColor = [UIColor cyanColor];
    pricelabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:pricelabel];
    
    UILabel *basicprice = [[UILabel alloc]initWithFrame:CGRectMake(20, pricelabel.frame.origin.y + 20 + 15, KScreenWidth / 3, 20)];
    basicprice.text = @"基本维修费:";
    basicprice.textAlignment = NSTextAlignmentRight;
    basicprice.textColor = [UIColor blackColor];
    basicprice.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:basicprice];
    UILabel *basicprice1 = [[UILabel alloc]initWithFrame:CGRectMake(40 + KScreenWidth / 3, pricelabel.frame.origin.y + 20 + 15, KScreenWidth / 3, 20)];
    self.basicprice = 600;
    basicprice1.text = [NSString stringWithFormat:@"￥ 600"];
    basicprice1.textAlignment = NSTextAlignmentLeft;
    basicprice1.textColor = [UIColor greenColor];
    basicprice1.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:basicprice1];

    
    UILabel *gzdprice = [[UILabel alloc]initWithFrame:CGRectMake(20, basicprice.frame.origin.y + 35, KScreenWidth / 3, 20)];
    gzdprice.text = @"故障点费:";
    gzdprice.textAlignment = NSTextAlignmentRight;
    gzdprice.textColor = [UIColor blackColor];
    gzdprice.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:gzdprice];
    UILabel *gzdprice1 = [[UILabel alloc]initWithFrame:CGRectMake(40 + KScreenWidth / 3, basicprice.frame.origin.y + 35, KScreenWidth / 3, 20)];
    self.gzdprice = [ZSDetailOrderModel shareDetailOrder].ProblemNum * 100;
    gzdprice1.text = [NSString stringWithFormat:@"￥ %ld",(long)self.gzdprice];
    gzdprice1.textAlignment = NSTextAlignmentLeft;
    gzdprice1.textColor = [UIColor greenColor];
    gzdprice1.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:gzdprice1];
    
    UILabel *highworkprice = [[UILabel alloc]initWithFrame:CGRectMake(20, gzdprice.frame.origin.y + 35, KScreenWidth / 3, 20)];
    highworkprice.text = @"高空作业费:";
    highworkprice.textAlignment = NSTextAlignmentRight;
    highworkprice.textColor = [UIColor blackColor];
    highworkprice.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:highworkprice];
    UILabel *highworkprice1 = [[UILabel alloc]initWithFrame:CGRectMake(40 + KScreenWidth / 3, gzdprice.frame.origin.y + 35, KScreenWidth / 3, 20)];
    self.highworkprice = [ZSDetailOrderModel shareDetailOrder].HighWork * 50;
    highworkprice1.text = [NSString stringWithFormat:@"￥ %ld",(long)self.highworkprice];
    highworkprice1.textAlignment = NSTextAlignmentLeft;
    highworkprice1.textColor = [UIColor greenColor];
    highworkprice1.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:highworkprice1];
    
    UILabel *countiesprice = [[UILabel alloc]initWithFrame:CGRectMake(20, highworkprice.frame.origin.y + 35, KScreenWidth / 3, 20)];
    countiesprice.text = @"郊县费:";
    countiesprice.textAlignment = NSTextAlignmentRight;
    countiesprice.textColor = [UIColor blackColor];
    countiesprice.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:countiesprice];
    UILabel *countiesprice1 = [[UILabel alloc]initWithFrame:CGRectMake(40 + KScreenWidth / 3, highworkprice.frame.origin.y + 35, KScreenWidth / 3, 20)];
    self.countriesprice = [ZSDetailOrderModel shareDetailOrder].Counties * 200;
    countiesprice1.text = [NSString stringWithFormat:@"￥ %ld",(long)self.countriesprice];
    countiesprice1.textAlignment = NSTextAlignmentLeft;
    countiesprice1.textColor = [UIColor greenColor];
    countiesprice1.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:countiesprice1];
    
    UILabel *Allprice = [[UILabel alloc]initWithFrame:CGRectMake(20, countiesprice.frame.origin.y + 35, KScreenWidth / 3, 20)];
    Allprice.text = @"总费用:";
    Allprice.textAlignment = NSTextAlignmentRight;
    Allprice.textColor = [UIColor blueColor];
    Allprice.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:Allprice];
    UILabel *Allprice1 = [[UILabel alloc]initWithFrame:CGRectMake(40 + KScreenWidth / 3, countiesprice.frame.origin.y + 35, KScreenWidth / 3, 20)];
    self.Allprice = self.basicprice + self.gzdprice + self.highworkprice + self.countriesprice;
    Allprice1.text = [NSString stringWithFormat:@"￥ %ld",(long)self.Allprice];
    Allprice1.textAlignment = NSTextAlignmentLeft;
    Allprice1.textColor = [UIColor greenColor];
    Allprice1.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:Allprice1];
    
    /**
     *  确认提交
     *
     */
    UIButton *commitbtn = [[UIButton alloc]initWithFrame:CGRectMake(20, KScreenHeight - 50 - _Textview.frame.size.height / 3, KScreenWidth - 40, 40)];
    
    commitbtn.backgroundColor = [UIColor orangeColor];
    [commitbtn setTitle:@"确认提交" forState:UIControlStateNormal];
    [self.view addSubview:commitbtn];
    commitbtn.layer.cornerRadius = 8;
    [commitbtn addTarget:self action:@selector(commitclick) forControlEvents:UIControlEventTouchDown];
}

- (void)commitclick {
    NSLog(@"确认提交订单");
}


- (void)btnSelectView:(ZHBtnSelectView *)btnSelectView selectedBtn:(ZHCustomBtn *)btn {
    btnSelectView.selectType = BtnSelectTypeMultiChoose;
    if ((btnSelectView.tag == 1)) {
        self.btnServiceView.selectType = BtnSelectTypeSingleChoose;
        self.currentServiceBtn.btnSelected = NO;
        self.currentServiceBtn = btn;
        btn.btnSelected = YES;
    }if ((btnSelectView.tag == 2)) {
        self.btnOrderModelView.selectType = BtnSelectTypeSingleChoose;
        self.currentOrderModelBtn.btnSelected = NO;
        self.currentOrderModelBtn = btn;
        btn.btnSelected = YES;
    }
}
#pragma mark - --- delegate 视图委托 ---

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    _PhotoArray = [[NSMutableArray alloc]initWithObjects:@"1",@"2",@"1",@"2",@"12", nil];;
    return _PhotoArray.count;
    //return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
   
    StepthirdCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.item == _PhotoArray.count - 1) {
        cell.imgView.image = [UIImage imageNamed:@"add.jpg"];
        cell.imgView.frame = CGRectMake(0, 0, 70, 70);
        cell.imgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addphotos)];
        [cell.imgView addGestureRecognizer:tap];
        
    }else {
        cell.imgView.frame = CGRectMake(0, 0, 70, 70);
        cell.imgView.backgroundColor = [UIColor blueColor];
    }
   
    return cell;
    
}

- (void)addphotos {
    
    
}


#pragma mark collectionview------------

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return (CGSize){70 ,70};
}



//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 5, 10, 5);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.f;
}



//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
//{
//    return (CGSize){5,80};
//}
//
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
//{
//    return (CGSize){KScreenWidth,70};
//}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}


@end
