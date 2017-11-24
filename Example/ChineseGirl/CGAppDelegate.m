//
//  CGAppDelegate.m
//  ChineseGirl
//
//  Created by wanjiehuizhaofang on 08/07/2017.
//  Copyright (c) 2017 wanjiehuizhaofang. All rights reserved.
//

#import "CGAppDelegate.h"
#import "LCTabBarController.h"
#import "IndexViewController.h"
#import "DriftBottleViewController.h"
#import "NewsViewController.h"
#import "MineViewController.h"
#import "CGSingleCommitData.h"
#import "MineViewController.h"
#import "CGLoginViewController.h"
#import "IQKeyboardManager.h"
#import "CGPinglunModel.h"
#import "NSObject+NSLocalNotification.h"
#import "CGFriendsViewcontroller.h"
#import "CGAnimationIndexViewController.h"
@interface CGAppDelegate()<UITabBarControllerDelegate>
@property(nonatomic,strong)LCTabBarController *tabBarC;
@end
@implementation CGAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    //发送本地推送
    // [CGAppDelegate registerLocalNotification:5 title:@"收到的标题" content:@"你收到啦消息"];
    
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    //1.创建Window
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
         //a.初始化一个tabBar控制器
    UITabBarController *tb=[[UITabBarController alloc]init];
    tb.tabBar.backgroundColor=[UIColor whiteColor];
    tb.tabBar.tintColor=[UIColor blackColor];
    tb.tabBar.unselectedItemTintColor=[UIColor blackColor];
    tb.tabBar.translucent=NO;
    tb.delegate=self;
    //设置控制器为Window的根控制器
    self.window.rootViewController=tb;
    
    //b.创建子控制器
    IndexViewController *indeVC=[[IndexViewController alloc] init];
    indeVC.tabBarItem.image=[UIImage imageNamed:@"Home"];
    indeVC.tabBarItem.selectedImage=[UIImage imageNamed:@"Homeed"];
    //indeVC.tabBarItem.badgeValue=@"123";
    indeVC.tabBarItem.imageInsets = UIEdgeInsetsMake(7, 0, -7, 0);
    
    CGAnimationIndexViewController *animationVC=[[CGAnimationIndexViewController alloc] init];
    animationVC.tabBarItem.image=[UIImage imageNamed:@"ic_video"];
    animationVC.tabBarItem.selectedImage=[UIImage imageNamed:@"videoed"];
    animationVC.tabBarItem.imageInsets = UIEdgeInsetsMake(7, 0, -7, 0);
    
    CGFriendsViewcontroller *friendVC=[[CGFriendsViewcontroller alloc] init];
    friendVC.tabBarItem.image=[UIImage imageNamed:@"Home"];
    friendVC.tabBarItem.selectedImage=[UIImage imageNamed:@"Homeed"];
    friendVC.tabBarItem.imageInsets = UIEdgeInsetsMake(7, 0, -7, 0);
    
    NewsViewController *newsVC=[[NewsViewController alloc] init];
    newsVC.tabBarItem.image=[UIImage imageNamed:@"Home"];
    newsVC.tabBarItem.selectedImage=[UIImage imageNamed:@"Homeed"];
    newsVC.tabBarItem.imageInsets = UIEdgeInsetsMake(7, 0, -7, 0);
    
    MineViewController *mineVC=[[MineViewController alloc] init];
    mineVC.tabBarItem.image=[UIImage imageNamed:@"Profile"];
    mineVC.tabBarItem.selectedImage=[UIImage imageNamed:@"Profileed"];
    mineVC.tabBarItem.imageInsets = UIEdgeInsetsMake(7, 0, -7, 0);
    
    //c.添加子控制器到ITabBarController中
    //c.1第一种方式
    //    [tb addChildViewController:c1];
    //    [tb addChildViewController:c2];
    
    //c.2第二种方式
    
    UINavigationController *c1=[[UINavigationController alloc]initWithRootViewController:indeVC];
    UINavigationController *c2=[[UINavigationController alloc]initWithRootViewController:animationVC];
    UINavigationController *c3=[[UINavigationController alloc]initWithRootViewController:friendVC];
    UINavigationController *c4=[[UINavigationController alloc]initWithRootViewController:newsVC];
    UINavigationController *c5=[[UINavigationController alloc]initWithRootViewController:mineVC];
    
    tb.viewControllers=@[c1,c2,c3,c4,c5];
    
    //2.设置Window为主窗口并显示出来
    [self.window makeKeyAndVisible];
    
    return YES;
}

-(UIImage *)scaleImageToSize:(UIImage *)img size:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    NSLog(@"index:=%lu",(unsigned long)tabBarController.selectedIndex);
    
}


/**
 只有当发送出一个本地通知, 并且满足以下条件时, 才会调用该方法
 APP 处于前台情况
 当用用户点击了通知, 从后台, 进入到前台时,
 当锁屏状态下, 用户点击了通知, 从后台进入前台
 
 注意: 当App彻底退出时, 用户点击通知, 打开APP , 不会调用这个方法
 
 但是会把通知的参数传递给 application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
 
 */

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    
    UIAlertView  *alert = [[UIAlertView alloc]initWithTitle:@"接收到本地通知" message:notification.alertBody delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    
    // 查看当前的状态出于(前台: 0)/(后台: 2)/(从后台进入前台: 1)
    NSLog(@"applicationState.rawValue: %zd", application.applicationState);
    
    // 执行响应操作
    // 如果当前App在前台,执行操作
    if (application.applicationState == UIApplicationStateActive) {
        NSLog(@"执行前台对应的操作");
    } else if (application.applicationState == UIApplicationStateInactive) {
        // 后台进入前台
        NSLog(@"执行后台进入前台对应的操作");
        NSLog(@"*****%@", notification.userInfo);
    } else if (application.applicationState == UIApplicationStateBackground) {
        // 当前App在后台
        
        NSLog(@"执行后台对应的操作");
    }
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
