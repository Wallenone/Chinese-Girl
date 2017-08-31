//
//  CGLoginIndexCustomTextField.m
//  ChineseGirl
//
//  Created by wallen on 2017/8/31.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGLoginIndexCustomTextField.h"

@implementation CGLoginIndexCustomTextField

// 修改文本展示区域，一般跟editingRectForBounds一起重写
- (CGRect)textRectForBounds:(CGRect)bounds
{
    CGRect inset = CGRectMake(bounds.origin.x+20*SCREEN_RADIO, bounds.origin.y, bounds.size.width-70*SCREEN_RADIO, bounds.size.height);//更好理解些
    return inset;
}

// 重写来编辑区域，可以改变光标起始位置，以及光标最右到什么地方，placeHolder的位置也会改变
-(CGRect)editingRectForBounds:(CGRect)bounds
{
    CGRect inset = CGRectMake(bounds.origin.x+20*SCREEN_RADIO, bounds.origin.y, bounds.size.width-70*SCREEN_RADIO, bounds.size.height);//更好理解些
    return inset;
}

- (CGRect)rightViewRectForBounds:(CGRect)bounds{
    CGRect textRect = [super rightViewRectForBounds:bounds];
    textRect.origin.x -= 21*SCREEN_RADIO;
    return textRect;
}

@end
