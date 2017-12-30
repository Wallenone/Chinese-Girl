//
//  CGTopOneTableViewCell.m
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/12/30.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGTopOneTableViewCell.h"
#import "CGUserInfo.h"
#import "CGVipViewController.h"
@interface CGTopOneTableViewCell()
@property(nonatomic,strong)UIImageView *topIcon;
@property(nonatomic,strong)UIImageView *leftImgView;
@property(nonatomic,strong)UIImageView *avaterTopImgView;  //105
@property(nonatomic,strong)UIImageView *avaterImgView;
@property(nonatomic,strong)UIImageView *level_up_background;
@property(nonatomic,strong)UIImageView *rightImgView;
@property(nonatomic,strong)UILabel *nickName;
@property(nonatomic,strong)UILabel *moneyPit;
@property(nonatomic,strong)UIImageView *goldImgView;
@property(nonatomic,strong)UILabel *goldNum;
@property(nonatomic,strong)UIButton *addFriend;
@property(nonatomic,strong)UIView *lineView;
@property(nonatomic,strong)CGMoneyTopModel *cellModel;
@property(nonatomic,assign)NSInteger modeltype;
@end
@implementation CGTopOneTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withModel:(CGMoneyTopModel *)model withType:(NSInteger)type{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        self.cellModel=model;
        self.modeltype=type;
        [self setData];
        [self addSubViews];
    }
    
    return self;
}

-(void)addSubViews{
    [self addSubview:self.topIcon];
    [self addSubview:self.leftImgView];
    [self addSubview:self.level_up_background];
    [self addSubview:self.avaterTopImgView];
    [self addSubview:self.avaterImgView];
    [self addSubview:self.rightImgView];
    [self addSubview:self.nickName];
    [self addSubview:self.moneyPit];
    [self addSubview:self.goldImgView];
    [self addSubview:self.goldNum];
    [self addSubview:self.addFriend];
    [self addSubview:self.lineView];
    
}

-(void)setData{
    if (self.modeltype==1) {
        [self.avaterImgView sd_setImageWithURL:[NSURL URLWithString:self.cellModel.moneyUserInfo.avater] placeholderImage:[UIImage imageNamed:@"bigdefault_icon"]];
        
        [self.nickName setText:self.cellModel.moneyUserInfo.nickname];
        self.goldNum.frame=CGRectMake(CGRectGetMaxX(self.goldImgView.frame)+3*SCREEN_RADIO, CGRectGetMaxY(self.nickName.frame)+9*SCREEN_RADIO, 0, 13*SCREEN_RADIO);
        self.goldNum.text=[NSString stringWithFormat:@"%@K",self.cellModel.moneyNum];
        self.goldNum.textColor=[UIColor getColor:@"f4bb00"];
        
        [self.goldNum sizeToFit];
        self.moneyPit.text=@"送了";
        self.goldImgView.image=[UIImage imageNamed:@"leaderboard_coin"];
        self.goldImgView.frame=CGRectMake(CGRectGetMaxX(self.moneyPit.frame)+2*SCREEN_RADIO, CGRectGetMaxY(self.nickName.frame)+10*SCREEN_RADIO, 12*SCREEN_RADIO, 12*SCREEN_RADIO);
        
    }else{
        [self.avaterImgView sd_setImageWithURL:[NSURL URLWithString:self.cellModel.hotUserInfo.avater] placeholderImage:[UIImage imageNamed:@"bigdefault_icon"]];
        [self.nickName setText:self.cellModel.hotUserInfo.nickname];
        self.goldNum.frame=CGRectMake(CGRectGetMaxX(self.goldImgView.frame)+9*SCREEN_RADIO, CGRectGetMaxY(self.nickName.frame)+9*SCREEN_RADIO, 0, 13*SCREEN_RADIO);
        self.goldNum.text=[NSString stringWithFormat:@"%@",self.cellModel.hotNum];
        self.goldNum.textColor=[UIColor getColor:@"ff43ff"];
        [self.goldNum sizeToFit];
        self.moneyPit.text=@"粉丝";
        self.goldImgView.image=[UIImage imageNamed:@"leaderboard_fans"];
        self.goldImgView.frame=CGRectMake(CGRectGetMaxX(self.moneyPit.frame)+2*SCREEN_RADIO, CGRectGetMaxY(self.nickName.frame)+9*SCREEN_RADIO, 16*SCREEN_RADIO, 16*SCREEN_RADIO);
    }
}

-(void)addClick{
    NSString *userid;
    if (self.modeltype==1) {
        userid=self.cellModel.moneyuserid;
    }else{
        userid=self.cellModel.hotuserid;
    }
    
    if ([CGSingleCommitData sharedInstance].vipLevel.length>0) {
        NSData *data1 = UIImagePNGRepresentation(self.addFriend.currentBackgroundImage);
        NSData *data = UIImagePNGRepresentation([UIImage imageNamed:@"leaderboard_discover_following_top_ico"]);
        if (![data isEqual:data1]) {
            [[CGSingleCommitData sharedInstance] addFriendArr:userid];
            [self.addFriend setBackgroundImage:[UIImage imageNamed:@"leaderboard_discover_following_top_ico"] forState:UIControlStateNormal];
        }
    }else{
        CGVipViewController *vipVC=[[CGVipViewController alloc] init];
        vipVC.definesPresentationContext = YES;
        vipVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        vipVC.view.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        [[CGCommonToolsNode getCurrentVC] presentViewController:vipVC animated:NO completion:nil];
    }
}

-(UIImageView *)topIcon{
    if (!_topIcon) {
        _topIcon=[[UIImageView alloc] initWithFrame:CGRectMake(15*SCREEN_RADIO, 100*SCREEN_RADIO, 28*SCREEN_RADIO, 38*SCREEN_RADIO)];
        _topIcon.image=[UIImage imageNamed:@"leaderboard_medal_1"];
    }
    
    return _topIcon;
}

-(UIImageView *)leftImgView{
    if (!_leftImgView) {
        _leftImgView=[[UIImageView alloc] initWithFrame:CGRectMake(screen_width/2-52.5*SCREEN_RADIO-54*SCREEN_RADIO, 63*SCREEN_RADIO, 44*SCREEN_RADIO, 106*SCREEN_RADIO)];
        _leftImgView.image=[UIImage imageNamed:@"leaderboard_cbackground_left"];
    }
    
    return _leftImgView;
}

-(UIImageView *)avaterTopImgView{
    if (!_avaterTopImgView) {
        _avaterTopImgView=[[UIImageView alloc] initWithFrame:CGRectMake(screen_width/2-22*SCREEN_RADIO, 46*SCREEN_RADIO, 44*SCREEN_RADIO, 23*SCREEN_RADIO)];
        _avaterTopImgView.image=[UIImage imageNamed:@"leaderboard_crown"];
    }
    
    return _avaterTopImgView;
}

-(UIImageView *)avaterImgView{
    if (!_avaterImgView) {
        _avaterImgView=[[UIImageView alloc] initWithFrame:CGRectMake(screen_width/2-52.5*SCREEN_RADIO, CGRectGetMaxY(self.avaterTopImgView.frame)-2, 105*SCREEN_RADIO, 105*SCREEN_RADIO)];
        _avaterImgView.layer.cornerRadius=52.5*SCREEN_RADIO;
        _avaterImgView.layer.borderWidth=1;
        _avaterImgView.layer.borderColor=[UIColor getColor:@"ffc142"].CGColor;
        _avaterImgView.clipsToBounds=YES;
    }
    
    return _avaterImgView;
}

-(UIImageView *)level_up_background{
    if (!_level_up_background) {
        _level_up_background=[[UIImageView alloc] initWithFrame:CGRectMake(screen_width/2-85*SCREEN_RADIO, 25*SCREEN_RADIO, 170*SCREEN_RADIO, 170*SCREEN_RADIO)];
        _level_up_background.image=[UIImage imageNamed:@"level_up_background"];
    }
    
    return _level_up_background;
}


-(UIImageView *)rightImgView{
    if (!_rightImgView) {
        _rightImgView=[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.avaterImgView.frame)+10*SCREEN_RADIO, 63*SCREEN_RADIO, 67*SCREEN_RADIO, 93*SCREEN_RADIO)];
        _rightImgView.image=[UIImage imageNamed:@"leaderboard_cbackground_right"];
    }
    
    return _rightImgView;
}

-(UILabel *)nickName{
    if (!_nickName) {
        _nickName=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.avaterImgView.frame)+25*SCREEN_RADIO, screen_width, 16*SCREEN_RADIO)];
        [_nickName setTextColor:[UIColor getColor:@"ffffff"]];
        _nickName.textAlignment=NSTextAlignmentCenter;
        _nickName.font=[UIFont systemFontOfSize:16*SCREEN_RADIO];
    }
    
    return _nickName;
}

-(UILabel *)moneyPit{
    if (!_moneyPit) {
        _moneyPit=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.nickName.frame)+10*SCREEN_RADIO, screen_width/2-8*SCREEN_RADIO, 13*SCREEN_RADIO)];
        _moneyPit.textColor=[UIColor getColor:@"a99dc3"];
        _moneyPit.font=[UIFont systemFontOfSize:13*SCREEN_RADIO];
        _moneyPit.textAlignment=NSTextAlignmentRight;
    }
    
    return _moneyPit;
}

-(UIImageView *)goldImgView{
    if (!_goldImgView) {
        _goldImgView=[[UIImageView alloc] initWithFrame:CGRectMake(screen_width/2-6*SCREEN_RADIO, CGRectGetMaxY(self.nickName.frame)+10*SCREEN_RADIO, 12*SCREEN_RADIO, 12*SCREEN_RADIO)];
    }
    
    return _goldImgView;
}

-(UILabel *)goldNum{
    if (!_goldNum) {
        _goldNum=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.goldImgView.frame)+3*SCREEN_RADIO, CGRectGetMaxY(self.nickName.frame)+9*SCREEN_RADIO, 0, 13*SCREEN_RADIO)];
        
        _goldNum.font=[UIFont systemFontOfSize:13*SCREEN_RADIO];
        [_goldNum sizeToFit];
    }
    
    return _goldNum;
}

-(UIButton *)addFriend{
    if (!_addFriend) {
        NSString *userid;
        if (self.modeltype==1) {
            userid=self.cellModel.moneyuserid;
        }else{
            userid=self.cellModel.hotuserid;
        }
        _addFriend=[[UIButton alloc]initWithFrame:CGRectMake(screen_width/2-35*SCREEN_RADIO, CGRectGetMaxY(self.goldNum.frame)+10*SCREEN_RADIO, 70*SCREEN_RADIO, 28*SCREEN_RADIO)];
        if ([[CGSingleCommitData sharedInstance].addFriendArr containsObject:userid]) {
            [_addFriend setBackgroundImage:[UIImage imageNamed:@"leaderboard_discover_following_top_ico"] forState:UIControlStateNormal];
        }else{
            [_addFriend setBackgroundImage:[UIImage imageNamed:@"leaderboard_follow_button"] forState:UIControlStateNormal];
        }
        [_addFriend addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _addFriend;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView=[[UIView alloc] initWithFrame:CGRectMake(0, 294*SCREEN_RADIO-0.5, screen_width, 0.5)];
        _lineView.backgroundColor=[UIColor getColor:@"493D83"];
    }
    
    return _lineView;
}
@end
