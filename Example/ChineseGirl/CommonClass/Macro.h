//
//  Macro.h
//  TeachThin
//
//  Created by 巩鑫 on 14-11-19.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#ifndef TeachThin_Macro_h
#define TeachThin_Macro_h

//判断程序的版本
#define IOS_7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f)


#define screen_width          [UIScreen mainScreen].bounds.size.width
#define SCREEN_WIDTH          [UIScreen mainScreen].bounds.size.width
#define screen_height          [UIScreen mainScreen].bounds.size.height
#define SCREEN_HEIGHT          [UIScreen mainScreen].bounds.size.height
#define main_content_height   [UIScreen mainScreen].bounds.size.height - self.header.frame.size.height
#define bottomY(view)         view.frame.size.height + view.frame.origin.y
#define leftX(view)           view.frame.size.width + view.frame.origin.x
#define IOS6                  ([[[UIDevice currentDevice] systemVersion] floatValue] < 7)?YES:NO
#define IOS7                  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)?YES:NO
#define IOS8                  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8)?YES:NO
#define SCREEN_RADIO [UIScreen mainScreen].bounds.size.height/667


#define degreesToRadians(x) (M_PI*(x)/180.0) //把角度转换成PI的方式
#define  PROGREESS_WIDTH 80 //圆直径
#define PROGRESS_LINE_WIDTH 4 //弧线的宽度


#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define iapShareSecret @"c6fe618ece23402ba43746da5bb400cf"
#endif
