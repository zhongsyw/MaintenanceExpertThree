//
//  ZSMineInfoViewController.m
//  MaintenanceExpert
//
//  Created by koka on 16/10/27.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSMineInfoViewController.h"
#import "ZSAlertView.h"
#import "MinedetailInformationViewController.h"
#import "MineInfModel.h"
#import "UIViewController+SelectPhotoIcon.h"




@interface ZSMineInfoViewController ()<UITableViewDataSource,UITableViewDelegate>

{
    NSMutableArray *_array1;
    NSMutableArray *_array2;
    UIImageView *_icon;
    UIImage *_iconimage;
    NSString *_name;
    NSString *_mineinfo;
    
    UITableViewCell *_namecell;
    
    MineInfModel *_Model;
}

@property(nonatomic,strong)UITableView *tableview;;

@end


@implementation ZSMineInfoViewController

#warning 选取完图片之后会闪一下，需要修改

- (void)viewWillAppear:(BOOL)animated {
    
    self.navigationController.navigationBarHidden = NO;

    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSData *data = [user objectForKey:@"USER"];
    MineInfModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    _Model = model;
    NSLog(@"%@",_Model.MineInformation);
    
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:2 inSection:0];
    [_tableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor cyanColor];
    
    _array1 = [[NSMutableArray alloc]initWithObjects:@"头像",@"名字",@"个人简介",  nil];
    self.navigationItem.title = @"个人信息";
    
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(5, 24, KScreenWidth - 10, 44 * 2 + 80) style:UITableViewStylePlain];
    
    _tableview.backgroundColor = [UIColor cyanColor];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.showsVerticalScrollIndicator = NO;
    _tableview.showsHorizontalScrollIndicator = NO;
    
    
    [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableview];
    
    _namecell = [[UITableViewCell alloc]init];
    _iconimage = [[UIImage alloc]init];
    
    [self createDonebtn];
}

- (void)createDonebtn {
    
    UIBarButtonItem *barbtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(Done)];
    self.navigationItem.rightBarButtonItem = barbtn;
    
}

- (void)Done {
    
    [self.navigationController popViewControllerAnimated:NO];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return 50;
    }else{
        return 44;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
   return 3;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    if (cell == nil) {
    
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.row == 0) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.detailTextLabel.text = @"000";
        _icon = [[UIImageView alloc]initWithFrame:CGRectMake(-10, -10, 40, 40)];
        _icon.backgroundColor = [UIColor blueColor];
        _icon.image = _Model.usericon;
        _icon.contentMode = UIViewContentModeScaleToFill;
        _icon.layer.cornerRadius = _icon.frame.size.width / 2;
        _icon.clipsToBounds = YES;
        [cell.detailTextLabel addSubview:_icon];
        
    }else if (indexPath.row == 1) {
        
        _namecell = cell;
        _name = _Model.username;
        cell.detailTextLabel.text = _name;
        _Model.username = cell.detailTextLabel.text;
        /**
         *  先取，改完再存
         */
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_Model];
        NSUserDefaults *users = [NSUserDefaults standardUserDefaults];
        [users setObject:data forKey:@"USER"];
        
        
    }else if (indexPath.row == 2) {
        
        _mineinfo = _Model.MineInformation;
        
        cell.detailTextLabel.text = _mineinfo;
        
    }

    cell.textLabel.text = [NSString stringWithFormat:@"%@",_array1[indexPath.row]];
    cell.layer.cornerRadius = 5;
    
    // 解决ios8 detailTextLabel 不显示问题
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8) {  // 判断当前系统版本。（其实不判断也没问题）
    [cell layoutSubviews];
        }
    
    return cell;
    
}

#warning 改昵称时，数据传达，点开，数据保留
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {

        [self showActionSheet];
        
    }else if (indexPath.row == 1) {
        [ZSAlertView showAlertTextFieldViewWith:self title:nil message:@"请输入昵称" TextFeildCallBackBlock:^(NSString *text) {
            _Model.username = text;
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:1 inSection:0];
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        } cancelButtonTitle:@"取消" otherButtonTitles:@"确定"];
        
    }else {
        
        MinedetailInformationViewController *mineinf = [[MinedetailInformationViewController alloc]init];
        [self.navigationController pushViewController:mineinf animated:NO];
        
    }
   
}

//TODO:修改头像
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info;{
    
    //获得编辑后的图片
    UIImage *editedImage = (UIImage *)info[UIImagePickerControllerEditedImage];
    _iconimage= editedImage;
    
    _Model.usericon = _iconimage;
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_Model];
    NSUserDefaults *users = [NSUserDefaults standardUserDefaults];
    [users setObject:data forKey:@"USER"];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
    [_tableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    
    [picker dismissViewControllerAnimated:NO completion:nil];
}

@end
