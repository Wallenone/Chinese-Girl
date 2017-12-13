//
//  CGVipViewController.m
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/11/17.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGVipViewController.h"
#import "EZJFastTableView.h"
#import "CGVipTableViewCell.h"
@interface CGVipViewController ()
@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)UIButton *leftIcon;
@property(nonatomic,strong)UIImageView *vipIcon;
@property(nonatomic,strong)UILabel *vipTitle;
@property(nonatomic,strong)UIView *headerLine;
@property(nonatomic,strong)UILabel *vipLabel;
@property(nonatomic,strong)UIButton *payBtn;
@property(nonatomic,strong)UIView *lineView;
@property(nonatomic,strong)EZJFastTableView *tbv;
@end

@implementation CGVipViewController
- (void)viewWillAppear:(BOOL)animated{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubViews];
}

-(void)addSubViews{
    self.view.backgroundColor=[UIColor getColor:@"ffffff"];
    [self.view addSubview:self.headerView];
    [self.headerView addSubview:self.leftIcon];
    [self.view addSubview:self.tbv];
}

-(UIView *)headerView{
    if (!_headerView) {
        _headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height/2-50)];
        _headerView.backgroundColor=[UIColor getColor:@"46198d"];
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

-(UIImageView *)vipIcon{
    if (!_vipIcon) {
        _vipIcon=[[UIImageView alloc] initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)]
    }
}
@property(nonatomic,strong)UIImageView *vipIcon;
@property(nonatomic,strong)UILabel *vipTitle;
@property(nonatomic,strong)UIView *headerLine;
@property(nonatomic,strong)UILabel *vipLabel;
@property(nonatomic,strong)UIButton *payBtn;
@property(nonatomic,strong)UIView *lineView;


-(EZJFastTableView *)tbv{
    if (!_tbv) {
        
        CGRect tbvFrame = CGRectMake(0, 64*SCREEN_RADIO+1, self.view.frame.size.width, 62*SCREEN_RADIO*4);
        //初始化
        
        _tbv = [[EZJFastTableView alloc]initWithFrame:tbvFrame];
        _tbv.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tbv.scrollEnabled=NO;
        [_tbv setDataArray:@[@{@"content":@"12个月VIP服务",@"moneyNum":@"298"},@{@"content":@"6个月VIP服务",@"moneyNum":@"168"},@{@"content":@"3个月VIP服务",@"moneyNum":@"88"},@{@"content":@"1个月VIP服务",@"moneyNum":@"30"}]];
        __weak __typeof(self)weakSelf = self;
        [_tbv onBuildCell:^(id cellData,NSString *cellIdentifier,NSIndexPath *index) {
            CGVipTableViewCell *cell=[[CGVipTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier withLabel:[cellData objectForKey:@"content"] withMoney:[cellData objectForKey:@"moneyNum"]];
           
            return cell;
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
            
        }];
        
    }
    
    return _tbv;
}

@end
