//
//  CGFollowTableViewCell.m
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/11/18.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGFollowTableViewCell.h"
@interface CGFollowTableViewCell(){
    BOOL _lineHidden;
}
@property(nonatomic,strong)CGUserInfo *userModel;
@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UILabel *nickName;
@property(nonatomic,strong)UILabel *aboutUs;
@property(nonatomic,strong)UIButton *addBtn;
@property(nonatomic,strong)UIView *bottomLineView;
@end

@implementation CGFollowTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(id)reuseIdentifier withModel:(CGUserInfo *)model withHidden:(BOOL)state{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        self.userModel=model;
        _lineHidden=state;
        [self addSubViews];
    }
    
    return self;
}

-(void)addSubViews{
    [self addSubview:self.icon];
    [self addSubview:self.nickName];
    [self addSubview:self.aboutUs];
    [self addSubview:self.bottomLineView];
}

-(UIImageView *)icon{
    if (!_icon) {
        _icon=[[UIImageView alloc] initWithFrame:CGRectMake(15*SCREEN_RADIO, 10*SCREEN_RADIO, 42*SCREEN_RADIO, 42*SCREEN_RADIO)];
        [_icon sd_setImageWithURL:[NSURL URLWithString:self.userModel.avater]];
        _icon.layer.cornerRadius=21*SCREEN_RADIO;
        _icon.clipsToBounds=YES;
    }
    return _icon;
}

-(UILabel *)nickName{
    if (!_nickName) {
        _nickName=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.icon.frame)+10*SCREEN_RADIO, 10*SCREEN_RADIO, 150*SCREEN_RADIO, 16*SCREEN_RADIO)];
        _nickName.text=self.userModel.nickname;
        _nickName.textColor=[UIColor getColor:@"444444"];
        _nickName.font=[UIFont systemFontOfSize:16*SCREEN_RADIO];
    }
    
    return _nickName;
}

-(UILabel *)aboutUs{
    if (!_aboutUs) {
        _aboutUs=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.icon.frame)+10*SCREEN_RADIO, CGRectGetMaxY(self.nickName.frame)+7*SCREEN_RADIO, 200*SCREEN_RADIO, 20*SCREEN_RADIO)];
        _aboutUs.text=self.userModel.aboutus;
        _aboutUs.textColor=[UIColor getColor:@"8e8e8e"];
        _aboutUs.font=[UIFont systemFontOfSize:10*SCREEN_RADIO];
        _aboutUs.numberOfLines=2;
        _aboutUs.lineBreakMode = NSLineBreakByTruncatingTail;
        [_aboutUs setContentMode:UIViewContentModeTop];
        [_aboutUs sizeToFit];
    }
    
    return _aboutUs;
}


-(UIView *)bottomLineView{
    if (!_bottomLineView) {
        _bottomLineView=[[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.icon.frame)+10*SCREEN_RADIO, 62*SCREEN_RADIO-0.5, screen_width-CGRectGetMaxX(self.icon.frame)+10*SCREEN_RADIO, 0.5)];
        _bottomLineView.backgroundColor=[UIColor getColor:@"d3d3d3"];
        _bottomLineView.hidden=_lineHidden;
    }
    
    return _bottomLineView;
}

@end
