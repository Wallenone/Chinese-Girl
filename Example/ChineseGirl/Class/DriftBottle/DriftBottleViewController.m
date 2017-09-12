//
//  DriftBottleViewController.m
//  ChineseGirl
//
//  Created by wallen on 2017/8/8.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "DriftBottleViewController.h"

@interface DriftBottleViewController (){
    BOOL touchState;
}
@property(nonatomic,strong)UIImageView *bgImgView;
@property(nonatomic,strong)UIImageView *menuImgView;
@property(nonatomic,strong)UIButton *drogBtn;
@property(nonatomic,strong)UIButton *pickBtn;
@property(nonatomic,strong)UIButton *myBottleBtn;
@property(nonatomic,strong)UILabel *drogLabel;
@property(nonatomic,strong)UILabel *pickLabel;
@property(nonatomic,strong)UILabel *myBottleLabel;
@property(nonatomic,strong)UIImageView *whImgView;   //浪花
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
    [self.view addSubview:self.menuImgView];
    [self.view addSubview:self.drogBtn];
    [self.view addSubview:self.pickBtn];
    [self.view addSubview:self.myBottleBtn];
    [self.view addSubview:self.drogLabel];
    [self.view addSubview:self.pickLabel];
    [self.view addSubview:self.myBottleLabel];
    [self.view addSubview:self.whImgView];
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
    
    [self.whImgView startAnimating];
    [self.whImgView performSelector:@selector(stopAnimating) withObject:nil afterDelay:1];
}

//触摸事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{

}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    touchState=!touchState;
    [self setTouchHiddenNav:touchState];
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{

}

-(UIImageView *)bgImgView{
    if (!_bgImgView) {
        _bgImgView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, screen_height)];
        _bgImgView.image=[UIImage imageNamed:@"bottle_bg"];
    }
    
    return _bgImgView;
}

-(UIImageView *)menuImgView{
    if (!_menuImgView) {
        _menuImgView=[[UIImageView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-44.5, SCREEN_WIDTH, 44.5)];
        _menuImgView.image=[UIImage imageNamed:@"bottle_vg"];
    }
    
    return _menuImgView;
}


-(UIButton *)drogBtn{
    if (!_drogBtn) {
        _drogBtn=[[UIButton alloc] initWithFrame:CGRectMake(20*SCREEN_RADIO, screen_height-93*SCREEN_RADIO, 73*SCREEN_RADIO, 88*SCREEN_RADIO)];
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
        _pickBtn=[[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-44*SCREEN_RADIO, screen_height-93*SCREEN_RADIO, 73*SCREEN_RADIO, 88*SCREEN_RADIO)];
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
        _myBottleBtn=[[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-(20+73)*SCREEN_RADIO, screen_height-93*SCREEN_RADIO, 73*SCREEN_RADIO, 88*SCREEN_RADIO)];
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


@end
