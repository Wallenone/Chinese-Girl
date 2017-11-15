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
#import "CGaddFriendsModel.h"
#import "CGAnswerOptionViewController.h"
@interface CGFriendsAddViewController ()
@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)UIView *lineView;
@property(nonatomic,strong)UIButton *leftIcon;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)EZJFastTableView *tbv;
@end

@implementation CGFriendsAddViewController

- (void)viewWillAppear:(BOOL)animated{
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
    self.view.backgroundColor=[UIColor getColor:@"f0f0f0"];
    [self setHeaderView];
    [self addSubViews];
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


-(UIView *)headerView{
    if (!_headerView) {
        _headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, 60*SCREEN_RADIO)];
        _headerView.backgroundColor=[UIColor whiteColor];
    }
    
    return _headerView;
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
        _titleLabel.text=@"新朋友";
        _titleLabel.font=[UIFont systemFontOfSize:18*SCREEN_RADIO];
        _titleLabel.textColor=[UIColor getColor:@"232627"];
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
        [_tbv setDataArray:[CGaddFriendsModel reloadTable]];
        __weak __typeof(self)weakSelf = self;
        [_tbv onBuildCell:^(id cellData,NSString *cellIdentifier,NSIndexPath *index) {
            CGNewFriendTableViewCell *cell=[[CGNewFriendTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier WithModel:cellData withAddFriendBlock:^{
                CGAnswerOptionViewController *answerVC=[[CGAnswerOptionViewController alloc] init];
                [weakSelf.navigationController pushViewController:answerVC animated:NO];
            }];

            return cell;
        }];
        
        //动态改变
        
        [_tbv onChangeCellHeight:^CGFloat(NSIndexPath *indexPath,id cellData) {
            return 62*SCREEN_RADIO;
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
            
        }];
        
    }
    
    return _tbv;
}


@end
