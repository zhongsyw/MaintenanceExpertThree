//
//  TwoViewController.m
//  XWPopMenuVCDemo
//
//  Created by xpc on 16/10/18.
//  Copyright © 2016年 ZSYW. All rights reserved.
//
/*
 这是快捷下单页面
 */
#import "TwoViewController.h"
#import "TZTestCell.h"
#import "TwoDetailsViewController.h"

#import "TZImagePickerController.h"
#import "UIView+Layout.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "LxGridViewFlowLayout.h"
#import "TZImageManager.h"
#import "TZVideoPlayerController.h"


#define HEADERIMG_HEIGHT 64
#define SHOW_IMAGE_COUNT 4
@interface TwoViewController ()<TZImagePickerControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIAlertViewDelegate, UIActionSheetDelegate, UITextViewDelegate,UITextFieldDelegate>

{
    UIImageView *headerImg; //  NavigationView
    UIView *upView;
    UIView *midUpView;
    UIView *midDownView;
    UIView *downView;       //
    UILabel *descriptLabel; //  描述
    UIView *slideBackView;  //  滑动按钮View
    UILabel *prace;         //  价格 Cell
    
    
    NSMutableArray *_selectedPhotos;
    NSMutableArray *_selectedAssets;
    BOOL _isSelectOriginalPhoto;
    
    CGFloat _itemWH;
    CGFloat _margin;
    
}

//字数的限制
@property (nonatomic, strong)UILabel *wordCountLabel;

@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@property (nonatomic, strong) UICollectionView *collectionView;

// 6个设置开关
// UISwitch *showTakePhotoBtnSwitch;  ///< 在内部显示拍照按钮
// UISwitch *sortAscendingSwitch;     ///< 照片排列按修改时间升序
// UISwitch *allowPickingVideoSwitch; ///< 允许选择视频
// UISwitch *allowPickingImageSwitch; ///< 允许选择图片
// UISwitch *allowPickingOriginalPhotoSwitch; ///< 允许选择原图
// UISwitch *showSheetSwitch; ///< 显示一个sheet,把拍照按钮放在外
// UITextField *maxCountTF; ///< 照片最大可选张数，设置为1即为单选
// UITextField *columnNumberTF;

@end

@implementation TwoViewController


- (void)viewWillAppear:(BOOL)animated {
    
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    
    self.navigationController.navigationBarHidden = YES;
}

//  懒加载
- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        // set appearance / 改变相册选择页的导航栏外观
        _imagePickerVc.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
        _imagePickerVc.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
        if (iOS9Later) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
#pragma clang diagnostic pop
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    }
    return _imagePickerVc;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:BACK_GROUND_COLOR];
    
    //  点击任意地方收起键盘 1/3
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(finishPublish)];
//    
//    self.navigationItem.leftBarButtonItem = back;
    
    self.title = @"拍照下单";
    
    _selectedPhotos = [NSMutableArray array];
    _selectedAssets = [NSMutableArray array];
    
    
    [self creatBakeWhiteColor];
    
    [self creatUpView];             //  自定义的NavigationView
    [self creatPosition];           //  添加地理位置
    [self configCollectionView];    //  添加图片、视频
    [self creatSlider];             //  添加滑动条
    [self creatPrice];              //  添加价格
    [self creatMaintain];           //  添加维修按钮
    [self creatInstall];            //  添加安装按钮
    [self creatButton];             //  添加确定下单按钮
    
    
    //  添加取消按钮->更改原生leftBarButtonItem
    [self addCancelBtn];
    
    /**
     http://blog.csdn.net/xuejunrong/article/details/50038999
     */
#pragma mark - 点击任意地方收起键盘 2/3   和选择照片 有冲突
    //    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBG:)];
    //    [self.view addGestureRecognizer:tapGesture];
    
}

//  隐藏状态栏
- (BOOL)prefersStatusBarHidden {
    return NO;
}


#pragma mark - 添加控件

//  上、中、下 三块白色的背景
- (void)creatBakeWhiteColor {
    
    //  标题、描述、地址
    upView = [[UIView alloc] init];
    upView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:upView];
    upView.sd_layout.leftSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .heightIs(KScreenHeight * 0.3);
    
    //  图片、视频
    midUpView = [[UIView alloc] init];
    midUpView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:midUpView];
    midUpView.sd_layout.leftSpaceToView(self.view, 0)
    .topSpaceToView(upView, 10)
    .rightSpaceToView(self.view, 0)
    .heightIs(KScreenHeight * 0.17);
    
    //  slider、价格、类型
    midDownView = [[UIView alloc] init];
    midDownView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:midDownView];
    midDownView.sd_layout.leftEqualToView(upView)
    .topSpaceToView(midUpView, 10)
    .rightEqualToView(upView)
    .heightIs(KScreenHeight * 0.27);
    
    //  确定发布按钮
    downView = [[UIView alloc] init];
    downView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:downView];
    downView.sd_layout.leftEqualToView(midDownView)
    .rightEqualToView(midDownView)
    .bottomSpaceToView(self.view, 0)
    .heightIs(KScreenHeight * 0.1);
    
}

//  Navigation、标题、描述
- (void)creatUpView {
    
//    //  Navigation 发 布
//    headerImg = [[UIImageView alloc] init];
//    headerImg.backgroundColor = [UIColor colorWithRed:253.0/255.0 green:217.0/255.0 blue:85.0/255.0 alpha:1];
//    [self.view addSubview:headerImg];
//    headerImg.sd_layout.leftSpaceToView(self.view, 0)
//    .topSpaceToView(self.view, 0)
//    .rightSpaceToView(self.view, 0)
//    .heightIs(HEADERIMG_HEIGHT);
//    
//    UILabel *titleLable = [[UILabel alloc] init];
//    //    titleLable.backgroundColor = [UIColor purpleColor];
//    titleLable.text = @"发 布";
//    [titleLable setFont:[UIFont systemFontOfSize:18]];
//    titleLable.textAlignment = NSTextAlignmentCenter;
//    [headerImg addSubview:titleLable];
//    titleLable.sd_layout.leftSpaceToView(headerImg, self.view.frame.size.width / 2 - 30)
//    .topSpaceToView(headerImg, 25)
//    .bottomSpaceToView(headerImg, 5)
//    .widthIs(60);
    
    
    //  标题
#warning 限制 输入字数！！！！！15个字数限制
    _titleTF = [[UITextField alloc] init];
    //    _titleTF.backgroundColor = [UIColor cyanColor];
    _titleTF.placeholder = @"*标题";
    _titleTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_titleTF setFont:[UIFont systemFontOfSize:15]];
    _titleTF.returnKeyType = UIReturnKeyDone;
    _titleTF.delegate = self;
    [upView addSubview:_titleTF];
    _titleTF.sd_layout.leftSpaceToView(upView, 20)
    .topSpaceToView(upView, 5)
    .rightSpaceToView(upView, 20)
    .heightIs(30);
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = BACK_GROUND_COLOR;
    [upView addSubview:lineView];
    lineView.sd_layout.leftEqualToView(_titleTF)
    .topSpaceToView(_titleTF, 5)
    .rightSpaceToView(upView, 0)
    .heightIs(1);
    
    //  描 述
#warning 限制 输入字数 ！！！！100个字数限制
    _descriptTV = [[UITextView alloc] init];
    //        _descriptTV.backgroundColor = [UIColor cyanColor];
    _descriptTV.returnKeyType = UIReturnKeyDone;
    _descriptTV.delegate = self;
    [_descriptTV setFont:[UIFont systemFontOfSize:15]];
    [upView addSubview:_descriptTV];
    _descriptTV.sd_layout.leftSpaceToView(upView, 16)
    .topSpaceToView(lineView, 5)
    .rightEqualToView(_titleTF)
    .heightIs(95);
    
    descriptLabel = [[UILabel alloc] init];
    descriptLabel.text = @" *请详细描述一下您的请求";
    descriptLabel.enabled = NO;
    descriptLabel.font = [UIFont systemFontOfSize:15];
    descriptLabel.textColor = [UIColor colorWithRed:241.0 / 255.0 green:241.0 / 255.0 blue:242.0 / 255.0 alpha:1];
    [_descriptTV addSubview:descriptLabel];
    descriptLabel.sd_layout.leftSpaceToView(_descriptTV, 0)
    .topSpaceToView(_descriptTV, 0)
    .rightSpaceToView(_descriptTV, 0)
    .heightIs(30);
    
    
    //  限制字数
    _wordCountLabel = [[UILabel alloc] init];
    //    _wordCountLabel.backgroundColor = [UIColor blueColor];
    _wordCountLabel.text = @"0/300";
    _wordCountLabel.font = [UIFont systemFontOfSize:14.f];
    _wordCountLabel.textColor = [UIColor lightGrayColor];
    self.wordCountLabel.textAlignment = NSTextAlignmentRight;
    [upView addSubview:_wordCountLabel];
    _wordCountLabel.sd_layout.topSpaceToView(_descriptTV, 0)
    .rightEqualToView(_descriptTV)
    .heightIs(15)
    .widthIs(80);
    
}

#warning 地理位置 这里 换成一个按钮????（ 添加图片（可不选））
//  添加 地理位置
- (void)creatPosition {
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = BACK_GROUND_COLOR;
    [upView addSubview:lineView];
    lineView.sd_layout.leftEqualToView(_titleTF)
    .rightSpaceToView(upView, 0)
    .bottomSpaceToView(upView, 40)
    .heightIs(1);
    
    _addressTF = [[UITextField alloc] init];
    _addressTF.placeholder = @"*请输入省市区街道，以及具体位置";
    _addressTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_addressTF setFont:[UIFont systemFontOfSize:14]];
    _addressTF.returnKeyType = UIReturnKeyDone;
    _addressTF.delegate = self;
    [upView addSubview:_addressTF];
    _addressTF.sd_layout.leftEqualToView(_titleTF)
    .bottomSpaceToView(upView, 5)
    .rightEqualToView(_titleTF)
    .heightIs(30);
    
}

//  添加 图片、视频
- (void)configCollectionView {
    
    // 如不需要长按排序效果，将LxGridViewFlowLayout类改成UICollectionViewFlowLayout即可
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //  横向滚动
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    _margin = 10;
    _itemWH = (KScreenWidth - 2 * _margin - 10)/4 - _margin;
    layout.itemSize = CGSizeMake(_itemWH, _itemWH);
    layout.minimumInteritemSpacing = _margin;
    layout.minimumLineSpacing = _margin;
    
    
#warning 添加视频-未完成！！！！！！
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, _itemWH + _margin * 2) collectionViewLayout:layout];
    _collectionView.alwaysBounceVertical = NO;     //  垂直的弹跳
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    //    _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [midUpView addSubview:_collectionView];
    
    [_collectionView registerClass:[TZTestCell class] forCellWithReuseIdentifier:@"TZTestCell"];
    
    //  选择照片 提示
    UILabel *label = [[UILabel alloc] init];
    label.text = @"请选择上传的图片或者视频(可不选)";
    label.textColor = [UIColor orangeColor];
    label.font = [UIFont systemFontOfSize:12];
    [midUpView addSubview:label];
    label.sd_layout.leftEqualToView(_titleTF)
    .rightEqualToView(_titleTF)
    .topSpaceToView(_collectionView, 0)
    .heightIs(15);
    
}

//  滑动按钮 价钱 横线
- (void)creatSlider {
    
    slideBackView = [[UIView alloc] init];
    //    slideBackView.backgroundColor = [UIColor cyanColor];
    [midDownView addSubview:slideBackView];
    slideBackView.sd_layout.leftEqualToView(_titleTF)
    .topSpaceToView(midDownView, 0)
    .rightEqualToView(_titleTF)
    .heightRatioToView(midDownView, 0.45);
    
    
    CGRect fram = CGRectMake(20, 5, KScreenWidth - 80, self.view.frame.size.height);
    NSArray *array = [NSArray arrayWithObjects:@"一口价",@"待技术勘察",@"协商价", nil];
    
#warning 这里的fram要改
    _filter = [[ZSFitterControl alloc] initWithFrame:fram Titles:array];
    //    _filter.centerY = slideBackView.centerY;
    [_filter addTarget:self action:@selector(filterValueChanged:) forControlEvents:UIControlEventTouchUpInside];
    [_filter setProgressColor:[UIColor groupTableViewBackgroundColor]];   //设置滑杆的颜色
    [_filter setTopTitlesColor:[UIColor yellowColor]];  //设置滑块上方字体颜色
    [_filter setSelectedIndex:0];   //设置当前选中
    [slideBackView addSubview:_filter];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = BACK_GROUND_COLOR;
    [midDownView addSubview:line];
    line.sd_layout.leftSpaceToView(midDownView, 0)
    .topSpaceToView(slideBackView, 0)
    .rightSpaceToView(midDownView, 0)
    .heightIs(1);
    
}

//  价格 横线
- (void)creatPrice {
    
    
#warning 这里 用 TextField-------
    
    prace = [[UILabel alloc] init];
    //    prace.backgroundColor = [UIColor cyanColor];
    prace.text = @"价格";
    [prace setFont:[UIFont systemFontOfSize:15]];
    prace.textColor = [UIColor blackColor];
    [midDownView addSubview:prace];
    prace.sd_layout.leftEqualToView(_titleTF)
    .topSpaceToView(slideBackView, 1)
    .widthRatioToView(midDownView, 0.2)
    .heightRatioToView(midDownView, 0.25);
    
    _priceTF = [[UITextField alloc] init];
    //    _priceLabel.backgroundColor = [UIColor brownColor];
    _priceTF.returnKeyType = UIReturnKeyDone;
    _priceTF.delegate = self;
    _priceTF.placeholder = @"请输入价格";
    [_priceTF setFont:[UIFont systemFontOfSize:15]];
    _priceTF.textColor = [UIColor blackColor];
    [midDownView addSubview:_priceTF];
    _priceTF.sd_layout.leftSpaceToView(prace, 0)
    .topEqualToView(prace)
    .rightEqualToView(_titleTF)
    .heightRatioToView(midDownView, 0.25);
    
}

//  分类（ 维护Maintain、安装Install ）
//  维护 按钮
- (void)creatMaintain {
    
    _maintainBtn = [[UIButton alloc] init];
    _maintainBtn.backgroundColor = [UIColor magentaColor];
    [_maintainBtn setTitle:@"维 护" forState:UIControlStateNormal];
    [_maintainBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_maintainBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    _maintainBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [_maintainBtn addTarget:self action:@selector(maintaBtnClick:) forControlEvents:UIControlEventTouchDown];
    
    [midDownView addSubview:_maintainBtn];
    _maintainBtn.sd_layout.leftEqualToView(_titleTF)
    .topSpaceToView(_priceTF, 1)
    .widthIs(self.view.frame.size.width/2 - 20)
    .heightRatioToView(midDownView, 0.25);
    
    
}

//  安装 按钮
- (void)creatInstall {
    
    _installBtn = [[UIButton alloc] init];
    _installBtn.backgroundColor = [UIColor cyanColor];
    [_installBtn setTitle:@"安 装" forState:UIControlStateNormal];
    [_installBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_installBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    _installBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [_installBtn addTarget:self action:@selector(installBtnClick:) forControlEvents:UIControlEventTouchDown];
    
    [midDownView addSubview:_installBtn];
    _installBtn.sd_layout.rightSpaceToView(midDownView, 20)
    .topEqualToView(_maintainBtn)
    .widthIs(self.view.frame.size.width/2 - 20)
    .heightRatioToView(midDownView, 0.25);
    
}

//  确认下单 按钮
- (void)creatButton {
    
    UIButton *confirmatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmatBtn = [[UIButton alloc] init];
    confirmatBtn.backgroundColor = [UIColor colorWithRed:253.0/255.0 green:217.0/255.0 blue:85.0/255.0 alpha:1];
    [confirmatBtn setTitle:@"确定发布" forState:UIControlStateNormal];
    [confirmatBtn.titleLabel setFont:[UIFont systemFontOfSize:17]];
    [confirmatBtn addTarget:self action:@selector(confirmatButtonClick) forControlEvents:UIControlEventTouchDown];
    [downView addSubview:confirmatBtn];
    confirmatBtn.sd_layout.leftSpaceToView(downView, 12)
    .topSpaceToView(downView, 10)
    .rightSpaceToView(downView, 12)
    .bottomSpaceToView(downView, 10);
    
}

//  改变键盘右下角 按钮
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    //    [_addressTF resignFirstResponder];
    return YES;
}

//  维护的 点击事件
- (void)maintaBtnClick:(UIButton *)button {
    
    NSLog(@"已选择维护");
}

//  安装的 点击事件
- (void)installBtnClick:(UIButton *)button {
    
    NSLog(@"已选择安装");
}


#warning 如果 slider 没有选择，则弹出一个提示框！或者默认就是 0 ---------------------------
#pragma mark - 滑动按钮点击 响应事件
-(void)filterValueChanged:(ZSFitterControl *)sender
{
    NSLog(@"当前滑块位置%d",_filter.SelectedIndex);
    switch (sender.SelectedIndex) {
        case 0:
            NSLog(@"一口价");
            break;
        case 1:
            NSLog(@"待技术勘察");
            break;
        case 2:
            NSLog(@"协商价");
            break;
        default:
            break;
    }
}

#pragma mark - 确定下单按钮
- (void)confirmatButtonClick {
    
    NSLog(@"确定发布----");
    
#warning 这里加 发布判定
    
    if ([_titleTF.text isEqual: @""]) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入标题" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        
    }else if ([_descriptTV.text isEqual: @""]) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请描述一下您的需求" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    }else if ([_addressTF.text isEqual: @""]) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入详细地址" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    }else if ([_priceTF.text isEqual: @""] && (_filter.SelectedIndex == 0)) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入价格" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    }else {
        
        NSLog(@"_filter.SelectedIndex:%d",_filter.SelectedIndex);
        
        TwoDetailsViewController *detailsVC = [[TwoDetailsViewController alloc] init];
        
        [self.navigationController pushViewController:detailsVC animated:YES];
    }
}

#pragma mark - 键盘响应
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_titleTF resignFirstResponder];
    [_descriptTV resignFirstResponder];
    [_addressTF resignFirstResponder];
    [_priceTF resignFirstResponder];
    
    [self.view endEditing:YES];
}

#pragma mark - UITextViewDelegate收回键盘
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}


#pragma mark - 点击任意地方收起键盘 3/3
//- (void)tapBG:(UITapGestureRecognizer *)gesture {
//
//    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
//}




#pragma mark - 取消下单按钮  < 按钮
//添加取消按钮->
- (void)addCancelBtn {
    
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backbtn"] style:UIBarButtonItemStylePlain target:self action:@selector(cancelTwoClick)];
    
    self.navigationItem.leftBarButtonItem = backBtn;
    
}

//取消按钮点击方法
- (void)cancelTwoClick {
    
    [self twoFinishPublish];
}

#pragma mark - 完成发布
//返回
-(void)twoFinishPublish{
    //2.block传值
    if (self.mDismissBlock != nil) {
        self.mDismissBlock();
    }
    [self dismissViewControllerAnimated:YES completion:nil];//
    //[self popoverPresentationController];
}
//block声明方法
-(void)toDissmissSelf:(dismissBlock)block{
    self.mDismissBlock = block;
}

#pragma mark - UITextViewDelegate  字数限制

//  在这个地方计算输入的字数
- (void)textViewDidChange:(UITextView *)textView {
    
    if ([textView.text length] == 0) {
        [descriptLabel setHidden:NO];
    }else {
        [descriptLabel setHidden:YES];
    }
    
    NSInteger wordCount = textView.text.length;
    self.wordCountLabel.text = [NSString stringWithFormat:@"%ld/300",(long)wordCount];
    [self wordLimit:textView];
}

#warning 这里有问题，粘贴的内容大于300之后就不能继续操作了
#pragma mark - 超过300字不能输入
-(BOOL)wordLimit:(UITextView *)text {
    if (text.text.length < 300) {
        NSLog(@"text.text.length:%ld",text.text.length);
        _descriptTV.editable = YES;
        
    }else {
        _descriptTV.editable = NO;
    }
    return nil;
}


#pragma mark UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _selectedPhotos.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TZTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TZTestCell" forIndexPath:indexPath];
    cell.videoImageView.hidden = YES;
    if (indexPath.row == _selectedPhotos.count) {
        cell.imageView.image = [UIImage imageNamed:@"AlbumAddBtn.png"];
        cell.deleteBtn.hidden = YES;
    }else {
        cell.imageView.image = _selectedPhotos[indexPath.row];
        cell.asset = _selectedAssets[indexPath.row];
        cell.deleteBtn.hidden = NO;
    }
    cell.deleteBtn.tag = indexPath.row;
    [cell.deleteBtn addTarget:self action:@selector(deleteBtnClik:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == _selectedPhotos.count) {
        BOOL showSheet = YES;
        if (showSheet) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"去相册选择", nil];
#pragma clang diagnostic pop
            [sheet showInView:self.view];
        } else {
            [self pushImagePickerController];
        }
    } else { // preview photos or video / 预览照片或者视频
        id asset = _selectedAssets[indexPath.row];
        BOOL isVideo = NO;
        if ([asset isKindOfClass:[PHAsset class]]) {
            PHAsset *phAsset = asset;
            isVideo = phAsset.mediaType == PHAssetMediaTypeVideo;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        } else if ([asset isKindOfClass:[ALAsset class]]) {
            ALAsset *alAsset = asset;
            isVideo = [[alAsset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypeVideo];
#pragma clang diagnostic pop
        }
        if (isVideo) { // perview video / 预览视频
            TZVideoPlayerController *vc = [[TZVideoPlayerController alloc] init];
            TZAssetModel *model = [TZAssetModel modelWithAsset:asset type:TZAssetModelMediaTypeVideo timeLength:@""];
            vc.model = model;
            [self presentViewController:vc animated:YES completion:nil];
        } else { // preview photos / 预览照片
            TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithSelectedAssets:_selectedAssets selectedPhotos:_selectedPhotos index:indexPath.row];
            imagePickerVc.maxImagesCount = SHOW_IMAGE_COUNT;
            imagePickerVc.allowPickingOriginalPhoto = YES;
            imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
            [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
                _selectedPhotos = [NSMutableArray arrayWithArray:photos];
                _selectedAssets = [NSMutableArray arrayWithArray:assets];
                _isSelectOriginalPhoto = isSelectOriginalPhoto;
                [_collectionView reloadData];
                _collectionView.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));
            }];
            [self presentViewController:imagePickerVc animated:YES completion:nil];
        }
    }
}

#pragma mark - LxGridViewDataSource

/// 以下三个方法为长按排序相关代码
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.item < _selectedPhotos.count;
}

- (BOOL)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)sourceIndexPath canMoveToIndexPath:(NSIndexPath *)destinationIndexPath {
    return (sourceIndexPath.item < _selectedPhotos.count && destinationIndexPath.item < _selectedPhotos.count);
}

- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)sourceIndexPath didMoveToIndexPath:(NSIndexPath *)destinationIndexPath {
    UIImage *image = _selectedPhotos[sourceIndexPath.item];
    [_selectedPhotos removeObjectAtIndex:sourceIndexPath.item];
    [_selectedPhotos insertObject:image atIndex:destinationIndexPath.item];
    
    id asset = _selectedAssets[sourceIndexPath.item];
    [_selectedAssets removeObjectAtIndex:sourceIndexPath.item];
    [_selectedAssets insertObject:asset atIndex:destinationIndexPath.item];
    
    [_collectionView reloadData];
}

#pragma mark - TZImagePickerController

- (void)pushImagePickerController {
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:SHOW_IMAGE_COUNT columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    
    
#pragma mark - 四类个性化设置，这些参数都可以不传，此时会走默认设置
    imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
    
    // 1.设置目前已经选中的图片数组
    imagePickerVc.selectedAssets = _selectedAssets; // 目前已经选中的图片数组
    
    imagePickerVc.allowTakePicture = NO; // 在内部显示拍照按钮
    
    // 2. Set the appearance
    // 2. 在这里设置imagePickerVc的外观
    // imagePickerVc.navigationBar.barTintColor = [UIColor greenColor];
    // imagePickerVc.oKButtonTitleColorDisabled = [UIColor lightGrayColor];
    // imagePickerVc.oKButtonTitleColorNormal = [UIColor greenColor];
    
    // 3. Set allow picking video & photo & originalPhoto or not
    // 3. 设置是否可以选择视频/图片/原图
    imagePickerVc.allowPickingVideo = YES;
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.allowPickingOriginalPhoto = YES;
    
    // 4. 照片排列按修改时间升序
    imagePickerVc.sortAscendingByModificationDate = YES;
    
    // imagePickerVc.minImagesCount = 3;
    // imagePickerVc.alwaysEnableDoneBtn = YES;
    
    // imagePickerVc.minPhotoWidthSelectable = 3000;
    // imagePickerVc.minPhotoHeightSelectable = 2000;
#pragma mark - 到这里为止
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
    }];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

#pragma mark - UIImagePickerController

- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) && iOS7Later) {
        // 无相机权限 做一个友好的提示
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        [alert show];
#define push @#clang diagnostic pop
        // 拍照之前还需要检查相册权限
    } else if ([[TZImageManager manager] authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        alert.tag = 1;
        [alert show];
    } else if ([[TZImageManager manager] authorizationStatus] == 0) { // 正在弹框询问用户是否允许访问相册，监听权限状态
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            return [self takePhoto];
        });
    } else { // 调用相机
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            self.imagePickerVc.sourceType = sourceType;
            if(iOS8Later) {
                _imagePickerVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            }
            [self presentViewController:_imagePickerVc animated:YES completion:nil];
        } else {
            NSLog(@"模拟器中无法打开照相机,请在真机中使用");
        }
    }
}

- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
        tzImagePickerVc.sortAscendingByModificationDate = YES;
        [tzImagePickerVc showProgressHUD];
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        // save photo and get asset / 保存图片，获取到asset
        [[TZImageManager manager] savePhotoWithImage:image completion:^(NSError *error){
            if (error) {
                [tzImagePickerVc hideProgressHUD];
                NSLog(@"图片保存失败 %@",error);
            } else {
                [[TZImageManager manager] getCameraRollAlbum:NO allowPickingImage:YES completion:^(TZAlbumModel *model) {
                    [[TZImageManager manager] getAssetsFromFetchResult:model.result allowPickingVideo:NO allowPickingImage:YES completion:^(NSArray<TZAssetModel *> *models) {
                        [tzImagePickerVc hideProgressHUD];
                        TZAssetModel *assetModel = [models firstObject];
                        if (tzImagePickerVc.sortAscendingByModificationDate) {
                            assetModel = [models lastObject];
                        }
                        [_selectedAssets addObject:assetModel.asset];
                        [_selectedPhotos addObject:image];
                        [_collectionView reloadData];
                    }];
                }];
            }
        }];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if ([picker isKindOfClass:[UIImagePickerController class]]) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - UIActionSheetDelegate

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
#pragma clang diagnostic pop
    if (buttonIndex == 0) { // take photo / 去拍照
        [self takePhoto];
    } else if (buttonIndex == 1) {
        [self pushImagePickerController];
    }
}

#pragma mark - UIAlertViewDelegate

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
#pragma clang diagnostic pop
    if (buttonIndex == 1) { // 去设置界面，开启相机访问权限
        if (iOS8Later) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        } else {
            NSURL *privacyUrl;
            if (alertView.tag == 1) {
                privacyUrl = [NSURL URLWithString:@"prefs:root=Privacy&path=PHOTOS"];
            } else {
                privacyUrl = [NSURL URLWithString:@"prefs:root=Privacy&path=CAMERA"];
            }
            if ([[UIApplication sharedApplication] canOpenURL:privacyUrl]) {
                [[UIApplication sharedApplication] openURL:privacyUrl];
            } else {
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"抱歉" message:@"无法跳转到隐私设置页面，请手动前往设置页面，谢谢" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
            }
        }
    }
}

#pragma mark - TZImagePickerControllerDelegate

/// User click cancel button
/// 用户点击了取消
- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker {
    // NSLog(@"cancel");
}

// The picker should dismiss itself; when it dismissed these handle will be called.
// If isOriginalPhoto is YES, user picked the original photo.
// You can get original photo with asset, by the method [[TZImageManager manager] getOriginalPhotoWithAsset:completion:].
// The UIImage Object in photos default width is 828px, you can set it by photoWidth property.
// 这个照片选择器会自己dismiss，当选择器dismiss的时候，会执行下面的代理方法
// 如果isSelectOriginalPhoto为YES，表明用户选择了原图
// 你可以通过一个asset获得原图，通过这个方法：[[TZImageManager manager] getOriginalPhotoWithAsset:completion:]
// photos数组里的UIImage对象，默认是828像素宽，你可以通过设置photoWidth属性的值来改变它
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    _selectedPhotos = [NSMutableArray arrayWithArray:photos];
    _selectedAssets = [NSMutableArray arrayWithArray:assets];
    _isSelectOriginalPhoto = isSelectOriginalPhoto;
    [_collectionView reloadData];
    // _collectionView.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));
    
    // 1.打印图片名字
    [self printAssetsName:assets];
}

// If user picking a video, this callback will be called.
// If system version > iOS8,asset is kind of PHAsset class, else is ALAsset class.
// 如果用户选择了一个视频，下面的handle会被执行
// 如果系统版本大于iOS8，asset是PHAsset类的对象，否则是ALAsset类的对象
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(id)asset {
    _selectedPhotos = [NSMutableArray arrayWithArray:@[coverImage]];
    _selectedAssets = [NSMutableArray arrayWithArray:@[asset]];
    // open this code to send video / 打开这段代码发送视频
    // [[TZImageManager manager] getVideoOutputPathWithAsset:asset completion:^(NSString *outputPath) {
    // NSLog(@"视频导出到本地完成,沙盒路径为:%@",outputPath);
    // Export completed, send video here, send by outputPath or NSData
    // 导出完成，在这里写上传代码，通过路径或者通过NSData上传
    
    // }];
    [_collectionView reloadData];
    // _collectionView.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));
}

#pragma mark - Click Event

- (void)deleteBtnClik:(UIButton *)sender {
    [_selectedPhotos removeObjectAtIndex:sender.tag];
    [_selectedAssets removeObjectAtIndex:sender.tag];
    
    [_collectionView performBatchUpdates:^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:sender.tag inSection:0];
        [_collectionView deleteItemsAtIndexPaths:@[indexPath]];
    } completion:^(BOOL finished) {
        [_collectionView reloadData];
    }];
}


#pragma mark - Private

/// 打印图片名字
- (void)printAssetsName:(NSArray *)assets {
    NSString *fileName;
    for (id asset in assets) {
        if ([asset isKindOfClass:[PHAsset class]]) {
            PHAsset *phAsset = (PHAsset *)asset;
            fileName = [phAsset valueForKey:@"filename"];
        } else if ([asset isKindOfClass:[ALAsset class]]) {
            ALAsset *alAsset = (ALAsset *)asset;
            fileName = alAsset.defaultRepresentation.filename;;
        }
        NSLog(@"图片名字:%@",fileName);
    }
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}


@end
