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
@property (nonatomic, strong) UIScrollView *scrollViewPointView;
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
    [self addSubViews];
    [self setHeaderView];
    [self setScrollViewPoint];
    [self setTableView];
}

-(void)setHeaderView{
    [self setUpNavWithTitle:@"onLine" leftIcon:nil rightIcon:nil leftTitle:nil rightTitle:nil delegate:nil];
}

-(void)addSubViews{
    [self.view addSubview:self.scrollViewPointView];
}

-(void)setScrollViewPoint{
    for (int i=0; i<7; i++) {
        UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(10*SCREEN_RADIO+i*(15+60)*SCREEN_RADIO, 10*SCREEN_RADIO, 60*SCREEN_RADIO, 60*SCREEN_RADIO)];
        imgView.layer.cornerRadius=30*SCREEN_RADIO;
        imgView.image=[UIImage imageNamed:@"Avatar"];
        imgView.layer.borderWidth=2;
        imgView.layer.borderColor=[UIColor getColor:@"FF7D44"].CGColor;
        [self.scrollViewPointView addSubview:imgView];
        
        UILabel *nickName=[[UILabel alloc] initWithFrame:CGRectMake(10*SCREEN_RADIO+i*(15+60)*SCREEN_RADIO, CGRectGetMaxY(imgView.frame)+5*SCREEN_RADIO, 60*SCREEN_RADIO, 12*SCREEN_RADIO)];
        nickName.text=[NSString stringWithFormat:@"Avatar%d-%d",i,i];
        nickName.textColor=[UIColor getColor:@"333333"];
        nickName.textAlignment=NSTextAlignmentCenter;
        nickName.font=[UIFont systemFontOfSize:12*SCREEN_RADIO];
        [self.scrollViewPointView addSubview:nickName];
    }
    
}

-(void)setTableView{
    self.indexCollectionView=[[IndexCollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.scrollViewPointView.frame), self.view.frame.size.width, self.view.frame.size.height) onCellSelected:^(NSIndexPath  *indexPath) {
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

-(UIScrollView *)scrollViewPointView{
    if (!_scrollViewPointView) {
        _scrollViewPointView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 90*SCREEN_RADIO)];
        _scrollViewPointView.contentSize=CGSizeMake(screen_width*2, 90*SCREEN_RADIO);
    }
    
    return _scrollViewPointView;
}

@end
