//
//  CGForgetPasswordViewController.m
//  ChineseGirl
//
//  Created by Wallen on 2017/9/8.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGForgetPasswordViewController.h"
#import "CGLoginIndexCustomTextField.h"
@interface CGForgetPasswordViewController ()
@property(nonatomic,strong)UIButton *backBtn;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)CGLoginIndexCustomTextField *EmailField;
@end

@implementation CGForgetPasswordViewController

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    self.navigationItem.hidesBackButton = YES;
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

-(void)backClick{
    [self.navigationController popViewControllerAnimated:NO];
}

-(UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn=[[UIButton alloc] initWithFrame:CGRectMake(16*SCREEN_RADIO, 33*SCREEN_RADIO, 10*SCREEN_RADIO, 19*SCREEN_RADIO)];
        [_backBtn setBackgroundImage:[UIImage imageNamed:@"BlackArrowleft"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _backBtn;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(50*SCREEN_RADIO, CGRectGetMaxY(self.backBtn.frame)+12*SCREEN_RADIO, SCREEN_WIDTH-100*SCREEN_RADIO, 0)];
        _titleLabel.text=@"PASSWORD RECOVERY";
        _titleLabel.textColor=[UIColor getColor:@"232627"];
        _titleLabel.font=[UIFont systemFontOfSize:32*SCREEN_RADIO];
        _titleLabel.numberOfLines=0;
        [_titleLabel sizeToFit];
    }
    
    return _titleLabel;
}

-(CGLoginIndexCustomTextField *)EmailField{
    if (!_EmailField) {
        _EmailField=[[CGLoginIndexCustomTextField alloc] initWithFrame:CGRectMake(62.5*SCREEN_RADIO, CGRectGetMaxY(self.titleLabel.frame)+15*SCREEN_RADIO, screen_width-125*SCREEN_RADIO, 45*SCREEN_RADIO)];
        _EmailField.layer.cornerRadius=45/2*SCREEN_RADIO;
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        // 设置富文本对象的颜色
        attributes[NSForegroundColorAttributeName] = [UIColor whiteColor];
        // 设置UITextField的占位文字
        _EmailField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email" attributes:attributes];
        _EmailField.textColor=[UIColor whiteColor];
        _EmailField.backgroundColor=[UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:0.2];
        UIImageView *imageViewuserName=[[UIImageView alloc]initWithFrame:CGRectMake(44*SCREEN_RADIO, 13*SCREEN_RADIO, 23*SCREEN_RADIO, 19*SCREEN_RADIO)];
        imageViewuserName.image=[UIImage imageNamed:@"login_Mail"];
        _EmailField.rightView=imageViewuserName;
        _EmailField.rightViewMode=UITextFieldViewModeAlways; //此处用来设置leftview现实时机
        _EmailField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _EmailField.autocorrectionType = UITextAutocorrectionTypeNo;
    }
    
    return _EmailField;
}


@end
