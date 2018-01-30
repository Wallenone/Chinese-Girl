//
//  UILabel+SizeToFitHeight.h
//  Expecta
//
//  Created by Wallen on 2018/1/13.
//

#import <UIKit/UIKit.h>

@interface UILabel (SizeToFitHeight)
+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont*)font;
+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font;

@end
