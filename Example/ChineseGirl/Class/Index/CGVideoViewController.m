//
//  CGVideoViewController.m
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/11/21.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGVideoViewController.h"
#import "XLVideoPlayer.h"
#import <AVFoundation/AVFoundation.h>
@interface CGVideoViewController ()
@property(nonatomic,strong)XLVideoPlayer *player;
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
    [self.view addSubview:self.close];
    [self showVideoPlayer];
}

-(void)closeClick{
    [_player destroyPlayer];
    _player = nil;
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)showVideoPlayer{
    [_player destroyPlayer];
    _player = nil;
  
    _player = [[XLVideoPlayer alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.close.frame)+15*SCREEN_RADIO, screen_width, 284*SCREEN_RADIO) withVideoPauseBlock:^{
        
    } withPlayBlock:^{
        
    }];
    _player.videoUrl = self.videoStr;
    
    [self.view addSubview:_player];
    
    _player.completedPlayingBlock = ^(XLVideoPlayer *player) {
        [player destroyPlayer];
        _player = nil;
    };
    
}

-(UIButton *)close{
    if (!_close) {
        _close=[[UIButton alloc] initWithFrame:CGRectMake(10*SCREEN_RADIO, 30*SCREEN_RADIO, 12*SCREEN_RADIO, 18*SCREEN_RADIO)];
        [_close setImage:[UIImage imageNamed:@"Fillback"] forState:UIControlStateNormal];
        [_close addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _close;
}

@end
