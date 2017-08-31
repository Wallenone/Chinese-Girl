//
//  CGRegisterIndexViewController.m
//  ChineseGirl
//
//  Created by Wallen on 2017/8/31.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGRegisterIndexViewController.h"
#import "CGRegisterIndexView.h"
@interface CGRegisterIndexViewController ()
@property(nonatomic,strong)CGRegisterIndexView *registerIndexView;
@end

@implementation CGRegisterIndexViewController

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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubViews];
}

-(void)addSubViews{
    [self.view addSubview:self.registerIndexView];
}

-(CGRegisterIndexView *)registerIndexView{
    if (!_registerIndexView) {
        __weak typeof(self) weakSelf = self;
        _registerIndexView=[[CGRegisterIndexView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height) onCancelClick:^{
            [weakSelf.navigationController popViewControllerAnimated:NO];
        } onSingUpClick:^{
            [weakSelf.navigationController popViewControllerAnimated:NO];
        }];
    }
    
    return _registerIndexView;
}

@end
