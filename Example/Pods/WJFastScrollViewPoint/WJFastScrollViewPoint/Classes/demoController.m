//
//  demoController.m
//  BHInfiniteScrollView
//
//  Created by libohao on 16/3/8.
//  Copyright © 2016年 libohao. All rights reserved.
//
/*
 *********************************************************************************
 *
 * 如果您使用轮播图库的过程中遇到Bug,请联系我,我将会及时修复Bug，为你解答问题。
 * QQ讨论群 :  206177395 (BHInfiniteScrollView讨论群)
 * Email:  375795423@qq.com
 * GitHub: https://github.com/qylibohao
 *
 *
 *********************************************************************************
 */

#import "demoController.h"
#import "BHInfiniteScrollView.h"


@interface demoController ()<BHInfiniteScrollViewDelegate>

@property (nonatomic, strong) BHInfiniteScrollView* infinitePageView;

@end

@implementation demoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.automaticallyAdjustsScrollViewInsets = YES;
    
    NSArray* urlsArray = @[
                           @"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1602/26/c0/18646722_1456498424671_800x600.jpg",
                           @"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1602/26/c0/18646649_1456498410838_800x600.jpg",
                           @"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1602/26/c0/18646706_1456498430419_800x600.jpg",
                           @"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1602/26/c0/18646723_1456498427059_800x600.jpg",
                           @"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1602/26/c0/18646705_1456498422529_800x600.jpg"
                           ];
    
    
    NSArray* titlesArray = @[@"欢迎使用BHInfiniteScrollView无限轮播图",
                             @"如果你在使用过程中遇到什么疑问",
                             @"可以添加QQ群：206177395",
                             @"我会及时修复bug",
                             @"为你解答问题",
                             ];
    
    CGFloat viewHeight = [UIScreen mainScreen].bounds.size.height/4;
    
    BHInfiniteScrollView* infinitePageView1 = [BHInfiniteScrollView
                                              infiniteScrollViewWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), viewHeight) Delegate:self ImagesArray:urlsArray];
    infinitePageView1.titlesArray = titlesArray;
    infinitePageView1.dotSize = 10;
    infinitePageView1.pageControlAlignmentOffset = CGSizeMake(0, 20);
    infinitePageView1.titleView.textColor = [UIColor whiteColor];
    infinitePageView1.dotColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:0.24];
    infinitePageView1.titleView.margin = 30;
    infinitePageView1.titleView.hidden = YES;
    infinitePageView1.scrollTimeInterval = 2;
    infinitePageView1.autoScrollToNextPage = YES;
    infinitePageView1.delegate = self;
    [self.view addSubview:infinitePageView1];
    
    
    
    [self performSelector:@selector(stop) withObject:nil afterDelay:5];
    [self performSelector:@selector(start) withObject:nil afterDelay:10];

}

- (void)stop {
    [_infinitePageView stopAutoScrollPage];
}

- (void)start {
    [_infinitePageView startAutoScrollPage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)infiniteScrollView:(BHInfiniteScrollView *)infiniteScrollView didScrollToIndex:(NSInteger)index {
    NSLog(@"did scroll to index %ld", index);
}

- (void)infiniteScrollView:(BHInfiniteScrollView *)infiniteScrollView didSelectItemAtIndex:(NSInteger)index {
    //NSLog(@"did select item at index %ld", index);
}

@end
