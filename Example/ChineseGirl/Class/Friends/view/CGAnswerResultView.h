//
//  CGAnswerResultView.h
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/11/17.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^TalkClickBlock)(void);
typedef void (^VipClickBlock)(void);
@interface CGAnswerResultView : UIView
- (instancetype)initWithFrame:(CGRect)frame withleftAvater:(NSString *)avater withNickName:(NSString *)nickName withTalkBlock:(TalkClickBlock)talkBlok withVipBlock:(VipClickBlock)vipBlock;
@end
