//
//  CGFriendsAddViewController.m
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/11/15.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGFriendsAddViewController.h"
#import "EZJFastTableView.h"
#import "CGNewFriendTableViewCell.h"
#import "CGUserInfo.h"
#import "MyIndexViewController.h"
@interface CGFriendsAddViewController ()
@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)UIView *lineView;
@property(nonatomic,strong)RkyExtendedHitButton *leftIcon;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)EZJFastTableView *tbv;
@property(nonatomic,assign)NSInteger currentPage;
@end

@implementation CGFriendsAddViewController

- (void)viewWillAppear:(BOOL)animated{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [self.tabBarController.tabBar setHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor getColor:@"EEEEEE"];
    [self setData];
    [self setHeaderView];
    [self addSubViews];
}

-(void)setData{
    _currentPage=1;
    [CGUserInfo updateReloadTable];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setHeaderView{
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.leftIcon];
}

-(void)addSubViews{
    [self.view addSubview:self.tbv];
}

-(void)getCollectionData{
    NSMutableArray *array = [CGUserInfo reloadTableWithRangeFrom:_currentPage*10 rangeTLenth:10];
    if (array.count>0) {
        [self.tbv addContentData:array];
        _currentPage++;
    }else{
        [self.tbv noMoreData];
    }
}

-(void)updateData{
    NSMutableArray *array = [CGUserInfo reloadTableWithRangeFrom:_currentPage*10 rangeTLenth:10];
    if (array.count>0) {
        [self.tbv updateData:array];
        _currentPage++;
    }else{
        [self.tbv noMoreData];
    }
}


-(UIView *)headerView{
    if (!_headerView) {
        _headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, 64*SCREEN_RADIO)];
        _headerView.backgroundColor=[UIColor whiteColor];
    }
    
    return _headerView;
}



-(RkyExtendedHitButton *)leftIcon{
    if (!_leftIcon) {
        _leftIcon=[[RkyExtendedHitButton alloc] initWithFrame:CGRectMake(19*SCREEN_RADIO, 34*SCREEN_RADIO, 10*SCREEN_RADIO, 16*SCREEN_RADIO)];
        [_leftIcon setImage:[UIImage imageNamed:@"BlackArrowleft"] forState:UIControlStateNormal];
        [_leftIcon addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        _leftIcon.hitTestEdgeInsets = UIEdgeInsetsMake(-25, -25, -25, -25);
    }
    return _leftIcon;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 32*SCREEN_RADIO, screen_width, 20*SCREEN_RADIO)];
        _titleLabel.text=NSLocalizedString(@"xinpengyou", nil);
        _titleLabel.font=[UIFont systemFontOfSize:17*SCREEN_RADIO];
        _titleLabel.textColor=[UIColor getColor:@"030303"];
        _titleLabel.textAlignment=NSTextAlignmentCenter;
    }
    return _titleLabel;
}


-(EZJFastTableView *)tbv{
    if (!_tbv) {
        
        CGRect tbvFrame = CGRectMake(0, 60*SCREEN_RADIO+1, self.view.frame.size.width, screen_height-60*SCREEN_RADIO);
        //初始化
        
        _tbv = [[EZJFastTableView alloc]initWithFrame:tbvFrame];
        _tbv.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tbv.backgroundColor=[UIColor getColor:@"eeeeee"];
        [_tbv setDataArray:[CGUserInfo reloadTableWithRangeFrom:0 rangeTLenth:10]];
        __weak __typeof(self)weakSelf = self;
        [_tbv onBuildCell:^(id cellData,NSString *cellIdentifier,NSIndexPath *index) {
            CGNewFriendTableViewCell *cell=[[CGNewFriendTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier WithModel:cellData];

            return cell;
        }];
        
        //动态改变
        
        [_tbv onChangeCellHeight:^CGFloat(NSIndexPath *indexPath,id cellData) {
            return 181*SCREEN_RADIO;
        }];
        
        
        
        //允许上行滑动
        [_tbv onDragUp:^(int page) {
            [weakSelf getCollectionData];
        }];
        
        //允许下行滑动刷新
        [_tbv onDragDown:^{
            weakSelf.currentPage=0;
            [CGUserInfo updateReloadTable];
            [weakSelf updateData];
        }];
        
        
        //设置选中事件 block设置方式
        //indexPath  是当前行对象 indexPath.row(获取行数)
        //cellData 是当前行的数据
        
        [_tbv onCellSelected:^(NSIndexPath *indexPath, id cellData) {
            NSLog(@"click");
            CGUserInfo *model=cellData;
            MyIndexViewController *indexVC=[[MyIndexViewController alloc] init];
            indexVC.ids=[model.ids integerValue];
            [weakSelf.navigationController pushViewController:indexVC animated:NO];
        }];
        
    }
    
    return _tbv;
}


@end
