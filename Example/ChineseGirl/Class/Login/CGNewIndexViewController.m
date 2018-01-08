//
//  CGNewIndexViewController.m
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/11/27.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGNewIndexViewController.h"
#import "CGNewSignInViewController.h"
#import "UICountryViewController.h"
#import "CGProfileIndexViewController.h"
#import "CGAppDelegate.h"
@interface CGNewIndexViewController ()
@property(nonatomic,strong)RkyExtendedHitButton *leftIcon;
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
@property(nonatomic,strong)RkyExtendedHitButton *cityBtn;
@property(nonatomic,strong)RkyExtendedHitButton *setupBtn;
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getCityName:) name:@"getAreaName" object:nil];
    [self addSubViews];
}

-(void)getCityName:(NSNotification *)obj{
    if ([obj.object stringForKey:@"countryName"].length>0 || [obj.object stringForKey:@"cityName"].length>0) {
        NSString *str=[NSString stringWithFormat:@"%@ %@",[obj.object stringForKey:@"countryName"],[obj.object stringForKey:@"cityName"]];
        [CGSingleCommitData sharedInstance].countryName=[obj.object stringForKey:@"countryName"];
        [CGSingleCommitData sharedInstance].cityName=[obj.object stringForKey:@"cityName"];
        if (str.length>0) {
            self.addressContent.text=str;
        }
    }
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
    [self.view addSubview:self.cityBtn];
    [self.view addSubview:self.setupBtn];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)chooseCity{
    UICountryViewController *countryVC=[[UICountryViewController alloc] init];
    [self.navigationController pushViewController:countryVC animated:NO];
}


-(void)setupClick{
    if ([self isValidateEmail:self.emailContent.text]) {
            if (self.usernameContent.text.length>0) {
            if (self.passwordContent.text.length>=6) {
                
                if (self.addressContent.text.length>0) {
                    [CGSingleCommitData sharedInstance].uid=self.emailContent.text;
                    [CGSingleCommitData sharedInstance].nickName=self.usernameContent.text;
                    [CGSingleCommitData sharedInstance].email=self.emailContent.text;
                    [CGSingleCommitData sharedInstance].password=self.passwordContent.text;
                    [self showMessageWithState:YES withWarningsText:NSLocalizedString(@"register_success", nil)];
                }else{
                    [self showMessageWithState:NO withWarningsText:NSLocalizedString(@"city_can_not_be_empty", nil)];
                }
                
            }else{
                [self showMessageWithState:NO withWarningsText:NSLocalizedString(@"password_no_less_than_6_characters", nil)];
            }
            
            
        }else{
            [self showMessageWithState:NO withWarningsText:NSLocalizedString(@"username_cannot_be_empty", nil)];
        }
    }else{
        [self showMessageWithState:NO withWarningsText:NSLocalizedString(@"the_mailbox_format_is_incorrect", nil)];
    }
    
}

-(void)showMessageWithState:(BOOL)state withWarningsText:(NSString *)warningsText{
    if (state) {
        [SVProgressHUD showSuccessWithStatus:warningsText];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }else{
        [SVProgressHUD showErrorWithStatus:warningsText];
    }
}

-(void)signInClick{
    CGNewSignInViewController *signInVC=[[CGNewSignInViewController alloc] init];
    [self.navigationController pushViewController:signInVC animated:NO];
}

-(RkyExtendedHitButton *)leftIcon{
    if (!_leftIcon) {
        _leftIcon=[[RkyExtendedHitButton alloc] initWithFrame:CGRectMake(23*SCREEN_RADIO, 37*SCREEN_RADIO, 10*SCREEN_RADIO, 19*SCREEN_RADIO)];
        [_leftIcon setImage:[UIImage imageNamed:@"BlackArrowleft"] forState:UIControlStateNormal];
        [_leftIcon addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        _leftIcon.hitTestEdgeInsets = UIEdgeInsetsMake(-25, -25, -25, -25);
    }
    return _leftIcon;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.leftIcon.frame)+13*SCREEN_RADIO, 29*SCREEN_RADIO, 0, 35*SCREEN_RADIO)];
        _titleLabel.text=NSLocalizedString(@"chuangjianyonghu", nil);
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
        _emailLabel.text=NSLocalizedString(@"yourEmail", nil);
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
        _username.text=NSLocalizedString(@"nicheng", nil);
        _username.textColor=[UIColor getColor:@"2A2A2A"];
        _username.font=[UIFont systemFontOfSize:14*SCREEN_RADIO];
        [_username sizeToFit];
    }

    return _username;
}

-(UITextField *)usernameContent{
    if (!_usernameContent) {
        _usernameContent=[[UITextField alloc] initWithFrame:CGRectMake(30*SCREEN_RADIO, CGRectGetMaxY(self.username.frame)+7*SCREEN_RADIO, SCREEN_WIDTH-60*SCREEN_RADIO, 32*SCREEN_RADIO)];
        _usernameContent.placeholder=NSLocalizedString(@"yourNickname", nil);
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
        _password.text=NSLocalizedString(@"chuangjianmima", nil);
        _password.textColor=[UIColor getColor:@"2A2A2A"];
        _password.font=[UIFont systemFontOfSize:14*SCREEN_RADIO];
        [_password sizeToFit];
    }
    
    return _password;
}

-(UITextField *)passwordContent{
    if (!_passwordContent) {
        _passwordContent=[[UITextField alloc] initWithFrame:CGRectMake(30*SCREEN_RADIO, CGRectGetMaxY(self.password.frame)+7*SCREEN_RADIO, SCREEN_WIDTH-60*SCREEN_RADIO, 32*SCREEN_RADIO)];
        _passwordContent.placeholder=NSLocalizedString(@"zhishao6zifu", nil);
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
        _address.text=NSLocalizedString(@"xuanzechengshi", nil);
        _address.textColor=[UIColor getColor:@"2A2A2A"];
        _address.font=[UIFont systemFontOfSize:14*SCREEN_RADIO];
        [_address sizeToFit];
    }
    
    return _address;
}

-(UITextField *)addressContent{
    if (!_addressContent) {
        _addressContent=[[UITextField alloc] initWithFrame:CGRectMake(30*SCREEN_RADIO, CGRectGetMaxY(self.address.frame)+7*SCREEN_RADIO, SCREEN_WIDTH-60*SCREEN_RADIO, 32*SCREEN_RADIO)];
        _addressContent.placeholder=NSLocalizedString(@"yourCity", nil);
        [_addressContent setValue:[UIColor getColor:@"D5D5D5"] forKeyPath:@"_placeholderLabel.textColor"];
        [_addressContent setValue:[UIFont boldSystemFontOfSize:24*SCREEN_RADIO] forKeyPath:@"_placeholderLabel.font"];
        _addressContent.textColor=[UIColor getColor:@"2A2A2A"];
        _addressContent.font=[UIFont systemFontOfSize:24*SCREEN_RADIO];
    }
    
    return _addressContent;
}

-(RkyExtendedHitButton *)cityBtn{
    if (!_cityBtn) {
        _cityBtn=[[RkyExtendedHitButton alloc] initWithFrame:CGRectMake(30*SCREEN_RADIO, CGRectGetMaxY(self.address.frame)+7*SCREEN_RADIO, SCREEN_WIDTH-60*SCREEN_RADIO, 32*SCREEN_RADIO)];
        [_cityBtn addTarget:self action:@selector(chooseCity) forControlEvents:UIControlEventTouchUpInside];
        _cityBtn.hitTestEdgeInsets = UIEdgeInsetsMake(-25, -25, -25, -25);
    }
    
    return _cityBtn;
}

-(RkyExtendedHitButton *)setupBtn{
    if (!_setupBtn) {
        _setupBtn=[[RkyExtendedHitButton alloc] initWithFrame:CGRectMake(30*SCREEN_RADIO, screen_height-120*SCREEN_RADIO, screen_width-60*SCREEN_RADIO, 50*SCREEN_RADIO)];
        [_setupBtn setTitle:NSLocalizedString(@"fasongxinxi", nil) forState:UIControlStateNormal];
        [_setupBtn setTitleColor:[UIColor getColor:@"ffffff"] forState:UIControlStateNormal];
        _setupBtn.titleLabel.font=[UIFont systemFontOfSize:18*SCREEN_RADIO];
        [_setupBtn setBackgroundColor:[UIColor getColor:@"157CF8"]];
        _setupBtn.layer.cornerRadius=6;
        _setupBtn.clipsToBounds=YES;
        [_setupBtn addTarget:self action:@selector(setupClick) forControlEvents:UIControlEventTouchUpInside];
        _setupBtn.hitTestEdgeInsets = UIEdgeInsetsMake(-25, -25, -25, -25);
    }
    
    return _setupBtn;
}

- (BOOL)isValidateEmail:(NSString *)email{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
@end
