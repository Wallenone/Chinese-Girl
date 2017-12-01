//
//  CGEditProfileViewController.m
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/11/29.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGEditProfileViewController.h"
#import "EZJFastTableView.h"
#import "MySettingTableViewCell.h"
#import "MineSettingTextViewController.h"
#import "WYGenderPickerView.h"
#import "WYBirthdayPickerView.h"
#import "UICustomPickImgView.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"
#import "UICountryViewController.h"
@interface CGEditProfileViewController ()
@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)UIButton *leftIcon;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIView *lineView;
@property(nonatomic,strong)EZJFastTableView *tbv;
@property(nonatomic,strong)UIButton *logoutBtn;
@property(nonatomic,strong)UIButton *deleteBtn;
@end

@implementation CGEditProfileViewController
- (void)viewWillAppear:(BOOL)animated{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor getColor:@"ffffff"];
    [self.view addSubview:self.headerView];
    [self.headerView addSubview:self.titleLabel];
    [self.headerView addSubview:self.leftIcon];
    [self.headerView addSubview:self.lineView];
    [self.view addSubview:self.tbv];
    [self.view addSubview:self.logoutBtn];
    [self.view addSubview:self.deleteBtn];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)logoutClick{
    
}

-(void)deleteClick{
    
}

-(UIView *)headerView{
    if (!_headerView) {
        _headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 64*SCREEN_RADIO)];
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
        _titleLabel.text=@"Settings";
        _titleLabel.font=[UIFont systemFontOfSize:18*SCREEN_RADIO];
        _titleLabel.textColor=[UIColor getColor:@"111111"];
        _titleLabel.textAlignment=NSTextAlignmentCenter;
    }
    return _titleLabel;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView=[[UIView alloc] initWithFrame:CGRectMake(0, 64*SCREEN_RADIO-0.5, screen_width, 0.5)];
        _lineView.backgroundColor=[UIColor colorWithRed:17/255 green:17/255 blue:17/255 alpha:0.1];
    }
    
    return _lineView;
}

-(EZJFastTableView *)tbv{
    if (!_tbv) {
        NSString *cityName=[CGSingleCommitData sharedInstance].cityName.length>0?[CGSingleCommitData sharedInstance].cityName:[CGSingleCommitData sharedInstance].countryName;
        NSMutableArray *arrays =[[NSMutableArray alloc] initWithObjects:
                                 @{@"left":NSLocalizedString(@"nickname", nil),@"right":[CGSingleCommitData sharedInstance].nickName},
                                 @{@"left":NSLocalizedString(@"gender", nil),@"right":[CGSingleCommitData sharedInstance].sex},
                                 @{@"left":NSLocalizedString(@"city", nil),@"right":cityName},
                                 @{@"left":NSLocalizedString(@"birthday", nil),@"right":[CGSingleCommitData sharedInstance].birthDay},
                                 @{@"left":NSLocalizedString(@"about", nil),@"right":[CGSingleCommitData sharedInstance].aboutUs},
                                 nil];
        
        __weak typeof(self) weakSelf = self;
        CGRect tbvFrame = CGRectMake(0, CGRectGetMaxY(self.headerView.frame), screen_width, 52*arrays.count*SCREEN_RADIO);
        //初始化
        
        _tbv = [[EZJFastTableView alloc]initWithFrame:tbvFrame];
        _tbv.scrollEnabled=NO;
        _tbv.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tbv.backgroundColor=[UIColor getColor:@"ffffff"];
        
        
        //给tableview赋值
        [_tbv setDataArray:arrays];
        
        [_tbv onBuildCell:^(id cellData,NSString *cellIdentifier,NSIndexPath *index) {
            MySettingTableViewCell *cell=[[MySettingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier withModel:cellData withAllowHidden:NO];
            return cell;
            
        }];
        
        //动态改变
        
        [_tbv onChangeCellHeight:^CGFloat(NSIndexPath *indexPath,id cellData) {
            
            return 52*SCREEN_RADIO;
        }];
        
        //设置选中事件 block设置方式
        //indexPath  是当前行对象 indexPath.row(获取行数)
        //cellData 是当前行的数据
        
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        
        [_tbv onCellSelected:^(NSIndexPath *indexPath, id cellData) {
            
            MySettingTableViewCell *cell = [strongSelf.tbv cellForRowAtIndexPath:indexPath];
            
            if ([[cellData objectForKey:@"left"] isEqualToString:NSLocalizedString(@"nickname", nil)]) {
                MineSettingTextViewController *nickVC=[[MineSettingTextViewController alloc] init];
                nickVC.titleText=NSLocalizedString(@"nickname", nil);
                nickVC.textStr=[cell getContent];
                [nickVC onTextBlock:^(NSString *text) {
                    [CGSingleCommitData sharedInstance].nickName=text;
                    [cell updateCellContent:text];
                }];
                
                [strongSelf.navigationController pushViewController:nickVC animated:NO];
            }else if ([[cellData objectForKey:@"left"] isEqualToString:NSLocalizedString(@"gender", nil)]){
                //strongSelf.tabBarController.tabBar.hidden=YES;
                WYGenderPickerView *customPickerSex=[[WYGenderPickerView alloc] initWithInitialGender:NSLocalizedString(@"sex_man", nil)];
                customPickerSex.confirmBlock = ^(NSString *selectedGender){
                    [CGSingleCommitData sharedInstance].sex=selectedGender;
                  //  strongSelf.tabBarController.tabBar.hidden=NO;
                    [cell updateCellContent:selectedGender];
                    
                };
                
                [strongSelf.view addSubview:customPickerSex];
            }else if ([[cellData objectForKey:@"left"] isEqualToString:NSLocalizedString(@"city", nil)]){
                //                NSString *cityName=[CGSingleCommitData sharedInstance].cityName.length>0?[CGSingleCommitData sharedInstance].cityName:[CGSingleCommitData sharedInstance].countryName;
                //                [cell updateCellContent:cityName];
                
                UICountryViewController *countryVC=[[UICountryViewController alloc] init];
                [strongSelf.navigationController pushViewController:countryVC animated:NO];
                
                
            }else if ([[cellData objectForKey:@"left"] isEqualToString:NSLocalizedString(@"birthday", nil)]){
                //strongSelf.tabBarController.tabBar.hidden=YES;
                WYBirthdayPickerView *birthdayPickerView = [[WYBirthdayPickerView alloc] initWithInitialDate:@"1990-01-01"];
                
                // 选择日期完成之后的回调 : 按自己的要求做相应的处理就可以了
                birthdayPickerView.confirmBlock = ^(NSString *selectedDate) {
                    [CGSingleCommitData sharedInstance].birthDay=selectedDate;
                    //strongSelf.tabBarController.tabBar.hidden=NO;
                    [cell updateCellContent:selectedDate];
                };
                
                [strongSelf.view addSubview:birthdayPickerView];
            }else if ([[cellData objectForKey:@"left"] isEqualToString:NSLocalizedString(@"about", nil)]){
                MineSettingTextViewController *aboutVC=[[MineSettingTextViewController alloc] init];
                aboutVC.titleText=NSLocalizedString(@"about", nil);
                aboutVC.textStr=[cell getContent];
                [aboutVC onTextBlock:^(NSString *text) {
                    [CGSingleCommitData sharedInstance].aboutUs=text;
                    [cell updateCellContent:text];
                }];
                [strongSelf.navigationController pushViewController:aboutVC animated:NO];
            }
            
        }];
        
    }
    
    return _tbv;
}

-(UIButton *)logoutBtn{
    if (!_logoutBtn) {
        _logoutBtn=[[UIButton alloc] initWithFrame:CGRectMake(16*SCREEN_RADIO, screen_height-124*SCREEN_RADIO, screen_width-32*SCREEN_RADIO, 50*SCREEN_RADIO)];
        [_logoutBtn setTitleColor:[UIColor getColor:@"ffffff"] forState:UIControlStateNormal];
        [_logoutBtn setTitle:@"Logout" forState:UIControlStateNormal];
        _logoutBtn.titleLabel.font=[UIFont systemFontOfSize:16*SCREEN_RADIO];
        _logoutBtn.layer.cornerRadius=8*SCREEN_RADIO;
        [_logoutBtn addTarget:self action:@selector(logoutClick) forControlEvents:UIControlEventTouchUpInside];
        _logoutBtn.backgroundColor=[UIColor getColor:@"FF473D"];
    }
    
    return _logoutBtn;
}

-(UIButton *)deleteBtn{
    if (!_deleteBtn) {
        _deleteBtn=[[UIButton alloc] initWithFrame:CGRectMake(16*SCREEN_RADIO, screen_height-66*SCREEN_RADIO, screen_width-32*SCREEN_RADIO, 50*SCREEN_RADIO)];
        [_deleteBtn setTitleColor:[UIColor getColor:@"111111"] forState:UIControlStateNormal];
        [_deleteBtn setTitle:@"Delete account" forState:UIControlStateNormal];
        _deleteBtn.titleLabel.font=[UIFont systemFontOfSize:16*SCREEN_RADIO];
        _deleteBtn.layer.cornerRadius=8*SCREEN_RADIO;
        _deleteBtn.layer.borderColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5].CGColor;
        _deleteBtn.layer.borderWidth=2;
        [_deleteBtn addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
        _deleteBtn.backgroundColor=[UIColor getColor:@"ffffff"];
    }
    
    return _deleteBtn;
}

@end
