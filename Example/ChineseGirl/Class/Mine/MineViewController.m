//
//  MineViewController.m
//  ChineseGirl
//
//  Created by wallen on 2017/8/8.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "MineViewController.h"
#import "CGLoginViewController.h"
#import "EZJFastTableView.h"
#import "MySettingTableViewCell.h"
#import "MineSettingTextViewController.h"
#import "WYGenderPickerView.h"
#import "WYBirthdayPickerView.h"
#import "WYHeightPickerView.h"
#import "WYCityPickerView.h"
#import "UICustomPickImgView.h"
#import "CGSingleCommitData.h"
#import "CGLoginViewController.h"
#import "MineProfileInfoViewController.h"
#import "MineAccountViewController.h"
@interface MineViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>{
}
@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)UIImageView *headerImgView;
@property(nonatomic,strong)UIButton *AvatarImgView;
@property(nonatomic,strong)UIButton *nickName;
@property(nonatomic,strong)EZJFastTableView *tbv;

@end

@implementation MineViewController
-(void)viewWillAppear:(BOOL)animated
{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor getColor:@"F8F8F8"];
    [self addHeaderView];
    [self addBodyView];
    [self setData];
}


-(void)addHeaderView{
    [self.view addSubview:self.headerView];
    [self.headerView addSubview:self.headerImgView];
    [self.headerView addSubview:self.AvatarImgView];
    [self.headerView addSubview:self.nickName];
}

-(void)addBodyView{
    [self.view addSubview:self.tbv];
}

-(void)setData{
    if ([CGSingleCommitData sharedInstance].uid.length<=0) {
        [self.nickName setTitle:@"注册/登录" forState:UIControlStateNormal];
        self.nickName.userInteractionEnabled=YES;
    }else{
        self.nickName.userInteractionEnabled=NO;
        [self.nickName setTitle:[CGSingleCommitData sharedInstance].nickName forState:UIControlStateNormal];
    }
    
}

-(void)LoginCheck{
    CGLoginViewController *loginVc=[[CGLoginViewController alloc] init];
    UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:loginVc];
    [self.navigationController presentViewController:nav animated:NO completion:nil];
}

-(void)chooseImg{
    __weak typeof(self) weakSelf = self;
    UICustomPickImgView *customVC=[[UICustomPickImgView alloc] init];
    [customVC onGetImg:^(UIImage *ava) {
        [weakSelf.AvatarImgView setImage:ava forState:UIControlStateNormal];
    }];
    [self.view addSubview:customVC];
   
}


-(UIView *)headerView{
    if (!_headerView) {
        _headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 269*SCREEN_RADIO)];
        _headerView.backgroundColor=[UIColor getColor:@"2979FF"];
    }
    return _headerView;
}

-(UIImageView *)headerImgView{
    if (!_headerImgView) {
        _headerImgView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 299*SCREEN_RADIO)];
        _headerImgView.image=[UIImage imageNamed:@"myBar"];
    }
    
    return _headerImgView;
}


-(UIButton *)AvatarImgView{
    if (!_AvatarImgView) {
        _AvatarImgView=[[UIButton alloc] initWithFrame:CGRectMake(screen_width/2-47*SCREEN_RADIO, 51.5*SCREEN_RADIO, 94*SCREEN_RADIO, 94*SCREEN_RADIO)];
        [_AvatarImgView setImage:[UIImage imageNamed:@"Avatar"] forState:UIControlStateNormal];
        _AvatarImgView.layer.cornerRadius=47*SCREEN_RADIO;
        _AvatarImgView.layer.masksToBounds=YES;
        [_AvatarImgView addTarget:self action:@selector(chooseImg) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _AvatarImgView;
}

-(UIButton *)nickName{
    if (!_nickName) {
        _nickName=[[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.AvatarImgView.frame)+12*SCREEN_RADIO, screen_width, 18*SCREEN_RADIO)];
        _nickName.titleLabel.font=[UIFont systemFontOfSize:17*SCREEN_RADIO];
        [_nickName setTitleColor:[UIColor getColor:@"ffffff"] forState:UIControlStateNormal];
        [_nickName addTarget:self action:@selector(LoginCheck) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nickName;
}



-(EZJFastTableView *)tbv{
    if (!_tbv) {
        
        __weak typeof(self) weakSelf = self;
        CGRect tbvFrame = CGRectMake(16*SCREEN_RADIO, CGRectGetMaxY(self.nickName.frame)+20*SCREEN_RADIO, screen_width-32*SCREEN_RADIO, 49.5*5*SCREEN_RADIO);
        //初始化
        
        _tbv = [[EZJFastTableView alloc]initWithFrame:tbvFrame];
        _tbv.scrollEnabled=NO;
        _tbv.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tbv.layer.cornerRadius=6;
        _tbv.backgroundColor=[UIColor getColor:@"ffffff"];
        NSMutableArray *arrays =[[NSMutableArray alloc] initWithObjects:@"账号信息",@"个人信息",@"我的钻石",@"关注",nil];
        
        //给tableview赋值
        [_tbv setDataArray:arrays];
        
        [_tbv onBuildCell:^(id cellData,NSString *cellIdentifier,NSIndexPath *index) {
            MySettingTableViewCell *cell=[[MySettingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier withModel:cellData];
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

           // MySettingTableViewCell *cell = [weakSelf.tbv cellForRowAtIndexPath:indexPath];
            
            if ([cellData isEqualToString:@"账号信息"]) {
                MineAccountViewController *accountVC=[[MineAccountViewController alloc] init];
                [weakSelf.navigationController pushViewController:accountVC animated:NO];
            }else if ([cellData isEqualToString:@"个人信息"]){
                MineProfileInfoViewController *profileInfoVC=[[MineProfileInfoViewController alloc] init];
                [weakSelf.navigationController pushViewController:profileInfoVC animated:NO];
                
            }else if ([cellData isEqualToString:@"我的钻石"]){
                
            }else if ([cellData isEqualToString:@"关注"]){
                
            }
         
        }];
        
    }
    
    return _tbv;
}

@end
