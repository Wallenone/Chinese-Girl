//
//  CGMailListViewController.m
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/11/30.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGMailListViewController.h"
#import "CGFavoriteView.h"
#import "MyIndexViewController.h"
@interface CGMailListViewController ()
@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIButton *leftBtn;
@property(nonatomic,strong)CGFavoriteView *favoriteView;
@end

@implementation CGMailListViewController

- (void)viewWillAppear:(BOOL)animated{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.headerView];
    [self.headerView addSubview:self.titleLabel];
    [self.headerView addSubview:self.leftBtn];
    [self.view addSubview:self.favoriteView];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:NO];
}

-(UIView *)headerView{
    if (!_headerView) {
        _headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 64*SCREEN_RADIO)];
        _headerView.backgroundColor=[UIColor getColor:@"ffffff"];
    }
    
    return _headerView;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 28.5*SCREEN_RADIO, screen_width, 24*SCREEN_RADIO)];
        _titleLabel.text=NSLocalizedString(@"my_favorite", nil);
        _titleLabel.textColor=[UIColor getColor:@"111111"];
        _titleLabel.font=[UIFont systemFontOfSize:18*SCREEN_RADIO];
        _titleLabel.textAlignment=NSTextAlignmentCenter;
    }
    return _titleLabel;
}

-(UIButton *)leftBtn{
    if (!_leftBtn) {
        _leftBtn=[[UIButton alloc] initWithFrame:CGRectMake(20*SCREEN_RADIO, 33*SCREEN_RADIO, 10.5*SCREEN_RADIO, 17.5*SCREEN_RADIO)];
        [_leftBtn setImage:[UIImage imageNamed:@"BlackArrowleft"] forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _leftBtn;
}

-(CGFavoriteView *)favoriteView{
    if (!_favoriteView) {
        __weak typeof(self) weakSelf = self;
        _favoriteView=[[CGFavoriteView alloc] initWithFrame:CGRectMake(0, 64*SCREEN_RADIO, screen_width, screen_height-64*SCREEN_RADIO) withCellBlock:^(NSInteger ids) {
            MyIndexViewController *indexVC=[[MyIndexViewController alloc] init];
            indexVC.ids=ids;
            [weakSelf.navigationController pushViewController:indexVC animated:NO];
        } withType:YES];
    }
    
    return _favoriteView;
}
@end
