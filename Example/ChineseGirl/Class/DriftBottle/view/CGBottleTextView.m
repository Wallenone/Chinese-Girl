//
//  CGBottleTextView.m
//  ChineseGirl
//
//  Created by Wallen on 2017/9/19.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGBottleTextView.h"

@implementation CGBottleTextView


//控制placeHolder的位置，左右缩20
-(CGRect)placeholderRectForBounds:(CGRect)bounds
{
    
    //return CGRectInset(bounds, 20, 0);
    CGRect inset = CGRectMake(bounds.origin.x+20*SCREEN_RADIO, bounds.origin.y, bounds.size.width, bounds.size.height);//更好理解些
    return inset;
}


//控制编辑文本的位置
-(CGRect)editingRectForBounds:(CGRect)bounds
{
    //return CGRectInset( bounds, 10 , 0 );
    
    CGRect inset = CGRectMake(bounds.origin.x +20*SCREEN_RADIO, bounds.origin.y, bounds.size.width -10, bounds.size.height);
    return inset;
}


@end
