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
#import "CGVipViewController.h"
#import "CGMyFollowViewController.h"
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
    [self.tabBarController.tabBar setHidden:NO];
    [super viewWillAppear:animated];
    [self setData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor getColor:@"F5F5F5"];
    [self addHeaderView];
    [self addBodyView];
    
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
        [self.nickName setTitle:[NSString stringWithFormat:@"%@/%@",NSLocalizedString(@"register", nil),NSLocalizedString(@"login", nil)] forState:UIControlStateNormal];
        self.nickName.userInteractionEnabled=YES;
        [self.AvatarImgView setImage:[CGSingleCommitData sharedInstance].avatar forState:UIControlStateNormal];
    }else{
        self.nickName.userInteractionEnabled=NO;
        [self.nickName setTitle:[CGSingleCommitData sharedInstance].nickName forState:UIControlStateNormal];
        [self.AvatarImgView setImage:[CGSingleCommitData sharedInstance].avatar forState:UIControlStateNormal];
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
        [CGSingleCommitData sharedInstance].avatar=ava;
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
        //[_AvatarImgView setImage:[UIImage imageNamed:@"Avatar"] forState:UIControlStateNormal];
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
        CGRect tbvFrame = CGRectMake(0, CGRectGetMaxY(self.nickName.frame)+20*SCREEN_RADIO, screen_width, 49.5*4*SCREEN_RADIO);
        //初始化
        
        _tbv = [[EZJFastTableView alloc]initWithFrame:tbvFrame];
        _tbv.scrollEnabled=NO;
        _tbv.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tbv.backgroundColor=[UIColor getColor:@"ffffff"];
        NSMutableArray *arrays =[[NSMutableArray alloc] initWithObjects:NSLocalizedString(@"settings", nil),NSLocalizedString(@"account", nil),@"VIP",NSLocalizedString(@"my_favorite", nil),nil];
        
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

           // MySettingTableViewCell *cell = [weakSelf.tbv cellForRowAtIndexPath:indexPath];
            
            if ([cellData isEqualToString:NSLocalizedString(@"settings", nil)]) {
                
                if ([CGCommonString isBlankString:[CGSingleCommitData sharedInstance].uid]) {
                    CGLoginViewController *loginVC=[[CGLoginViewController alloc] init];
                    UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:loginVC];
                    [self.navigationController presentViewController:nav animated:NO completion:nil];
                }else{
                    MineAccountViewController *accountVC=[[MineAccountViewController alloc] init];
                    [weakSelf.navigationController pushViewController:accountVC animated:NO];
                }
            }else if ([cellData isEqualToString:NSLocalizedString(@"account", nil)]){
                if ([CGCommonString isBlankString:[CGSingleCommitData sharedInstance].uid]) {
                    CGLoginViewController *loginVC=[[CGLoginViewController alloc] init];
                    UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:loginVC];
                    [self.navigationController presentViewController:nav animated:NO completion:nil];
                }else{
                    MineProfileInfoViewController *profileInfoVC=[[MineProfileInfoViewController alloc] init];
                    [weakSelf.navigationController pushViewController:profileInfoVC animated:NO];
                }
                
            }else if ([cellData isEqualToString:@"VIP"]){
                CGVipViewController *vipVC=[[CGVipViewController alloc] init];
                [weakSelf.navigationController pushViewController:vipVC animated:NO];
            }else if ([cellData isEqualToString:NSLocalizedString(@"my_favorite", nil)]){
                CGMyFollowViewController *followVC=[[CGMyFollowViewController alloc] init];
                [weakSelf.navigationController pushViewController:followVC animated:NO];
            }
         
        }];
        
    }
    
    return _tbv;
}

@end
