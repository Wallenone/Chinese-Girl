//
//  CGNewFriendTableViewCell.m
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/11/15.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGNewFriendTableViewCell.h"

@interface CGNewFriendTableViewCell(){
    AddFriendClickBlock addFriendClickBlock;
}
@property(nonatomic,strong)CGaddFriendsModel *addModel;
@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UILabel *nickName;
@property(nonatomic,strong)UILabel *aboutUs;
@property(nonatomic,strong)UIButton *addBtn;
@property(nonatomic,strong)UIView *bottomLineView;
@end
@implementation CGNewFriendTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithModel:(CGaddFriendsModel *)commitModel withAddFriendBlock:(AddFriendClickBlock)block{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        self.addModel=commitModel;
        addFriendClickBlock=block;
        [self creatSubView];
    }
    
    return self;
}

-(void)creatSubView{
    [self addSubview:self.icon];
    [self addSubview:self.nickName];
    [self addSubview:self.aboutUs];
    [self addSubview:self.addBtn];
    [self addSubview:self.bottomLineView];
}

-(void)addClick{
    if (addFriendClickBlock) {
        addFriendClickBlock();
    }
}

-(UIImageView *)icon{
    if (!_icon) {
        _icon=[[UIImageView alloc] initWithFrame:CGRectMake(15*SCREEN_RADIO, 10*SCREEN_RADIO, 42*SCREEN_RADIO, 42*SCREEN_RADIO)];
        [_icon sd_setImageWithURL:[NSURL URLWithString:self.addModel.avater]];
        _icon.layer.cornerRadius=21*SCREEN_RADIO;
        _icon.clipsToBounds=YES;
    }
    return _icon;
}

-(UILabel *)nickName{
    if (!_nickName) {
        _nickName=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.icon.frame)+10*SCREEN_RADIO, 10*SCREEN_RADIO, 150*SCREEN_RADIO, 16*SCREEN_RADIO)];
        _nickName.text=self.addModel.nickName;
        _nickName.textColor=[UIColor getColor:@"444444"];
        _nickName.font=[UIFont systemFontOfSize:16*SCREEN_RADIO];
    }
    
    return _nickName;
}

-(UILabel *)aboutUs{
    if (!_aboutUs) {
        _aboutUs=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.icon.frame)+10*SCREEN_RADIO, CGRectGetMaxY(self.nickName.frame)+7*SCREEN_RADIO, 200*SCREEN_RADIO, 20*SCREEN_RADIO)];
        _aboutUs.text=self.addModel.aboutUs;
        _aboutUs.textColor=[UIColor getColor:@"8e8e8e"];
        _aboutUs.font=[UIFont systemFontOfSize:10*SCREEN_RADIO];
        _aboutUs.numberOfLines=2;
        _aboutUs.lineBreakMode = NSLineBreakByTruncatingTail;
        [_aboutUs setContentMode:UIViewContentModeTop];
        [_aboutUs sizeToFit];
    }
    
    return _aboutUs;
}

-(UIButton *)addBtn{
    if (!_addBtn) {
        _addBtn=[[UIButton alloc] initWithFrame:CGRectMake(screen_width-95*SCREEN_RADIO, 19*SCREEN_RADIO, 75*SCREEN_RADIO, 24*SCREEN_RADIO)];
        [_addBtn setTitle:@"加为好友" forState:UIControlStateNormal];
        [_addBtn setTitleColor:[UIColor getColor:@"ffaa00"] forState:UIControlStateNormal];
        _addBtn.titleLabel.font=[UIFont systemFontOfSize:12*SCREEN_RADIO];
        _addBtn.layer.cornerRadius=12*SCREEN_RADIO;
        _addBtn.layer.borderWidth=1;
        _addBtn.layer.borderColor=[UIColor getColor:@"ffaa00"].CGColor;
        [_addBtn addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _addBtn;
}

-(UIView *)bottomLineView{
    if (!_bottomLineView) {
        _bottomLineView=[[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.icon.frame)+10*SCREEN_RADIO, 62*SCREEN_RADIO-0.5, screen_width-CGRectGetMaxX(self.icon.frame)+10*SCREEN_RADIO, 0.5)];
        _bottomLineView.backgroundColor=[UIColor getColor:@"d3d3d3"];
    }
    
    return _bottomLineView;
}

@end
