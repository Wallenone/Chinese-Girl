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
@interface CGAnimationIndexCell()
@property(nonatomic,strong)id dataModel;
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
    [self addSubview:self.leftImgView];
    [self addSubview:self.rightImgView];
}

-(UIImage *)getGifImage{
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www.gif5.net/img/images/2017/11/23/NUxtUTZKRzE1NE9ZNTRTWjVxaWg1WVcz.gif"]];
    UIImage *image = [UIImage sd_animatedGIFWithData:data];
    return image;
}

-(UIImageView *)leftImgView{
    if (!_leftImgView) {
        _leftImgView=[[UIImageView alloc] initWithFrame:CGRectMake(5*SCREEN_RADIO, 10*SCREEN_RADIO, screen_width/2-7.5*SCREEN_RADIO, 170*SCREEN_RADIO)];
        _leftImgView.image=[self getGifImage];
        _leftImgView.layer.cornerRadius=5;
        _leftImgView.clipsToBounds=YES;
    }
    
    return _leftImgView;
}

-(UIImageView *)rightImgView{
    if (!_rightImgView) {
        _rightImgView=[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.leftImgView.frame)+5*SCREEN_RADIO, 10*SCREEN_RADIO, screen_width/2-7.5*SCREEN_RADIO, 170*SCREEN_RADIO)];
       // _rightImgView.image=[self getGifImage];
        _rightImgView.layer.cornerRadius=5;
        _rightImgView.clipsToBounds=YES;
    }
    
    return _rightImgView;
}
@end
