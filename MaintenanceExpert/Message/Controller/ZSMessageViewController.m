//
//  ZSMessageViewController.m
//  MaintenanceExpert
//
//  Created by koka on 16/10/18.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSMessageViewController.h"
#import "TWSpringyFlowLayout.h"
#import "ZSMessageViewCell.h"

@interface ZSMessageViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectionView;
}
@end



@implementation ZSMessageViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:[[TWSpringyFlowLayout alloc]init]];
    

    _collectionView.backgroundColor = [UIColor cyanColor];
    [_collectionView registerClass:[ZSMessageViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    
    
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 100;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZSMessageViewCell *cell = (ZSMessageViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.layer.cornerRadius = 10;
    cell.backgroundColor = [UIColor colorWithWhite:1.0 alpha:1];
    
    cell.iconview.image = [UIImage imageNamed:@"account_highlight"];
    cell.iconview.layer.cornerRadius = 30;
    cell.iD.text = @"老张";
    cell.news.text = @"你猜猜我是谁啊 | 5 分钟前";
    cell.image.image =[UIImage imageNamed:@"93S58PICcXy_1024"];
    
    
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.bounds.size.width - 20, 100);
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
