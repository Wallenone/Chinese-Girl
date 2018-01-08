//
//  CGTopFullTableViewCell.m
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/12/30.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGTopFullTableViewCell.h"
#import "NewsMessageController.h"
#import "CGVipViewController.h"
@interface CGTopFullTableViewCell()
@property(nonatomic,strong)UIImageView *topIcon;
@property(nonatomic,strong)UILabel *topLeftLabel;
@property(nonatomic,strong)UIImageView *avaterImgView;
@property(nonatomic,strong)UILabel *nickName;
@property(nonatomic,strong)UILabel *moneyPit;
@property(nonatomic,strong)UIImageView *goldImgView;
@property(nonatomic,strong)UILabel *goldNum;
@property(nonatomic,strong)RkyExtendedHitButton *addFriend;
@property(nonatomic,strong)UIView *lineView;
@property(nonatomic,strong)CGMoneyTopModel *cellModel;
@property(nonatomic,assign)NSInteger modeltype;
@end
@implementation CGTopFullTableViewCell

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
    [self addSubview:self.topLeftLabel];
    [self addSubview:self.topIcon];
    [self addSubview:self.avaterImgView];
    [self addSubview:self.nickName];
    [self addSubview:self.moneyPit];
    [self addSubview:self.goldImgView];
    [self addSubview:self.goldNum];
    [self addSubview:self.addFriend];
    [self addSubview:self.lineView];
}

-(void)setData{
    if ([self.cellModel.ids intValue]==2) {
        self.topLeftLabel.hidden=YES;
        self.topIcon.hidden=NO;
        self.topIcon.image=[UIImage imageNamed:@"leaderboard_medal_2"];
    }else if ([self.cellModel.ids intValue]==3){
        self.topLeftLabel.hidden=YES;
        self.topIcon.hidden=NO;
        self.topIcon.image=[UIImage imageNamed:@"leaderboard_medal_3"];
    }else{
        self.topLeftLabel.hidden=NO;
        self.topIcon.hidden=YES;
        self.topLeftLabel.text=self.cellModel.ids;
        [self.topLeftLabel sizeToFit];
    }
    
    if (self.modeltype==1) {
        [self.avaterImgView sd_setImageWithURL:[NSURL URLWithString:self.cellModel.moneyUserInfo.avater] placeholderImage:[UIImage imageNamed:@"smalldefault_icon"]];
        [self.nickName setText:self.cellModel.moneyUserInfo.nickname];
        [self.nickName sizeToFit];
        self.goldNum.frame=CGRectMake(CGRectGetMaxX(self.goldImgView.frame)+3*SCREEN_RADIO, CGRectGetMaxY(self.nickName.frame)+9*SCREEN_RADIO, 0, 13*SCREEN_RADIO);
        self.goldNum.text=[NSString stringWithFormat:@"%@K",self.cellModel.moneyNum];
        self.goldNum.textColor=[UIColor getColor:@"f4bb00"];
        
        [self.goldNum sizeToFit];
        self.moneyPit.text=NSLocalizedString(@"songla", nil);
        self.goldImgView.image=[UIImage imageNamed:@"leaderboard_coin"];
        self.goldImgView.frame=CGRectMake(CGRectGetMaxX(self.moneyPit.frame)+2*SCREEN_RADIO, CGRectGetMaxY(self.nickName.frame)+10*SCREEN_RADIO, 12*SCREEN_RADIO, 12*SCREEN_RADIO);
        
    }else{
        [self.avaterImgView sd_setImageWithURL:[NSURL URLWithString:self.cellModel.hotUserInfo.avater] placeholderImage:[UIImage imageNamed:@"smalldefault_icon"]];
        [self.nickName setText:self.cellModel.hotUserInfo.nickname];
        [self.nickName sizeToFit];
        self.goldNum.frame=CGRectMake(CGRectGetMaxX(self.goldImgView.frame)+9*SCREEN_RADIO, CGRectGetMaxY(self.nickName.frame)+9*SCREEN_RADIO, 0, 13*SCREEN_RADIO);
        self.goldNum.text=[NSString stringWithFormat:@"%@",self.cellModel.hotNum];
        self.goldNum.textColor=[UIColor getColor:@"ff43ff"];
        [self.goldNum sizeToFit];
        self.moneyPit.text=NSLocalizedString(@"fensi", nil);
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
        NSData *data = UIImagePNGRepresentation([UIImage imageNamed:@"leaderboard_discover_following_ico"]);
        if (![data isEqual:data1]) {
            [[CGSingleCommitData sharedInstance] addFriendArr:userid];
            [self.addFriend setBackgroundImage:[UIImage imageNamed:@"leaderboard_discover_following_ico"] forState:UIControlStateNormal];
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
        _topIcon=[[UIImageView alloc] initWithFrame:CGRectMake(15*SCREEN_RADIO, 73*SCREEN_RADIO/2-19*SCREEN_RADIO, 28*SCREEN_RADIO, 38*SCREEN_RADIO)];
    }
    
    return _topIcon;
}

-(UILabel *)topLeftLabel{
    if (!_topLeftLabel) {
        _topLeftLabel=[[UILabel alloc] initWithFrame:CGRectMake(20*SCREEN_RADIO, 73*SCREEN_RADIO/2-10.5*SCREEN_RADIO, 0, 21*SCREEN_RADIO)];
        [_topLeftLabel setTextColor:[UIColor getColor:@"a89cc2"]];
        _topLeftLabel.font=[UIFont boldSystemFontOfSize:21*SCREEN_RADIO];
        [_topLeftLabel sizeToFit];
    }
    
    return _topLeftLabel;
}

-(UIImageView *)avaterImgView{
    if (!_avaterImgView) {
        _avaterImgView=[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.topIcon.frame)+15*SCREEN_RADIO, 73*SCREEN_RADIO/2-22.5*SCREEN_RADIO, 45*SCREEN_RADIO, 45*SCREEN_RADIO)];
        _avaterImgView.image=[UIImage imageNamed:@"Avatar"];
        
        _avaterImgView.layer.cornerRadius=22.5*SCREEN_RADIO;
        _avaterImgView.clipsToBounds=YES;
    }
    
    return _avaterImgView;
}

-(UILabel *)nickName{
    if (!_nickName) {
        _nickName=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.avaterImgView.frame)+15*SCREEN_RADIO, 73*SCREEN_RADIO/2-25*SCREEN_RADIO, 0, 15*SCREEN_RADIO)];
        [_nickName setTextColor:[UIColor getColor:@"ffffff"]];
        _nickName.font=[UIFont systemFontOfSize:15*SCREEN_RADIO];
        [_nickName sizeToFit];
    }
    
    return _nickName;
}

-(UILabel *)moneyPit{
    if (!_moneyPit) {
        _moneyPit=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.avaterImgView.frame)+15*SCREEN_RADIO, CGRectGetMaxY(self.nickName.frame)+10*SCREEN_RADIO, 0, 13*SCREEN_RADIO)];
        _moneyPit.text=NSLocalizedString(@"songla", nil);
        _moneyPit.textColor=[UIColor getColor:@"a99dc3"];
        _moneyPit.font=[UIFont systemFontOfSize:13*SCREEN_RADIO];
        [_moneyPit sizeToFit];
    }
    
    return _moneyPit;
}

-(UIImageView *)goldImgView{
    if (!_goldImgView) {
        _goldImgView=[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.moneyPit.frame)+2*SCREEN_RADIO, CGRectGetMaxY(self.nickName.frame)+10*SCREEN_RADIO, 12*SCREEN_RADIO, 12*SCREEN_RADIO)];
        _goldImgView.image=[UIImage imageNamed:@"leaderboard_coin"];
    }
    
    return _goldImgView;
}

-(UILabel *)goldNum{
    if (!_goldNum) {
        _goldNum=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.goldImgView.frame)+3*SCREEN_RADIO, CGRectGetMaxY(self.nickName.frame)+9*SCREEN_RADIO, 0, 13*SCREEN_RADIO)];
        _goldNum.textColor=[UIColor getColor:@"f4bb00"];
        _goldNum.font=[UIFont systemFontOfSize:13*SCREEN_RADIO];
        [_goldNum sizeToFit];
    }
    
    return _goldNum;
}

-(RkyExtendedHitButton *)addFriend{
    if (!_addFriend) {
        _addFriend=[[RkyExtendedHitButton alloc]initWithFrame:CGRectMake(screen_width-65*SCREEN_RADIO, 73*SCREEN_RADIO/2-15.5*SCREEN_RADIO, 50*SCREEN_RADIO, 31*SCREEN_RADIO)];
        NSString *userid;
        if (self.modeltype==1) {
            userid=self.cellModel.moneyuserid;
        }else{
            userid=self.cellModel.hotuserid;
        }
        if ([[CGSingleCommitData sharedInstance].addFriendArr containsObject:userid]) {
            [_addFriend setBackgroundImage:[UIImage imageNamed:@"leaderboard_discover_following_ico"] forState:UIControlStateNormal];
        }else{
            [_addFriend setBackgroundImage:[UIImage imageNamed:@"video_follow"] forState:UIControlStateNormal];
        }
        [_addFriend addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
        _addFriend.hitTestEdgeInsets = UIEdgeInsetsMake(-25, -25, -25, -25);
    }
    
    return _addFriend;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView=[[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.topIcon.frame)+15*SCREEN_RADIO, 73*SCREEN_RADIO-0.5, screen_width-CGRectGetMaxX(self.topIcon.frame)+15*SCREEN_RADIO, 0.5)];
        _lineView.backgroundColor=[UIColor getColor:@"493D83"];
    }
    
    return _lineView;
}
@end
