//
//  CGVideoViewController.m
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/11/21.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGVideoViewController.h"
#import "ZFPlayer.h"
#import "MyIndexViewController.h"
@interface CGVideoViewController ()
@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)UIImageView *headerIconView;
@property(nonatomic,strong)UILabel *nickName;
@property(nonatomic,strong)UILabel *numLook;
@property(nonatomic,strong)UIButton *closeBtn;
@property(nonatomic,strong)UIButton *menuBtn1;
@property(nonatomic,strong)UIButton *menuBtn2;
@property(nonatomic,strong)UIButton *menuBtn3;
@property(nonatomic,strong)ZFPlayerView *playerView;
@end

@implementation CGVideoViewController
-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor blackColor];
    [self showVideoPlayer];
    [self addSubViews];
}

-(void)tapAction{
    
    MyIndexViewController *indexVC=[[MyIndexViewController alloc] init];
    indexVC.ids=[self.userInfo.ids integerValue];
    
}


-(void)closeClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)menuClick1{
    
}

-(void)menuClick2{
    
}

-(void)menuClick3{
    
}

-(void)videoAddClick{
    
}

-(void)addSubViews{
    [self.view addSubview:self.headerView];
    [self.headerView addSubview:self.headerIconView];
    [self.headerView addSubview:self.nickName];
    [self.headerView addSubview:self.numLook];
    
    [self.view addSubview:self.closeBtn];
    [self.view addSubview:self.menuBtn1];
    [self.view addSubview:self.menuBtn2];
    [self.view addSubview:self.menuBtn3];

}

- (void)showVideoPlayer{
    self.playerView = [[ZFPlayerView alloc] init];
    [self.view addSubview:self.playerView];
    [self.playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.left.right.equalTo(self.view);
        // Here a 16:9 aspect ratio, can customize the video aspect ratio
        make.height.equalTo(self.playerView.mas_width).multipliedBy(9.0f/16.0f);
    }];
    ZFPlayerControlView *controlView = [[ZFPlayerControlView alloc] init];
    // model
    ZFPlayerModel *playerModel = [[ZFPlayerModel alloc] init];
    playerModel.fatherView=self.view;
    playerModel.videoURL = [NSURL URLWithString:@"https://raw.githubusercontent.com/Wallenone/service/master/test.mp4"];
    [self.playerView playerControlView:controlView playerModel:playerModel];
    // delegate
    self.playerView.delegate = self;
    [self.playerView.screenImgView sd_setImageWithURL:[NSURL URLWithString:self.videoIcon]];
    self.playerView.playerLayerGravity=ZFPlayerLayerGravityResize;
    [self.playerView autoPlayTheVideo];
    
}


-(UIView *)headerView{
    if (!_headerView) {
        _headerView=[[UIView alloc] initWithFrame:CGRectMake(6*SCREEN_RADIO, 20*SCREEN_RADIO, 130*SCREEN_RADIO, 35*SCREEN_RADIO)];
        _headerView.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        _headerView.layer.cornerRadius=17.5*SCREEN_RADIO;
        UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
        [_headerView addGestureRecognizer:tapGesturRecognizer];
    }
    
    return _headerView;
}


-(UIImageView *)headerIconView{
    if (!_headerIconView) {
        _headerIconView=[[UIImageView alloc] initWithFrame:CGRectMake(2*SCREEN_RADIO, 2*SCREEN_RADIO, 31*SCREEN_RADIO, 31*SCREEN_RADIO)];
        [_headerIconView sd_setImageWithURL:[NSURL URLWithString:self.userInfo.avater]];
        _headerIconView.layer.cornerRadius=31/2*SCREEN_RADIO;
        _headerIconView.clipsToBounds=YES;
    }
    
    return _headerIconView;
}

-(UILabel *)nickName{
    if (!_nickName) {
        _nickName=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headerIconView.frame)+5*SCREEN_RADIO, 4*SCREEN_RADIO, 70*SCREEN_RADIO, 12*SCREEN_RADIO)];
        _nickName.font=[UIFont systemFontOfSize:12*SCREEN_RADIO];
        _nickName.textColor=[UIColor getColor:@"ffffff"];
        _nickName.text=self.userInfo.nickname;
    }
    
    return _nickName;
}

-(UILabel *)numLook{    
    if (!_numLook) {
        _numLook=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headerIconView.frame)+5*SCREEN_RADIO, CGRectGetMaxY(self.nickName.frame)+3*SCREEN_RADIO, 70*SCREEN_RADIO, 8*SCREEN_RADIO)];
        _numLook.text=@"3532 观看人数";
        _numLook.textColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.85];
        _numLook.font=[UIFont systemFontOfSize:8*SCREEN_RADIO];
    }
    
    return _numLook;
}

-(UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn=[[UIButton alloc] initWithFrame:CGRectMake(screen_width-30*SCREEN_RADIO, 30*SCREEN_RADIO, 14*SCREEN_RADIO, 14*SCREEN_RADIO)];
        [_closeBtn setImage:[UIImage imageNamed:@"closeShape"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _closeBtn;
}

-(UIButton *)menuBtn1{
    if (!_menuBtn1) {
        _menuBtn1=[[UIButton alloc] initWithFrame:CGRectMake(screen_width-22*SCREEN_RADIO, screen_height/2, 17*SCREEN_RADIO, 21*SCREEN_RADIO)];
        [_menuBtn1 setImage:[UIImage imageNamed:@"播放"] forState:UIControlStateNormal];
        [_menuBtn1 addTarget:self action:@selector(menuClick1) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _menuBtn1;
}

-(UIButton *)menuBtn2{
    if (!_menuBtn2) {
        _menuBtn2=[[UIButton alloc] initWithFrame:CGRectMake(screen_width-22*SCREEN_RADIO, CGRectGetMaxY(self.menuBtn1.frame)+25*SCREEN_RADIO, 17*SCREEN_RADIO, 21*SCREEN_RADIO)];
        [_menuBtn2 setImage:[UIImage imageNamed:@"播放"] forState:UIControlStateNormal];
        [_menuBtn2 addTarget:self action:@selector(menuClick2) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _menuBtn2;
}

-(UIButton *)menuBtn3{
    if (!_menuBtn3) {
        _menuBtn3=[[UIButton alloc] initWithFrame:CGRectMake(screen_width-22*SCREEN_RADIO, CGRectGetMaxY(self.menuBtn2.frame)+25*SCREEN_RADIO, 17*SCREEN_RADIO, 21*SCREEN_RADIO)];
        [_menuBtn3 setImage:[UIImage imageNamed:@"播放"] forState:UIControlStateNormal];
        [_menuBtn3 addTarget:self action:@selector(menuClick3) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _menuBtn3;
}

@end
