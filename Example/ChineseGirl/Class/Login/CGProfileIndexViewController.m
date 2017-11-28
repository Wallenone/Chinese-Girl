//
//  CGProfileIndexViewController.m
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/11/28.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGProfileIndexViewController.h"

@interface CGProfileIndexViewController ()
@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)UIImageView *headerImgView;
@property(nonatomic,strong)UIButton *rightBtn;
@property(nonatomic,strong)UIButton *avaterBtn;
@property(nonatomic,strong)UILabel *nickName;
@property(nonatomic,strong)UILabel *address;
@property(nonatomic,strong)UIView *menuView;
@property(nonatomic,strong)UIView *topLineView;
@property(nonatomic,strong)UIButton *following;
@property(nonatomic,strong)UIButton *like;
@property(nonatomic,strong)UIView *bottomLineView;
@end

@implementation CGProfileIndexViewController

- (void)viewWillAppear:(BOOL)animated{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:NO];
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
    [self.view addSubview:self.menuView];
    [self.menuView addSubview:self.topLineView];
    [self.menuView addSubview:self.following];
    [self.menuView addSubview:self.like];
    [self.menuView addSubview:self.bottomLineView];
}

-(void)editClick{
    
}

-(void)followClick:(UIButton *)sender{
    if (!CGColorEqualToColor(sender.currentTitleColor.CGColor, [UIColor getColor:@"157CF8"].CGColor)) {
        [sender setTitleColor:[UIColor getColor:@"157CF8"] forState:UIControlStateNormal];
        [self.like setTitleColor:[UIColor getColor:@"111111"] forState:UIControlStateNormal];
    }
}

-(void)likeClick:(UIButton *)sender{
    if (!CGColorEqualToColor(sender.currentTitleColor.CGColor, [UIColor getColor:@"157CF8"].CGColor)) {
        [sender setTitleColor:[UIColor getColor:@"157CF8"] forState:UIControlStateNormal];
        [self.following setTitleColor:[UIColor getColor:@"111111"] forState:UIControlStateNormal];
    }
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
        [_avaterBtn addTarget:self action:@selector(editClick) forControlEvents:UIControlEventTouchUpInside];
        [_avaterBtn setImage:[UIImage imageNamed:@"default_hd_avatar"] forState:UIControlStateNormal];
        _avaterBtn.layer.cornerRadius=55*SCREEN_RADIO;
        _avaterBtn.clipsToBounds=YES;
        _avaterBtn.backgroundColor=[UIColor getColor:@"F6F6F6"];
    }
    
    return _avaterBtn;
}

-(UILabel *)nickName{
    if (!_nickName) {
        _nickName=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.avaterBtn.frame)+12*SCREEN_RADIO, screen_width, 18*SCREEN_RADIO)];
        _nickName.text=@"NickName";
        _nickName.textColor=[UIColor getColor:@"111111"];
        _nickName.font=[UIFont systemFontOfSize:18*SCREEN_RADIO];
        _nickName.textAlignment=NSTextAlignmentCenter;
    }
    
    return _nickName;
}

-(UILabel *)address{
    if (!_address) {
        _address=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.nickName.frame)+8*SCREEN_RADIO, screen_width, 12*SCREEN_RADIO)];
        _address.text=@"China.BeiJing";
        _address.textColor=[UIColor getColor:@"111111"];
        _address.font=[UIFont systemFontOfSize:12*SCREEN_RADIO];
        _address.textAlignment=NSTextAlignmentCenter;
    }
    
    return _address;
}

-(UIView *)menuView{
    if (!_menuView) {
        _menuView=[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.address.frame)+16*SCREEN_RADIO, screen_width, 53*SCREEN_RADIO)];
    }
    
    return _menuView;
}

-(UIView *)topLineView{
    if (!_topLineView) {
        _topLineView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 0.5)];
        _topLineView.backgroundColor=[UIColor getColor:@"111111"];
    }
    
    return _topLineView;
}

-(UIButton *)following{
    if (!_following) {
        _following=[[UIButton alloc] initWithFrame:CGRectMake(0, 26.5*SCREEN_RADIO-7*SCREEN_RADIO, screen_width/2, 14*SCREEN_RADIO)];
        [_following setTitle:@"Following" forState:UIControlStateNormal];
        [_following setTitleColor:[UIColor getColor:@"157CF8"] forState:UIControlStateNormal];
        _following.titleLabel.font=[UIFont systemFontOfSize:14*SCREEN_RADIO];
        [_following addTarget:self action:@selector(followClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _following;
}

-(UIButton *)like{
    if (!_like) {
        _like=[[UIButton alloc] initWithFrame:CGRectMake(screen_width/2, 26.5*SCREEN_RADIO-7*SCREEN_RADIO, screen_width/2, 14*SCREEN_RADIO)];
        [_like setTitle:@"Likes" forState:UIControlStateNormal];
        [_like setTitleColor:[UIColor getColor:@"111111"] forState:UIControlStateNormal];
        _like.titleLabel.font=[UIFont systemFontOfSize:14*SCREEN_RADIO];
        [_like addTarget:self action:@selector(likeClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _like;
}

-(UIView *)bottomLineView{
    if (!_bottomLineView) {
        _bottomLineView=[[UIView alloc] initWithFrame:CGRectMake(0, 53*SCREEN_RADIO-0.5, screen_width, 0.5)];
        _bottomLineView.backgroundColor=[UIColor getColor:@"111111"];
    }
    
    return _bottomLineView;
}
@end
