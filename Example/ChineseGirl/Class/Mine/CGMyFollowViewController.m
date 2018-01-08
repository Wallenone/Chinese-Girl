//
//  CGVipViewController.m
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/11/17.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGMyFollowViewController.h"
#import "EZJFastTableView.h"
#import "CGFollowTableViewCell.h"
#import "CGUserInfo.h"
#import "MyIndexViewController.h"
@interface CGMyFollowViewController ()
@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)UIButton *leftIcon;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIView *lineView;
@property(nonatomic,strong)EZJFastTableView *tbv;
@property(nonatomic,strong)NSMutableArray *followsArr;
@end

@implementation CGMyFollowViewController
- (void)viewWillAppear:(BOOL)animated{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
    [self getData];
    [self.tbv updateData:self.followsArr];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
    [self addSubViews];
}

-(void)addSubViews{
    self.view.backgroundColor=[UIColor getColor:@"f0f1f2"];
    [self.view addSubview:self.headerView];
    [self.headerView addSubview:self.titleLabel];
    [self.headerView addSubview:self.leftIcon];
    [self.view addSubview:self.tbv];
}

-(void)getData{
    [self.followsArr removeAllObjects];
    for (NSString *ids in [CGSingleCommitData sharedInstance].follows) {
        if (ids.length>0) {
           CGUserInfo *userInfo= [CGUserInfo getitemWithID:ids];
           [self.followsArr addObject:userInfo];
        }
    }
}

-(UIView *)headerView{
    if (!_headerView) {
        _headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, 64*SCREEN_RADIO)];
        _headerView.backgroundColor=[UIColor whiteColor];
    }
    
    return _headerView;
}

-(void)back{
    [self.navigationController popViewControllerAnimated:NO];
}


-(UIButton *)leftIcon{
    if (!_leftIcon) {
        _leftIcon=[[UIButton alloc] initWithFrame:CGRectMake(16*SCREEN_RADIO, 33*SCREEN_RADIO, 10*SCREEN_RADIO, 19*SCREEN_RADIO)];
        [_leftIcon setImage:[UIImage imageNamed:@"BlackArrowleft"] forState:UIControlStateNormal];
        [_leftIcon addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftIcon;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 29*SCREEN_RADIO, screen_width, 24*SCREEN_RADIO)];
        _titleLabel.text=NSLocalizedString(@"guanzhu", nil);
        _titleLabel.font=[UIFont systemFontOfSize:18*SCREEN_RADIO];
        _titleLabel.textColor=[UIColor getColor:@"232627"];
        _titleLabel.textAlignment=NSTextAlignmentCenter;
    }
    return _titleLabel;
}


-(EZJFastTableView *)tbv{
    if (!_tbv) {
        
        CGRect tbvFrame = CGRectMake(0, 64*SCREEN_RADIO+1, self.view.frame.size.width, 62*SCREEN_RADIO*self.followsArr.count);
        //初始化
        
        _tbv = [[EZJFastTableView alloc]initWithFrame:tbvFrame];
        _tbv.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tbv.scrollEnabled=NO;
        _tbv.backgroundColor=[UIColor getColor:@"f0f1f2"];
        [_tbv setDataArray:self.followsArr];
        __weak __typeof(self)weakSelf = self;
        [_tbv onBuildCell:^(id cellData,NSString *cellIdentifier,NSIndexPath *index) {
            BOOL lineState=NO;
            if (index.row== self.followsArr.count-1) {
                lineState=YES;
            }
            CGFollowTableViewCell *cell=[[CGFollowTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier withModel:cellData withHidden:lineState];
            
            return cell;
        }];
        
        //动态改变
        
        [_tbv onChangeCellHeight:^CGFloat(NSIndexPath *indexPath,id cellData) {
            return 62*SCREEN_RADIO;
        }];
        
        [_tbv onCellediting:^(NSIndexPath *index, id cellData) {
            CGUserInfo *model=cellData;
            [[CGSingleCommitData sharedInstance] deletefollow:model.ids];
        }];
        
        //    //允许上行滑动
        //    [_tbv onDragUp:^NSArray * (int page) {
        //        return [self loadNewData:page];
        //    }];
        //
        //    //允许下行滑动刷新
        //    [_tbv onDragDown:^{
        //
        //    }];
        
        
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

-(NSMutableArray *)followsArr{
    if (!_followsArr) {
        _followsArr=[[NSMutableArray alloc] init];
    }
    
    return _followsArr;
}

@end

