//
//  MineAccountViewController.m
//  ChineseGirl
//
//  Created by Wallen on 2017/10/23.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGLanguagesViewController.h"
#import "EZJFastTableView.h"
#import "MySettingTableViewCell.h"
#import "MinePasswordViewController.h"
#import "CGLoginViewController.h"
@interface CGLanguagesViewController ()
@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)UILabel *titleLable;
@property(nonatomic,strong)UIButton *leftBtn;
@property(nonatomic,strong)EZJFastTableView *tbv;
@property(nonatomic,strong)NSIndexPath *lastPath;// 主要是用来接收用户上一次所选的cell的indexpath，并且对其synthesize
@property(nonatomic,strong)NSMutableArray *languageArrays;
@end

@implementation CGLanguagesViewController

-(NSMutableArray *)languageArrays{
    if (!_languageArrays) {
        _languageArrays=[[NSMutableArray alloc] initWithObjects:@"English",@"简体中文",@"繁體中文",@"한국어",@"日本語",nil];
    }
 
    return _languageArrays;
}

-(void)viewWillAppear:(BOOL)animated
{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self.tabBarController.tabBar setHidden:YES];
    [super viewWillAppear:animated];
    [self setData];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.tabBarController.tabBar setHidden:NO];
}

-(void)setData{
    for (int i=0; i<self.languageArrays.count; i++) {
        if ([[self.languageArrays objectAtIndex:i] isEqualToString:[CGSingleCommitData sharedInstance].languageName]) {
            self.lastPath=[NSIndexPath indexPathForRow:i inSection:0];
        }
    }
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
        _titleLable.text=NSLocalizedString(@"choose_language", nil);
        _titleLable.textColor=[UIColor getColor:@"232627"];
        _titleLable.font=[UIFont systemFontOfSize:18*SCREEN_RADIO];
        _titleLable.textAlignment=NSTextAlignmentCenter;
    }
    return _titleLable;
}

-(UIButton *)leftBtn{
    if (!_leftBtn) {
        _leftBtn=[[UIButton alloc] initWithFrame:CGRectMake(18.5*SCREEN_RADIO, 35*SCREEN_RADIO, 10*SCREEN_RADIO, 19*SCREEN_RADIO)];
        [_leftBtn setBackgroundImage:[UIImage imageNamed:@"BlackArrowleft"] forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _leftBtn;
}

-(EZJFastTableView *)tbv{
    if (!_tbv) {
        
        __weak typeof(self) weakSelf = self;
        CGRect tbvFrame = CGRectMake(0, 80*SCREEN_RADIO, screen_width, self.languageArrays.count*49.5*SCREEN_RADIO);
        //初始化
        
        _tbv = [[EZJFastTableView alloc]initWithFrame:tbvFrame];
        _tbv.scrollEnabled=NO;
        _tbv.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tbv.backgroundColor=[UIColor getColor:@"ffffff"];
        
        //给tableview赋值
        [_tbv setDataArray:self.languageArrays];
        
        [_tbv onBuildCell:^(id cellData,NSString *cellIdentifier,NSIndexPath *index) {
            BOOL state=NO;
            if (index.row==weakSelf.languageArrays.count-1) {
                state=YES;
            }
            
            NSInteger row = [index row];
            
            NSInteger oldRow = [weakSelf.lastPath row];
            MySettingTableViewCell *cell=[[MySettingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier withModel:cellData withLineHidden:state withAllowHidden:YES];
            if (row == oldRow && weakSelf.lastPath!=nil) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }else{
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
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
                
            [CGSingleCommitData sharedInstance].languageName=cellData;
            NSInteger newRow = [indexPath row];
            
            NSInteger oldRow = (weakSelf.lastPath !=nil)?[weakSelf.lastPath row]:-1;
            
            if (newRow != oldRow) {
                
                UITableViewCell *newCell = [weakSelf.tbv cellForRowAtIndexPath:indexPath];
                
                newCell.accessoryType = UITableViewCellAccessoryCheckmark;
                
                UITableViewCell *oldCell = [weakSelf.tbv cellForRowAtIndexPath:weakSelf.lastPath];
                
                oldCell.accessoryType = UITableViewCellAccessoryNone;
                
                weakSelf.lastPath = indexPath;
                
            }
            
            [weakSelf.tbv deselectRowAtIndexPath:indexPath animated:YES];
        }];
        
    }
    
    return _tbv;
}



@end

