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
@interface NewsViewController ()
@property(nonatomic,strong)EZJFastTableView *tbv;
@end

@implementation NewsViewController

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [self.tabBarController.tabBar setHidden:YES];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [self.tabBarController.tabBar setHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setHeaderView];
    [self addSubViews];
}

-(void)setHeaderView{
    [self setUpNavWithTitle:@"Activity" leftIcon:@"news_Menu" rightIcon:@"" leftTitle:nil rightTitle:nil delegate:nil];
}

-(void)addSubViews{
    [self.view addSubview:self.tbv];
}

-(EZJFastTableView *)tbv{
    if (!_tbv) {
        
        
        CGRect tbvFrame = CGRectMake(0, 0, self.view.frame.size.width, screen_height);
        //初始化
        
        _tbv = [[EZJFastTableView alloc]initWithFrame:tbvFrame];
        _tbv.separatorStyle=UITableViewCellSeparatorStyleNone;
        NSMutableArray *arrays =[[NSMutableArray alloc] init];
        
        NewsInfoModel *model = [[NewsInfoModel alloc] init];
        model.icon = @"Avatar";
        model.nickName = @"Randy Young";
        model.content = @"This is a book！";
        
        NewsInfoModel *model1 = [[NewsInfoModel alloc] init];
        model1.icon = @"Avatar";
        model1.nickName = @"Randy Young1";
        model1.content = @"This is a book！1";
        
        NewsInfoModel *model2 = [[NewsInfoModel alloc] init];
        model2.icon = @"Avatar";
        model2.nickName = @"Randy Young2";
        model2.content = @"This is a book！2";
        //给tableview赋值
        [arrays addObject:model];
        [arrays addObject:model1];
        [arrays addObject:model2];
        [_tbv setDataArray:arrays];
        
        [_tbv onBuildCell:^(id cellData,NSString *cellIdentifier,NSIndexPath *index) {
            NewsInfoCellTableViewCell *cell =[[NewsInfoCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier WithModel:cellData];
            
            return cell;
            
        }];
        
       
        
        //动态改变
        [_tbv onChangeCellHeight:^CGFloat(NSIndexPath *indexPath,id cellData) {
            
            return 82*SCREEN_RADIO;
        }];
        
    
        
        //设置选中事件 block设置方式
        //indexPath  是当前行对象 indexPath.row(获取行数)
        //cellData 是当前行的数据
        
        [_tbv onCellSelected:^(NSIndexPath *indexPath, id cellData) {
            NSLog(@"click");
            NewsMessageController *messageVC=[[NewsMessageController alloc] init];
            [self.navigationController pushViewController:messageVC animated:YES];
        }];
        
    }
    
    return _tbv;
}


@end
