//
//  MineAccountViewController.m
//  ChineseGirl
//
//  Created by Wallen on 2017/10/23.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "MineAccountViewController.h"
#import "EZJFastTableView.h"
#import "MySettingTableViewCell.h"
#import "MinePasswordViewController.h"
#import "CGLoginViewController.h"
@interface MineAccountViewController ()
@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)UILabel *titleLable;
@property(nonatomic,strong)RkyExtendedHitButton *leftBtn;
@property(nonatomic,strong)EZJFastTableView *tbv;
@property(nonatomic,strong)RkyExtendedHitButton *logoutBtn;
@end

@implementation MineAccountViewController

-(void)viewWillAppear:(BOOL)animated
{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self.tabBarController.tabBar setHidden:YES];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.tabBarController.tabBar setHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor getColor:@"F5F5F5"];
    [self addHeaderView];
    [self addBodyView];
}

-(void)addHeaderView{
    [self.view addSubview:self.headerView];
    [self.headerView addSubview:self.titleLable];
    [self.headerView addSubview:self.leftBtn];
}

-(void)addBodyView{
    [self.view addSubview:self.tbv];
    [self.view addSubview:self.logoutBtn];
}
-(void)backClick{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)logoutClick{
    [[CGSingleCommitData sharedInstance] logout];
    [self.navigationController popToRootViewControllerAnimated:NO];
}

-(UIView *)headerView{
    if (!_headerView) {
        _headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 64)];
        _headerView.backgroundColor=[UIColor whiteColor];
    }
    return _headerView;
}

-(UILabel *)titleLable{
    if (!_titleLable) {
        _titleLable=[[UILabel alloc] initWithFrame:CGRectMake(0, 29*SCREEN_RADIO, screen_width, 24*SCREEN_RADIO)];
        _titleLable.text=NSLocalizedString(@"settings", nil);
        _titleLable.textColor=[UIColor getColor:@"232627"];
        _titleLable.font=[UIFont systemFontOfSize:18*SCREEN_RADIO];
        _titleLable.textAlignment=NSTextAlignmentCenter;
    }
    return _titleLable;
}

-(RkyExtendedHitButton *)leftBtn{
    if (!_leftBtn) {
        _leftBtn=[[RkyExtendedHitButton alloc] initWithFrame:CGRectMake(18.5*SCREEN_RADIO, 35*SCREEN_RADIO, 10*SCREEN_RADIO, 19*SCREEN_RADIO)];
        [_leftBtn setBackgroundImage:[UIImage imageNamed:@"BlackArrowleft"] forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
        _leftBtn.hitTestEdgeInsets = UIEdgeInsetsMake(-25, -25, -25, -25);
    }
    
    return _leftBtn;
}

-(EZJFastTableView *)tbv{
    if (!_tbv) {
        
        NSMutableArray *arrays =[[NSMutableArray alloc] initWithObjects:NSLocalizedString(@"change_password", nil),nil];
        
        __weak typeof(self) weakSelf = self;
        CGRect tbvFrame = CGRectMake(0, 80*SCREEN_RADIO, screen_width, arrays.count*49.5*SCREEN_RADIO);
        //初始化
        
        _tbv = [[EZJFastTableView alloc]initWithFrame:tbvFrame];
        _tbv.scrollEnabled=NO;
        _tbv.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tbv.backgroundColor=[UIColor getColor:@"ffffff"];
        
        //给tableview赋值
        [_tbv setDataArray:arrays];
        
        [_tbv onBuildCell:^(id cellData,NSString *cellIdentifier,NSIndexPath *index) {
            BOOL state=NO;
            if (index.row==arrays.count-1) {
                state=YES;
            }
            MySettingTableViewCell *cell=[[MySettingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier withModel:cellData withAllowHidden:NO];
            return cell;
            
        }];
        
        //动态改变
        
        [_tbv onChangeCellHeight:^CGFloat(NSIndexPath *indexPath,id cellData) {
            
            return 49.5*SCREEN_RADIO;
        }];
        
        //设置选中事件 block设置方式
        //indexPath  是当前行对象 indexPath.row(获取行数)
        //cellData 是当前行的数据
        
        [_tbv onCellSelected:^(NSIndexPath *indexPath, id cellData) {
            
            if ([cellData isEqualToString:NSLocalizedString(@"change_password", nil)]) {
                MinePasswordViewController *passwordVC=[[MinePasswordViewController alloc] init];
                [weakSelf.navigationController pushViewController:passwordVC animated:NO];
            }
        }];
        
    }
    
    return _tbv;
}


-(RkyExtendedHitButton *)logoutBtn{
    if (!_logoutBtn) {
        _logoutBtn=[[RkyExtendedHitButton alloc] initWithFrame:CGRectMake(screen_width/2-110*SCREEN_RADIO, screen_height-90*SCREEN_RADIO, 220*SCREEN_RADIO, 42*SCREEN_RADIO)];
        [_logoutBtn setTitleColor:[UIColor getColor:@"2979FF"] forState:UIControlStateNormal];
        [_logoutBtn setTitle:NSLocalizedString(@"log_out", nil) forState:UIControlStateNormal];
        _logoutBtn.titleLabel.font=[UIFont systemFontOfSize:18*SCREEN_RADIO];
        _logoutBtn.layer.cornerRadius=21*SCREEN_RADIO;
        _logoutBtn.layer.borderWidth=1;
        _logoutBtn.layer.borderColor=[UIColor getColor:@"2979FF"].CGColor;
        [_logoutBtn addTarget:self action:@selector(logoutClick) forControlEvents:UIControlEventTouchUpInside];
        _logoutBtn.hitTestEdgeInsets = UIEdgeInsetsMake(-25, -25, -25, -25);
    }
    
    return _logoutBtn;
}


@end
