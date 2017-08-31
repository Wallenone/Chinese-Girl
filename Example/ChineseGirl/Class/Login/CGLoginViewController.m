//
//  CGLoginViewController.m
//  ChineseGirl
//
//  Created by wallen on 2017/8/31.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGLoginViewController.h"
#import "CGLoginIndexView.h"
@interface CGLoginViewController ()
@property(nonatomic,strong)CGLoginIndexView *loginIndexView;
@end

@implementation CGLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubViews];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [self.tabBarController.tabBar setHidden:NO];
}


-(void)addSubViews{
    [self.view addSubview:self.loginIndexView];
}

-(CGLoginIndexView *)loginIndexView{
    __weak typeof(self) weakSelf = self;
    if (!_loginIndexView) {
        _loginIndexView=[[CGLoginIndexView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height) onSingUpClick:^{
            
        } onForgotPasswordClick:^{
            
        } onSignInClick:^{
            
        } onGooleClick:^{
            
        } onFacebookClick:^{
            
        } onwitterClick:^{
            
        }];
    }
    
    return _loginIndexView;
}

@end
