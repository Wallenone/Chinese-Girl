//
//  DriftBottleViewController.m
//  ChineseGirl
//
//  Created by wallen on 2017/8/8.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "DriftBottleViewController.h"
#import "CGPickBottleContentView.h"
@interface DriftBottleViewController (){
    BOOL touchState;
}
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
@end

@implementation DriftBottleViewController

-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
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
    [self.navigationController setNavigationBarHidden:state];
    [self.tabBarController.tabBar setHidden:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:state];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubViews];
    [self setUpNavWithTitle:@"漂流瓶" leftIcon:@"Newsleft" rightIcon:nil leftTitle:@"发现" rightTitle:nil delegate:nil];
    
}

-(void)addSubViews{
    [self.view addSubview:self.bgImgView];
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


-(void)drogClick{
    
}

-(void)pickClick{
    [self.bgImgView setImage:[UIImage imageNamed:@"battle_check"]];
    [self startAnimaction];
    

}

-(void)myBottleClick{
    
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
    self.getBottle.frame=CGRectMake(_size.width+20*SCREEN_RADIO, _size.height+20*SCREEN_RADIO, 156/2, 114/2);
    self.getBottle.hidden=NO;
    [self.getBottle setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"bottle_vw%d",index]] forState:UIControlStateNormal];
    
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
        _bottleContentView=[[CGPickBottleContentView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
        
    }
    
    return _bottleContentView;
}


@end
