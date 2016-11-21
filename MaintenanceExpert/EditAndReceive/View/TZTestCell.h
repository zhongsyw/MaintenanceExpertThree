//
//  TZTestCell.h
//  TZImagePickerController
//
//  Created by xpc on 16/1/3.
//  Copyright © 2016年 xpc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TZTestCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *videoImageView;
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, assign) NSInteger row;
@property (nonatomic, strong) id asset;

- (UIView *)snapshotView;

@end

