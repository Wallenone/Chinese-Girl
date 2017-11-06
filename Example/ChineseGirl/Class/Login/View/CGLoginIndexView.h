//
//  CGLoginIndexView.h
//  ChineseGirl
//
//  Created by wallen on 2017/8/31.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^SingUpClickBlock)(void);
typedef void (^ForgotPasswordClickBlock)(void);
typedef void (^SignInClickBlock)(BOOL,NSString *);
typedef void (^CanCelClickBlock)(void);
@interface CGLoginIndexView : UIView
- (id)initWithFrame:(CGRect)frame onSingUpClick:(SingUpClickBlock)singUpBlock onForgotPasswordClick:(ForgotPasswordClickBlock)forgotPasswordBlock onSignInClick:(SignInClickBlock)signInkBlock onCanCelClick:(CanCelClickBlock)canCelClick;
-(void)checkRespons;  //检查键盘
@end
