//
//  OneViewController.m
//  XWPopMenuVCDemo
//
//  Created by koka on 16/10/18.
//  Copyright © 2016年 ZSYW. All rights reserved.
//
/**
 *  这是详细下单页面
 *
 */

#import "OneViewController.h"
#import "ZSAlertView.h"
#import "myimgeview.h"
#import "Stepfirst.h"
#import "ZSDetailOrderModel.h"

#define RADIUS 100.0
#define PHOTONUM 5
#define PHOTOSTRING @"icon"
#define TAGSTART 1000
#define TIME 1.5
#define SCALENUMBER 1.25
int array [PHOTONUM][PHOTONUM] ={
    {0,1,2,3,4},
    {4,0,1,2,3},
    {3,4,0,1,2},
    {2,3,4,0,1},
    {1,2,3,4,0}
};

@interface OneViewController ()
{
    NSMutableArray *_detailArray;
    
}
@end


@implementation OneViewController



CATransform3D rotationTransform1[PHOTONUM];

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor cyanColor]];
    self.navigationController.navigationBarHidden = YES;

    
   // 自定义返回按钮
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(Clickup:) forControlEvents:UIControlEventTouchUpInside];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    /**
     初始化数组二级数据
     */
    [self initArray];
    
    UIImageView *backview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"IMG_0255"]];
    backview.frame = self.view.frame;
    backview.center = CGPointMake(backview.center.x, backview.center.y - 10);
    
    [self.view addSubview:backview];
    
    NSArray *textArray = [NSArray arrayWithObjects:@"安防系统",@"UPS系统",@"音视频系统",@"LED",@"待定ing",nil];
    
    float centery = self.view.center.y - 50;
    float centerx = self.view.center.x;
    
    for (int i = 0;i<PHOTONUM;i++ )
    {
        float tmpy =  centery + RADIUS*cos(2.0*M_PI *i/PHOTONUM);
        float tmpx =	centerx - RADIUS*sin(2.0*M_PI *i/PHOTONUM);
        myimgeview *addview1 =	[[myimgeview alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@%d",PHOTOSTRING,i]] text:[textArray objectAtIndex:i]];
        addview1.frame = CGRectMake(0.0, 0.0,120.0,140.0);
        [addview1 setdege:self];
        addview1.tag = TAGSTART + i;
        addview1.center = CGPointMake(tmpx,tmpy);
        rotationTransform1[i] = CATransform3DIdentity;
        
        //float Scalenumber =atan2f(sin(2.0*M_PI *i/PHOTONUM));
        float Scalenumber = fabs(i - PHOTONUM/2.0)/(PHOTONUM/2.0);
        if (Scalenumber<0.3)
        {
            Scalenumber = 0.4;
        }
        CATransform3D rotationTransform = CATransform3DIdentity;
        rotationTransform = CATransform3DScale (rotationTransform, Scalenumber*SCALENUMBER,Scalenumber*SCALENUMBER, 1);
        addview1.layer.transform=rotationTransform;		
        [self.view addSubview:addview1];
        
    }
    currenttag = TAGSTART;
    //添加取消按钮->
    [self addCancelBtn];
}

- (void)initArray {
    
    NSMutableArray *array0 = [[NSMutableArray alloc]initWithObjects:@"闭门监控系统",@"防盗报警系统",@"门禁管理系统",@"停车场管理系统",@"电子巡更系统", nil];
    NSMutableArray *array1 = [[NSMutableArray alloc]initWithObjects:@"UPS主机电池安装",@"UPS更换电池",@"UPS系统维护", nil];
    NSMutableArray *array2 = [[NSMutableArray alloc]initWithObjects:@"音视频系统",@"多媒体投影系统",@"会议系统",@"舞台幕布系统",@"智能灯光系统", nil];
    NSMutableArray *array3 = [[NSMutableArray alloc]initWithObjects:@"立柱屏安装维护",@"室外挂墙屏安装维护",@"室内挂墙屏安装维护", nil];
    
    _detailArray = [[NSMutableArray alloc]initWithObjects:array0,array1,array2,array3, nil];
}

/**
 *   根据1级按钮的tag值判定二级选项
 *   一级按钮tag 1000 1001 1002 1003 1004
 *   二级按钮tag 2 3 4 。。。取消按钮为0
 *  @param tag
 **/

-(void)Clickup:(NSInteger)tag
{
    NSLog(@"点击TAG%ld:",tag);
    /**
     *  一级分类存入Model
     */
    [ZSDetailOrderModel shareDetailOrder].FirstIndex = tag;
    
    NSInteger t = [self getblank:tag];
    //NSLog(@"%d",t);
    int i = 0;
    for (i = 0;i<PHOTONUM;i++ )
    {
        
        UIImageView *imgview = (UIImageView*)[self.view viewWithTag:TAGSTART+i];
        [imgview.layer addAnimation:[self moveanimation:TAGSTART+i number:t] forKey:@"position"];
        [imgview.layer addAnimation:[self setscale:TAGSTART+i clicktag:tag] forKey:@"transform"];
        
        int j = array[tag - TAGSTART][i];
        float Scalenumber = fabs(j - PHOTONUM/2.0)/(PHOTONUM/2.0);
        if (Scalenumber<0.3)
        {
            Scalenumber = 0.4;
        }
}
    currenttag = tag;
    //	[self performSelector:@selector(setcurrenttag) withObject:nil afterDelay:TIME];
    [self alertActionClink:currenttag];
}
- (void)alertActionClink:(NSInteger)tag {
   
    if (tag == 1000) {
        [ZSAlertView showAlertViewWith:self imagename:@"home-prolist-icon1-hover.jpg" title:@"安防系统" message:@"请选择服务项目" CallBackBlock:^(NSInteger btnIndex) {
            self.integer = btnIndex;
            [self pushToView];
            NSLog(@"%ld", (long)btnIndex);
        } cancelButtonTitle:@"取消" destructiveButtonTitle:@"撤销" otherButtonTitles:@"闭门监控系统",@"防盗报警系统",@"门禁管理系统",@"停车场管理系统",@"电子巡更系统",nil];
    }else if (tag == 1001) {
        [ZSAlertView showAlertViewWith:self imagename:@"home-prolist-icon2-hover.jpg" title:@"UPS系统" message:@"请选择服务项目" CallBackBlock:^(NSInteger btnIndex) {
            self.integer = btnIndex;
            [self pushToView];
            NSLog(@"%ld", (long)btnIndex);
        } cancelButtonTitle:@"取消" destructiveButtonTitle:@"撤销" otherButtonTitles:@"UPS主机电池安装",@"UPS更换电池",@"UPS系统维护",nil];
    }else if (tag == 1002) {
        [ZSAlertView showAlertViewWith:self imagename:@"home-prolist-icon3-hover.jpg" title:@"音视频系统" message:@"请选择服务项目" CallBackBlock:^(NSInteger btnIndex) {
            self.integer = btnIndex;
            [self pushToView];
            NSLog(@"%ld", (long)btnIndex);
        } cancelButtonTitle:@"取消" destructiveButtonTitle:@"撤销" otherButtonTitles:@"音视频系统",@"多媒体投影系统",@"会议系统",@"舞台幕布系统",@"智能灯光系统",nil];
    }else if (tag == 1003) {
        [ZSAlertView showAlertViewWith:self imagename:@"home-prolist-icon4-hover.jpg" title:@"LED" message:@"请选择服务项目务" CallBackBlock:^(NSInteger btnIndex) {
            self.integer = btnIndex;
            [self pushToView];
            NSLog(@"%ld", (long)btnIndex);
        } cancelButtonTitle:@"取消" destructiveButtonTitle:@"撤销"  otherButtonTitles:@"立柱屏安装维护",@"室外挂墙屏安装维护",@"室内挂墙屏安装维护",nil];
    }else {
        [ZSAlertView showAlertViewWith:self imagename:@"home-prolist-icon1-hover.jpg" title:@"待开放" message:@"请选择服务项目务" CallBackBlock:^(NSInteger btnIndex) {
            
            
            
            self.integer = btnIndex;
            [self pushToView];
        
            
            NSLog(@"%ld", (long)btnIndex);
        } cancelButtonTitle:@"取消" destructiveButtonTitle:@"撤销" otherButtonTitles:nil];
    }
}

- (void)pushToView {
    
    NSLog(@"%ld",self.integer);
    
    [ZSDetailOrderModel shareDetailOrder].SecondIndex = self.integer;
    
    Stepfirst *first = [[Stepfirst alloc]init];
    if (self.integer == 0) {
        
    }else {
        [self.navigationController pushViewController:first animated:YES];
    }
    
    
}

-(void)setcurrenttag
{
    int i = 0;
    for (i = 0;i<PHOTONUM;i++ )
    {
        
        UIImageView *imgview = (UIImageView*)[self.view viewWithTag:TAGSTART+i];
        int j = array[currenttag - TAGSTART][i];
        float Scalenumber = fabs(j - PHOTONUM/2.0)/(PHOTONUM/2.0);
        if (Scalenumber<0.3)
        {
            Scalenumber = 0.4;
        }
        CATransform3D dtmp = CATransform3DScale(rotationTransform1[i],Scalenumber*SCALENUMBER, Scalenumber*SCALENUMBER, 1.0);
        imgview.layer.transform=dtmp;
        
        //	imgview.layer.needsDisplayOnBoundsChange = YES;
    }
}

-(CAAnimation*)setscale:(NSInteger)tag clicktag:(NSInteger)clicktag
{
    
    
    int i = array[clicktag - TAGSTART][tag - TAGSTART];
    int i1 = array[currenttag - TAGSTART][tag - TAGSTART];
    float Scalenumber = fabs(i - PHOTONUM/2.0)/(PHOTONUM/2.0);
    float Scalenumber1 = fabs(i1 - PHOTONUM/2.0)/(PHOTONUM/2.0);
    if (Scalenumber<0.3)
    {
        Scalenumber = 0.4;
    }
    //UIImageView *imgview = (UIImageView*)[self.view viewWithTag:tag];
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.duration = TIME;
    animation.repeatCount =1;
    
    
    CATransform3D dtmp = CATransform3DScale(rotationTransform1[tag - TAGSTART],Scalenumber*SCALENUMBER, Scalenumber*SCALENUMBER, 1.0);
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(rotationTransform1[tag - TAGSTART],Scalenumber1*SCALENUMBER,Scalenumber1*SCALENUMBER, 1.0)];
    animation.toValue = [NSValue valueWithCATransform3D:dtmp ];
    animation.autoreverses = NO;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    //imgview.layer.transform=dtmp;
    
    return animation;
}

-(CAAnimation*)moveanimation:(NSInteger)tag number:(NSInteger)num
{
    // CALayer
    UIImageView *imgview = (UIImageView*)[self.view viewWithTag:tag];
    CAKeyframeAnimation* animation;
    animation = [CAKeyframeAnimation animation];
    CGMutablePathRef path = CGPathCreateMutable();
    NSLog(@"原点%f原点%f",imgview.layer.position.x,imgview.layer.position.y);
    CGPathMoveToPoint(path, NULL,imgview.layer.position.x,imgview.layer.position.y);
    
    NSInteger p =  [self getblank:tag];
    NSLog(@"旋转%ld",p);
    float f = 2.0*M_PI  - 2.0*M_PI *p/PHOTONUM;
    float h = f + 2.0*M_PI *num/PHOTONUM;
    float centery = self.view.center.y - 50;
    float centerx = self.view.center.x;
    float tmpy =  centery + RADIUS*cos(h);
    float tmpx =	centerx - RADIUS*sin(h);
    imgview.center = CGPointMake(tmpx,tmpy);
    
    CGPathAddArc(path,nil,self.view.center.x, self.view.center.y - 50,RADIUS,f+ M_PI/2,f+ M_PI/2 + 2.0*M_PI *num/PHOTONUM,0);
    animation.path = path;
    CGPathRelease(path);
    animation.duration = TIME;
    animation.repeatCount = 1;
    animation.calculationMode = @"paced";
    return animation;
}


-(NSInteger)getblank:(NSInteger)tag
{
    if (currenttag>tag)
    {
        return currenttag - tag;
    }
    else
    {
        return PHOTONUM  - tag + currenttag;
    }
    
}

-(void)Scale
{
    [UIView beginAnimations:nil context:(__bridge void * _Nullable)(self)];
    [UIView setAnimationRepeatCount:3];
    [UIView setAnimationDuration:1];
    
    /*
     + (void)setAnimationWillStartSelector:(SEL)selector;                // default = NULL. -animationWillStart:(NSString *)animationID context:(void *)context
     + (void)setAnimationDidStopSelector:(SEL)selector;                  // default = NULL. -animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
     + (void)setAnimationDuration:(NSTimeInterval)duration;              // default = 0.2
     + (void)setAnimationDelay:(NSTimeInterval)delay;                    // default = 0.0
     + (void)setAnimationStartDate:(NSDate *)startDate;                  // default = now ([NSDate date])
     + (void)setAnimationCurve:(UIViewAnimationCurve)curve;              // default = UIViewAnimationCurveEaseInOut
     + (void)setAnimationRepeatCount:(float)repeatCount;                 // default = 0.0.  May be fractional
     + (void)setAnimationRepeatAutoreverses:(BOOL)repeatAutoreverses;
     */
    
    CATransform3D rotationTransform = CATransform3DIdentity;
    
    rotationTransform = CATransform3DRotate(rotationTransform,3.14, 1.0, 0.0, 0.0);
    //rotationTransform = CATransform3DScale (rotationTransform, 0.1,0.1, 2);
    //self.view.transform=CGAffineTransformMakeScale(2,2);
    
    self.view.layer.transform=rotationTransform;
    [UIView setAnimationDelegate:self];	
    [UIView commitAnimations];
}








//添加取消按钮->
-(void)addCancelBtn{
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [cancelBtn setFrame:CGRectMake(5, KScreenHeight - 50 , KScreenWidth - 10, 50)];
    [cancelBtn setTitle:@"取   消" forState:UIControlStateNormal];
    [self.view addSubview:cancelBtn];
    cancelBtn.backgroundColor = [UIColor orangeColor];
    cancelBtn.layer.cornerRadius = 10;
    [cancelBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
}

//取消按钮点击方法
-(void)cancelClick{
    [self finishPublish];
}


#pragma mark - 完成发布
//完成发布
-(void)finishPublish{
    //2.block传值
    if (self.mDismissBlock != nil) {
        self.mDismissBlock();
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
//block声明方法
-(void)toDissmissSelf:(dismissBlock)block{
    self.mDismissBlock = block;
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
