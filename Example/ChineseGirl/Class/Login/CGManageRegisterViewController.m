//
//  CGManageRegisterViewController.m
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/11/28.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGManageRegisterViewController.h"
#import "CGNewSignInViewController.h"
@interface CGManageRegisterViewController ()
@property(nonatomic,strong)UIImageView *headerImgView;
@property(nonatomic,strong)UIButton *leftIcon;
@property(nonatomic,strong)UIButton *loginGo;
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
    [self.view addSubview:self.loginGo];
}

-(void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)LoginClick{
    CGNewSignInViewController *loginVC=[[CGNewSignInViewController alloc] init];
    [self.navigationController pushViewController:loginVC animated:NO];
}

-(UIImageView *)headerImgView{
    if(!_headerImgView){
        _headerImgView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
        _headerImgView.image=[UIImage imageNamed:@"forget_Bitmap"];
    }
    
    return _headerImgView;
}

-(UIButton *)leftIcon{
    if (!_leftIcon) {
        _leftIcon=[[UIButton alloc] initWithFrame:CGRectMake(23*SCREEN_RADIO, 37*SCREEN_RADIO, 10*SCREEN_RADIO, 19*SCREEN_RADIO)];
        [_leftIcon setImage:[UIImage imageNamed:@"BlackArrowleft"] forState:UIControlStateNormal];
        [_leftIcon addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftIcon;
}

-(UIButton *)loginGo{
    if(!_loginGo){
        _loginGo=[[UIButton alloc] initWithFrame:CGRectMake(0, screen_height-28*SCREEN_RADIO, screen_width-15*SCREEN_RADIO, 18*SCREEN_RADIO)];
        [_loginGo setTitle:@"去登录 >" forState:UIControlStateNormal];
        [_loginGo setTitleColor:[UIColor getColor:@"157CF8"] forState:UIControlStateNormal];
        _loginGo.titleLabel.font=[UIFont systemFontOfSize:18*SCREEN_RADIO];
        [_loginGo addTarget:self action:@selector(LoginClick) forControlEvents:UIControlEventTouchUpInside];
        _loginGo.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    
    return _loginGo;
}
@end