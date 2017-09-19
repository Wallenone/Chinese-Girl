//
//  CGPickBottleContentView.h
//  ChineseGirl
//
//  Created by Wallen on 2017/9/13.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^DrogBlock)(void);
@interface CGPickBottleContentView : UIView
-(instancetype)initWithFrame:(CGRect)frame withDrogBlock:(DrogBlock)block;
@end
