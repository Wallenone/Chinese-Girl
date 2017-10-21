//
//  RkyExtendedHitButton.m
//  EasyJieApp
//
//  Created by eson on 14-9-24.
//  Copyright (c) 2014年 easyjie. All rights reserved.
//

#import "RkyExtendedHitButton.h"

@implementation RkyExtendedHitButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    CGRect relativeFrame = self.bounds;
    UIEdgeInsets hitTestEdgeInsets = self.hitTestEdgeInsets;
    CGRect hitFrame = UIEdgeInsetsInsetRect(relativeFrame, hitTestEdgeInsets);
    return CGRectContainsPoint(hitFrame, point);
}

@end
