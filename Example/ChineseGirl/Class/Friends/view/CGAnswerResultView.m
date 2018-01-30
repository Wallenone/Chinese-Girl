//
//  CGAnswerResultView.m
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/11/17.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGAnswerResultView.h"
@interface CGAnswerResultView(){
    NSString *_avater;
    NSString *_nickName;
    TalkClickBlock talkClickBlock;
    VipClickBlock vipClickBlock;
}
@property(nonatomic,strong)UILabel *resultTitle;
@property(nonatomic,strong)UIImageView *leftIcon;
@property(nonatomic,strong)UILabel *leftNickName;
@property(nonatomic,strong)UILabel *precentLabel;
@property(nonatomic,strong)UIImageView *rightIcon;
@property(nonatomic,strong)UILabel *rightNickName;
@property(nonatomic,strong)UIButton *talkBtn;
@property(nonatomic,strong)UIButton *vipBtn;
@end

@implementation CGAnswerResultView

- (instancetype)initWithFrame:(CGRect)frame withleftAvater:(NSString *)avater withNickName:(NSString *)nickName withTalkBlock:(TalkClickBlock)talkBlok withVipBlock:(VipClickBlock)vipBlock
{
    self = [super initWithFrame:frame];
    if (self) {
        _avater=avater;
        _nickName=nickName;
        talkClickBlock=talkBlok;
        vipClickBlock=vipBlock;
        [self addSubViews];
    }
    return self;
}

-(void)addSubViews{
    [self addSubview:self.resultTitle];
    [self addSubview:self.leftIcon];
    [self addSubview:self.leftNickName];
    [self addSubview:self.precentLabel];
    [self addSubview:self.rightIcon];
    [self addSubview:self.rightNickName];
    [self addSubview:self.talkBtn];
    [self addSubview:self.vipBtn];
}

-(void)talkClick{
    if (talkClickBlock) {
        talkClickBlock();
    }
}

-(void)VipClick{
    if (vipClickBlock) {
        vipClickBlock();
    }
}

-(UILabel *)resultTitle{
    if (!_resultTitle) {
        _resultTitle=[[UILabel alloc] initWithFrame:CGRectMake(0, 40*SCREEN_RADIO, screen_width, 18*SCREEN_RADIO)];
        _resultTitle.text=@"一个新的配对";
        _resultTitle.textColor=[UIColor getColor:@"CCCCCC"];
        _resultTitle.font=[UIFont systemFontOfSize:18*SCREEN_RADIO];
        _resultTitle.textAlignment=NSTextAlignmentCenter;
    }
    return _resultTitle;
}

-(UIImageView *)leftIcon{
    if (!_leftIcon) {
        _leftIcon=[[UIImageView alloc] initWithFrame:CGRectMake(20*SCREEN_RADIO, CGRectGetMaxY(self.resultTitle.frame)+40*SCREEN_RADIO, 84*SCREEN_RADIO, 84*SCREEN_RADIO)];
        _leftIcon.layer.cornerRadius=42*SCREEN_RADIO;
        _leftIcon.clipsToBounds=YES;
        _leftIcon.contentMode = UIViewContentModeScaleAspectFill;
        [_leftIcon sd_setImageWithURL:[NSURL URLWithString:_avater] placeholderImage:[UIImage imageNamed:@"default_nor_avatar"]];
    }
    
    return _leftIcon;
}

-(UILabel *)leftNickName{
    if (!_leftNickName) {
        _leftNickName=[[UILabel alloc] initWithFrame:CGRectMake(20*SCREEN_RADIO, CGRectGetMaxY(self.leftIcon.frame)+20*SCREEN_RADIO, 84*SCREEN_RADIO, 16*SCREEN_RADIO)];
        _leftNickName.text=_nickName;
        _leftNickName.textColor=[UIColor getColor:@"A9A9A9"];
        _leftNickName.font=[UIFont systemFontOfSize:16*SCREEN_RADIO];
        _leftNickName.textAlignment=NSTextAlignmentCenter;
    }
    
    return _leftNickName;
}

-(UILabel *)precentLabel{
    if (!_precentLabel) {
        _precentLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.resultTitle.frame)+50*SCREEN_RADIO, screen_width, 50*SCREEN_RADIO)];
        _precentLabel.text=@"86%";
        _precentLabel.textColor=[UIColor getColor:@"EDEDED"];
        _precentLabel.textAlignment=NSTextAlignmentCenter;
        _precentLabel.font=[UIFont systemFontOfSize:50*SCREEN_RADIO];
    }
    
    return _precentLabel;
}

-(UIImageView *)rightIcon{
    if (!_rightIcon) {
        _rightIcon=[[UIImageView alloc] initWithFrame:CGRectMake(screen_width-104*SCREEN_RADIO, CGRectGetMaxY(self.resultTitle.frame)+40*SCREEN_RADIO, 84*SCREEN_RADIO, 84*SCREEN_RADIO)];
        
        _rightIcon.layer.cornerRadius=42*SCREEN_RADIO;
        _rightIcon.clipsToBounds=YES;
        _rightIcon.contentMode = UIViewContentModeScaleAspectFill;
        _rightIcon.image=[CGSingleCommitData sharedInstance].avatar;
    }
    
    return _rightIcon;
}

-(UILabel *)rightNickName{
    if (!_rightNickName) {
        _rightNickName=[[UILabel alloc] initWithFrame:CGRectMake(screen_width-104*SCREEN_RADIO, CGRectGetMaxY(self.leftIcon.frame)+20*SCREEN_RADIO, 84*SCREEN_RADIO, 16*SCREEN_RADIO)];
        _rightNickName.text=[CGSingleCommitData sharedInstance].nickName;
        _rightNickName.textColor=[UIColor getColor:@"A9A9A9"];
        _rightNickName.font=[UIFont systemFontOfSize:16*SCREEN_RADIO];
        _rightNickName.textAlignment=NSTextAlignmentCenter;
    }
    
    return _rightNickName;
}

-(UIButton *)talkBtn{
    if (!_talkBtn) {
        _talkBtn=[[UIButton alloc] initWithFrame:CGRectMake(screen_width/2-110*SCREEN_RADIO, self.frame.size.height-150*SCREEN_RADIO, 220*SCREEN_RADIO, 24*SCREEN_RADIO)];
        [_talkBtn setTitle:@"开始聊天" forState:UIControlStateNormal];
        [_talkBtn setTitleColor:[UIColor getColor:@"ffffff"] forState:UIControlStateNormal];
        _talkBtn.titleLabel.font=[UIFont systemFontOfSize:16*SCREEN_RADIO];
        _talkBtn.backgroundColor=[UIColor getColor:@"D62230"];
        [_talkBtn addTarget:self action:@selector(talkClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _talkBtn;
}

-(UIButton *)vipBtn{
    if (!_vipBtn) {
        _vipBtn=[[UIButton alloc] initWithFrame:CGRectMake(screen_width/2-110*SCREEN_RADIO, CGRectGetMaxY(self.talkBtn.frame)+20*SCREEN_RADIO, 220*SCREEN_RADIO, 24*SCREEN_RADIO)];
        [_vipBtn setTitle:@"Vip聊天" forState:UIControlStateNormal];
        [_vipBtn setTitleColor:[UIColor getColor:@"ffffff"] forState:UIControlStateNormal];
        _vipBtn.titleLabel.font=[UIFont systemFontOfSize:16*SCREEN_RADIO];
        _vipBtn.backgroundColor=[UIColor getColor:@"D62230"];
        [_vipBtn addTarget:self action:@selector(VipClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _vipBtn;
}
@end
