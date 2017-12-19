//
//  UIMessageCustom.m
//  ChineseGirl
//
//  Created by wallen on 2017/8/27.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "UIMessageCustom.h"

@implementation UIMessageCustom

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       [self buildingDefaultParamsAndAddObserver];
    }
    return self;
}





- (void)buildingDefaultParamsAndAddObserver {
    _leftMarggin = 20*SCREEN_RADIO;
    _topMarggin = 10*SCREEN_RADIO;
    _placeholderFont = [UIFont systemFontOfSize:17*SCREEN_RADIO];
    _placeholderColor = [UIColor grayColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange:) name:UITextViewTextDidChangeNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
}

- (void)textChange:(NSNotification *)notification {
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    if (self.text.length > 0) { } else {
        NSDictionary *dictionary = @{NSFontAttributeName: _placeholderFont, NSForegroundColorAttributeName: _placeholderColor};
        [self.placeholder drawInRect:CGRectMake(_leftMarggin, _topMarggin, self.bounds.size.width, self.bounds.size.height) withAttributes:dictionary];
    }
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    [self setNeedsDisplay];
}

#pragma mark -
#pragma mark - setter methods
- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    [self setNeedsDisplay];
}

- (void)setPlaceholderFont:(UIFont *)placeholderFont {
    _placeholderFont = placeholderFont;
    [self setNeedsDisplay];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}


//控制placeHolder的位置，左右缩20
-(CGRect)placeholderRectForBounds:(CGRect)bounds
{
    
    //return CGRectInset(bounds, 20, 0);
    CGRect inset = CGRectMake(bounds.origin.x+20*SCREEN_RADIO, bounds.origin.y, bounds.size.width, bounds.size.height);//更好理解些
    return inset;
}


//控制编辑文本的位置
//-(CGRect)editingRectForBounds:(CGRect)bounds
//{
//    //return CGRectInset( bounds, 10 , 0 );
//
//    CGRect inset = CGRectMake(bounds.origin.x +20*SCREEN_RADIO, bounds.origin.y, bounds.size.width -10, bounds.size.height);
//    return inset;
//}


@end
