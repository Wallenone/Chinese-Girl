//
//  NNewsBottomMessage.h
//  ChineseGirl
//
//  Created by wallen on 2017/8/27.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DidBeginEditing)(UITextView *);
@interface NewsBottomMessage : UIView
- (instancetype)initWithFrame:(CGRect)frame withDidBeginEditing:(DidBeginEditing)block;
@end
