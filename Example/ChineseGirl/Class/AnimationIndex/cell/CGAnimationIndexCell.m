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
@interface CGAnimationIndexCell()
@property(nonatomic,strong)id dataModel;
@property(nonatomic,strong)UIView *leftView;
@property(nonatomic,strong)UIView *rightView;
@property(nonatomic,strong)UIImageView *leftImgView;
@property(nonatomic,strong)UIImageView *rightImgView;
@end
@implementation CGAnimationIndexCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withModel:(id)model{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor=[UIColor getColor:@"ffffff"];
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

-(UIImage *)getGifImage{
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://img10.360buyimg.com/imgzone/g15/M00/12/15/rBEhWFM78I0IAAAAAASCSaIWQVkAALGbQHe6OcABIJh018.gif"]];
    UIImage *image = [UIImage sd_animatedGIFWithData:data];
    return image;
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
        _leftImgView.image=[self getGifImage];
        _leftImgView.layer.cornerRadius=5;
        _leftImgView.clipsToBounds=YES;
    }
    
//    if (!_leftImgView) {
//        FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://img.zcool.cn/community/01c6e25889bd4ca8012060c80f8067.gif"]]];
//        _leftImgView = [[FLAnimatedImageView alloc] init];
//        _leftImgView.animatedImage = image;
//        _leftImgView.frame = CGRectMake(5*SCREEN_RADIO, 10*SCREEN_RADIO, screen_width/2-7.5*SCREEN_RADIO, 220*SCREEN_RADIO);
//    }
//
    
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
        _rightImgView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screen_width/2-7.5*SCREEN_RADIO, 220*SCREEN_RADIO)];
        _rightImgView.image=[self getGifImage];
        _rightImgView.layer.cornerRadius=5;
        _rightImgView.clipsToBounds=YES;
    }
    
//    if (!_rightImgView) {
//        FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://img.zcool.cn/community/01c6e25889bd4ca8012060c80f8067.gif"]]];
//        _rightImgView = [[FLAnimatedImageView alloc] init];
//        _rightImgView.animatedImage = image;
//        _rightImgView.frame = CGRectMake(CGRectGetMaxX(self.leftImgView.frame)+5*SCREEN_RADIO, 10*SCREEN_RADIO, screen_width/2-7.5*SCREEN_RADIO, 220*SCREEN_RADIO);
//    }
    
    return _rightImgView;
}
@end
