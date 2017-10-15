//
//  MineSettingTextView.h
//  ChineseGirl
//
//  Created by Wallen on 2017/10/15.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^SettingTextBlock)(NSString *);
@interface MineSettingTextView : UIView
- (instancetype)initWithFrame:(CGRect)frame withMaxNum:(int)maxNum withTextBlock:(SettingTextBlock)block withTextStr:(NSString *)textStr;
@end
