//
//  DriftBottleViewController.m
//  ChineseGirl
//
//  Created by wallen on 2017/8/8.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "DriftBottleViewController.h"
#import "CGPickBottleContentView.h"
#import "CGBottleTextView.h"
@interface DriftBottleViewController ()<UITextViewDelegate>{
    BOOL touchState;
}
@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)UIButton *backBtn;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIImageView *bgImgView;
@property(nonatomic,strong)UIImageView *menuImgView;
@property(nonatomic,strong)UIView *menuView;
@property(nonatomic,strong)UIButton *drogBtn;
@property(nonatomic,strong)UIButton *pickBtn;
@property(nonatomic,strong)UIButton *myBottleBtn;
@property(nonatomic,strong)UILabel *drogLabel;
@property(nonatomic,strong)UILabel *pickLabel;
@property(nonatomic,strong)UILabel *myBottleLabel;
@property(nonatomic,strong)UIImageView *whImgView;   //浪花
@property(nonatomic,strong)UIButton *getBottle;   //捡到的瓶子
@property(nonatomic,strong)CGPickBottleContentView *bottleContentView;
@property(nonatomic,strong)CGBottleTextView *wirteView;
@property(nonatomic,strong)CALayer *maskLayer;
@property(nonatomic,strong)UIImageView *pickImgView;
@end

@implementation DriftBottleViewController

-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self.tabBarController.tabBar setHidden:YES];
    [super viewWillAppear:animated];
    touchState=NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [self.tabBarController.tabBar setHidden:NO];
}

-(void)setTouchHiddenNav:(BOOL)state{
    self.headerView.hidden=state;
    [self.tabBarController.tabBar setHidden:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:state];
}

-(void)backClick{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubViews];
    [self setUpNavWithTitle:@"漂流瓶" leftIcon:@"Newsleft" rightIcon:nil leftTitle:@"发现" rightTitle:nil delegate:nil];
    
}

-(void)addSubViews{
    [self.view addSubview:self.bgImgView];
    [self.view addSubview:self.headerView];
    [self.headerView addSubview:self.titleLabel];
    [self.headerView addSubview:self.backBtn];
    [self.view addSubview:self.menuView];
    [self.menuView addSubview:self.menuImgView];
    [self.menuView addSubview:self.drogBtn];
    [self.menuView addSubview:self.pickBtn];
    [self.menuView addSubview:self.myBottleBtn];
    [self.menuView addSubview:self.drogLabel];
    [self.menuView addSubview:self.pickLabel];
    [self.menuView addSubview:self.myBottleLabel];
    [self.view addSubview:self.whImgView];
    [self.view addSubview:self.getBottle];
}

-(void)setCommonAction:(BOOL)state{
    self.headerView.hidden=state;
    self.menuView.hidden=state;
}

-(void)drogClick{
    [self setCommonAction:YES];
    [self.view.layer addSublayer:self.maskLayer];
    [self.view addSubview:self.wirteView];
}

-(void)pickClick{
    [self setCommonAction:YES];
    [self.bgImgView setImage:[UIImage imageNamed:@"battle_check"]];
    [self startAnimaction];

}

-(void)myBottleClick{
    [self setCommonAction:YES];
}

-(void)setPickStart{
    [self.wirteView removeFromSuperview];
    [self.maskLayer removeFromSuperlayer];
    [self.bgImgView setImage:[UIImage imageNamed:@"battle_check"]];
    self.pickImgView= [self rotate360DegreeWithImageView:@"bottle_vm"];
    [self.view addSubview:self.pickImgView];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        [textView resignFirstResponder];
        [self setPickStart];
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    
    return YES;
}

-(void)startAnimaction{
    CGFloat y = [self getRandomNumber:-30 to:60];
    CGFloat x = [self getRandomNumber:-50 to:100];
    self.whImgView.frame=CGRectMake(screen_width/2-35*SCREEN_RADIO+x, screen_height/2+y, 103*SCREEN_RADIO, 73*SCREEN_RADIO);
    [self.whImgView startAnimating];
    [self.whImgView performSelector:@selector(stopAnimating) withObject:nil afterDelay:1];
    [self performSelector:@selector(clearnImgView:) withObject:[NSValue valueWithCGSize:CGSizeMake(screen_width/2-35*SCREEN_RADIO+x, screen_height/2+y)] afterDelay:1.1];
    
}

-(void)clearnImgView:(NSValue *)size{
    CGSize _size=[size CGSizeValue];
    int index=arc4random() %3+1;
    self.getBottle.frame=CGRectMake(_size.width+20*SCREEN_RADIO, _size.height+20*SCREEN_RADIO, 156/2, 57*SCREEN_RADIO);
    self.getBottle.hidden=NO;
    [self.getBottle setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"bottle_vw%d",index]] forState:UIControlStateNormal];
    
}

-(void)clearnPickImg{
    [self.pickImgView removeFromSuperview];
    self.whImgView.frame=CGRectMake(screen_width/2-50*SCREEN_RADIO, screen_height/2, 103*SCREEN_RADIO, 73*SCREEN_RADIO);
    [self.whImgView startAnimating];
    [self.whImgView performSelector:@selector(stopAnimating) withObject:nil afterDelay:1];
    [self performSelector:@selector(bottlebg) withObject:nil afterDelay:1];

}

-(void)bottlebg{
    [self.bgImgView setImage:[UIImage imageNamed:@"bottle_bg"]];
    [self setCommonAction:NO];
}

-(void)getBottleClick{  //捡起来的瓶子
    self.getBottle.hidden=YES;
    [self.view addSubview:self.bottleContentView];
    
}

-(int)getRandomNumber:(int)from to:(int)to
{
    return (int)(from + (arc4random() % (to-from + 1)));
}

//触摸事件

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    touchState=!touchState;
    [self setTouchHiddenNav:touchState];
}

-(UIView *)headerView{
    if (!_headerView) {
        _headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 64*SCREEN_RADIO)];
        _headerView.backgroundColor=[UIColor getColor:@"141515"];
    }
    
    return _headerView;
}

-(UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn=[[UIButton alloc] initWithFrame:CGRectMake(15*SCREEN_RADIO, 30*SCREEN_RADIO, 10*SCREEN_RADIO, 19*SCREEN_RADIO)];
        [_backBtn setBackgroundImage:[UIImage imageNamed:@"Newsleft"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _backBtn;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 30*SCREEN_RADIO, screen_width, 24*SCREEN_RADIO)];
        _titleLabel.font=[UIFont systemFontOfSize:19];
        _titleLabel.textColor=[UIColor whiteColor];
        _titleLabel.text=@"漂流瓶";
        _titleLabel.textAlignment=NSTextAlignmentCenter;
    }
    
    return _titleLabel;
}

-(UIImageView *)bgImgView{
    if (!_bgImgView) {
        _bgImgView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, screen_height)];
        _bgImgView.image=[UIImage imageNamed:@"bottle_bg"];
    }
    
    return _bgImgView;
}

-(UIView *)menuView{
    if (!_menuView) {
        _menuView=[[UIView alloc] initWithFrame:CGRectMake(0, screen_height-93*SCREEN_RADIO, screen_width, 93*SCREEN_RADIO)];
    }
    
    return _menuView;
}

-(UIImageView *)menuImgView{
    if (!_menuImgView) {
        _menuImgView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 48.5*SCREEN_RADIO, SCREEN_WIDTH, 44.5)];
        _menuImgView.image=[UIImage imageNamed:@"bottle_vg"];
    }
    
    return _menuImgView;
}


-(UIButton *)drogBtn{
    if (!_drogBtn) {
        _drogBtn=[[UIButton alloc] initWithFrame:CGRectMake(20*SCREEN_RADIO, 0, 73*SCREEN_RADIO, 88*SCREEN_RADIO)];
        [_drogBtn setBackgroundImage:[UIImage imageNamed:@"bottle_vm"] forState:UIControlStateNormal];
        [_drogBtn addTarget:self action:@selector(drogClick) forControlEvents:UIControlEventTouchUpInside];
    }
                  
    return _drogBtn;
}

-(UILabel *)drogLabel{
    if (!_drogLabel) {
        _drogLabel=[[UILabel alloc] initWithFrame:CGRectMake(40*SCREEN_RADIO, CGRectGetMaxY(self.drogBtn.frame)-12*SCREEN_RADIO, 0, 12*SCREEN_RADIO)];
        _drogLabel.text=@"扔一个";
        _drogLabel.textColor=[UIColor getColor:@"ffffff"];
        _drogLabel.font=[UIFont systemFontOfSize:11*SCREEN_RADIO];
        [_drogLabel sizeToFit];
    }
    
    return _drogLabel;
}




-(UIButton *)pickBtn{
    if (!_pickBtn) {
        _pickBtn=[[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-44*SCREEN_RADIO, 0, 73*SCREEN_RADIO, 88*SCREEN_RADIO)];
        [_pickBtn setBackgroundImage:[UIImage imageNamed:@"bottle_vi"] forState:UIControlStateNormal];
        [_pickBtn addTarget:self action:@selector(pickClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _pickBtn;
}

-(UILabel *)pickLabel{
    if (!_pickLabel) {
        _pickLabel=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-24*SCREEN_RADIO, CGRectGetMaxY(self.pickBtn.frame)-12*SCREEN_RADIO, 0, 12*SCREEN_RADIO)];
        _pickLabel.text=@"捡一个";
        _pickLabel.textColor=[UIColor getColor:@"ffffff"];
        _pickLabel.font=[UIFont systemFontOfSize:11*SCREEN_RADIO];
        [_pickLabel sizeToFit];
    }
    
    return _pickLabel;
}


-(UIButton *)myBottleBtn{
    if (!_myBottleBtn) {
        _myBottleBtn=[[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-(20+73)*SCREEN_RADIO,0, 73*SCREEN_RADIO, 88*SCREEN_RADIO)];
        [_myBottleBtn setBackgroundImage:[UIImage imageNamed:@"bottle_vk"] forState:UIControlStateNormal];
        [_myBottleBtn addTarget:self action:@selector(myBottleClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _myBottleBtn;
}

-(UILabel *)myBottleLabel{
    if (!_myBottleLabel) {
        _myBottleLabel=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-(5+73)*SCREEN_RADIO, CGRectGetMaxY(self.myBottleBtn.frame)-12*SCREEN_RADIO, 0, 12*SCREEN_RADIO)];
        _myBottleLabel.text=@"我的瓶子";
        _myBottleLabel.textColor=[UIColor getColor:@"ffffff"];
        _myBottleLabel.font=[UIFont systemFontOfSize:11*SCREEN_RADIO];
        [_myBottleLabel sizeToFit];
    }
    
    return _myBottleLabel;
}

-(UIButton *)getBottle{
    if (!_getBottle) {
        _getBottle=[[UIButton alloc] init];
      //  [_getBottle setBackgroundImage:[UIImage imageNamed:@"bottle_vw"] forState:UIControlStateNormal];
        [_getBottle addTarget:self action:@selector(getBottleClick) forControlEvents:UIControlEventTouchUpInside];
        _getBottle.hidden=YES;
    }
    
    return _getBottle;
}

-(UIImageView *)whImgView{
    if (!_whImgView) {
        _whImgView=[[UIImageView alloc] initWithFrame:CGRectMake(screen_width/2, screen_height/2, 103*SCREEN_RADIO, 73*SCREEN_RADIO)];
        NSMutableArray *imgs=[NSMutableArray array];
        for (int i=1; i<4; i++) {
            UIImage *img=[UIImage imageNamed:[NSString stringWithFormat:@"bottle_wh%d",i]];
            [imgs addObject:img];
        }
        
        [_whImgView setAnimationImages:imgs];
        
        //添加动画执行的时间
        [_whImgView setAnimationDuration:1];
        [_whImgView setAnimationRepeatCount:1];
        

    }
    
    return _whImgView;
}

-(CGPickBottleContentView *)bottleContentView{
    if (!_bottleContentView) {
        __weak __typeof(self)weakSelf = self;
        _bottleContentView=[[CGPickBottleContentView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height) withDrogBlock:^{
            [weakSelf setPickStart];
        }];
        
    }
    
    return _bottleContentView;
}

-(CGBottleTextView *)wirteView{
    if (!_wirteView) {
        _wirteView=[[CGBottleTextView alloc] initWithFrame:CGRectMake(15*SCREEN_RADIO, 15*SCREEN_RADIO, screen_width-30*SCREEN_RADIO, screen_height-30*SCREEN_RADIO)];
        _wirteView.backgroundColor=[UIColor whiteColor];
        _wirteView.textColor=[UIColor blackColor];
        _wirteView.font=[UIFont systemFontOfSize:16*SCREEN_RADIO];
        _wirteView.delegate=self;
        _wirteView.layer.cornerRadius=5;
        
    }
    
    return _wirteView;
}

-(CALayer *)maskLayer{
    if(!_maskLayer){
        _maskLayer = [CALayer layer];
        [_maskLayer setFrame:CGRectMake(0, 0, screen_width, screen_height)];
        [_maskLayer setBackgroundColor:[[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4] CGColor]];
    }
    
    return _maskLayer;
}

- (UIImageView *)rotate360DegreeWithImageView:(NSString *)imageStr{
    CGFloat _x=screen_width/2+100*SCREEN_RADIO;
    CGFloat _y=screen_height/2+200*SCREEN_RADIO;
    
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(_x, _y, 73*SCREEN_RADIO, 88*SCREEN_RADIO)];
    imageView.image=[UIImage imageNamed:imageStr];
    CABasicAnimation *animation = [ CABasicAnimation
                                   animationWithKeyPath: @"transform" ];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    //animation.speed=2;
    
    //围绕Z轴旋转，垂直与屏幕
    animation.toValue = [ NSValue valueWithCATransform3D:
                         
                         CATransform3DMakeRotation(M_PI, 0.0, 0.0, 1.0) ];
   // animation.duration = 1.0;
    //旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转
    animation.cumulative = YES;
    animation.repeatCount = 1;
    
    //在图片边缘添加一个像素的透明区域，去图片锯齿
    CGRect imageRrect = CGRectMake(0, 0,imageView.frame.size.width, imageView.frame.size.height);
    UIGraphicsBeginImageContext(imageRrect.size);
    [imageView.image drawInRect:CGRectMake(1,1,imageView.frame.size.width-2,imageView.frame.size.height-2)];
    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    CABasicAnimation *move=[CABasicAnimation animationWithKeyPath:@"position"];
    // 设定动画起始帧和结束帧
    move.fromValue = [NSValue valueWithCGPoint:CGPointMake(_x, _y)]; // 起始点
    move.toValue = [NSValue valueWithCGPoint:CGPointMake(screen_width/2, screen_height/2+50*SCREEN_RADIO)]; // 终了点
   // move.duration = 1.0;
    move.repeatCount = 1;

//    [imageView.layer addAnimation:animation forKey:nil];
//    [imageView.layer addAnimation:move forKey:nil];
    
    
    
    CAAnimationGroup *animaGroup = [CAAnimationGroup animation];
    animaGroup.duration = 1.0f;
    animaGroup.fillMode = kCAFillModeForwards;
    animaGroup.removedOnCompletion = NO;
    animaGroup.animations = @[animation,move];
    //animaGroup.speed=2;
    [imageView.layer addAnimation:animaGroup forKey:@"Animation"];
    
    [self performSelector:@selector(clearnPickImg) withObject:nil afterDelay:1];
    return imageView;
}

@end
