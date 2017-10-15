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
    
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(10*SCREEN_RADIO, 5*SCREEN_RADIO, screen_width-20*SCREEN_RADIO, 380*SCREEN_RADIO)];
    imgV.tag = 10;
    //imgV.layer.cornerRadius=5*SCREEN_RADIO;
    //imgV.layer.masksToBounds = YES;
    
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:imgV.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5*SCREEN_RADIO,5*SCREEN_RADIO)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    
    maskLayer.frame = imgV.bounds;
    
    maskLayer.path = maskPath.CGPath;
    
    imgV.layer.mask = maskLayer;

    [self addSubview:imgV];

    
    
    
    UIView *menuView=[[UIView alloc] initWithFrame:CGRectMake(10*SCREEN_RADIO, CGRectGetMaxY(imgV.frame), screen_width-20*SCREEN_RADIO, 35*SCREEN_RADIO)];
    menuView.backgroundColor=[UIColor whiteColor];
    
    UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:menuView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5*SCREEN_RADIO,5*SCREEN_RADIO)];
    
    CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
    
    maskLayer1.frame = menuView.bounds;
    
    maskLayer1.path = maskPath1.CGPath;
    
    menuView.layer.mask = maskLayer1;
    
    [self addSubview:menuView];
    
    
}


-(void)setModel:(CellModel *)model {
    _model = model;
    UIImageView *imgV = (UIImageView *)[self viewWithTag:10];
    [imgV sd_setImageWithURL:[NSURL URLWithString:_model.imgURL]];
}

@end
