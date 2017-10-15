//
//  MineSettingNickNameViewController.h
//  ChineseGirl
//
//  Created by Wallen on 2017/10/15.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^SettingTextBlock)(NSString *);
@interface MineSettingTextViewController : UIViewController
@property(nonatomic,copy)NSString *textStr;
@property(nonatomic,copy)NSString *titleText;
-(void)onTextBlock:(SettingTextBlock)textBlock;
@end
