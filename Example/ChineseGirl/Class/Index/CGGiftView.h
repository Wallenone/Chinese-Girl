//
//  CGGiftViewController.h
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/12/12.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^BuyGiftClickBlock)(NSString *);
@interface CGGiftView : UIView
- (instancetype)initWithFrame:(CGRect)frame withBuyBlock:(BuyGiftClickBlock)block;
@end
