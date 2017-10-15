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
@property (nonatomic,strong)UIImageView *infiniteImgView;
@property (nonatomic, strong) IndexCollectionView *indexCollectionView;
@end

@implementation IndexViewController

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillAppear:animated];
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
    self.infinitePageView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 200*SCREEN_RADIO)];
    self.infiniteImgView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 200*SCREEN_RADIO)];
    self.infiniteImgView.image=[UIImage imageNamed:@"https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=2231522172,3198791950&fm=173&s=5527965541A1E9475A19147B0300D072&w=640&h=364&img.JPG"];
    [self.infinitePageView addSubview:self.infiniteImgView];
    [self.view addSubview:self.infinitePageView];
}

-(void)setTableView{
    self.indexCollectionView=[[IndexCollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.infinitePageView.frame), self.view.frame.size.width, self.view.frame.size.height) onCellSelected:^(NSIndexPath  *indexPath) {
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



@end
