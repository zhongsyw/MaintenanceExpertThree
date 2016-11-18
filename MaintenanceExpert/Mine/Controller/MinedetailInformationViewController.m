//
//  MinedetailInformationViewController.m
//  MaintenanceExpert
//
//  Created by koka on 16/11/16.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "MinedetailInformationViewController.h"
#import "PlaceholderTextView.h"
#import "MineInfModel.h"

#define kTextBorderColor     RGBCOLOR(227,224,216)

#undef  RGBCOLOR
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

@interface MinedetailInformationViewController ()<UITextViewDelegate>

@property (nonatomic, strong) PlaceholderTextView * textView;

//字数的限制
@property (nonatomic, strong)UILabel *wordCountLabel;

@end

@implementation MinedetailInformationViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"个人简介";
    
    [self createtextview];
    [self createwordcount];
    [self createDonebtn];
}

- (void)createtextview {
    
    _textView = [[PlaceholderTextView alloc]initWithFrame:CGRectMake(20, 10, self.view.frame.size.width - 40, 170)];
    _textView.backgroundColor = [UIColor whiteColor];
    _textView.delegate = self;
    _textView.font = [UIFont systemFontOfSize:14.f];
    _textView.textColor = [UIColor blackColor];
    _textView.textAlignment = NSTextAlignmentLeft;
    _textView.editable = YES;
    _textView.layer.cornerRadius = 4.0f;
    _textView.layer.borderColor = kTextBorderColor.CGColor;
    _textView.layer.borderWidth = 0.5;
    _textView.placeholderColor = RGBCOLOR(0x89, 0x89, 0x89);
    _textView.placeholder = @"请输入您的个人简介";
    [self.view addSubview:_textView];
    _textView.returnKeyType = UIReturnKeyDone;
}

- (void)createwordcount {
    
    self.wordCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.textView.frame.origin.x ,  self.textView.frame.size.height - 1, [UIScreen mainScreen].bounds.size.width - 40, 20)];
    _wordCountLabel.font = [UIFont systemFontOfSize:14.f];
    _wordCountLabel.textColor = [UIColor lightGrayColor];
    self.wordCountLabel.text = @"0/300";
    self.wordCountLabel.backgroundColor = [UIColor whiteColor];
    self.wordCountLabel.textAlignment = NSTextAlignmentRight;
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(self.textView.frame.origin.x,  self.textView.frame.size.height - 1 + 23, [UIScreen mainScreen].bounds.size.width - 40, 1)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:lineView];
    [self.view addSubview:_wordCountLabel];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)createDonebtn {
    
    UIBarButtonItem *barbtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(Done)];
    self.navigationItem.rightBarButtonItem = barbtn;
    
}

- (void)Done {
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSData *data = [user objectForKey:@"USER"];
    MineInfModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    model.MineInformation = _textView.text;
    
    NSData *data1 = [NSKeyedArchiver archivedDataWithRootObject:model];
    NSUserDefaults *users = [NSUserDefaults standardUserDefaults];
    [users setObject:data1 forKey:@"USER"];
    
    [self.navigationController popViewControllerAnimated:NO];
    
}

//把回车键当做退出键盘的响应键  textView退出键盘的操作
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([@"\n" isEqualToString:text] == YES)
    {
        [textView resignFirstResponder];
        
        
        return NO;
    }
    
    return YES;
}

- (UIColor *)colorWithRGBHex:(UInt32)hex
{
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}

//在这个地方计算输入的字数
- (void)textViewDidChange:(UITextView *)textView
{
    NSInteger wordCount = textView.text.length;
    self.wordCountLabel.text = [NSString stringWithFormat:@"%ld/300",(long)wordCount];
    [self wordLimit:textView];
}

#pragma mark 超过300字不能输入
-(BOOL)wordLimit:(UITextView *)text{
    if (text.text.length < 300) {
        
        self.textView.editable = YES;
        
    }
    else{
        self.textView.editable = NO;
        
    }
    return nil;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
   
    [_textView resignFirstResponder];

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
