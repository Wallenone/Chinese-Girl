//
//  IndexViewController.m
//  ChineseGirl
//
//  Created by wallen on 2017/8/8.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "IndexViewController.h"
#import "BHInfiniteScrollView.h"
#import "EZJFastTableView.h"
#import "IndexCollectionView.h"
@interface IndexViewController ()<BHInfiniteScrollViewDelegate>
@property (nonatomic, strong) BHInfiniteScrollView* infinitePageView;
@property (nonatomic, strong) IndexCollectionView *indexCollectionView;
@end

@implementation IndexViewController

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setHeaderView];
    [self setScrollViewPoint];
    [self setTableView];
}

-(void)setHeaderView{
    [self setUpNavWithTitle:@"onLine" leftIcon:nil rightIcon:nil leftTitle:nil rightTitle:nil delegate:nil];
}

-(void)setScrollViewPoint{
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
    
    
    self.infinitePageView = [BHInfiniteScrollView
                                               infiniteScrollViewWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 100) Delegate:self ImagesArray:urlsArray];
    self.infinitePageView.backgroundColor=[UIColor redColor];
    self.infinitePageView.titlesArray = titlesArray;
    self.infinitePageView.dotSize = 10;
    self.infinitePageView.pageControlAlignmentOffset = CGSizeMake(0, 20);
    self.infinitePageView.titleView.textColor = [UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:0.24];
    self.infinitePageView.dotColor = [UIColor redColor];
    self.infinitePageView.titleView.margin = 30;
    self.infinitePageView.titleView.hidden = YES;
    self.infinitePageView.scrollTimeInterval = 2;
    self.infinitePageView.autoScrollToNextPage = YES;
    self.infinitePageView.delegate = self;
    [self.view addSubview:self.infinitePageView];
    
}

-(void)setTableView{
    self.indexCollectionView=[[IndexCollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.infinitePageView.frame), self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:self.indexCollectionView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)infiniteScrollView:(BHInfiniteScrollView *)infiniteScrollView didScrollToIndex:(NSInteger)index {
    //NSLog(@"did scroll to index %ld", index);
}

- (void)infiniteScrollView:(BHInfiniteScrollView *)infiniteScrollView didSelectItemAtIndex:(NSInteger)index {
    //NSLog(@"did select item at index %ld", index);
}



@end
