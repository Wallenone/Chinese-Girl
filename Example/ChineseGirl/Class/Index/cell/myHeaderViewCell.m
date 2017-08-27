//
//  myHeaderViewCell.m
//  ChineseGirl
//
//  Created by Wallen on 2017/8/26.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "myHeaderViewCell.h"

@interface myHeaderViewCell()
@property(nonatomic,strong)MyIndexModel *myIndexModel;
@property(nonatomic,strong)UIImageView *AvatarImgView;
@property(nonatomic,strong)UILabel *nickName;
@property(nonatomic,strong)UILabel *address;
@property(nonatomic,strong)UIImageView *addressIcon;
@property(nonatomic,strong)UIButton *talkBtn;
@property(nonatomic,strong)UIButton *followingBtn;
@property(nonatomic,strong)UIView *infoLinView;
@end
@implementation myHeaderViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithModel:(MyIndexModel *)indexModel{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        self.myIndexModel = indexModel;
        [self creatSubView];
    }
    
    return self;
}

- (void)creatSubView {
    [self addSubview:self.AvatarImgView];
    [self addSubview:self.nickName];
    [self addSubview:self.addressIcon];
    [self addSubview:self.address];
    [self addSubview:self.talkBtn];
    [self addSubview:self.followingBtn];
    [self addSubview:self.infoLinView];

}

-(void)talkClick{
    
}

-(void)followingClick{
    
}



-(UIImageView *)AvatarImgView{
    if (!_AvatarImgView) {
        _AvatarImgView=[[UIImageView alloc] initWithFrame:CGRectMake(30*SCREEN_RADIO, 21*SCREEN_RADIO, 115*SCREEN_RADIO, 115*SCREEN_RADIO)];
        _AvatarImgView.image=[UIImage imageNamed:@"Avatar"];
    }
    
    return _AvatarImgView;
}

-(UILabel *)nickName{
    if (!_nickName) {
        _nickName=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.AvatarImgView.frame)+24*SCREEN_RADIO, 31*SCREEN_RADIO, 0, 27*SCREEN_RADIO)];
        _nickName.font=[UIFont systemFontOfSize:22*SCREEN_RADIO];
        _nickName.text=@"Victoria Phillips";
        _nickName.textColor=[UIColor getColor:@"232627"];
        [_nickName sizeToFit];
    }
    return _nickName;
}

-(UILabel *)address{
    if (!_address) {
        _address=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.addressIcon.frame)+7.5*SCREEN_RADIO, CGRectGetMaxY(self.nickName.frame)+6.5*SCREEN_RADIO, 0, 14*SCREEN_RADIO)];
        _address.font=[UIFont systemFontOfSize:11*SCREEN_RADIO];
        _address.textColor=[UIColor getColor:@"575E62"];
        _address.text=@"MOSCOW, RUSSIA";
        [_address sizeToFit];
    }
    
    return _address;
}

-(UIImageView *)addressIcon{
    if (!_addressIcon) {
        _addressIcon=[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.AvatarImgView.frame)+52*SCREEN_RADIO, CGRectGetMaxY(self.nickName.frame)+7*SCREEN_RADIO, 9*SCREEN_RADIO, 12.5*SCREEN_RADIO)];
        _addressIcon.image=[UIImage imageNamed:@"myindex_pin"];
    }
    return _addressIcon;
}

-(UIButton *)talkBtn{
    if (!_talkBtn) {
        _talkBtn=[[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.AvatarImgView.frame)+63*SCREEN_RADIO, CGRectGetMinY(self.AvatarImgView.frame)+76.5*SCREEN_RADIO, 52*SCREEN_RADIO, 52*SCREEN_RADIO)];
        [_talkBtn setBackgroundImage:[UIImage imageNamed:@"Writemessage"] forState:UIControlStateNormal];
        [_talkBtn addTarget:self action:@selector(talkClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _talkBtn;
}



-(UIButton *)followingBtn{
    if (!_followingBtn) {
        _followingBtn=[[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.talkBtn.frame)+19*SCREEN_RADIO, CGRectGetMaxY(self.address.frame)+19*SCREEN_RADIO, 180*SCREEN_RADIO, 52*SCREEN_RADIO)];
        [_followingBtn setBackgroundImage:[UIImage imageNamed:@"FlatBlue"] forState:UIControlStateNormal];
        [_followingBtn addTarget:self action:@selector(followingClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _followingBtn;
}

-(UIView *)infoLinView{
    if(!_infoLinView){
        _infoLinView=[[UIView alloc] initWithFrame:CGRectMake(0, 164*SCREEN_RADIO-0.5, screen_width, 0.5)];
        _infoLinView.backgroundColor=[UIColor getColor:@"CED7DB"];
    }
    
    return _infoLinView;
}

@end
