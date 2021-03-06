//
//  VOVCManager.h
//  joylife
//
//  Created by Valo on 15/4/25.
//  Copyright (c) 2015年 ValoLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VVManager.h"

#define VVMDeprecated(desc) NS_DEPRECATED_IOS(1_0_0, 2_0_0, desc)

/**
 * @brief 页面管理器
 *
 * @brief 1.支持直接跳转页面
 * @brief 2.支持URL方式
 * @brief 3.参数传递,aParams的每个key和viewController的属性对应(通过key-value方式设置)
 * @brief 4.URL方式传参,对应参数必须是string类型的.
 */
@interface VOVCManager : NSObject

/**
 *  ViewController管理器单例对象
 *
 *  @return 单例对象
 */
+ (instancetype)sharedManager VVMDeprecated("不再使用");

@property (nonatomic, assign) BOOL logPageSwitch; /**< 打印页面切换 */

@property (nonatomic, weak, readonly) UIViewController *currentViewController VVMDeprecated("使用[VVManager currentViewController]");          /**< 当前页面 */
@property (nonatomic, weak, readonly) UINavigationController *currentNaviController VVMDeprecated("使用[VVManager currentNaviController]");    /**< 当前导航 */
@property (nonatomic, weak, readonly) UIViewController *rootViewController VVMDeprecated("使用[VVManager rootViewController]");             /**< 第一个页面 */
@property (nonatomic, weak, readonly) UINavigationController *rootNavigationController VVMDeprecated("使用[VVManager rootNavigationController]"); /**< 第一个导航 */

/**
 *  在viewDidAppear要处理的通用额外操作,比如统计页面是否显示
 *  通常在-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions中设置
 *
 *  @param appearExtraHandler 额外操作
 */
- (void)setAppearExtraHandler:(void (^)(UIViewController *))appearExtraHandler VVMDeprecated("使用[VVManager setAppearExtraHandler:]");

/**
 *  在viewDidDisappear要处理的通用额外操作,比如统计页面是否退出
 *  通常在-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions中设置
 *
 *  @param disappearExtraHandler 额外操作
 */
- (void)setDisappearExtraHandler:(void (^)(UIViewController *))disappearExtraHandler VVMDeprecated("使用[VVManager setDisappearExtraHandler:]");

#pragma mark - 页面创建

/**
 *  从xib,storyboard或者代码生成页面，默认无参数
 *
 *  @param aController 目标页面,请在storyboard中设置和class名相同的storyboard id
 *  @param aStoryboard 目标页面所在的storyboard
 *
 *  @return 页面对象
 */
- (UIViewController *)viewController:(NSString *)aController
                          storyboard:(NSString *)aStoryboard VVMDeprecated("使用[VVHop viewController:storyboard:params:]");

/**
 *  从xib,storyboard或者代码生成页面
 *
 *  @param aController 目标页面,请在storyboard中设置和class名相同的storyboard id
 *  @param aStoryboard 目标页面所在的storyboard
 *  @param aParams     页面参数,aParams的每个key和viewController的属性对应(通过key-value方式设置),aParams的每个key和viewController的属性对应(通过key-value方式设置)
 *
 *  @return 页面对象
 */
- (UIViewController *)viewController:(NSString *)aController
                          storyboard:(NSString *)aStoryboard
                              params:(NSDictionary *)aParams VVMDeprecated("使用[VVHop viewController:storyboard:params:]");


#pragma mark - 页面跳转,Push
/**
 *  页面跳转，默认有push动画，默认无参数
 *
 *  @param aController 目标页面,请在storyboard中设置和class名相同的storyboard id
 *  @param aStoryboard 目标页面所在的storyboard
 */
- (void)pushController:(NSString *)aController
            storyboard:(NSString *)aStoryboard VVMDeprecated("使用[VVManager showPageWithMethod:hop:]");

/**
 *  页面跳转,默认有push动画
 *
 *  @param aController 目标页面,请在storyboard中设置和class名相同的storyboard id
 *  @param aStoryboard 目标页面所在的storyboard
 *  @param aParams     页面参数,aParams的每个key和viewController的属性对应(通过key-value方式设置)
 */
- (void)pushController:(NSString *)aController
            storyboard:(NSString *)aStoryboard
                params:(NSDictionary *)aParams VVMDeprecated("使用[VVManager showPageWithMethod:hop:]");

/**
 *  页面跳转,默认无参数
 *
 *  @param aController 目标页面,请在storyboard中设置和class名相同的storyboard id
 *  @param aStoryboard 目标页面所在的storyboard
 *  @param animated    是否动画
 */
- (void)pushController:(NSString *)aController
            storyboard:(NSString *)aStoryboard
              animated:(BOOL)animated VVMDeprecated("使用[VVManager showPageWithMethod:hop:]");

/**
 *  页面跳转
 *
 *  @param aController 目标页面,请在storyboard中设置和class名相同的storyboard id
 *  @param aStoryboard 目标页面所在的storyboard
 *  @param aParams     页面参数,aParams的每个key和viewController的属性对应(通过key-value方式设置)
 *  @param animated    是否动画
 */
- (void)pushController:(NSString *)aController
            storyboard:(NSString *)aStoryboard
                params:(NSDictionary *)aParams
              animated:(BOOL)animated VVMDeprecated("使用[VVManager showPageWithMethod:hop:]");

/**
 *  页面跳转,移除中间页面
 *
 *  @param aController       目标页面,请在storyboard中设置和class名相同的storyboard id
 *  @param aStoryboard       目标页面所在的storyboard
 *  @param aParams           页面参数,aParams的每个key和viewController的属性对应(通过key-value方式设置)
 *  @param animated          是否动画
 *  @param removeControllers 要移除的页面名称数组
 */
- (void)pushController:(NSString *)aController
            storyboard:(NSString *)aStoryboard
                params:(NSDictionary *)aParams
              animated:(BOOL)animated
     removeControllers:(NSArray *)removeControllers VVMDeprecated("使用[VVManager showPageWithMethod:hop:]");

#pragma mark - 页面出栈
/**
 *  页面弹出
 *
 *  @param animated 是否有动画
 *
 *  @return 被弹出的页面
 */
- (UIViewController *)popViewControllerAnimated:(BOOL)animated VVMDeprecated("使用[VVManager showPageWithMethod:hop:]");

/**
 *  弹出到根页面
 *
 *  @param animated 是否动画
 *
 *  @return 出栈后的页面数组
 */
- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated VVMDeprecated("使用[VVManager showPageWithMethod:hop:]");

/**
 *  页面弹出，默认无参数，默认有动画
 *
 *  @param aController 目标页面
 *  @param aStoryboard 目标页面所在的storyboard
 *
 *  @return 出栈页面数组
 */
- (NSArray *)popToViewController:(NSString *)aController
                      storyboard:(NSString *)aStoryboard VVMDeprecated("使用[VVManager showPageWithMethod:hop:]");

/**
 *  页面弹出，默认有动画
 *
 *  @param aController 目标页面
 *  @param aStoryboard 目标页面所在的storyboard
 *  @param aParams     页面参数,aParams的每个key和viewController的属性对应(通过key-value方式设置)
 *
 *  @return 出栈页面数组
 */
- (NSArray *)popToViewController:(NSString *)aController
                      storyboard:(NSString *)aStoryboard
                          params:(NSDictionary *)aParams VVMDeprecated("使用[VVManager showPageWithMethod:hop:]");

/**
 *  页面弹出
 *
 *  @param aController 目标页面
 *  @param aStoryboard 目标页面所在的storyboard
 *  @param aParams     页面参数,aParams的每个key和viewController的属性对应(通过key-value方式设置)
 *  @param animated    是否有动画
 *
 *  @return 出栈页面数组
 */
- (NSArray *)popToViewController:(NSString *)aController
                      storyboard:(NSString *)aStoryboard
                          params:(NSDictionary *)aParams
                        animated:(BOOL)animated VVMDeprecated("使用[VVManager showPageWithMethod:hop:]");

/**
 *  页面弹出
 *
 *  @param viewControllers 要排除的页面,可以是页面名或者页面对象
 *  @param animated        是否有动画
 *
 *  @return 出栈页面数组
 */
- (NSArray *)popExcludeViewControllers:(NSArray *)viewControllers
                              animated:(BOOL)animated VVMDeprecated("使用[VVManager showPageWithMethod:hop:]");

#pragma mark - 页面显示,present
/**
 *  弹出模态页面，默认无参数，源页面和目标页面都包含在UINavigationController中(目标页面如果没有UINavigationController则会自动创建)
 *
 *  @param aController 目标页面,请在storyboard中设置和class名相同的storyboard id
 *  @param aStoryboard 目标页面所在的storyboard
 *
 *  @return 目标页面
 */
- (UIViewController *)presentViewController:(NSString *)aController
                                 storyboard:(NSString *)aStoryboard VVMDeprecated("使用[VVManager showPageWithMethod:hop:]");

/**
 *  弹出模态页面，源页面和目标页面都包含在UINavigationController中(目标页面如果没有UINavigationController则会自动创建)
 *
 *  @param aController 目标页面,请在storyboard中设置和class名相同的storyboard id
 *  @param aStoryboard 目标页面所在的storyboard
 *  @param aParams     页面参数,aParams的每个key和viewController的属性对应(通过key-value方式设置)
 *
 *  @return 目标页面
 */
- (UIViewController *)presentViewController:(NSString *)aController
                                 storyboard:(NSString *)aStoryboard
                                     params:(NSDictionary *)aParams VVMDeprecated("使用[VVManager showPageWithMethod:hop:]");

/**
 *  弹出模态页面,源页面包含在UINavigationController中,若源页面不在UINavigationController中则使用页面本身
 *
 *  @param aController 目标页面,请在storyboard中设置和class名相同的storyboard id
 *  @param aStoryboard 目标页面所在的storyboard
 *  @param aParams     页面参数,aParams的每个key和viewController的属性对应(通过key-value方式设置)
 *  @param destInNavi  目标页面是否包含在UINavigationController中
 *
 *  @return 目标页面
 */
- (UIViewController *)presentViewController:(NSString *)aController
                                 storyboard:(NSString *)aStoryboard
                                     params:(NSDictionary *)aParams
                                 destInNavi:(BOOL)destInNavi VVMDeprecated("使用[VVManager showPageWithMethod:hop:]");

/**
 *  弹出模态页面,自定义源页面和目标页面是否包含在UINavigationController中
 *
 *  @param aController    目标页面,请在storyboard中设置和class名相同的storyboard id
 *  @param aStoryboard    目标页面所在的storyboard
 *  @param aParams        页面参数,aParams的每个key和viewController的属性对应(通过key-value方式设置)
 *  @param sourceWithNavi 是否使用源页面的UINavigationController进行弹出操作,源页面若无UINavigationController,则直接使用页面本身弹出
 *  @param destInNavi     目标页面是否包含在UINavigationController中
 *  @param completion     页面显示动画完成后的操作
 *
 *  @return 目标页面
 */
- (UIViewController *)presentViewController:(NSString *)aController
                                 storyboard:(NSString *)aStoryboard
                                     params:(NSDictionary *)aParams
                             sourceWithNavi:(BOOL)sourceWithNavi
                                 destInNavi:(BOOL)destInNavi
                                 completion:(void (^)(void))completion VVMDeprecated("使用[VVManager showPageWithMethod:hop:]");

/**
 *  弹出模态页面,自定义源页面和目标页面是否包含在UINavigationController中,自定义弹出页面背景透明度
 *
 *  @param aController    目标页面,请在storyboard中设置和class名相同的storyboard id
 *  @param aStoryboard    目标页面所在的storyboard
 *  @param aParams        页面参数,aParams的每个key和viewController的属性对应(通过key-value方式设置)
 *  @param sourceWithNavi 是否使用源页面的UINavigationController进行弹出操作,源页面若无UINavigationController,则直接使用页面本身弹出
 *  @param destInNavi     目标页面是否包含在UINavigationController中
 *  @param alpha          目标页面背景透明度(0.0 - 1.0)
 *  @param completion     页面显示动画完成后的操作
 *
 *  @return 目标页面
 */
- (UIViewController *)presentViewController:(NSString *)aController
                                 storyboard:(NSString *)aStoryboard
                                     params:(NSDictionary *)aParams
                             sourceWithNavi:(BOOL)sourceWithNavi
                                 destInNavi:(BOOL)destInNavi
                                      alpha:(CGFloat)alpha
                                   animated:(CGFloat)animated
                                 completion:(void (^)(void))completion VVMDeprecated("使用[VVManager showPageWithMethod:hop:]");

/**
 *  弹出模态页面,自定义源页面和目标页面是否包含在UINavigationController中,自定义弹出页面背景透明度
 *
 *  @param viewController 目标页面,请在storyboard中设置和class名相同的storyboard id
 *  @param sourceWithNavi 是否使用源页面的UINavigationController进行弹出操作,源页面若无UINavigationController,则直接使用页面本身弹出
 *  @param destInNavi     目标页面是否包含在UINavigationController中
 *  @param alpha          目标页面背景透明度(0.0 - 1.0)
 *  @param completion     页面显示动画完成后的操作
 *
 *  @return 目标页面
 */
- (UIViewController *)presentViewController:(UIViewController *)viewController
                             sourceWithNavi:(BOOL)sourceWithNavi
                                 destInNavi:(BOOL)destInNavi
                                      alpha:(CGFloat)alpha
                                   animated:(CGFloat)animated
                                 completion:(void (^)(void))completion VVMDeprecated("使用[VVManager showPageWithMethod:hop:]");

#pragma mark - 页面回收
/**
 *  回收当前页面
 *
 *  @param animated   是否有动画效果
 *  @param completion 动画完成后的操作
 */
- (void)dismissViewControllerAnimated:(BOOL)animated completion:(void (^)(void))completion VVMDeprecated("使用[VVManager showPageWithMethod:hop:]");

/**
 *  回收当前页面
 *
 *  @param withNavi   是否连同页面的UINavigationController一起回收
 *  @param animated   是否有动画效果
 *  @param completion 动画完成后的操作
 */
- (void)dismissViewControllerWithNavi:(BOOL)withNavi animated:(BOOL)animated  completion:(void (^)(void))completion VVMDeprecated("使用[VVManager showPageWithMethod:hop:]");

/**
 *  回收页面至有UINavigationController的页面
 *
 *  @param completion 回收完成后的操作
 */
- (void)dismissToNavigationControllerCompletion:(void (^)(void))completion VVMDeprecated("使用[VVManager showPageWithMethod:hop:]");


#pragma mark - 页面URL管理
/**
 *  注册页面信息
 *
 *  @param spec 页面信息
 *
 */
- (void)registerWithSpec:(NSDictionary *)spec VVMDeprecated("使用[VVManager registerURLPath:forHop:]");

/**
 *  注册页面路径
 *
 *  @param name        页面注册名
 *  @param aController 页面ViewController类名
 *  @param aStoryboard nil表示从xib或者代码创建,否则从制定的Storyboard创建
 *  @param isPresent   显示方式,是-present,否-push
 */
- (void)registerName:(NSString *)name forViewController:(NSString *)aController inStoryboard:(NSString *)aStoryboard isPresent:(BOOL)isPresent VVMDeprecated("使用[VVManager registerURLPath:forHop:]");

/**
 *  取消注册页面路径
 *
 *  @param name 要取消的页面注册名
 */
- (void)cancelRegisterName:(NSString *)name VVMDeprecated("使用[VVManager deregisterURLPath:]");

/**
 *  处理页面跳转URL
 *
 *  @param url 要处理的URL路径,URL的scheme必须和APP的scheme匹配.如果要传递参数,只支持string类型的(key和目标页面属性对应,这些属性必须是NSString类型)
 *
 *  @return 是否处理成功
 */
- (BOOL)handleOpenURL:(NSURL *)url  VVMDeprecated("使用[VVManager handleOpenURL:]");

@end
