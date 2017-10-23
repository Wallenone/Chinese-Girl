//
//  MinePasswordViewController.m
//  ChineseGirl
//
//  Created by Wallen on 2017/10/23.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "MinePasswordViewController.h"
#import "CGLoginIndexCustomTextField.h"
@interface MinePasswordViewController ()
@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)UILabel *titleLable;
@property(nonatomic,strong)UIButton *leftBtn;
@property(nonatomic,strong)UIView *line;
@property(nonatomic,strong)CGLoginIndexCustomTextField *passwordField;
@property(nonatomic,strong)CGLoginIndexCustomTextField *newpasswordField;
@end

@implementation MinePasswordViewController
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
    [self addHeaderView];
    [self addBodyView];
}

-(void)addHeaderView{
    [self.view addSubview:self.headerView];
    [self.headerView addSubview:self.titleLable];
    [self.headerView addSubview:self.leftBtn];
    [self.headerView addSubview:self.line];
}

-(void)addBodyView{
    [self.view addSubview:self.passwordField];
    [self.view addSubview:self.newpasswordField];
}

-(void)backClick{
    [self.navigationController popViewControllerAnimated:NO];
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
        _titleLable.text=@"修改密码";
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

-(UIView *)line{
    if (!_line) {
        _line=[[UIView alloc] initWithFrame:CGRectMake(0, 63.5, screen_width, 0.5)];
        _line.backgroundColor=[UIColor getColor:@"CED7DB"];
    }
    
    return _line;
}

-(CGLoginIndexCustomTextField *)passwordField{
    if (!_passwordField) {
        _passwordField=[[CGLoginIndexCustomTextField alloc] initWithFrame:CGRectMake(62.5*SCREEN_RADIO, 80*SCREEN_RADIO, screen_width-125*SCREEN_RADIO, 45*SCREEN_RADIO)];
        _passwordField.layer.cornerRadius=45/2*SCREEN_RADIO;
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        // 设置富文本对象的颜色
        attributes[NSForegroundColorAttributeName] = [UIColor getColor:@"5E7785"];
        // 设置UITextField的占位文字
        _passwordField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:attributes];
        _passwordField.textColor=[UIColor getColor:@"5E7785"];
        _passwordField.backgroundColor=[UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:0.2];
        UIImageView *imageViewPassword=[[UIImageView alloc]initWithFrame:CGRectMake(44*SCREEN_RADIO, 13*SCREEN_RADIO, 23*SCREEN_RADIO, 19*SCREEN_RADIO)];
        imageViewPassword.image=[UIImage imageNamed:@"login_Password"];
        _passwordField.leftView=imageViewPassword;
        _passwordField.leftViewMode=UITextFieldViewModeAlways; //此处用来设置leftview现实时机
        _passwordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _passwordField.autocorrectionType = UITextAutocorrectionTypeNo;
    }
    
    return _passwordField;
}

-(CGLoginIndexCustomTextField *)newpasswordField{
    if (!_newpasswordField) {
        _newpasswordField=[[CGLoginIndexCustomTextField alloc] initWithFrame:CGRectMake(62.5*SCREEN_RADIO, CGRectGetMaxY(self.passwordField.frame)+15*SCREEN_RADIO, screen_width-125*SCREEN_RADIO, 45*SCREEN_RADIO)];
        _newpasswordField.layer.cornerRadius=45/2*SCREEN_RADIO;
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        // 设置富文本对象的颜色
        attributes[NSForegroundColorAttributeName] = [UIColor getColor:@"5E7785"];
        // 设置UITextField的占位文字
        _newpasswordField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:attributes];
        _newpasswordField.textColor=[UIColor getColor:@"5E7785"];
        _newpasswordField.backgroundColor=[UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:0.2];
        UIImageView *imageViewPassword=[[UIImageView alloc]initWithFrame:CGRectMake(44*SCREEN_RADIO, 13*SCREEN_RADIO, 23*SCREEN_RADIO, 19*SCREEN_RADIO)];
        imageViewPassword.image=[UIImage imageNamed:@"login_Password"];
        _newpasswordField.leftView=imageViewPassword;
        _newpasswordField.leftViewMode=UITextFieldViewModeAlways; //此处用来设置leftview现实时机
        _newpasswordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _newpasswordField.autocorrectionType = UITextAutocorrectionTypeNo;
    }
    
    return _newpasswordField;
}
@end
