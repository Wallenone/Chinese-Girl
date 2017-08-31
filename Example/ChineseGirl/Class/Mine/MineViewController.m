//
//  MineViewController.m
//  ChineseGirl
//
//  Created by wallen on 2017/8/8.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "MineViewController.h"
#import "CGLoginViewController.h"
@interface MineViewController ()

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 30)];
    [btn setTitle:@"登录" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}


-(void)click{
    CGLoginViewController *loginVC=[[CGLoginViewController alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];
}

@end
