//
//  CGNewIndexViewController.m
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/11/27.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGNewIndexViewController.h"
#import "CGNewSignInViewController.h"
@interface CGNewIndexViewController ()
@property(nonatomic,strong)UIButton *leftIcon;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIView *titleLineView;
@property(nonatomic,strong)UILabel *emailLabel;
@property(nonatomic,strong)UITextField *emailContent;
@property(nonatomic,strong)UILabel *username;
@property(nonatomic,strong)UITextField *usernameContent;
@property(nonatomic,strong)UILabel *password;
@property(nonatomic,strong)UITextField *passwordContent;
@property(nonatomic,strong)UILabel *address;
@property(nonatomic,strong)UITextField *addressContent;
@property(nonatomic,strong)UIButton *setupBtn;
@property(nonatomic,strong)UILabel *signInLabel;
@property(nonatomic,strong)UIButton *signInBtn;
@end

@implementation CGNewIndexViewController
- (void)viewWillAppear:(BOOL)animated{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self addSubViews];
}

-(void)addSubViews{
    [self.view addSubview:self.leftIcon];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.titleLineView];
    [self.view addSubview:self.emailLabel];
    [self.view addSubview:self.emailContent];
    [self.view addSubview:self.username];
    [self.view addSubview:self.usernameContent];
    [self.view addSubview:self.password];
    [self.view addSubview:self.passwordContent];
    [self.view addSubview:self.address];
    [self.view addSubview:self.addressContent];
    [self.view addSubview:self.signInLabel];
    [self.view addSubview:self.signInBtn];
    [self.view addSubview:self.setupBtn];
}

-(void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)setupClick{
    
}

-(void)signInClick{
    CGNewSignInViewController *signInVC=[[CGNewSignInViewController alloc] init];
    [self.navigationController pushViewController:signInVC animated:NO];
}

-(UIButton *)leftIcon{
    if (!_leftIcon) {
        _leftIcon=[[UIButton alloc] initWithFrame:CGRectMake(23*SCREEN_RADIO, 37*SCREEN_RADIO, 10*SCREEN_RADIO, 19*SCREEN_RADIO)];
        [_leftIcon setImage:[UIImage imageNamed:@"BlackArrowleft"] forState:UIControlStateNormal];
        [_leftIcon addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftIcon;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.leftIcon.frame)+13*SCREEN_RADIO, 29*SCREEN_RADIO, 0, 35*SCREEN_RADIO)];
        _titleLabel.text=@"Create an Account";
        _titleLabel.textColor=[UIColor getColor:@"2A2A2A"];
        _titleLabel.font=[UIFont systemFontOfSize:26*SCREEN_RADIO];
        _titleLabel.textAlignment=NSTextAlignmentCenter;
        [_titleLabel sizeToFit];
    }
    
    return _titleLabel;
}


-(UIView *)titleLineView{
    if (!_titleLineView) {
        _titleLineView=[[UILabel alloc] initWithFrame:CGRectMake(20*SCREEN_RADIO, CGRectGetMaxY(self.titleLabel.frame)+13*SCREEN_RADIO, screen_width-40*SCREEN_RADIO, 1)];
        _titleLineView.backgroundColor=[UIColor getColor:@"F3F3F3"];
    }
    
    return _titleLineView;
}

-(UILabel *)emailLabel{
    if (!_emailLabel) {
        _emailLabel=[[UILabel alloc] initWithFrame:CGRectMake(30*SCREEN_RADIO, CGRectGetMaxY(self.titleLineView.frame)+30*SCREEN_RADIO, 0, 14*SCREEN_RADIO)];
        _emailLabel.text=@"Your Email";
        _emailLabel.textColor=[UIColor getColor:@"2A2A2A"];
        _emailLabel.font=[UIFont systemFontOfSize:14*SCREEN_RADIO];
        [_emailLabel sizeToFit];
    }
    
    return _emailLabel;
}

-(UITextField *)emailContent{
    if (!_emailContent) {
        _emailContent=[[UITextField alloc] initWithFrame:CGRectMake(30*SCREEN_RADIO, CGRectGetMaxY(self.emailLabel.frame)+7*SCREEN_RADIO, SCREEN_WIDTH-60*SCREEN_RADIO, 32*SCREEN_RADIO)];
        _emailContent.placeholder=@"name@domain.com";
        [_emailContent setValue:[UIColor getColor:@"D5D5D5"] forKeyPath:@"_placeholderLabel.textColor"];
        [_emailContent setValue:[UIFont boldSystemFontOfSize:24*SCREEN_RADIO] forKeyPath:@"_placeholderLabel.font"];
        _emailContent.textColor=[UIColor getColor:@"2A2A2A"];
        _emailContent.font=[UIFont systemFontOfSize:24*SCREEN_RADIO];
    }
    
    return _emailContent;
}

-(UILabel *)username{
    if (!_username)  {
        _username=[[UILabel alloc] initWithFrame:CGRectMake(30*SCREEN_RADIO, CGRectGetMaxY(self.emailContent.frame)+30*SCREEN_RADIO, 0, 14*SCREEN_RADIO)];
        _username.text=@"Username";
        _username.textColor=[UIColor getColor:@"2A2A2A"];
        _username.font=[UIFont systemFontOfSize:14*SCREEN_RADIO];
        [_username sizeToFit];
    }

    return _username;
}

-(UITextField *)usernameContent{
    if (!_usernameContent) {
        _usernameContent=[[UITextField alloc] initWithFrame:CGRectMake(30*SCREEN_RADIO, CGRectGetMaxY(self.username.frame)+7*SCREEN_RADIO, SCREEN_WIDTH-60*SCREEN_RADIO, 32*SCREEN_RADIO)];
        _usernameContent.placeholder=@"your username";
        [_usernameContent setValue:[UIColor getColor:@"D5D5D5"] forKeyPath:@"_placeholderLabel.textColor"];
        [_usernameContent setValue:[UIFont boldSystemFontOfSize:24*SCREEN_RADIO] forKeyPath:@"_placeholderLabel.font"];
        _usernameContent.textColor=[UIColor getColor:@"2A2A2A"];
        _usernameContent.font=[UIFont systemFontOfSize:24*SCREEN_RADIO];
    }
    
    return _usernameContent;
}

-(UILabel *)password{
    if (!_password)  {
        _password=[[UILabel alloc] initWithFrame:CGRectMake(30*SCREEN_RADIO, CGRectGetMaxY(self.usernameContent.frame)+30*SCREEN_RADIO, 0, 14*SCREEN_RADIO)];
        _password.text=@"Create Password";
        _password.textColor=[UIColor getColor:@"2A2A2A"];
        _password.font=[UIFont systemFontOfSize:14*SCREEN_RADIO];
        [_password sizeToFit];
    }
    
    return _password;
}

-(UITextField *)passwordContent{
    if (!_passwordContent) {
        _passwordContent=[[UITextField alloc] initWithFrame:CGRectMake(30*SCREEN_RADIO, CGRectGetMaxY(self.password.frame)+7*SCREEN_RADIO, SCREEN_WIDTH-60*SCREEN_RADIO, 32*SCREEN_RADIO)];
        _passwordContent.placeholder=@"Min 6 symbols";
        [_passwordContent setValue:[UIColor getColor:@"D5D5D5"] forKeyPath:@"_placeholderLabel.textColor"];
        [_passwordContent setValue:[UIFont boldSystemFontOfSize:24*SCREEN_RADIO] forKeyPath:@"_placeholderLabel.font"];
        _passwordContent.textColor=[UIColor getColor:@"2A2A2A"];
        _passwordContent.font=[UIFont systemFontOfSize:24*SCREEN_RADIO];
    }
    
    return _passwordContent;
}

-(UILabel *)address{
    if (!_address)  {
        _address=[[UILabel alloc] initWithFrame:CGRectMake(30*SCREEN_RADIO, CGRectGetMaxY(self.passwordContent.frame)+30*SCREEN_RADIO, 0, 14*SCREEN_RADIO)];
        _address.text=@"Choose Address";
        _address.textColor=[UIColor getColor:@"2A2A2A"];
        _address.font=[UIFont systemFontOfSize:14*SCREEN_RADIO];
        [_address sizeToFit];
    }
    
    return _address;
}

-(UITextField *)addressContent{
    if (!_addressContent) {
        _addressContent=[[UITextField alloc] initWithFrame:CGRectMake(30*SCREEN_RADIO, CGRectGetMaxY(self.address.frame)+7*SCREEN_RADIO, SCREEN_WIDTH-60*SCREEN_RADIO, 32*SCREEN_RADIO)];
        _addressContent.placeholder=@"Your Address";
        [_addressContent setValue:[UIColor getColor:@"D5D5D5"] forKeyPath:@"_placeholderLabel.textColor"];
        [_addressContent setValue:[UIFont boldSystemFontOfSize:24*SCREEN_RADIO] forKeyPath:@"_placeholderLabel.font"];
        _addressContent.textColor=[UIColor getColor:@"2A2A2A"];
        _addressContent.font=[UIFont systemFontOfSize:24*SCREEN_RADIO];
    }
    
    return _addressContent;
}

-(UILabel *)signInLabel{
    if (!_signInLabel) {
        _signInLabel=[[UILabel alloc] initWithFrame:CGRectMake(30*SCREEN_RADIO, screen_height-170*SCREEN_RADIO, 0, 16*SCREEN_RADIO)];
        _signInLabel.text=@"Already have an account? ";
        _signInLabel.textColor=[UIColor getColor:@"6F6F6F"];
        _signInLabel.font=[UIFont systemFontOfSize:16*SCREEN_RADIO];
        [_signInLabel sizeToFit];
    }
    
    return _signInLabel;
}

-(UIButton *)signInBtn{
    if (!_signInBtn) {
        _signInBtn=[[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.signInLabel.frame)+5*SCREEN_RADIO, screen_height-170*SCREEN_RADIO, screen_width-CGRectGetMaxX(self.signInLabel.frame)+5*SCREEN_RADIO, 21*SCREEN_RADIO)];
        [_signInBtn setTitle:@"Sign in now!" forState:UIControlStateNormal];
        [_signInBtn setTitleColor:[UIColor getColor:@"157CF8"] forState:UIControlStateNormal];
        _signInBtn.titleLabel.font=[UIFont systemFontOfSize:21*SCREEN_RADIO];
        _signInBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_signInBtn addTarget:self action:@selector(signInClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _signInBtn;
}

-(UIButton *)setupBtn{
    if (!_setupBtn) {
        _setupBtn=[[UIButton alloc] initWithFrame:CGRectMake(30*SCREEN_RADIO, screen_height-120*SCREEN_RADIO, screen_width-60*SCREEN_RADIO, 50*SCREEN_RADIO)];
        [_setupBtn setTitle:@"Start Messaging" forState:UIControlStateNormal];
        [_setupBtn setTitleColor:[UIColor getColor:@"ffffff"] forState:UIControlStateNormal];
        _setupBtn.titleLabel.font=[UIFont systemFontOfSize:18*SCREEN_RADIO];
        [_setupBtn setBackgroundColor:[UIColor getColor:@"157CF8"]];
        _setupBtn.layer.cornerRadius=6;
        _setupBtn.clipsToBounds=YES;
        [_setupBtn addTarget:self action:@selector(setupClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _setupBtn;
}
@end
