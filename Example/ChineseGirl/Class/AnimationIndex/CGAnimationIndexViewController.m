//
//  CGAnimationIndexViewController.m
//  ChineseGirl_Example
//
//  Created by wallen on 2017/11/24.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGAnimationIndexViewController.h"
#import "EZJFastTableView.h"
#import "CGFriendsAddViewController.h"
#import "CGAnimationIndexCell.h"
@interface CGAnimationIndexViewController ()
@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)UIButton *rightIcon;
@property(nonatomic,strong)UIImageView *titleImg;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIView *lineView;
@property(nonatomic,strong)EZJFastTableView *tbv;
@end

@implementation CGAnimationIndexViewController

-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor getColor:@"EEEEEE"];
    [self addHeaderView];
    [self addBodyView];
}

-(void)addHeaderView{
    [self.view addSubview:self.headerView];
    // [self.headerView addSubview:self.titleImg];
    [self.headerView addSubview:self.titleLabel];
    [self.headerView addSubview:self.rightIcon];
    [self.view addSubview:self.lineView];
}

-(void)addBodyView{
    [self.view addSubview:self.tbv];
}

- (void)addFriend{
    CGFriendsAddViewController *addVC=[[CGFriendsAddViewController alloc] init];
    [self.navigationController pushViewController:addVC animated:NO];
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

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 32*SCREEN_RADIO, screen_width, 30*SCREEN_RADIO)];
        _titleLabel.text=@"ChineseGirl";
        _titleLabel.textColor=[UIColor getColor:@"1D1D1B"];
        _titleLabel.font=[UIFont fontWithName:@"Billabong" size:25*SCREEN_RADIO];
        _titleLabel.textAlignment=NSTextAlignmentCenter;
    }
    
    return _titleLabel;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView=[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headerView.frame)-1, screen_width, 1)];
        _lineView.backgroundColor=[UIColor getColor:@"FAFAFA"];
    }
    
    return _lineView;
}

-(EZJFastTableView *)tbv{
    if (!_tbv) {
        
        __weak typeof(self) weakSelf = self;
        CGRect tbvFrame = CGRectMake(0, 64*SCREEN_RADIO, self.view.frame.size.width, screen_height-64*SCREEN_RADIO);
        //初始化
        
        _tbv = [[EZJFastTableView alloc]initWithFrame:tbvFrame];
        _tbv.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tbv.backgroundColor=[UIColor getColor:@"EEEEEE"];
        //给tableview赋值
        NSMutableArray *newArr=[NSMutableArray new];
        for (int i=0; i<1; i++) {
            [newArr addObject:[NSString stringWithFormat:@"cell%d",i]];
        }
        [_tbv setDataArray:newArr];
        
        [_tbv onBuildCell:^(id cellData,NSString *cellIdentifier,NSIndexPath *index) {
            CGAnimationIndexCell *cell=[[CGAnimationIndexCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier withModel:cellData];
            return cell;
        }];
        
        //动态改变
        
        [_tbv onChangeCellHeight:^CGFloat(NSIndexPath *indexPath,id cellData) {
           
            return 180*SCREEN_RADIO;
        }];
        
        
        
        //允许上行滑动
        [_tbv onDragUp:^(int page) {
            
        }];
        
        //允许下行滑动刷新
        //            [_tbv onDragDown:^{
        //                [weakSelf getCollectionData];
        //            }];
        
        
        //设置选中事件 block设置方式
        //indexPath  是当前行对象 indexPath.row(获取行数)
        //cellData 是当前行的数据
        
        [_tbv onCellSelected:^(NSIndexPath *indexPath, id cellData) {
            NSLog(@"click");
           
        }];
        
    
        
    }
    
    return _tbv;
}


@end
