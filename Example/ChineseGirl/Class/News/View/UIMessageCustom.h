//
//  UIMessageCustom.h
//  ChineseGirl
//
//  Created by wallen on 2017/8/27.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIMessageCustom : UITextView
@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, strong) UIFont *placeholderFont;
@property (nonatomic, strong) UIColor *placeholderColor;
@property (nonatomic, assign) CGFloat leftMarggin;
@property (nonatomic, assign) CGFloat topMarggin;
@end
