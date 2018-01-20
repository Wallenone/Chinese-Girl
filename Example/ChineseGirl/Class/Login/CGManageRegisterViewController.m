//
//  CGManageRegisterViewController.m
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/11/28.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGManageRegisterViewController.h"
#import "CGNewSignInViewController.h"
#import "CGNewIndexViewController.h"
@interface CGManageRegisterViewController ()
@property(nonatomic,strong)UIImageView *headerImgView;
@property(nonatomic,strong)RkyExtendedHitButton *leftIcon;
@property(nonatomic,strong)RkyExtendedHitButton *RegisterNext;
@property(nonatomic,strong)RkyExtendedHitButton *loginGo;
@end

@implementation CGManageRegisterViewController
- (void)viewWillAppear:(BOOL)animated{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.headerImgView];
    [self.view addSubview:self.leftIcon];
    [self.view addSubview:self.RegisterNext];
    [self.view addSubview:self.loginGo];
}

-(void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)LoginClick{
    CGNewSignInViewController *loginVC=[[CGNewSignInViewController alloc] init];
    [self.navigationController pushViewController:loginVC animated:NO];
}

-(void)registerClick{
    CGNewIndexViewController *registerVC=[[CGNewIndexViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:NO];
}

-(UIImageView *)headerImgView{
    if(!_headerImgView){
        _headerImgView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
        _headerImgView.image=[UIImage imageNamed:@"Splash Screen"];
    }
    
    return _headerImgView;
}

-(RkyExtendedHitButton *)leftIcon{
    if (!_leftIcon) {
        _leftIcon=[[RkyExtendedHitButton alloc] initWithFrame:CGRectMake(23*SCREEN_RADIO, 30*SCREEN_RADIO, 12*SCREEN_RADIO, 18*SCREEN_RADIO)];
        [_leftIcon setImage:[UIImage imageNamed:@"Fillback"] forState:UIControlStateNormal];
        [_leftIcon addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        _leftIcon.hitTestEdgeInsets = UIEdgeInsetsMake(-25, -25, -25, -25);
    }
    return _leftIcon;
}

-(RkyExtendedHitButton *)RegisterNext{
    if(!_RegisterNext){
        _RegisterNext=[[RkyExtendedHitButton alloc] initWithFrame:CGRectMake(15*SCREEN_RADIO, screen_height-150*SCREEN_RADIO, screen_width-30*SCREEN_RADIO, 40*SCREEN_RADIO)];
        _RegisterNext.layer.cornerRadius=20*SCREEN_RADIO;
        [_RegisterNext setTitle:NSLocalizedString(@"quzhuce", nil) forState:UIControlStateNormal];
        [_RegisterNext setTitleColor:[UIColor getColor:@"ffffff"] forState:UIControlStateNormal];
        [_RegisterNext setBackgroundColor:[UIColor getColor:@"3462ff"]];
        _RegisterNext.titleLabel.font=[UIFont systemFontOfSize:18*SCREEN_RADIO];
        [_RegisterNext addTarget:self action:@selector(registerClick) forControlEvents:UIControlEventTouchUpInside];
        _RegisterNext.hitTestEdgeInsets = UIEdgeInsetsMake(-25, -25, -25, -25);
    }
    
    return _RegisterNext;
}


-(RkyExtendedHitButton *)loginGo{
    if(!_loginGo){
        _loginGo=[[RkyExtendedHitButton alloc] initWithFrame:CGRectMake(15*SCREEN_RADIO, CGRectGetMaxY(self.RegisterNext.frame)+15*SCREEN_RADIO, screen_width-30*SCREEN_RADIO, 40*SCREEN_RADIO)];
        _loginGo.layer.cornerRadius=20*SCREEN_RADIO;
        [_loginGo setTitle:NSLocalizedString(@"qudenglu", nil) forState:UIControlStateNormal];
        [_loginGo setTitleColor:[UIColor getColor:@"ffffff"] forState:UIControlStateNormal];
        _loginGo.titleLabel.font=[UIFont systemFontOfSize:18*SCREEN_RADIO];
        [_loginGo addTarget:self action:@selector(LoginClick) forControlEvents:UIControlEventTouchUpInside];
        _loginGo.hitTestEdgeInsets = UIEdgeInsetsMake(-25, -25, -25, -25);
        _loginGo.backgroundColor=[UIColor clearColor];
    }
    
    return _loginGo;
}
@end
