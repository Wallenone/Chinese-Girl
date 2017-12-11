//
//  CGAnimationIndexCell.m
//  ChineseGirl_Example
//
//  Created by wallen on 2017/11/24.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGAnimationIndexCell.h"
#import "UIImageView+WebCache.h"
#import "UIImage+GIF.h"
#import "FLAnimatedImage.h"
#import "CGUserInfo.h"
@interface CGAnimationIndexCell(){
    PlayVideoBlock playVideoBlock;
}
@property(nonatomic,strong)NSArray *dataModel;
@property(nonatomic,strong)UIView *leftView;
@property(nonatomic,strong)UIView *rightView;
@property(nonatomic,strong)UIImageView *leftImgView;
@property(nonatomic,strong)UIImageView *rightImgView;
@end
@implementation CGAnimationIndexCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withModel:(NSArray *)model withPlayCell:(PlayVideoBlock)block{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor=[UIColor getColor:@"ffffff"];
        playVideoBlock=block;
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        self.dataModel=model;
        [self creatSubView];
    }
    
    return self;
}

-(void)creatSubView{
    [self addSubview:self.leftView];
    [self addSubview:self.rightView];
    [self.leftView addSubview:self.leftImgView];
    [self.rightView addSubview:self.rightImgView];
}

-(void)leftAction{
    CGVideoDataModel *model=self.dataModel[0];
    if (playVideoBlock) {
        playVideoBlock(model.videoUrl,model.videoIcon,[CGUserInfo getitemWithID:model.userId]);
    }
}

-(void)rightAction{
    CGVideoDataModel *model=self.dataModel[1];
    if (playVideoBlock) {
        playVideoBlock(model.videoUrl,model.videoIcon,[CGUserInfo getitemWithID:model.userId]);
    }
}


-(UIView *)leftView{
    if (!_leftView) {
        _leftView=[[UIView alloc] initWithFrame:CGRectMake(5*SCREEN_RADIO, 10*SCREEN_RADIO, screen_width/2-7.5*SCREEN_RADIO, 220*SCREEN_RADIO)];
        _leftView.backgroundColor=[UIColor getColor:@"E8E8E8"];
        _leftView.layer.cornerRadius=5;
    }
    
    return _leftView;
}

-(UIImageView *)leftImgView{
    if (!_leftImgView) {
        _leftImgView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screen_width/2-7.5*SCREEN_RADIO, 220*SCREEN_RADIO)];
//        _leftImgView.image=[self getGifImage];
        CGVideoDataModel *model=self.dataModel[0];
        [_leftImgView sd_setImageWithURL:[NSURL URLWithString:model.videoIcon]];
        _leftImgView.layer.cornerRadius=5;
        _leftImgView.clipsToBounds=YES;
        _leftImgView.userInteractionEnabled=YES;
        UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, screen_width/2-7.5*SCREEN_RADIO, 220*SCREEN_RADIO)];
        [btn addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
        [_leftImgView addSubview:btn];
        
        UIImageView *playView=[[UIImageView alloc] initWithFrame:CGRectMake((screen_width/2-7.5*SCREEN_RADIO)/2-19*SCREEN_RADIO, 91*SCREEN_RADIO, 38*SCREEN_RADIO, 38*SCREEN_RADIO)];
        playView.image=[UIImage imageNamed:@"smallPlayVideo"];
        [_leftImgView addSubview:playView];
    }
    
    return _leftImgView;
    
    
    
}

-(UIView *)rightView{
    if (!_rightView) {
        _rightView=[[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.leftView.frame)+5*SCREEN_RADIO, 10*SCREEN_RADIO, screen_width/2-7.5*SCREEN_RADIO, 220*SCREEN_RADIO)];
        _rightView.backgroundColor=[UIColor getColor:@"E8E8E8"];
        _rightView.layer.cornerRadius=5;
    }
    
    return _rightView;
}

-(UIImageView *)rightImgView{
    if (!_rightImgView) {
        CGVideoDataModel *model=self.dataModel[1];
        _rightImgView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screen_width/2-7.5*SCREEN_RADIO, 220*SCREEN_RADIO)];
       [_rightImgView sd_setImageWithURL:[NSURL URLWithString:model.videoIcon]];
        _rightImgView.layer.cornerRadius=5;
        _rightImgView.clipsToBounds=YES;
        _rightImgView.userInteractionEnabled=YES;
        UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, screen_width/2-7.5*SCREEN_RADIO, 220*SCREEN_RADIO)];
        [btn addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
        [_rightImgView addSubview:btn];
        
        UIImageView *playView=[[UIImageView alloc] initWithFrame:CGRectMake((screen_width/2-7.5*SCREEN_RADIO)/2-19*SCREEN_RADIO, 91*SCREEN_RADIO, 38*SCREEN_RADIO, 38*SCREEN_RADIO)];
        playView.image=[UIImage imageNamed:@"smallPlayVideo"];
        [_rightImgView addSubview:playView];
    }
    return _rightImgView;
}
@end
