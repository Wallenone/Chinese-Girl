//
//  myHeaderViewCell.m
//  ChineseGirl
//
//  Created by Wallen on 2017/8/26.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "myHeaderViewCell.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"
@interface myHeaderViewCell(){
    TalkCallBack talkCallBack;
}
@property(nonatomic,strong)CGUserInfo *myIndexModel;
@property(nonatomic,strong)UIImageView *AvatarImgView;
@property(nonatomic,strong)UIButton *avatarbtn;
@property(nonatomic,strong)UILabel *nickName;
@property(nonatomic,strong)UILabel *address;
@property(nonatomic,strong)UIImageView *addressIcon;
@property(nonatomic,strong)UIButton *talkBtn;
@property(nonatomic,strong)UIButton *followingBtn;
@property(nonatomic,strong)UIView *infoLinView;
@end
@implementation myHeaderViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithModel:(CGUserInfo *)indexModel withTalkCallBack:(TalkCallBack)block{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        talkCallBack=block;
        self.backgroundColor=[UIColor whiteColor];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        self.myIndexModel = indexModel;
        [self creatSubView];
    }
    
    return self;
}

- (void)creatSubView {
    [self addSubview:self.AvatarImgView];
    [self addSubview:self.avatarbtn];
    [self addSubview:self.nickName];
    [self addSubview:self.addressIcon];
    [self addSubview:self.address];
    [self addSubview:self.talkBtn];
    [self addSubview:self.followingBtn];
    [self addSubview:self.infoLinView];

}

-(void)talkClick{
    if (talkCallBack) {
        talkCallBack();
    }
}

-(void)avatarClick{
            // 替换为中等尺寸图片
    NSMutableArray *photos = [[NSMutableArray alloc] init];
    NSString *url = self.myIndexModel.bigAvater;
    MJPhoto *photo = [[MJPhoto alloc] init];
    photo.url = [NSURL URLWithString:url]; // 图片路径
    [photos addObject:photo];
        // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
        browser.currentPhotoIndex = 0; // 弹出相册时显示的第一张图片是？
        browser.photos = photos; // 设置所有的图片
        [browser show];
}

-(void)followingClick:(UIButton *)button{//C5D4D2  //320AFD
    if ([button.currentTitle isEqual:@"Following"]) {
        [button setBackgroundColor:[UIColor getColor:@"320AFD"]];
        [button setTitle:@"Follwed" forState:UIControlStateNormal];
        [[CGSingleCommitData sharedInstance] addFollows:[NSString stringWithFormat:@"%@",self.myIndexModel.ids]];
    }
    else {
        [button setBackgroundColor:[UIColor getColor:@"C5D4D2"]];
        [button setTitle:@"Follwing" forState:UIControlStateNormal];
        [[CGSingleCommitData sharedInstance] deletefollow:[NSString stringWithFormat:@"%@",self.myIndexModel.ids]];
    }
}

-(UIImageView *)AvatarImgView{
    if (!_AvatarImgView) {
        _AvatarImgView=[[UIImageView alloc] initWithFrame:CGRectMake(30*SCREEN_RADIO, 21*SCREEN_RADIO, 115*SCREEN_RADIO, 115*SCREEN_RADIO)];
        [_AvatarImgView sd_setImageWithURL:[NSURL URLWithString:self.myIndexModel.avater]];
        _AvatarImgView.layer.cornerRadius=115/2*SCREEN_RADIO;
        _AvatarImgView.clipsToBounds=YES;
    }
    
    return _AvatarImgView;
}

-(UIButton *)avatarbtn{
    if (!_avatarbtn) {
        _avatarbtn=[[UIButton alloc] initWithFrame:CGRectMake(30*SCREEN_RADIO, 21*SCREEN_RADIO, 115*SCREEN_RADIO, 115*SCREEN_RADIO)];
        [_avatarbtn addTarget:self action:@selector(avatarClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _avatarbtn;
}
-(UILabel *)nickName{
    if (!_nickName) {
        _nickName=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.AvatarImgView.frame)+24*SCREEN_RADIO, 31*SCREEN_RADIO, 180*SCREEN_RADIO, 27*SCREEN_RADIO)];
        _nickName.font=[UIFont systemFontOfSize:22*SCREEN_RADIO];
        _nickName.text=self.myIndexModel.nickname;
        _nickName.textColor=[UIColor getColor:@"232627"];
        _nickName.textAlignment=NSTextAlignmentCenter;
    }
    return _nickName;
}

-(UILabel *)address{
    if (!_address) {
        _address=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.addressIcon.frame)+7.5*SCREEN_RADIO, CGRectGetMaxY(self.nickName.frame)+6.5*SCREEN_RADIO, 0, 14*SCREEN_RADIO)];
        _address.font=[UIFont systemFontOfSize:11*SCREEN_RADIO];
        _address.textColor=[UIColor getColor:@"575E62"];
        _address.text=self.myIndexModel.address;
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
        [_followingBtn setTitleColor:[UIColor getColor:@"ffffff"] forState:UIControlStateNormal];//C5D4D2  //320AFD
        if (self.myIndexModel.followed) {
             [_followingBtn setBackgroundColor:[UIColor getColor:@"320AFD"]];
            [_followingBtn setTitle:@"Followed" forState:UIControlStateNormal];
        }else{
             [_followingBtn setBackgroundColor:[UIColor getColor:@"C5D4D2"]];
            [_followingBtn setTitle:@"Following" forState:UIControlStateNormal];

        }
        _followingBtn.layer.cornerRadius=26*SCREEN_RADIO;
        _followingBtn.titleLabel.font=[UIFont systemFontOfSize:24*SCREEN_RADIO];
        [_followingBtn addTarget:self action:@selector(followingClick:) forControlEvents:UIControlEventTouchUpInside];
        
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
