//
//  UIViewController+NavigationBar.h
//  Pods
//
//  Created by 万圣 on 2017/5/10.
//
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,NaviClickedBtnType){
    NaviClickedBtnTypeLeft,
    NaviClickedBtnTypeRight,
};

@protocol HzfNavigationBarDelegate <NSObject>

@optional

- (void)NavigationBarLeftButtonClicked;

- (void)NavigationBarRightButtonClicked;

@end


@interface UIViewController (NavigationBar)

@property (nonatomic,weak)id<HzfNavigationBarDelegate> naviDelegate;

/**
 设置导航栏1
 
 @param title 标题
 @param leftIcon 左边按钮名称 传nil为隐藏按钮
 @param rigthIcon 右边按钮名称 同上
 @param leftTitle 左边按钮文字名称 传nil为不显示文字
 @param rightTitle 右边边按钮文字名称 传nil为不显示文字
 */
- (void)setUpNavWithTitle:(NSString *)title leftIcon:(NSString *)leftIcon rightIcon:(NSString *)rigthIcon leftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle delegate:(id<HzfNavigationBarDelegate>)delegate;
@end
