//
//  WSCollectionCell.m
//  瀑布流
//
//  Created by iMac on 16/12/26.
//  Copyright © 2016年 zws. All rights reserved.
//

#import "WSCollectionCell.h"
#import "UIImageView+WebCache.h"

@implementation WSCollectionCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor grayColor];
        [self creatSubView];
        
    }
    return self;
}

- (void)creatSubView {
    
    
    
    
    UIView *menuView=[[UIView alloc] initWithFrame:CGRectMake(0, 5*SCREEN_RADIO, screen_width, 50*SCREEN_RADIO)];
    menuView.backgroundColor=[UIColor whiteColor];
    
    UIImageView *iconImgView=[[UIImageView alloc] initWithFrame:CGRectMake(10*SCREEN_RADIO, 5*SCREEN_RADIO, 40*SCREEN_RADIO, 40*SCREEN_RADIO)];
    iconImgView.image=[UIImage imageNamed:@"Avatar"];
    iconImgView.layer.cornerRadius=3*SCREEN_RADIO;
    iconImgView.tag=11;
    [menuView addSubview:iconImgView];
    
    UILabel *nickName=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(iconImgView.frame)+6*SCREEN_RADIO , 7*SCREEN_RADIO, 150*SCREEN_RADIO, 12*SCREEN_RADIO)];
    nickName.text=@"wallen";
    nickName.textColor=[UIColor getColor:@"4c4c4c"];
    nickName.font=[UIFont systemFontOfSize:12*SCREEN_RADIO];
    nickName.tag=12;
    [menuView addSubview:nickName];
    
    UILabel *birthday=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(iconImgView.frame)+6*SCREEN_RADIO, CGRectGetMaxY(nickName.frame)+7*SCREEN_RADIO, 150*SCREEN_RADIO, 12*SCREEN_RADIO)];
    birthday.text=@"1992-04-26";
    birthday.textColor=[UIColor getColor:@"7f7e80"];
    birthday.tag=13;
    birthday.font=[UIFont systemFontOfSize:12*SCREEN_RADIO];
    [menuView addSubview:birthday];
                                                                
    UILabel *content=[[UILabel alloc] initWithFrame:CGRectMake(0, 18*SCREEN_RADIO, screen_width-10*SCREEN_RADIO,15*SCREEN_RADIO)];
    content.text=@"3个月后打算去美国";
    content.textColor=[UIColor getColor:@"7f7e80"];
    content.font=[UIFont systemFontOfSize:12*SCREEN_RADIO];
    content.textAlignment=NSTextAlignmentRight;
    content.tag=14;
    [menuView addSubview:content];
    
//    UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:menuView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5*SCREEN_RADIO,5*SCREEN_RADIO)];
//
//    CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
//
//    maskLayer1.frame = menuView.bounds;
//
//    maskLayer1.path = maskPath1.CGPath;
//
//    menuView.layer.mask = maskLayer1;
//
    [self addSubview:menuView];
    
    
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(menuView.frame), screen_width, 365*SCREEN_RADIO)];
    imgV.tag = 10;
    
    
    
    
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:imgV.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5*SCREEN_RADIO,5*SCREEN_RADIO)];
//
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//
//    maskLayer.frame = imgV.bounds;
//
//    maskLayer.path = maskPath.CGPath;
//
//    imgV.layer.mask = maskLayer;

    [self addSubview:imgV];
}


-(void)setModel:(CGIndexModel *)model {
    _model = model;
    UIImageView *imgV = (UIImageView *)[self viewWithTag:10];
    [imgV sd_setImageWithURL:[NSURL URLWithString:_model.bigIcon]];
    UIImageView *imgIcon = (UIImageView *)[self viewWithTag:11];
    [imgIcon sd_setImageWithURL:[NSURL URLWithString:_model.icon]];
    UILabel *labelNickName=(UILabel *)[self viewWithTag:12];
    labelNickName.text=_model.nickName;
    UILabel *labelBirthday=(UILabel *)[self viewWithTag:13];
    labelBirthday.text=_model.birthday;
    UILabel *labelContent=(UILabel *)[self viewWithTag:14];
    labelContent.text=_model.toContent;
}

@end
