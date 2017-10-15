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
#import "MyIndexViewController.h"
@interface IndexViewController ()<BHInfiniteScrollViewDelegate>
@property (nonatomic, strong) UIView* infinitePageView;
@property (nonatomic, strong)UIImageView *infiniteImgView;
@property (nonatomic, strong)IndexCollectionView *indexCollectionView;
@property (nonatomic, strong)UIScrollView *verScrollview;
@end

@implementation IndexViewController

-(void)viewWillAppear:(BOOL)animated
{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor=[UIColor colorWithRed:239 green:239 blue:243 alpha:1];
    [self addSubViews];
    [self setHeaderView];
    [self setTableView];
}

-(void)setHeaderView{
    [self setUpNavWithTitle:@"onLine" leftIcon:nil rightIcon:nil leftTitle:nil rightTitle:nil delegate:nil];
}

-(void)addSubViews{
    [self.view addSubview:self.indexCollectionView];
}


-(void)setTableView{
    self.indexCollectionView=[[IndexCollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) onCellSelected:^(NSIndexPath  *indexPath) {
        MyIndexViewController *index=[[MyIndexViewController alloc] init];
        [self.navigationController pushViewController:index animated:NO];
    }];
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

-(UIScrollView *)verScrollview{
    if (!_verScrollview) {
        _verScrollview=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
    }
    
    return _verScrollview;
}
@end
