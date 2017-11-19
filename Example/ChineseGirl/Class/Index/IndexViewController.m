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
#import "CGFriendsAddViewController.h"
@interface IndexViewController ()<BHInfiniteScrollViewDelegate,HzfNavigationBarDelegate>
@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)UIButton *rightIcon;
@property(nonatomic,strong)UIImageView *titleImg;
@property(nonatomic,strong)UIView *lineView;
@property (nonatomic, strong)UIView* infinitePageView;
@property (nonatomic, strong)UIImageView *infiniteImgView;
@property (nonatomic, strong)IndexCollectionView *indexCollectionView;
@property (nonatomic, strong)UIScrollView *verScrollview;
@end

@implementation IndexViewController

-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor=[UIColor getColor:@"EEEEEE"];
    [self addSubViews];
    [self setHeaderView];
    [self setTableView];
}

-(void)setHeaderView{
    [self.view addSubview:self.headerView];
    [self.headerView addSubview:self.titleImg];
    [self.headerView addSubview:self.rightIcon];
    [self.view addSubview:self.lineView];
}



- (void)addFriend{
    CGFriendsAddViewController *addVC=[[CGFriendsAddViewController alloc] init];
    [self.navigationController pushViewController:addVC animated:NO];
}

-(void)addSubViews{
    [self.view addSubview:self.indexCollectionView];
}

-(void)setTableView{
    self.indexCollectionView=[[IndexCollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headerView.frame), self.view.frame.size.width, self.view.frame.size.height) onCellSelected:^(NSIndexPath  *indexPath) {
            MyIndexViewController *index=[[MyIndexViewController alloc] init];
            index.ids=indexPath.row;
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
-(UIView *)headerView{
    if (!_headerView) {
        _headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, 64*SCREEN_RADIO)];
        _headerView.backgroundColor=[UIColor whiteColor];
    }
    
    return _headerView;
}

-(UIButton *)rightIcon{
    if (!_rightIcon) {
        _rightIcon=[[UIButton alloc] initWithFrame:CGRectMake(screen_width-32*SCREEN_RADIO, 32*SCREEN_RADIO, 22*SCREEN_RADIO, 22*SCREEN_RADIO)];
        [_rightIcon setImage:[UIImage imageNamed:@"addFriends"] forState:UIControlStateNormal];
        [_rightIcon addTarget:self action:@selector(addFriend) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightIcon;
}

-(UIImageView *)titleImg{
    if (!_titleImg) {
        _titleImg=[[UIImageView alloc] initWithFrame:CGRectMake(screen_width/2-47*SCREEN_RADIO, 32*SCREEN_RADIO, 94*SCREEN_RADIO, 27*SCREEN_RADIO)];
        _titleImg.image=[UIImage imageNamed:@"BitmapIcon"];
    }
    return _titleImg;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView=[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headerView.frame)-1, screen_width, 1)];
        _lineView.backgroundColor=[UIColor getColor:@"FAFAFA"];
    }
    
    return _lineView;
}


-(UIScrollView *)verScrollview{
    if (!_verScrollview) {
        _verScrollview=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
    }
    
    return _verScrollview;
}
@end
