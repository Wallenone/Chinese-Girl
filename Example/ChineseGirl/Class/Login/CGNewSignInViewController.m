//
//  CGNewSignInViewController.m
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/11/27.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGNewSignInViewController.h"
#import "CGNewForgetViewController.h"
#import "CGNewIndexViewController.h"
@interface CGNewSignInViewController ()
@property(nonatomic,strong)UIButton *leftIcon;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIView *titleLineView;
@property(nonatomic,strong)UILabel *emailLabel;
@property(nonatomic,strong)UITextField *emailContent;
@property(nonatomic,strong)UILabel *password;
@property(nonatomic,strong)UITextField *passwordContent;
@property(nonatomic,strong)UILabel *ForgetLabel;
@property(nonatomic,strong)UIButton *ForgetBtn;
@property(nonatomic,strong)UILabel *SignUpLabel;
@property(nonatomic,strong)UIButton *SignUpBtn;
@property(nonatomic,strong)UIButton *signInBtn;
@end

@implementation CGNewSignInViewController

- (void)viewWillAppear:(BOOL)animated{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self addsubViews];
}

-(void)addsubViews{
    [self.view addSubview:self.leftIcon];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.titleLineView];
    [self.view addSubview:self.emailLabel];
    [self.view addSubview:self.emailContent];
    [self.view addSubview:self.password];
    [self.view addSubview:self.passwordContent];
    [self.view addSubview:self.ForgetLabel];
    [self.view addSubview:self.ForgetBtn];
    [self.view addSubview:self.SignUpLabel];
    [self.view addSubview:self.SignUpBtn];
    [self.view addSubview:self.signInBtn];
}

-(void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)signInClick{
    CGNewForgetViewController *forgetVC=[[CGNewForgetViewController alloc] init];
    [self.navigationController pushViewController:forgetVC animated:NO];
}

-(void)setupClick{
    if(self.emailContent.text.length>0 && self.passwordContent.text.length>0){
        if ([self.emailContent.text isEqualToString:[CGSingleCommitData sharedInstance].email] && [self.passwordContent.text isEqualToString:[CGSingleCommitData sharedInstance].password]) {
                [CGSingleCommitData sharedInstance].uid=self.emailContent.text;
                [CGSingleCommitData sharedInstance].email=self.emailContent.text;
                [CGSingleCommitData sharedInstance].password=self.passwordContent.text;
            [self setState:YES withMessgae:NSLocalizedString(@"login_success", nil)];
        }else{
                [self setState:NO withMessgae:NSLocalizedString(@"ERROR_Incorrect_username_or_password", nil)];
        }
    }
}

-(void)setState:(BOOL)state withMessgae:(NSString *)messageText{
    if (state) {
        [SVProgressHUD showSuccessWithStatus:messageText];
        [self dismissViewControllerAnimated:NO completion:nil];
    }else{
        [SVProgressHUD showErrorWithStatus:messageText];
    }
}

-(void)signUpClick{
    CGNewIndexViewController *indexVC=[[CGNewIndexViewController alloc] init];
    [self.navigationController pushViewController:indexVC animated:NO];
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
        _titleLabel.text=@"Sign In";
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

-(UILabel *)password{
    if (!_password)  {
        _password=[[UILabel alloc] initWithFrame:CGRectMake(30*SCREEN_RADIO, CGRectGetMaxY(self.emailContent.frame)+30*SCREEN_RADIO, 0, 14*SCREEN_RADIO)];
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

-(UILabel *)ForgetLabel{
    if (!_ForgetLabel) {
        _ForgetLabel=[[UILabel alloc] initWithFrame:CGRectMake(30*SCREEN_RADIO, screen_height-210*SCREEN_RADIO, 0, 16*SCREEN_RADIO)];
        _ForgetLabel.text=@"Forgot your password? ";
        _ForgetLabel.textColor=[UIColor getColor:@"6F6F6F"];
        _ForgetLabel.font=[UIFont systemFontOfSize:16*SCREEN_RADIO];
        [_ForgetLabel sizeToFit];
    }
    
    return _ForgetLabel;
}

-(UIButton *)ForgetBtn{
    if (!_ForgetBtn) {
        _ForgetBtn=[[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.ForgetLabel.frame)+5*SCREEN_RADIO, screen_height-210*SCREEN_RADIO, screen_width-CGRectGetMaxX(self.ForgetLabel.frame)+5*SCREEN_RADIO, 21*SCREEN_RADIO)];
        [_ForgetBtn setTitle:@"Reset." forState:UIControlStateNormal];
        [_ForgetBtn setTitleColor:[UIColor getColor:@"157CF8"] forState:UIControlStateNormal];
        _ForgetBtn.titleLabel.font=[UIFont systemFontOfSize:21*SCREEN_RADIO];
        _ForgetBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_ForgetBtn addTarget:self action:@selector(signInClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _ForgetBtn;
}

-(UILabel *)SignUpLabel{
    if (!_SignUpLabel) {
        _SignUpLabel=[[UILabel alloc] initWithFrame:CGRectMake(30*SCREEN_RADIO, screen_height-170*SCREEN_RADIO, 0, 16*SCREEN_RADIO)];
        _SignUpLabel.text=@"Create an Account? ";
        _SignUpLabel.textColor=[UIColor getColor:@"6F6F6F"];
        _SignUpLabel.font=[UIFont systemFontOfSize:16*SCREEN_RADIO];
        [_SignUpLabel sizeToFit];
    }
    
    return _SignUpLabel;
}

-(UIButton *)SignUpBtn{
    if (!_SignUpBtn) {
        _SignUpBtn=[[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.SignUpLabel.frame)+5*SCREEN_RADIO, screen_height-170*SCREEN_RADIO, screen_width-CGRectGetMaxX(self.SignUpLabel.frame)+5*SCREEN_RADIO, 21*SCREEN_RADIO)];
        [_SignUpBtn setTitle:@"RightNow!" forState:UIControlStateNormal];
        [_SignUpBtn setTitleColor:[UIColor getColor:@"157CF8"] forState:UIControlStateNormal];
        _SignUpBtn.titleLabel.font=[UIFont systemFontOfSize:21*SCREEN_RADIO];
        _SignUpBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_SignUpBtn addTarget:self action:@selector(signUpClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _SignUpBtn;
}


-(UIButton *)signInBtn{
    if (!_signInBtn) {
        _signInBtn=[[UIButton alloc] initWithFrame:CGRectMake(30*SCREEN_RADIO, screen_height-120*SCREEN_RADIO, screen_width-60*SCREEN_RADIO, 50*SCREEN_RADIO)];
        [_signInBtn setTitle:@"Start Messaging" forState:UIControlStateNormal];
        [_signInBtn setTitleColor:[UIColor getColor:@"ffffff"] forState:UIControlStateNormal];
        _signInBtn.titleLabel.font=[UIFont systemFontOfSize:18*SCREEN_RADIO];
        [_signInBtn setBackgroundColor:[UIColor getColor:@"157CF8"]];
        _signInBtn.layer.cornerRadius=6;
        _signInBtn.clipsToBounds=YES;
        [_signInBtn addTarget:self action:@selector(setupClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _signInBtn;
}

@end
