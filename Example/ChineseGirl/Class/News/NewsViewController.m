//
//  NewsViewController.m
//  ChineseGirl
//
//  Created by wallen on 2017/8/8.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "NewsViewController.h"
#import "EZJFastTableView.h"
#import "NewsInfoModel.h"
#import "NewsInfoCellTableViewCell.h"
#import "NewsMessageController.h"
#import "CGUserInfo.h"
#import "CGMailListViewController.h"
#import "CGMessageModel.h"
@interface NewsViewController ()<HzfNavigationBarDelegate>
@property(nonatomic,strong)UIButton *leftIcon;
@property(nonatomic,strong)EZJFastTableView *tbv;
@end

@implementation NewsViewController

-(void)viewWillAppear:(BOOL)animated
{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:NO];
    [self.tbv updateData:[CGSingleCommitData sharedInstance].newsListArr];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setHeaderView];
    [self addSubViews];
}


- (void)NavigationBarRightButtonClicked{
    CGMailListViewController *mailList=[[CGMailListViewController alloc] init];
    [self.navigationController pushViewController:mailList animated:NO];
}

-(void)setHeaderView{
    [self setUpNavWithTitle:NSLocalizedString(@"messages", nil) leftIcon:@"" rightIcon:@"addFriends" leftTitle:nil rightTitle:nil delegate:nil];
    self.naviDelegate=self;
}

-(void)addSubViews{
    [self.view addSubview:self.tbv];
}

-(EZJFastTableView *)tbv{
    if (!_tbv) {
        
        
        CGRect tbvFrame = CGRectMake(0, 0, self.view.frame.size.width, screen_height-64*SCREEN_RADIO);
        //初始化
        __weak __typeof(self)weakSelf = self;
        _tbv = [[EZJFastTableView alloc]initWithFrame:tbvFrame];
        _tbv.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tbv.backgroundColor=[UIColor getColor:@"eeeeee"];
        [_tbv setDataArray:[CGSingleCommitData sharedInstance].newsListArr];
        
        [_tbv onBuildCell:^(id cellData,NSString *cellIdentifier,NSIndexPath *index)
         {
            NewsInfoCellTableViewCell *cell =[[NewsInfoCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier WithModel:cellData];
            
            return cell;
            
        }];
        
        
        //是否启用删除功能
        [_tbv onCellediting:^(NSIndexPath *index, id cellData) {
            [[CGSingleCommitData sharedInstance] deleteNewList:index.row];
        }];
       
        
        //动态改变
        [_tbv onChangeCellHeight:^CGFloat(NSIndexPath *indexPath,id cellData) {
            
            return 62*SCREEN_RADIO;
        }];
        
    
        
        //设置选中事件 block设置方式
        //indexPath  是当前行对象 indexPath.row(获取行数)
        //cellData 是当前行的数据
        
        [_tbv onCellSelected:^(NSIndexPath *indexPath, id cellData) {
            NSLog(@"click");
            NewsMessageController *messageVC=[[NewsMessageController alloc] init];
            messageVC.myIndexModel=[[cellData dictionaryForKey:@"content"] arrayForKey:@"item"];
            messageVC.userid=[cellData stringForKey:@"userid"];
            [weakSelf.navigationController pushViewController:messageVC animated:NO];
        }];
        
    }
    
    return _tbv;
}


@end
