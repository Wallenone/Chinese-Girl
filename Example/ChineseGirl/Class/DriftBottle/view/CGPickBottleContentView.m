//
//  CGPickBottleContentView.m
//  ChineseGirl
//
//  Created by Wallen on 2017/9/13.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGPickBottleContentView.h"

@interface CGPickBottleContentView(){
    DrogBlock drogBlock;
}
@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UIImageView *sex;
@property(nonatomic,strong)UILabel *address;
@property(nonatomic,strong)UILabel *autograph;  //签名
@property(nonatomic,strong)UIView *contentView;
@property(nonatomic,strong)UILabel *contentLabel;
@property(nonatomic,strong)UIButton *drogUpBtn;
@property(nonatomic,strong)UIButton *RespondBtn;
@end
@implementation CGPickBottleContentView

-(instancetype)initWithFrame:(CGRect)frame withDrogBlock:(DrogBlock)block{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor clearColor];
        drogBlock=block;
        [self addSubviews];
    }
    
    return self;
}

-(void)addSubviews{
    [self addSubview:self.icon];
    [self addSubview:self.sex];
    [self addSubview:self.address];
    [self addSubview:self.autograph];
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.contentLabel];
    [self addSubview:self.drogUpBtn];
    [self addSubview:self.RespondBtn];
}

-(void)drogUpClick{
    if (drogBlock) {
        drogBlock();
    }
    [self removeFromSuperview];
}

-(void)RespondClick{
    
}

-(UIImageView *)icon{
    if (!_icon) {
        _icon=[[UIImageView alloc] initWithFrame:CGRectMake(25*SCREEN_RADIO, 30*SCREEN_RADIO, 52*SCREEN_RADIO, 52*SCREEN_RADIO)];
        _icon.image=[UIImage imageNamed:@"Avatar"];
        _icon.layer.cornerRadius=2*SCREEN_RADIO;
    }
    
    return _icon;
}

-(UIImageView *)sex{
    if (!_sex) {
        _sex=[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.icon.frame)+6*SCREEN_RADIO, 37*SCREEN_RADIO, 16*SCREEN_RADIO, 16*SCREEN_RADIO)];
        _sex.image=[UIImage imageNamed:@"battle_sex"];
    }
    
    return _sex;
}

-(UILabel *)address{
    if (!_address) {
        _address=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.sex.frame)+8*SCREEN_RADIO, 35*SCREEN_RADIO, 250*SCREEN_RADIO, 19*SCREEN_RADIO)];
        _address.text=@"走近你，就走近了大罪案打开撒达拉斯撒旦撒撒旦撒多撒多撒";
        _address.textColor=[UIColor getColor:@"ffffff"];
        _address.font=[UIFont systemFontOfSize:18*SCREEN_RADIO];
    }
    
    return _address;
}

-(UILabel *)autograph{
    if (!_autograph) {
        _autograph=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.icon.frame)+8*SCREEN_RADIO, CGRectGetMaxY(self.address.frame)+8*SCREEN_RADIO, 250*SCREEN_RADIO, 18*SCREEN_RADIO)];
        _autograph.text=@"走近你，就走近了大罪案打开撒达拉斯撒旦撒撒旦撒多撒多撒";
        _autograph.textColor=[UIColor getColor:@"99A3A9"];
        _autograph.font=[UIFont systemFontOfSize:16*SCREEN_RADIO];
    }
    
    return _autograph;
}

-(UIView *)contentView{
    if (!_contentView) {
        _contentView=[[UIView alloc] initWithFrame:CGRectMake(25*SCREEN_RADIO, CGRectGetMaxY(self.autograph.frame)+12*SCREEN_RADIO, screen_width-50*SCREEN_RADIO, 320*SCREEN_RADIO)];
        _contentView.backgroundColor=[UIColor whiteColor];
        _contentView.layer.cornerRadius=2*SCREEN_RADIO;
    }
    
    return _contentView;
}

-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel=[[UILabel alloc] initWithFrame:CGRectMake(12*SCREEN_RADIO, 20*SCREEN_RADIO, screen_width-104*SCREEN_RADIO, 0)];
        _contentLabel.text=@"走近你，就走近了大罪案打开撒达拉斯撒旦撒撒旦撒多撒多撒打开撒达拉斯撒旦撒撒旦撒多撒多撒打开撒达拉斯撒旦撒撒旦撒多撒多撒打开撒达拉斯撒旦撒撒旦撒多撒多撒";
        _contentLabel.textColor=[UIColor blackColor];
        _contentLabel.font=[UIFont systemFontOfSize:16*SCREEN_RADIO];
        _contentLabel.numberOfLines=0;
        [_contentLabel sizeToFit];
    }
    
    return _contentLabel;
}

-(UIButton *)drogUpBtn{
    if (!_drogUpBtn) {
        _drogUpBtn=[[UIButton alloc] initWithFrame:CGRectMake(30*SCREEN_RADIO, CGRectGetMaxY(self.contentView.frame)+20*SCREEN_RADIO, screen_width/2-35*SCREEN_RADIO, 35*SCREEN_RADIO)];
        _drogUpBtn.backgroundColor=[UIColor getColor:@"2979FF"];
        [_drogUpBtn setTitle:@"扔回海里" forState:UIControlStateNormal];
        [_drogUpBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _drogUpBtn.titleLabel.font=[UIFont systemFontOfSize:18*SCREEN_RADIO];
        _drogUpBtn.layer.cornerRadius=5*SCREEN_RADIO;
        [_drogUpBtn addTarget:self action:@selector(drogUpClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _drogUpBtn;
}

-(UIButton *)RespondBtn{
    if (!_RespondBtn) {
        _RespondBtn=[[UIButton alloc] initWithFrame:CGRectMake(screen_width/2+5*SCREEN_RADIO, CGRectGetMaxY(self.contentView.frame)+20*SCREEN_RADIO, screen_width/2-35*SCREEN_RADIO, 35*SCREEN_RADIO)];
        _RespondBtn.backgroundColor=[UIColor getColor:@"2979FF"];
        [_RespondBtn setTitle:@"回应" forState:UIControlStateNormal];
        [_RespondBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _RespondBtn.titleLabel.font=[UIFont systemFontOfSize:18*SCREEN_RADIO];
        _RespondBtn.layer.cornerRadius=5*SCREEN_RADIO;
        [_RespondBtn addTarget:self action:@selector(RespondClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _RespondBtn;
}
@end
