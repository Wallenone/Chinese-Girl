//
//  MinePasswordViewController.m
//  ChineseGirl
//
//  Created by Wallen on 2017/10/23.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "MinePasswordViewController.h"
#import "CGLoginIndexCustomTextField.h"
@interface MinePasswordViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)UILabel *titleLable;
@property(nonatomic,strong)UIButton *leftBtn;
@property(nonatomic,strong)UIView *line;
@property(nonatomic,strong)UITextField *passwordField;
@property(nonatomic,strong)UIView *lineView;
@property(nonatomic,strong)UITextField *newpasswordField;
@property(nonatomic,strong)UILabel *passwordContent;
@property(nonatomic,strong)UIButton *conformBtn;
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldPasswordChanged:) name:UITextFieldTextDidChangeNotification object:self.passwordField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldNewPasswordChanged:) name:UITextFieldTextDidChangeNotification object:self.newpasswordField];
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
    [self.view addSubview:self.lineView];
    [self.view addSubview:self.newpasswordField];
    [self.view addSubview:self.passwordContent];
    [self.view addSubview:self.conformBtn];
}

-(void)backClick{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)textFieldPasswordChanged:(UITextField *)sender{
    NSLog(@"textaa:=%@",self.passwordField.text);
    [self setConformStatus];
}

-(void)textFieldNewPasswordChanged:(UITextField *)sender{
    NSLog(@"textbb:=%@",self.newpasswordField.text);
    [self setConformStatus];
}

-(void)setConformStatus{
    if (self.passwordField.text.length>=6 && self.newpasswordField.text.length>=6) {
        self.conformBtn.backgroundColor=[UIColor getColor:@"2979FF"];
        self.conformBtn.userInteractionEnabled=YES;
    }else{
        self.conformBtn.backgroundColor=[UIColor getColor:@"c8d3d2"];
        self.conformBtn.userInteractionEnabled=NO;
    }
}

-(void)conformsClick{
    if ([[CGSingleCommitData sharedInstance].password isEqualToString:self.passwordField.text]) {
        [CGSingleCommitData sharedInstance].password=self.newpasswordField.text;
        [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"xiugaichenggong", nil)];
        [self.navigationController popToRootViewControllerAnimated:NO];
    }else{
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"mimacuowu", nil)];
    }
    
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
        _titleLable.text=NSLocalizedString(@"change_password", nil);
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

-(UITextField *)passwordField{
    if (!_passwordField) {
        _passwordField=[[UITextField alloc] initWithFrame:CGRectMake(16*SCREEN_RADIO, 74*SCREEN_RADIO, screen_width-32*SCREEN_RADIO, 49.5*SCREEN_RADIO)];
        _passwordField.placeholder=NSLocalizedString(@"current_password", nil);
        [_passwordField setValue:[UIColor getColor:@"c9c9c9"] forKeyPath:@"_placeholderLabel.textColor"];
        [_passwordField setValue:[UIFont systemFontOfSize:16*SCREEN_RADIO] forKeyPath:@"_placeholderLabel.font"];
        _passwordField.textColor=[UIColor getColor:@"565656"];
        _passwordField.font=[UIFont systemFontOfSize:16*SCREEN_RADIO];
        _passwordField.secureTextEntry=NO;
        _passwordField.delegate=self;
        _passwordField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    }
    
    return _passwordField;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView=[[UIView alloc] initWithFrame:CGRectMake(16*SCREEN_RADIO, CGRectGetMaxY(self.passwordField.frame), screen_width-16*SCREEN_RADIO, 0.5)];
        _lineView.backgroundColor=[UIColor getColor:@"FDFDFD"];
    }
    return _lineView;
}

-(UITextField *)newpasswordField{
    if (!_newpasswordField) {
        _newpasswordField=[[UITextField alloc] initWithFrame:CGRectMake(16*SCREEN_RADIO, CGRectGetMaxY(self.lineView.frame), screen_width-32*SCREEN_RADIO, 49.5*SCREEN_RADIO)];
        _newpasswordField.placeholder=NSLocalizedString(@"new_password", nil);
        [_newpasswordField setValue:[UIColor getColor:@"c9c9c9"] forKeyPath:@"_placeholderLabel.textColor"];
        [_newpasswordField setValue:[UIFont systemFontOfSize:16*SCREEN_RADIO] forKeyPath:@"_placeholderLabel.font"];
        _newpasswordField.textColor=[UIColor getColor:@"565656"];
        _newpasswordField.font=[UIFont systemFontOfSize:16*SCREEN_RADIO];
        _newpasswordField.secureTextEntry=NO;
        _newpasswordField.delegate=self;
        _newpasswordField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    }
    
    return _newpasswordField;
}

-(UILabel *)passwordContent{
    if (!_passwordContent) {
        _passwordContent=[[UILabel alloc] initWithFrame:CGRectMake(16*SCREEN_RADIO, CGRectGetMaxY(self.newpasswordField.frame)+8*SCREEN_RADIO, 0, 8*SCREEN_RADIO)];
        _passwordContent.text=NSLocalizedString(@"only_password_letters", nil);
        _passwordContent.font=[UIFont systemFontOfSize:8*SCREEN_RADIO];
        _passwordContent.textColor=[UIColor getColor:@"9c9c9c"];
        [_passwordContent sizeToFit];
    }
    return _passwordContent;
}

-(UIButton *)conformBtn{
    if (!_conformBtn) {
        _conformBtn=[[UIButton alloc] initWithFrame:CGRectMake(screen_width/2-110*SCREEN_RADIO, CGRectGetMaxY(self.passwordContent.frame)+20*SCREEN_RADIO, 220*SCREEN_RADIO, 42*SCREEN_RADIO)];
        [_conformBtn setTitle:NSLocalizedString(@"save", nil) forState:UIControlStateNormal];
        [_conformBtn setTitleColor:[UIColor getColor:@"ffffff"] forState:UIControlStateNormal];
        _conformBtn.backgroundColor=[UIColor getColor:@"c8d3d2"];
        _conformBtn.titleLabel.font=[UIFont systemFontOfSize:18*SCREEN_RADIO];
        _conformBtn.layer.cornerRadius=21*SCREEN_RADIO;
        [_conformBtn addTarget:self action:@selector(conformsClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _conformBtn;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}


@end
