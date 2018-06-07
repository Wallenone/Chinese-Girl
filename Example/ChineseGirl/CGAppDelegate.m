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
#import "CGAnimationIndexViewController.h"
#import "CGLoginViewController.h"
#import "CGNewIndexViewController.h"
#import "CGManageRegisterViewController.h"
#import "CGProfileIndexViewController.h"
#import "CGGlobalTimerNode.h"
#import "AFURLSessionManager.h"
#import "CGLaunchViewController.h"
#import "CGNetworkData.h"
@interface CGAppDelegate()<UITabBarControllerDelegate>
@property(nonatomic,strong)LCTabBarController *tabBarC;

@end
@implementation CGAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [self setUMConfig];
    //发送本地推送
    // [CGAppDelegate registerLocalNotification:5 title:@"收到的标题" content:@"你收到啦消息"];
    
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
//    CGLaunchViewController *indeVC=[[CGLaunchViewController alloc] init];
//    self.window.rootViewController=indeVC;
    [self.window makeKeyAndVisible];
    
    
    
    
//    NSInteger dis = 10; //前后的天数
//
//    NSDate*nowDate = [NSDate date];
//
//    NSDate* theDate;
//
//    NSTimeInterval  oneDay = 24*60*60*1;  //1天的长度
//
//    //之后的天数
//
//    theDate = [nowDate initWithTimeIntervalSinceNow: +oneDay*dis ];
//
//    NSTimeInterval time=[theDate timeIntervalSince1970];// *1000 是精确到毫秒，不乘就是精确到秒
//    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];

//
//
//
//    CGFloat timeSp = [theDate timeIntervalSince1970];
    
    CGFloat currentTimeSp=[[NSDate date] timeIntervalSince1970];
    
    if (currentTimeSp>1529202489) {
        [CGSingleCommitData sharedInstance].isDebug=NO;
    }else{
        [CGSingleCommitData sharedInstance].isDebug=YES;
        [CGSingleCommitData sharedInstance].email=@"910082734@qq.com";
        [CGSingleCommitData sharedInstance].password=@"qwer123";
       // [CGSingleCommitData sharedInstance].vipLevel=@"1";
    }
    
    if ([CGSingleCommitData sharedInstance].isDebug){
        [CGSingleCommitData sharedInstance].resultName=@"Debug/imgData/";
    }else{
        [CGSingleCommitData sharedInstance].resultName=@"imgData/";
    }
    
    [self setRootView];
    
    
    return YES;
}

-(void)getNetWorkAppInfo{
//    __weak __typeof(self)weakSelf = self;
//    UIImageView *im=[[UIImageView alloc] init];
//    [im sd_setImageWithURL:[NSURL URLWithString:@"https://raw.githubusercontent.com/Wallenone/service/master/appinfo/0.png"] placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//        if (error==nil) {
//            [CGSingleCommitData sharedInstance].isDebug=YES;
//        }else{
//            [CGSingleCommitData sharedInstance].isDebug=NO;
//        }
//        if ([CGSingleCommitData sharedInstance].isDebug){
//            [CGSingleCommitData sharedInstance].resultName=@"Debug/imgData/";
//            [CGSingleCommitData sharedInstance].vipLevel=@"1";
//        }else{
//            [CGSingleCommitData sharedInstance].resultName=@"imgData/";
//        }
//
//
//        [weakSelf setRootView];
//    }];
//    [self.window.rootViewController.view addSubview:im];

}

-(void)setUMConfig{
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    [MobClick setLogEnabled:YES];
    UMConfigInstance.appKey = @"5a93d60da40fa34e5f0000bf";
    UMConfigInstance.channelId = @"App Store";
    [MobClick startWithConfigure:UMConfigInstance];
}

-(void)setRootView{
    
    //a.初始化一个tabBar控制器
    UITabBarController *tb=[[UITabBarController alloc]init];
    tb.tabBar.backgroundColor=[UIColor whiteColor];
    tb.tabBar.tintColor=[UIColor blackColor];
    tb.tabBar.unselectedItemTintColor=[UIColor blackColor];
    tb.tabBar.translucent=YES;
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
    
    NewsViewController *newsVC=[[NewsViewController alloc] init];
    newsVC.tabBarItem.image=[UIImage imageNamed:@"news"];
    newsVC.tabBarItem.selectedImage=[UIImage imageNamed:@"newsed"];
    newsVC.tabBarItem.imageInsets = UIEdgeInsetsMake(7, 0, -7, 0);
    
    CGProfileIndexViewController *mineVC=[[CGProfileIndexViewController alloc] init];
    mineVC.tabBarItem.image=[UIImage imageNamed:@"Profile"];
    mineVC.tabBarItem.selectedImage=[UIImage imageNamed:@"Profileed"];
    mineVC.tabBarItem.imageInsets = UIEdgeInsetsMake(7, 0, -7, 0);
    
    //c.添加子控制器到ITabBarController中
    //c.1第一种方式
    //    [tb addChildViewController:c1];
    //    [tb addChildViewController:c2];
    
    //c.2第二种方式
    
    
    
    if ([CGSingleCommitData sharedInstance].isDebug) {
        UINavigationController *c1=[[UINavigationController alloc]initWithRootViewController:indeVC];
        UINavigationController *c3=[[UINavigationController alloc]initWithRootViewController:newsVC];
        UINavigationController *c4=[[UINavigationController alloc]initWithRootViewController:mineVC];
        
        tb.viewControllers=@[c1,c3,c4];
    }else{
        UINavigationController *c1=[[UINavigationController alloc]initWithRootViewController:indeVC];
        UINavigationController *c2=[[UINavigationController alloc]initWithRootViewController:animationVC];
        UINavigationController *c3=[[UINavigationController alloc]initWithRootViewController:newsVC];
        UINavigationController *c4=[[UINavigationController alloc]initWithRootViewController:mineVC];
    
        tb.viewControllers=@[c1,c2,c3,c4];
    }
    
    
    [self.window makeKeyAndVisible];
    
    //定时任务启动
    [CGGlobalTimerNode reloadTask];
    
    [self setIapHelperData];
}

-(void)setIapHelperData{
    if(![IAPShare sharedHelper].iap) {
        NSSet* dataSet = [[NSSet alloc] initWithObjects:@"9100827340001",@"9100827340002",@"9100827340003",@"9100827340004",@"9100827340005",@"9100827340009",@"91008273400010",@"91008273400011", nil];  //需要加产品id
        
        [IAPShare sharedHelper].iap = [[IAPHelper alloc] initWithProductIdentifiers:dataSet];
    }
    
    [IAPShare sharedHelper].iap.production = NO;  //测试
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    NSInteger _index=3;
    if ([CGSingleCommitData sharedInstance].isDebug) {
        _index=2;
    }
    if(viewController == [tabBarController.viewControllers objectAtIndex:_index]) {
        if ([CGSingleCommitData sharedInstance].uid.length<=0) {
            CGManageRegisterViewController *rootVC=[[CGManageRegisterViewController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:rootVC];
            [self.window.rootViewController presentViewController:nav animated:YES completion:nil];
            
            return NO;
        }
    }
    return YES;
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
