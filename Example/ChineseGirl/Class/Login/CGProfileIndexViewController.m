//
//  CGProfileIndexViewController.m
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/11/28.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGProfileIndexViewController.h"
#import "CGEditProfileViewController.h"
#import "CGFavoriteView.h"
#import "MyIndexViewController.h"
#import "UICustomPickImgView.h"
@interface CGProfileIndexViewController ()
@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)UIImageView *headerImgView;
@property(nonatomic,strong)UIButton *rightBtn;
@property(nonatomic,strong)UIButton *avaterBtn;
@property(nonatomic,strong)UILabel *nickName;
@property(nonatomic,strong)UILabel *address;
@property(nonatomic,strong)CGFavoriteView *favoriteView;
@end

@implementation CGProfileIndexViewController

- (void)viewWillAppear:(BOOL)animated{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:NO];
    [self setData];
}

-(void)setData{
    if([CGSingleCommitData sharedInstance].uid.length>0){
        [self.favoriteView updateTable];
        [self.avaterBtn setImage:[CGSingleCommitData sharedInstance].avatar forState:UIControlStateNormal];
        self.nickName.text=[CGSingleCommitData sharedInstance].nickName;
        NSString *_text=@"";
        if ([CGSingleCommitData sharedInstance].cityName.length>0 && [CGSingleCommitData sharedInstance].countryName.length>0) {
            _text=[NSString stringWithFormat:@"%@.%@",[CGSingleCommitData sharedInstance].countryName,[CGSingleCommitData sharedInstance].cityName];
        }else if ([CGSingleCommitData sharedInstance].countryName.length>0){
            _text=[CGSingleCommitData sharedInstance].countryName;
        }
        self.address.text=_text;
    }else{
        [self.tabBarController setSelectedIndex:0];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.headerImgView];
    [self.view addSubview:self.rightBtn];
    [self.view addSubview:self.avaterBtn];
    [self.view addSubview:self.nickName];
    [self.view addSubview:self.address];
    [self.view addSubview:self.favoriteView];
}

-(void)editClick{
    CGEditProfileViewController *editProfileVC=[[CGEditProfileViewController alloc] init];
    [self.navigationController pushViewController:editProfileVC animated:NO];
}

-(void)chooseImg{
    __weak typeof(self) weakSelf = self;
    UICustomPickImgView *customVC=[[UICustomPickImgView alloc] init];
    [customVC onGetImg:^(UIImage *ava) {
        [weakSelf.avaterBtn setImage:ava forState:UIControlStateNormal];
        [CGSingleCommitData sharedInstance].avatar=ava;
    }];
    [self.view addSubview:customVC];
    
}

-(UIView *)headerView{
    if (!_headerView) {
        _headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 138*SCREEN_RADIO)];
        _headerView.backgroundColor=[UIColor getColor:@"111111"];
    }
    
    return _headerView;
}

-(UIImageView *)headerImgView{
    if (!_headerImgView) {
        _headerImgView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 138*SCREEN_RADIO)];
        _headerImgView.image=[UIImage imageNamed:@"profileHeader"];
    }
    
    return _headerImgView;
}

-(UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 30*SCREEN_RADIO, screen_width-15*SCREEN_RADIO, 16*SCREEN_RADIO)];
        [_rightBtn setTitle:@"Edit" forState:UIControlStateNormal];
        [_rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(editClick) forControlEvents:UIControlEventTouchUpInside];
        _rightBtn.titleLabel.font=[UIFont systemFontOfSize:16*SCREEN_RADIO];
        _rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    
    return _rightBtn;
}

-(UIButton *)avaterBtn{
    if (!_avaterBtn) {
        _avaterBtn=[[UIButton alloc] initWithFrame:CGRectMake(screen_width/2-55*SCREEN_RADIO, 82*SCREEN_RADIO, 110*SCREEN_RADIO, 110*SCREEN_RADIO)];
        [_avaterBtn addTarget:self action:@selector(chooseImg) forControlEvents:UIControlEventTouchUpInside];
        [_avaterBtn setImage:[CGSingleCommitData sharedInstance].avatar forState:UIControlStateNormal];
        _avaterBtn.layer.cornerRadius=55*SCREEN_RADIO;
        _avaterBtn.clipsToBounds=YES;
        _avaterBtn.backgroundColor=[UIColor getColor:@"F6F6F6"];
    }
    
    return _avaterBtn;
}

-(UILabel *)nickName{
    if (!_nickName) {
        _nickName=[[UILabel alloc] initWithFrame:CGRectMake(0, 32*SCREEN_RADIO, screen_width, 18*SCREEN_RADIO)];
        _nickName.text=[CGSingleCommitData sharedInstance].nickName;
        _nickName.textColor=[UIColor getColor:@"ffffff"];
        _nickName.font=[UIFont systemFontOfSize:18*SCREEN_RADIO];
        _nickName.textAlignment=NSTextAlignmentCenter;
    }
    
    return _nickName;
}

-(UILabel *)address{
    if (!_address) {
        _address=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.nickName.frame)+8*SCREEN_RADIO, screen_width, 14*SCREEN_RADIO)];
        NSString *_text=@"";
        if ([CGSingleCommitData sharedInstance].cityName.length>0 && [CGSingleCommitData sharedInstance].countryName.length>0) {
            _text=[NSString stringWithFormat:@"%@.%@",[CGSingleCommitData sharedInstance].countryName,[CGSingleCommitData sharedInstance].cityName];
        }else if ([CGSingleCommitData sharedInstance].countryName.length>0){
            _text=[CGSingleCommitData sharedInstance].countryName;
        }
        _address.text=_text;
        _address.textColor=[UIColor getColor:@"ffffff"];
        _address.font=[UIFont systemFontOfSize:12*SCREEN_RADIO];
        _address.textAlignment=NSTextAlignmentCenter;
    }
    
    return _address;
}

-(CGFavoriteView *)favoriteView{
    if (!_favoriteView) {
        __weak typeof(self) weakSelf = self;
        _favoriteView=[[CGFavoriteView alloc] initWithFrame:CGRectMake(0, 205*SCREEN_RADIO, screen_width, screen_height-CGRectGetMaxY(self.address.frame)+10*SCREEN_RADIO) withCellBlock:^(NSInteger ids) {
            MyIndexViewController *indexVC=[[MyIndexViewController alloc] init];
            indexVC.ids=ids;
            [weakSelf.navigationController pushViewController:indexVC animated:NO];
        } withType:NO];
    }
    
    return _favoriteView;
}

@end
