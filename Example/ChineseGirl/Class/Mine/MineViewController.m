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
@interface MineViewController ()
@property(nonatomic,strong)UIScrollView *bgScrollView;
@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)UIImageView *headerImgView;
@property(nonatomic,strong)UILabel *titleLable;
@property(nonatomic,strong)UIImageView *AvatarImgView;
@property(nonatomic,strong)UILabel *nickName;
@property(nonatomic,strong)UIView *bodyView;
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
    [self.headerView addSubview:self.titleLable];
    [self.headerView addSubview:self.AvatarImgView];
    [self.headerView addSubview:self.nickName];
}

-(void)addBodyView{
    [self.view addSubview:self.bgScrollView];
    [self.bgScrollView addSubview:self.bodyView];
    [self.bgScrollView addSubview:self.tbv];
}

-(void)setData{
    self.bgScrollView.contentSize=CGSizeMake(screen_width, CGRectGetMaxY(self.tbv.frame)+57*SCREEN_RADIO);
}

-(UIScrollView *)bgScrollView{
    if (!_bgScrollView) {
        _bgScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
        _bgScrollView.backgroundColor=[UIColor clearColor];
        _bgScrollView.showsVerticalScrollIndicator = NO;
        _bgScrollView.showsHorizontalScrollIndicator = NO;
        _bgScrollView.backgroundColor=[UIColor clearColor];
    }
    return _bgScrollView;
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

-(UILabel *)titleLable{
    if (!_titleLable) {
        _titleLable=[[UILabel alloc] initWithFrame:CGRectMake(0, 29*SCREEN_RADIO, screen_width, 24*SCREEN_RADIO)];
        _titleLable.text=@"设置";
        _titleLable.textColor=[UIColor getColor:@"ffffff"];
        _titleLable.font=[UIFont systemFontOfSize:18*SCREEN_RADIO];
        _titleLable.textAlignment=NSTextAlignmentCenter;
    }
    return _titleLable;
}

-(UIImageView *)AvatarImgView{
    if (!_AvatarImgView) {
        _AvatarImgView=[[UIImageView alloc] initWithFrame:CGRectMake(screen_width/2-47*SCREEN_RADIO, CGRectGetMaxY(self.titleLable.frame)+21.5*SCREEN_RADIO, 94*SCREEN_RADIO, 94*SCREEN_RADIO)];
        _AvatarImgView.image=[UIImage imageNamed:@"Avatar"];
        _AvatarImgView.layer.cornerRadius=47*SCREEN_RADIO;
        _AvatarImgView.clipsToBounds=YES;
    }
    
    return _AvatarImgView;
}

-(UILabel *)nickName{
    if (!_nickName) {
        _nickName=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.AvatarImgView.frame)+12*SCREEN_RADIO, screen_width, 18*SCREEN_RADIO)];
        _nickName.text=@"Wallen";
        _nickName.textColor=[UIColor getColor:@"ffffff"];
        _nickName.font=[UIFont boldSystemFontOfSize:15*SCREEN_RADIO];
        _nickName.textAlignment=NSTextAlignmentCenter;
    }
    return _nickName;
}

-(UIView *)bodyView{
    if (!_bodyView) {
        _bodyView=[[UIView alloc] initWithFrame:CGRectMake(16*SCREEN_RADIO, CGRectGetMaxY(self.nickName.frame)+29*SCREEN_RADIO, screen_width-32*SCREEN_RADIO, 140*SCREEN_RADIO)];
        _bodyView.backgroundColor=[UIColor getColor:@"ffffff"];
        _bodyView.layer.cornerRadius=6;
    }
    
    return _bodyView;
}


-(EZJFastTableView *)tbv{
    if (!_tbv) {
        
        __weak typeof(self) weakSelf = self;
        CGRect tbvFrame = CGRectMake(16*SCREEN_RADIO, CGRectGetMaxY(self.bodyView.frame)+15*SCREEN_RADIO, screen_width-32*SCREEN_RADIO, 49.5*5*SCREEN_RADIO);
        //初始化
        
        _tbv = [[EZJFastTableView alloc]initWithFrame:tbvFrame];
        _tbv.scrollEnabled=NO;
        _tbv.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tbv.layer.cornerRadius=6;
        _tbv.backgroundColor=[UIColor getColor:@"ffffff"];
        NSMutableArray *arrays =[[NSMutableArray alloc] initWithObjects:@"昵称",@"性别",@"城市",@"生日",@"关于我",nil];
        
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
        
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        
        [_tbv onCellSelected:^(NSIndexPath *indexPath, id cellData) {

            MySettingTableViewCell *cell = [strongSelf.tbv cellForRowAtIndexPath:indexPath];
            
            if ([cellData isEqualToString:@"昵称"]) {
                MineSettingTextViewController *nickVC=[[MineSettingTextViewController alloc] init];
                nickVC.titleText=@"昵称";
                nickVC.textStr=[cell getContent];
                [nickVC onTextBlock:^(NSString *text) {
                    [cell updateCellContent:text];
                }];
              
                [strongSelf.navigationController pushViewController:nickVC animated:NO];
            }else if ([cellData isEqualToString:@"性别"]){
            
            }else if ([cellData isEqualToString:@"城市"]){
            
            }else if ([cellData isEqualToString:@"生日"]){
            
            }else if ([cellData isEqualToString:@"关于我"]){
                MineSettingTextViewController *aboutVC=[[MineSettingTextViewController alloc] init];
                aboutVC.titleText=@"关于我";
                aboutVC.textStr=[cell getContent];
                [aboutVC onTextBlock:^(NSString *text) {
                    [cell updateCellContent:text];
                }];
                [strongSelf.navigationController pushViewController:aboutVC animated:NO];
            }
         
        }];
        
    }
    
    return _tbv;
}



-(void)click{
    CGLoginViewController *loginVC=[[CGLoginViewController alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];
}

@end
