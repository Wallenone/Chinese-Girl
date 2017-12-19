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
    TalkCallBlock talkCallBack;
}
@property(nonatomic,strong)CGUserInfo *myIndexModel;
@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)UIImageView *AvatarImgView;
@property(nonatomic,strong)UIButton *avatarbtn;
@property(nonatomic,strong)UILabel *nickName;
@property(nonatomic,strong)UILabel *address;
@property(nonatomic,strong)UIImageView *addressIcon;
@property(nonatomic,strong)UIButton *talkBtn;
@property(nonatomic,strong)UIButton *followingBtn;
@property(nonatomic,strong)UIView *sectionView;
@property(nonatomic,strong)UILabel *postNum;
@property(nonatomic,strong)UILabel *postContent;
@property(nonatomic,strong)UILabel *followerNum;
@property(nonatomic,strong)UILabel *followerContent;
@property(nonatomic,strong)UILabel *followingNum;
@property(nonatomic,strong)UILabel *followingContent;
@property(nonatomic,strong)UIView *infoLinView;
@end
@implementation myHeaderViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithModel:(CGUserInfo *)indexModel withTalkCallBack:(TalkCallBlock)block{
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
    [self addSubview:self.headerView];
    [self addSubview:self.AvatarImgView];
    [self addSubview:self.avatarbtn];
    [self addSubview:self.nickName];
    [self addSubview:self.addressIcon];
    [self addSubview:self.address];
    [self addSubview:self.followingBtn];
    [self addSubview:self.talkBtn];
//    [self addSubview:self.sectionView];
//    [self.sectionView addSubview:self.postNum];
//    [self.sectionView addSubview:self.postContent];
//    [self.sectionView addSubview:self.followerNum];
//    [self.sectionView addSubview:self.followerContent];
//    [self.sectionView addSubview:self.followingNum];
//    [self.sectionView addSubview:self.followingContent];
//    [self.sectionView addSubview:self.infoLinView];

}

-(void)rightClick{
    
}

-(void)talkClick{
    if (talkCallBack) {
        talkCallBack(self.myIndexModel);
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
    if ([button.currentTitle isEqual:@"Follow"]) {
       // [button setBackgroundColor:[UIColor getColor:@"320AFD"]];
        [button setTitle:@"Followed" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"myindexfollowed"] forState:UIControlStateNormal];
        [[CGSingleCommitData sharedInstance] addFollows:[NSString stringWithFormat:@"%@",self.myIndexModel.ids]];
        self.myIndexModel.followed=YES;
    }
    else {
       // [button setBackgroundColor:[UIColor getColor:@"C5D4D2"]];
        [button setTitle:@"Follow" forState:UIControlStateNormal];
        [[CGSingleCommitData sharedInstance] deletefollow:[NSString stringWithFormat:@"%@",self.myIndexModel.ids]];
        [button setImage:[UIImage imageNamed:@"myindexplus"] forState:UIControlStateNormal];
        self.myIndexModel.followed=NO;
    }
}

-(UIView *)headerView{
    if (!_headerView) {
        _headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 141*SCREEN_RADIO)];
        _headerView.backgroundColor=[UIColor getColor:@"171616"];
    }
    
    return _headerView;
}


-(UIImageView *)AvatarImgView{
    if (!_AvatarImgView) {
        _AvatarImgView=[[UIImageView alloc] initWithFrame:CGRectMake(15*SCREEN_RADIO, 15*SCREEN_RADIO, 100*SCREEN_RADIO, 100*SCREEN_RADIO)];
        [_AvatarImgView sd_setImageWithURL:[NSURL URLWithString:self.myIndexModel.avater]];
        _AvatarImgView.layer.cornerRadius=50*SCREEN_RADIO;
        _AvatarImgView.clipsToBounds=YES;
    }
    
    return _AvatarImgView;
}

-(UIButton *)avatarbtn{
    if (!_avatarbtn) {
        _avatarbtn=[[UIButton alloc] initWithFrame:CGRectMake(15*SCREEN_RADIO, 15*SCREEN_RADIO, 115*SCREEN_RADIO, 115*SCREEN_RADIO)];
        [_avatarbtn addTarget:self action:@selector(avatarClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _avatarbtn;
}
-(UILabel *)nickName{
    if (!_nickName) {
        _nickName=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.AvatarImgView.frame)+24*SCREEN_RADIO, 20*SCREEN_RADIO, 180*SCREEN_RADIO, 16*SCREEN_RADIO)];
        _nickName.font=[UIFont systemFontOfSize:16*SCREEN_RADIO];
        _nickName.text=self.myIndexModel.nickname;
        _nickName.textColor=[UIColor getColor:@"ffffff"];
    }
    return _nickName;
}



-(UIImageView *)addressIcon{
    if (!_addressIcon) {
        _addressIcon=[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.AvatarImgView.frame)+25*SCREEN_RADIO, CGRectGetMaxY(self.nickName.frame)+6*SCREEN_RADIO, 7*SCREEN_RADIO, 12*SCREEN_RADIO)];
        _addressIcon.image=[UIImage imageNamed:@"myindexPin"];
    }
    return _addressIcon;
}

-(UILabel *)address{
    if (!_address) {
        _address=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.addressIcon.frame)+8.5*SCREEN_RADIO, CGRectGetMaxY(self.nickName.frame)+3*SCREEN_RADIO, 0, 14*SCREEN_RADIO)];
        _address.font=[UIFont systemFontOfSize:14*SCREEN_RADIO];
        _address.textColor=[UIColor getColor:@"777777"];
        _address.text=self.myIndexModel.address;
        [_address sizeToFit];
    }
    
    return _address;
}


-(UIButton *)followingBtn{
    if (!_followingBtn) {
        _followingBtn=[[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.AvatarImgView.frame)+25.5*SCREEN_RADIO, CGRectGetMaxY(self.address.frame)+20*SCREEN_RADIO, 159.5*SCREEN_RADIO, 45*SCREEN_RADIO)];
        [_followingBtn setTitleColor:[UIColor getColor:@"ffffff"] forState:UIControlStateNormal];//C5D4D2  //320AFD
        [_followingBtn setTitle:@"Follow" forState:UIControlStateNormal];
        _followingBtn.imageEdgeInsets = UIEdgeInsetsMake(13.5*SCREEN_RADIO,16.5*SCREEN_RADIO,14*SCREEN_RADIO,125*SCREEN_RADIO);
        _followingBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -_followingBtn.imageView.frame.size.width, 0, 0);
        
        if (self.myIndexModel.followed) {
            [_followingBtn setTitle:@"Followed" forState:UIControlStateNormal];
            [_followingBtn setImage:[UIImage imageNamed:@"myindexfollowed"] forState:UIControlStateNormal];
        }else{
            [_followingBtn setTitle:@"Follow" forState:UIControlStateNormal];
            [_followingBtn setImage:[UIImage imageNamed:@"myindexplus"] forState:UIControlStateNormal];
        }
        _followingBtn.layer.cornerRadius=22.5*SCREEN_RADIO;
        _followingBtn.layer.borderWidth=0.5;
        _followingBtn.layer.borderColor=[UIColor getColor:@"ffffff"].CGColor;
        _followingBtn.titleLabel.font=[UIFont systemFontOfSize:16*SCREEN_RADIO];
        [_followingBtn addTarget:self action:@selector(followingClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _followingBtn;
}

-(UIButton *)talkBtn{
    if (!_talkBtn) {
        _talkBtn=[[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.followingBtn.frame)+15*SCREEN_RADIO, CGRectGetMaxY(self.address.frame)+20*SCREEN_RADIO, 45*SCREEN_RADIO, 45*SCREEN_RADIO)];
        [_talkBtn setBackgroundImage:[UIImage imageNamed:@"talkButton"] forState:UIControlStateNormal];
        [_talkBtn addTarget:self action:@selector(talkClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _talkBtn;
}

-(UIView *)sectionView{
    if (!_sectionView) {
        _sectionView=[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headerView.frame), screen_width, 75*SCREEN_RADIO-0.5)];
        _sectionView.backgroundColor=[UIColor getColor:@"ffffff"];
    }
    
    return _sectionView;
}

-(UILabel *)postNum{
    if (!_postNum) {
        _postNum=[[UILabel alloc] initWithFrame:CGRectMake(0, 20*SCREEN_RADIO, 100*SCREEN_RADIO, 19.5*SCREEN_RADIO)];
        _postNum.text=@"1000";
        _postNum.textColor=[UIColor getColor:@"4A4A4A"];
        _postNum.font=[UIFont systemFontOfSize:16*SCREEN_RADIO];
        _postNum.textAlignment=NSTextAlignmentCenter;
    }
    return _postNum;
}

-(UILabel *)postContent{
    if (!_postContent) {
        _postContent=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.postNum.frame)+3.5*SCREEN_RADIO, 100*SCREEN_RADIO, 12*SCREEN_RADIO)];
        _postContent.text=@"POSTS";
        _postContent.textColor=[UIColor getColor:@"777777"];
        _postContent.font=[UIFont systemFontOfSize:10*SCREEN_RADIO];
        _postContent.textAlignment=NSTextAlignmentCenter;
    }
    
    return _postContent;
}

-(UILabel *)followerNum{
    if (!_followerNum) {
        _followerNum=[[UILabel alloc] initWithFrame:CGRectMake(0, 20*SCREEN_RADIO, screen_width, 19.5*SCREEN_RADIO)];
        _followerNum.text=@"13891";
        _followerNum.textColor=[UIColor getColor:@"4A4A4A"];
        _followerNum.font=[UIFont systemFontOfSize:16*SCREEN_RADIO];
        _followerNum.textAlignment=NSTextAlignmentCenter;
    }
    return _followerNum;
}

-(UILabel *)followerContent{
    if (!_followerContent) {
        _followerContent=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.followerNum.frame)+3.5*SCREEN_RADIO, screen_width, 12*SCREEN_RADIO)];
        _followerContent.text=@"FOLLOWERS";
        _followerContent.textColor=[UIColor getColor:@"777777"];
        _followerContent.font=[UIFont systemFontOfSize:10*SCREEN_RADIO];
        _followerContent.textAlignment=NSTextAlignmentCenter;
    }
    
    return _followerContent;
}

-(UILabel *)followingNum{
    if (!_followingNum) {
        _followingNum=[[UILabel alloc] initWithFrame:CGRectMake(screen_width-100*SCREEN_RADIO, 20*SCREEN_RADIO, 100*SCREEN_RADIO, 19.5*SCREEN_RADIO)];
        _followingNum.text=@"62191";
        _followingNum.textColor=[UIColor getColor:@"4A4A4A"];
        _followingNum.font=[UIFont systemFontOfSize:16*SCREEN_RADIO];
        _followingNum.textAlignment=NSTextAlignmentCenter;
    }
    return _followingNum;
}

-(UILabel *)followingContent{
    if (!_followingContent) {
        _followingContent=[[UILabel alloc] initWithFrame:CGRectMake(screen_width-100*SCREEN_RADIO, CGRectGetMaxY(self.followingNum.frame)+3.5*SCREEN_RADIO, 100*SCREEN_RADIO, 12*SCREEN_RADIO)];
        _followingContent.text=@"FOLLOWING";
        _followingContent.textColor=[UIColor getColor:@"777777"];
        _followingContent.font=[UIFont systemFontOfSize:10*SCREEN_RADIO];
        _followingContent.textAlignment=NSTextAlignmentCenter;
    }
    
    return _followingContent;
}



-(UIView *)infoLinView{
    if(!_infoLinView){
        _infoLinView=[[UIView alloc] initWithFrame:CGRectMake(0, 75*SCREEN_RADIO-0.5, screen_width, 0.5)];
        _infoLinView.backgroundColor=[UIColor getColor:@"D9D9D9"];
    }
    
    return _infoLinView;
}

@end
