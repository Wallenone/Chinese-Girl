//
//  CGNewFriendTableViewCell.m
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/11/15.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGNewFriendTableViewCell.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"
#import "CGUserInfo.h"
#import "CGVideoViewController.h"
@interface CGNewFriendTableViewCell(){
    AddFriendClickBlock addFriendClickBlock;
}
@property(nonatomic,strong)CGUserInfo *addModel;
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UILabel *nickName;
@property(nonatomic,strong)UILabel *aboutUs;
@property(nonatomic,strong)UIButton *addBtn;
@property(nonatomic,strong)UIImageView *contentImg1;
@property(nonatomic,strong)UIButton *contentBtn1;
@property(nonatomic,strong)UIImageView *contentImg2;
@property(nonatomic,strong)UIButton *contentBtn2;
@property(nonatomic,strong)UIImageView *contentImg3;
@property(nonatomic,strong)UIButton *contentBtn3;
@property(nonatomic,strong)NSMutableArray *imgViewArr;
@end
@implementation CGNewFriendTableViewCell

-(NSMutableArray *)imgViewArr{
    if (!_imgViewArr) {
        _imgViewArr=[NSMutableArray new];
    }
    
    return _imgViewArr;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithModel:(NSString *)userid withAddFriendBlock:(AddFriendClickBlock)block{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        self.addModel=[CGUserInfo getitemWithID:userid];
        addFriendClickBlock=block;
        [self creatSubView];
    }
    
    return self;
}

-(void)creatSubView{
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.icon];
    [self.bgView addSubview:self.nickName];
    [self.bgView addSubview:self.aboutUs];
    [self.bgView addSubview:self.addBtn];
    [self.bgView addSubview:self.contentImg1];
    [self.bgView addSubview:self.contentBtn1];
    [self.bgView addSubview:self.contentImg2];
    [self.bgView addSubview:self.contentBtn2];
    [self.bgView addSubview:self.contentImg3];
    [self.bgView addSubview:self.contentBtn3];
    [self.imgViewArr addObject:self.contentImg1];
    [self.imgViewArr addObject:self.contentImg2];
    [self.imgViewArr addObject:self.contentImg3];
}

-(void)addClick{
    if (addFriendClickBlock) {
        addFriendClickBlock(self.addModel.avater,self.addModel.nickname);
    }
}

-(void)ImgClick1{
    if ([self.addModel.type integerValue]==1) {
        [self setCheckPhotos:0];
    }else if ([self.addModel.type integerValue]==2){
        CGVideoViewController *videoVC=[[CGVideoViewController alloc] init];
        UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:videoVC];
        videoVC.videoIcon=self.addModel.picturesBig[0];
        videoVC.videoStr=self.addModel.videoUrlS[0];
        videoVC.userInfo=self.addModel;
        [[self getCurrentVC].navigationController presentViewController:nav animated:YES completion:nil];
    }
    
}

-(void)ImgClick2{
    if ([self.addModel.type integerValue]==1) {
        [self setCheckPhotos:1];
    }else if ([self.addModel.type integerValue]==2){
        CGVideoViewController *videoVC=[[CGVideoViewController alloc] init];
        UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:videoVC];
        videoVC.videoIcon=self.addModel.picturesBig[1];
        videoVC.videoStr=self.addModel.videoUrlS[1];
        videoVC.userInfo=self.addModel;
        [[self getCurrentVC].navigationController presentViewController:nav animated:YES completion:nil];
    }
}

-(void)ImgClick3{
    if ([self.addModel.type integerValue]==1) {
        [self setCheckPhotos:2];
    }else if ([self.addModel.type integerValue]==2){
        CGVideoViewController *videoVC=[[CGVideoViewController alloc] init];
        UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:videoVC];
        videoVC.videoIcon=self.addModel.picturesBig[2];
        videoVC.videoStr=self.addModel.videoUrlS[2];
        videoVC.userInfo=self.addModel;
        [[self getCurrentVC].navigationController presentViewController:nav animated:YES completion:nil];
    }
}

-(void)setCheckPhotos:(NSInteger)_tag{
    NSUInteger count = 3;
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        // 替换为中等尺寸图片
        NSString *url = self.addModel.picturesBig[i];
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:url]; // 图片路径
        photo.srcImageView = self.imgViewArr[i]; // 来源于哪个UIImageView
        [photos addObject:photo];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = _tag; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
}

-(UIView *)bgView{
    if (!_bgView) {
        _bgView=[[UIView alloc] initWithFrame:CGRectMake(7*SCREEN_RADIO, 6*SCREEN_RADIO, screen_width-14*SCREEN_RADIO, 175*SCREEN_RADIO)];
        _bgView.backgroundColor=[UIColor getColor:@"ffffff"];
        _bgView.layer.cornerRadius=5;
    }
    
    return _bgView;
}

-(UIImageView *)icon{
    if (!_icon) {
        _icon=[[UIImageView alloc] initWithFrame:CGRectMake(9*SCREEN_RADIO, 9*SCREEN_RADIO, 38*SCREEN_RADIO, 38*SCREEN_RADIO)];
        [_icon sd_setImageWithURL:[NSURL URLWithString:self.addModel.avater]];
        _icon.layer.borderWidth=1;
        _icon.layer.borderColor=[UIColor getColor:@"DDDDDD"].CGColor;
        _icon.layer.cornerRadius=19*SCREEN_RADIO;
        _icon.clipsToBounds=YES;
    }
    return _icon;
}

-(UILabel *)nickName{
    if (!_nickName) {
        _nickName=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.icon.frame)+13*SCREEN_RADIO, 11*SCREEN_RADIO, 150*SCREEN_RADIO, 16*SCREEN_RADIO)];
        _nickName.text=self.addModel.nickname;
        _nickName.textColor=[UIColor getColor:@"000000"];
        _nickName.font=[UIFont systemFontOfSize:14*SCREEN_RADIO];
    }
    
    return _nickName;
}

-(UILabel *)aboutUs{
    if (!_aboutUs) {
        _aboutUs=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.icon.frame)+13*SCREEN_RADIO, CGRectGetMaxY(self.nickName.frame)+3*SCREEN_RADIO, 250*SCREEN_RADIO, 15*SCREEN_RADIO)];
        _aboutUs.text=self.addModel.aboutus;
        _aboutUs.textColor=[UIColor getColor:@"AAAAAA"];
        _aboutUs.font=[UIFont systemFontOfSize:13*SCREEN_RADIO];
        _aboutUs.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    
    return _aboutUs;
}

-(UIButton *)addBtn{
    if (!_addBtn) {
        _addBtn=[[UIButton alloc] initWithFrame:CGRectMake(screen_width-41*SCREEN_RADIO, 21*SCREEN_RADIO, 20*SCREEN_RADIO, 20*SCREEN_RADIO)];
        [_addBtn setBackgroundImage:[UIImage imageNamed:@"FollowFriend"] forState:UIControlStateNormal];
        [_addBtn addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _addBtn;
}

-(UIImageView *)contentImg1{
    if (!_contentImg1) {
        _contentImg1=[[UIImageView alloc] initWithFrame:CGRectMake(1, CGRectGetMaxY(self.aboutUs.frame)+10*SCREEN_RADIO, (screen_width-17*SCREEN_RADIO)/3, (screen_width-17*SCREEN_RADIO)/3)];
        [_contentImg1 sd_setImageWithURL:[NSURL URLWithString:[self.addModel.pictures objectAtIndex:0]]];
        if ([self.addModel.type integerValue]==2) {
            UIImageView *playView=[[UIImageView alloc] initWithFrame:CGRectMake(((screen_width-17*SCREEN_RADIO)/3)/2-14*SCREEN_RADIO, ((screen_width-17*SCREEN_RADIO)/3)/2-14*SCREEN_RADIO, 28*SCREEN_RADIO, 28*SCREEN_RADIO)];
            playView.image=[UIImage imageNamed:@"smallPlayVideo"];
            [_contentImg1 addSubview:playView];
        }
    }
    
    return _contentImg1;
}

-(UIButton *)contentBtn1{
    if (!_contentBtn1) {
        _contentBtn1=[[UIButton alloc] initWithFrame:CGRectMake(1, CGRectGetMaxY(self.aboutUs.frame)+10*SCREEN_RADIO, (screen_width-17*SCREEN_RADIO)/3, (screen_width-17*SCREEN_RADIO)/3)];
        [_contentBtn1 addTarget:self action:@selector(ImgClick1) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _contentBtn1;
}

-(UIImageView *)contentImg2{
    if (!_contentImg2) {
        _contentImg2=[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.contentImg1.frame)+1, CGRectGetMaxY(self.aboutUs.frame)+10*SCREEN_RADIO, (screen_width-17*SCREEN_RADIO)/3, (screen_width-17*SCREEN_RADIO)/3)];
        [_contentImg2 sd_setImageWithURL:[NSURL URLWithString:[self.addModel.pictures objectAtIndex:1]]];
        if ([self.addModel.type integerValue]==2) {
            UIImageView *playView=[[UIImageView alloc] initWithFrame:CGRectMake(((screen_width-17*SCREEN_RADIO)/3)/2-14*SCREEN_RADIO, ((screen_width-17*SCREEN_RADIO)/3)/2-14*SCREEN_RADIO, 28*SCREEN_RADIO, 28*SCREEN_RADIO)];
            playView.image=[UIImage imageNamed:@"smallPlayVideo"];
            [_contentImg2 addSubview:playView];
        }
        
    }
    
    return _contentImg2;
}

-(UIButton *)contentBtn2{
    if (!_contentBtn2) {
        _contentBtn2=[[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.contentImg1.frame)+1, CGRectGetMaxY(self.aboutUs.frame)+10*SCREEN_RADIO, (screen_width-17*SCREEN_RADIO)/3, (screen_width-17*SCREEN_RADIO)/3)];
        [_contentBtn2 addTarget:self action:@selector(ImgClick2) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _contentBtn2;
}

-(UIImageView *)contentImg3{
    if (!_contentImg3) {
        _contentImg3=[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.contentImg2.frame)+1, CGRectGetMaxY(self.aboutUs.frame)+10*SCREEN_RADIO, (screen_width-17*SCREEN_RADIO)/3, (screen_width-17*SCREEN_RADIO)/3)];
        [_contentImg3 sd_setImageWithURL:[NSURL URLWithString:[self.addModel.pictures objectAtIndex:2]]];
        if ([self.addModel.type integerValue]==2) {
            UIImageView *playView=[[UIImageView alloc] initWithFrame:CGRectMake(((screen_width-17*SCREEN_RADIO)/3)/2-14*SCREEN_RADIO, ((screen_width-17*SCREEN_RADIO)/3)/2-14*SCREEN_RADIO, 28*SCREEN_RADIO, 28*SCREEN_RADIO)];
            playView.image=[UIImage imageNamed:@"smallPlayVideo"];
            [_contentImg3 addSubview:playView];
        }
    }
    
    return _contentImg3;
}

-(UIButton *)contentBtn3{
    if (!_contentBtn3) {
        _contentBtn3=[[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.contentImg2.frame)+1, CGRectGetMaxY(self.aboutUs.frame)+10*SCREEN_RADIO, (screen_width-17*SCREEN_RADIO)/3, (screen_width-17*SCREEN_RADIO)/3)];
        [_contentBtn3 addTarget:self action:@selector(ImgClick3) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _contentBtn3;
}

//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    
    return currentVC;
}

- (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        
        rootVC = [rootVC presentedViewController];
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
        
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
        
    } else {
        // 根视图为非导航类
        
        currentVC = rootVC;
    }
    
    return currentVC;
}
@end
