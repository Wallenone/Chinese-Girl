//
//  CGVideoViewController.m
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/11/21.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGVideoViewController.h"
#import "ZFPlayer.h"
@interface CGVideoViewController ()<ZFPlayerDelegate>
@property(nonatomic,strong)ZFPlayerView *playerView;
@property(nonatomic,strong)UIButton *close;
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
    playerModel.videoURL = [NSURL URLWithString:self.videoStr];
    [self.playerView playerControlView:controlView playerModel:playerModel];
    // delegate
    self.playerView.delegate = self;
    self.playerView.hasPreviewView=YES;
    self.playerView.playerLayerGravity=ZFPlayerLayerGravityResize;
    [self.playerView autoPlayTheVideo];
    
}

- (void)zf_playerControlViewWillShow:(UIView *)controlView isFullscreen:(BOOL)fullscreen{
    
}


- (void)zf_playerControlViewWillHidden:(UIView *)controlView isFullscreen:(BOOL)fullscreen{
    
}

- (void)zf_playerBackAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
