//
//  CGNewForgetViewController.m
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/11/27.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGNewForgetViewController.h"
#import "CGNetworkData.h"
@interface CGNewForgetViewController ()
@property(nonatomic,strong)RkyExtendedHitButton *leftIcon;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIView *titleLineView;
@property(nonatomic,strong)UILabel *titleContent;
@property(nonatomic,strong)UILabel *emailLabel;
@property(nonatomic,strong)UITextField *emailContent;
@property(nonatomic,strong)RkyExtendedHitButton *signInBtn;
@end

@implementation CGNewForgetViewController
- (void)viewWillAppear:(BOOL)animated{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self addSubVies];
}

-(void)addSubVies{
    [self.view addSubview:self.leftIcon];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.titleLineView];
    [self.view addSubview:self.titleContent];
    [self.view addSubview:self.emailLabel];
    [self.view addSubview:self.emailContent];
    [self.view addSubview:self.signInBtn];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)setupClick{
    if (self.emailContent.text.length>0) {
        [CGNetworkData postData:@{@"email":self.emailContent.text} withUrl:@"https://www.llstudy.com/zxt/cg/fgt.aspx "];
        if([self.emailContent.text isEqualToString:[CGSingleCommitData sharedInstance].email]){
            self.emailLabel.text=NSLocalizedString(@"nidemima", nil);
            self.emailContent.userInteractionEnabled=NO;
            self.emailContent.text=[CGSingleCommitData sharedInstance].password;
            [self.emailLabel sizeToFit];
            self.signInBtn.userInteractionEnabled=NO;
        }else{
           [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"zhuceguo", nil)];
        }
    }
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
        _titleLabel.text=NSLocalizedString(@"chongzhimima", nil);
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

-(UILabel *)titleContent{
    if (!_titleContent) {
        _titleContent=[[UILabel alloc] initWithFrame:CGRectMake(30*SCREEN_RADIO, CGRectGetMaxY(self.titleLineView.frame)+26*SCREEN_RADIO, screen_width-60*SCREEN_RADIO, 44*SCREEN_RADIO)];
        _titleContent.font=[UIFont systemFontOfSize:16*SCREEN_RADIO];
        _titleContent.textColor=[UIColor getColor:@"6F6F6F"];
        _titleContent.text=NSLocalizedString(@"chongzhiyouxiang", nil);
        _titleContent.numberOfLines=2;
        _titleContent.lineBreakMode=NSLineBreakByTruncatingTail;
        [_titleContent sizeToFit];
    }
    
    return _titleContent;
}

-(UILabel *)emailLabel{
    if (!_emailLabel) {
        _emailLabel=[[UILabel alloc] initWithFrame:CGRectMake(30*SCREEN_RADIO, CGRectGetMaxY(self.titleContent.frame)+30*SCREEN_RADIO, 0, 14*SCREEN_RADIO)];
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

-(RkyExtendedHitButton *)signInBtn{
    if (!_signInBtn) {
        _signInBtn=[[RkyExtendedHitButton alloc] initWithFrame:CGRectMake(30*SCREEN_RADIO, screen_height-120*SCREEN_RADIO, screen_width-60*SCREEN_RADIO, 50*SCREEN_RADIO)];
        [_signInBtn setTitle:NSLocalizedString(@"xiugaimima", nil) forState:UIControlStateNormal];
        [_signInBtn setTitleColor:[UIColor getColor:@"ffffff"] forState:UIControlStateNormal];
        _signInBtn.titleLabel.font=[UIFont systemFontOfSize:18*SCREEN_RADIO];
        [_signInBtn setBackgroundColor:[UIColor getColor:@"157CF8"]];
        _signInBtn.layer.cornerRadius=6;
        _signInBtn.clipsToBounds=YES;
        [_signInBtn addTarget:self action:@selector(setupClick) forControlEvents:UIControlEventTouchUpInside];
        _signInBtn.hitTestEdgeInsets = UIEdgeInsetsMake(-25, -25, -25, -25);
    }
    
    return _signInBtn;
}

@end
