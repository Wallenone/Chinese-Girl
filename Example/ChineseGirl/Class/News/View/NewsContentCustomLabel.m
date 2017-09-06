//
//  NewsContentCustomLabel.m
//  ChineseGirl
//
//  Created by Wallen on 2017/9/6.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "NewsContentCustomLabel.h"

@implementation NewsContentCustomLabel

-(void)drawTextInRect:(CGRect)rect {
    UIEdgeInsets insets = {12, 12, 12, 12};
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

@end
