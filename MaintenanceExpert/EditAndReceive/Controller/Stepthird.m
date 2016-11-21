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

#import "TZTestCell.h"
#import "TZImagePickerController.h"
#import "UIView+Layout.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "LxGridViewFlowLayout.h"
#import "TZImageManager.h"
#import "TZVideoPlayerController.h"

#define SHOW_IMAGE_COUNT 5

@interface Stepthird ()<ZHBtnSelectViewDelegate, TZImagePickerControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIAlertViewDelegate, UIActionSheetDelegate, UITextViewDelegate,UITextFieldDelegate>

{
    UITextView *_Textview;
    
    NSMutableArray *_selectedPhotos;
    NSMutableArray *_selectedAssets;
    BOOL _isSelectOriginalPhoto;
    
    CGFloat _itemWH;
    CGFloat _margin;
    
}
@property (nonatomic,weak)ZHCustomBtn *currentServiceBtn;
@property (nonatomic,weak)ZHBtnSelectView *btnServiceView;

@property (nonatomic,weak)ZHCustomBtn *currentOrderModelBtn;
@property (nonatomic,weak)ZHBtnSelectView *btnOrderModelView;

@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@property (nonatomic, strong) UICollectionView *collectionView;


@property (nonatomic,strong)NSArray *kindArr;
@end


@implementation Stepthird

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.title = [NSString stringWithFormat:@"%@(3/3)",[ZSDetailOrderModel shareDetailOrder].NavTitle];
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
    self.view.backgroundColor = [UIColor whiteColor];
    self.which = [ZSDetailOrderModel shareDetailOrder].KindIndex;
    
    _selectedPhotos = [NSMutableArray array];
    _selectedAssets = [NSMutableArray array];
    
    [self createUI];
}


- (void)initeverying {
    
    _Textview = [[UITextView alloc]init];
    if (self.which == 0) {
        _Textview.frame = CGRectMake(15, 20, KScreenWidth - 30, KScreenHeight / 3);
    }else{
        _Textview.frame = CGRectMake(15, 151, KScreenWidth - 30, KScreenHeight / 3 - 20);
    }
    _Textview.textColor = [UIColor blackColor];
    _Textview.font = [UIFont fontWithName:@"Arial" size:16];
    _Textview.delegate = self;
    _Textview.backgroundColor = [UIColor magentaColor];
    _Textview.scrollEnabled = YES;
    _Textview.autoresizingMask= UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_Textview];
    _Textview.returnKeyType = UIReturnKeyDone;
    
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
    
        
        // 如不需要长按排序效果，将LxGridViewFlowLayout类改成UICollectionViewFlowLayout即可
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];  //  横向滚动
        _margin = 10;
        _itemWH = (KScreenWidth - 2 * _margin - 10)/4 - _margin;
        layout.itemSize = CGSizeMake(_itemWH, _itemWH);
        layout.minimumInteritemSpacing = _margin;
        layout.minimumLineSpacing = _margin;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, photolabel.frame.origin.y + 20, KScreenWidth, _itemWH + _margin * 2) collectionViewLayout:layout];
        _collectionView.alwaysBounceVertical = NO;     //  垂直的弹跳
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        //    _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        [self.view addSubview:_collectionView];
        
        [_collectionView registerClass:[TZTestCell class] forCellWithReuseIdentifier:@"TZTestCell"];
        
        
        

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
        pricelabel.frame = CGRectMake(0, _collectionView.frame.origin.y + _collectionView.frame.size.height, KScreenWidth, 20);
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


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
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
