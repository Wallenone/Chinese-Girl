//
//  CGGoldCoinViewController.h
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/12/18.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^OnBuyBack)(void);
@interface CGGoldCoinViewController : UIViewController
-(void)onBuyBack:(OnBuyBack)block;
@end
