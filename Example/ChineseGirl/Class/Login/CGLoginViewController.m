//
//  CGLoginViewController.m
//  ChineseGirl
//
//  Created by wallen on 2017/8/31.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGLoginViewController.h"
#import "CGLoginIndexView.h"
#import "CGRegisterIndexView.h"
#import "CGRegisterIndexViewController.h"
#import "CGForgetPasswordViewController.h"
#import "MineViewController.h"
#import "CGSingleCommitData.h"
@interface CGLoginViewController ()
@property(nonatomic,strong)CGLoginIndexView *loginIndexView;
@end

@implementation CGLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView)];
    [self.view addGestureRecognizer:tap];
 
    [self addSubViews];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    self.navigationItem.hidesBackButton = YES;
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [self.tabBarController.tabBar setHidden:NO];
}

-(void)tapView{
    [self checkRespons];
}

-(void)checkRespons{
    [self.loginIndexView checkRespons];
}



-(void)addSubViews{
    [self.view addSubview:self.loginIndexView];
}

-(CGLoginIndexView *)loginIndexView{
    __weak typeof(self) weakSelf = self;
    if (!_loginIndexView) {
        _loginIndexView=[[CGLoginIndexView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height) onSingUpClick:^{
            CGRegisterIndexViewController *regVC=[[CGRegisterIndexViewController alloc]init];
            [weakSelf.navigationController pushViewController:regVC animated:NO];
        } onForgotPasswordClick:^{
            CGForgetPasswordViewController *forgetVC=[[CGForgetPasswordViewController alloc] init];
            [weakSelf.navigationController pushViewController:forgetVC animated:NO];
        } onSignInClick:^(BOOL state,NSString *warningText){
            if (state) {
                [SVProgressHUD showSuccessWithStatus:warningText];
                [weakSelf dismissViewControllerAnimated:NO completion:nil];
            }else{
                [SVProgressHUD showErrorWithStatus:warningText];
            }

        }onCanCelClick:^{
            [weakSelf dismissViewControllerAnimated:NO completion:nil];
            weakSelf.tabBarController.selectedIndex=0;
        }];
    }
    
    return _loginIndexView;
}




@end
