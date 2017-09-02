//
//  MyCommitSViewController.m
//  ChineseGirl
//
//  Created by Wallen on 2017/9/2.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "MyCommitSViewController.h"
#import "MyCommitHeaderView.h"
#import "MycommitModel.h"
#import "EZJFastTableView.h"
#import "myCommitCell.h"
@interface MyCommitSViewController ()
@property(nonatomic,strong)EZJFastTableView *tbv;
@end

@implementation MyCommitSViewController



-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}


-(void)setHeaderView{
    [self setUpNavWithTitle:@"Activity" leftIcon:@"news_Menu" rightIcon:nil leftTitle:nil rightTitle:nil delegate:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setHeaderView];
    [self addSubViews];
}

-(void)addSubViews{
    [self.view addSubview:self.tbv];
}

-(CGFloat)getCellHeightWithModel:(MycommitModel *)model withIndex:(NSInteger)index{
    CGFloat _height=50*SCREEN_RADIO;
    
    if (index==0) {
        _height=97;
    }

    CGSize constraint = CGSizeMake(screen_width-30*SCREEN_RADIO, 99999.0f);
    CGSize size = [model.content sizeWithFont:[UIFont systemFontOfSize:14*SCREEN_RADIO] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    _height+=size.height;
 
    
    return _height;
}



-(EZJFastTableView *)tbv{
    if (!_tbv) {
        _tbv = [[EZJFastTableView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height-64)];
        _tbv.separatorStyle=UITableViewCellSeparatorStyleNone;
        
        NSMutableArray *arrays=[[NSMutableArray alloc] init];
        for (int i=0; i<15; i++) {
            MycommitModel *model=[[MycommitModel alloc] init];
            model.icon=@"Avatar";
            model.nickName=@"Wallen";
            model.date=@"2017.9.1 14:30:21";
            model.content=[NSString stringWithFormat:@"%d-哈哈，说的不错了啊！Lorem ipsum",i];
            [arrays addObject:model];
        }
        
         [_tbv setDataArray:arrays];
        
        [_tbv onBuildCell:^(id cellData,NSString *cellIdentifier,NSIndexPath *index) {
            if (index.row==0) {
                MyCommitHeaderView *headerView=[[MyCommitHeaderView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier WithModel:cellData];
                headerView.userInteractionEnabled = true;
                return (UITableViewCell *)headerView;

            }else{
                myCommitCell *cell=[[myCommitCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier WithModel:cellData];
                cell.userInteractionEnabled = true;
                return (UITableViewCell *)cell;
            }
            
        }];
        
        //动态改变
        __weak typeof(self) weakSelf = self;
        [_tbv onChangeCellHeight:^CGFloat(NSIndexPath *indexPath,id cellData) {
            
            if (indexPath.row==0) {
                return [weakSelf getCellHeightWithModel:cellData withIndex:indexPath.row];
            }else{
                return [weakSelf getCellHeightWithModel:cellData withIndex:indexPath.row];
            }
            
        }];
        

        
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
