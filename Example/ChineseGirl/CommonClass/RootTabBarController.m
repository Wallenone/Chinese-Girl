//
//  RootTabBarController.m
//  StartMovie
//
//  Created by iMac on 17/5/25.
//  Copyright © 2017年 sinfotek. All rights reserved.
//

#import "RootTabBarController.h"

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
#import "RootNavController.h"
#import "CGLoginViewController.h"
@interface RootTabBarController ()<UITabBarControllerDelegate>
@property(nonatomic,strong)LCTabBarController *tabBarC;
@end

@implementation RootTabBarController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //创建子控制器
    [self _createSubCtrls];
    
}

- (void)_createSubCtrls{
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    //a.初始化一个tabBar控制器
   // UITabBarController *tb=[[UITabBarController alloc]init];
    self.tabBar.backgroundColor=[UIColor whiteColor];
    self.tabBar.tintColor=[UIColor blackColor];
    self.tabBar.unselectedItemTintColor=[UIColor blackColor];
    self.delegate=self;
    self.tabBar.translucent=YES;
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
    
//    CGFriendsViewcontroller *friendVC=[[CGFriendsViewcontroller alloc] init];
//    friendVC.tabBarItem.image=[UIImage imageNamed:@"Home"];
//    friendVC.tabBarItem.selectedImage=[UIImage imageNamed:@"Homeed"];
//    friendVC.tabBarItem.imageInsets = UIEdgeInsetsMake(7, 0, -7, 0);
    
    NewsViewController *newsVC=[[NewsViewController alloc] init];
    newsVC.tabBarItem.image=[UIImage imageNamed:@"Home"];
    newsVC.tabBarItem.selectedImage=[UIImage imageNamed:@"Homeed"];
    newsVC.tabBarItem.imageInsets = UIEdgeInsetsMake(7, 0, -7, 0);
    
    CGLoginViewController *mineVC=[[CGLoginViewController alloc] init];
    mineVC.tabBarItem.image=[UIImage imageNamed:@"Profile"];
    mineVC.tabBarItem.selectedImage=[UIImage imageNamed:@"Profileed"];
    mineVC.tabBarItem.imageInsets = UIEdgeInsetsMake(7, 0, -7, 0);
    
    
//    UINavigationController *c1=[[UINavigationController alloc]initWithRootViewController:indeVC];
//    UINavigationController *c2=[[UINavigationController alloc]initWithRootViewController:animationVC];
//    UINavigationController *c3=[[UINavigationController alloc]initWithRootViewController:friendVC];
//    UINavigationController *c4=[[UINavigationController alloc]initWithRootViewController:newsVC];
//    UINavigationController *c5=[[UINavigationController alloc]initWithRootViewController:mineVC];
    
    //创建数组
    NSArray *viewCtrls = @[indeVC,animationVC,newsVC,mineVC];
    
    //创建可变数组,存储导航控制器
    NSMutableArray *navs = [NSMutableArray arrayWithCapacity:viewCtrls.count];
    
    //创建二级控制器导航控制器
    for (UIViewController *ctrl in viewCtrls) {
        RootNavController *nav = [[RootNavController alloc] initWithRootViewController:ctrl];
        //将导航控制器加入到数组中
        [navs addObject:nav];
    }
    
    //将导航控制器交给标签控制器管理
    self.viewControllers = navs;
    
}

//- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
//    if(viewController == [tabBarController.viewControllers objectAtIndex:3]) {
//        if ([CGSingleCommitData sharedInstance].uid.length>0) {
//
//        }else{
//            CGRegisterNewIndexViewController *rootVC=[[CGRegisterNewIndexViewController alloc] init];
//            UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:<#(nonnull UIViewController *)#>]
//        }
//    }
//    return YES;
//}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
}

- (void)tabBarController:(UITabBarController *)tabBarController willBeginCustomizingViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers{
    
}

- (void)tabBarController:(UITabBarController *)tabBarController willEndCustomizingViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers changed:(BOOL)changed{
    
}

- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers changed:(BOOL)changed{
    
}


@end
