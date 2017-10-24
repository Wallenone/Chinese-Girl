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
@interface CGAppDelegate()<UITabBarControllerDelegate>
@property(nonatomic,strong)LCTabBarController *tabBarC;
@end
@implementation CGAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    //1.创建Window
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
         //a.初始化一个tabBar控制器
    UITabBarController *tb=[[UITabBarController alloc]init];
    tb.tabBar.barTintColor=[UIColor getColor:@"333333"];
    tb.tabBar.translucent=YES;
    tb.delegate=self;
    //设置控制器为Window的根控制器
    self.window.rootViewController=tb;
    
    //b.创建子控制器
    IndexViewController *indeVC=[[IndexViewController alloc] init];
    indeVC.tabBarItem.image=[UIImage imageNamed:@"工作台-未选中"];
    indeVC.tabBarItem.selectedImage=[UIImage imageNamed:@"工作台-选中"];
    indeVC.tabBarItem.badgeValue=@"123";
    indeVC.tabBarItem.imageInsets = UIEdgeInsetsMake(7, 0, -7, 0);
    
    DriftBottleViewController *driftVC=[[DriftBottleViewController alloc] init];
    driftVC.tabBarItem.image=[UIImage imageNamed:@"工作台-未选中"];
    driftVC.tabBarItem.selectedImage=[UIImage imageNamed:@"工作台-选中"];
    driftVC.tabBarItem.imageInsets = UIEdgeInsetsMake(7, 0, -7, 0);
    
    NewsViewController *newsVC=[[NewsViewController alloc] init];
    newsVC.tabBarItem.image=[UIImage imageNamed:@"工作台-未选中"];
    newsVC.tabBarItem.selectedImage=[UIImage imageNamed:@"工作台-选中"];
    newsVC.tabBarItem.imageInsets = UIEdgeInsetsMake(7, 0, -7, 0);
    
    MineViewController *mineVC=[[MineViewController alloc] init];
    mineVC.tabBarItem.image=[UIImage imageNamed:@"工作台-未选中"];
    mineVC.tabBarItem.selectedImage=[UIImage imageNamed:@"工作台-选中"];
    mineVC.tabBarItem.imageInsets = UIEdgeInsetsMake(7, 0, -7, 0);
    
    //c.添加子控制器到ITabBarController中
    //c.1第一种方式
    //    [tb addChildViewController:c1];
    //    [tb addChildViewController:c2];
    
    //c.2第二种方式
    
    UINavigationController *c1=[[UINavigationController alloc]initWithRootViewController:indeVC];
    UINavigationController *c2=[[UINavigationController alloc]initWithRootViewController:driftVC];
    UINavigationController *c3=[[UINavigationController alloc]initWithRootViewController:newsVC];
    UINavigationController *c4=[[UINavigationController alloc]initWithRootViewController:mineVC];
    
    tb.viewControllers=@[c1,c2,c3,c4];
    
    
    
   
    
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
