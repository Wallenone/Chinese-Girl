//
//  CGRegisterIndexView.m
//  ChineseGirl
//
//  Created by wallen on 2017/8/31.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGRegisterIndexView.h"
#import "CGLoginIndexCustomTextField.h"
@interface CGRegisterIndexView(){
    CancelClickBlock cancelClickBlock;
    SingUpClickBlock singUpClickBlock;
}
@property(nonatomic,strong)UIImageView *bgImgView;
@property(nonatomic,strong)UIButton *cancelBtn;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)CGLoginIndexCustomTextField *userNameField;
@property(nonatomic,strong)CGLoginIndexCustomTextField *EmailField;
@property(nonatomic,strong)CGLoginIndexCustomTextField *passwordField;
@property(nonatomic,strong)CGLoginIndexCustomTextField *confirmPasswordField;
@property(nonatomic,strong)UILabel *AgreementLabel;
@property(nonatomic,strong)UIButton *signUpBtn;
@end
@implementation CGRegisterIndexView


- (id)initWithFrame:(CGRect)frame onCancelClick:(CancelClickBlock)cancelBlock onSingUpClick:(SingUpClickBlock)singUpBlock{
    self.backgroundColor=[UIColor clearColor];
    if (self=[super initWithFrame:frame]) {
        cancelClickBlock = cancelBlock;
        singUpClickBlock = singUpBlock;
        
        [self addSubViews];
    }
    
    return self;
    
}

-(void)addSubViews{
    [self addSubview:self.bgImgView];
    UIView *_view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _view.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [self.bgImgView addSubview:_view];
    [self addSubview:self.cancelBtn];
    [self addSubview:self.titleLabel];
    [self addSubview:self.userNameField];
    [self addSubview:self.EmailField];
    [self addSubview:self.passwordField];
    [self addSubview:self.confirmPasswordField];
    [self addSubview:self.AgreementLabel];
    [self addSubview:self.signUpBtn];
}


-(void)singUpClick{
    if (singUpClickBlock) {
        singUpClickBlock();
    }
}

-(void)cancelClick{
    if (cancelClickBlock) {
        cancelClickBlock();
    }
}


-(UIImageView *)bgImgView{
    if (!_bgImgView) {
        _bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _bgImgView.image= [self imageByApplyingAlpha:0.9 image: [UIImage imageNamed:@"reg_Bitmap"]];
    }
    
    return _bgImgView;
}

-(UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn=[[UIButton alloc] initWithFrame:CGRectMake(16*SCREEN_RADIO, 33*SCREEN_RADIO, 10*SCREEN_RADIO, 19*SCREEN_RADIO)];
        [_cancelBtn setBackgroundImage:[UIImage imageNamed:@"Arrowleft"] forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _cancelBtn;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 94.6*SCREEN_RADIO, screen_width, 26*SCREEN_RADIO)];
        _titleLabel.textAlignment=NSTextAlignmentCenter;
        _titleLabel.textColor=[UIColor getColor:@"ffffff"];
        _titleLabel.font=[UIFont boldSystemFontOfSize:24*SCREEN_RADIO];
        _titleLabel.text=@"Create Your ID";
    }
    
    return _titleLabel;
}


-(CGLoginIndexCustomTextField *)userNameField{
    if (!_userNameField) {
        _userNameField=[[CGLoginIndexCustomTextField alloc] initWithFrame:CGRectMake(62.5*SCREEN_RADIO, CGRectGetMaxY(self.titleLabel.frame)+45.8*SCREEN_RADIO, screen_width-125*SCREEN_RADIO, 45*SCREEN_RADIO)];
        _userNameField.layer.cornerRadius=45/2*SCREEN_RADIO;
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        // 设置富文本对象的颜色
        attributes[NSForegroundColorAttributeName] = [UIColor whiteColor];
        // 设置UITextField的占位文字
        _userNameField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Username" attributes:attributes];
        _userNameField.textColor=[UIColor whiteColor];
        _userNameField.backgroundColor=[UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:0.2];
        UIImageView *imageViewuserName=[[UIImageView alloc]initWithFrame:CGRectMake(44*SCREEN_RADIO, 13*SCREEN_RADIO, 23*SCREEN_RADIO, 19*SCREEN_RADIO)];
        imageViewuserName.image=[UIImage imageNamed:@"reg_Avatar"];
        _userNameField.rightView=imageViewuserName;
        _userNameField.rightViewMode=UITextFieldViewModeAlways; //此处用来设置leftview现实时机
        _userNameField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _userNameField.autocorrectionType = UITextAutocorrectionTypeNo;
    }
    
    return _userNameField;
}

-(CGLoginIndexCustomTextField *)EmailField{
    if (!_EmailField) {
        _EmailField=[[CGLoginIndexCustomTextField alloc] initWithFrame:CGRectMake(62.5*SCREEN_RADIO, CGRectGetMaxY(self.userNameField.frame)+15*SCREEN_RADIO, screen_width-125*SCREEN_RADIO, 45*SCREEN_RADIO)];
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

-(CGLoginIndexCustomTextField *)passwordField{
    if (!_passwordField) {
        _passwordField=[[CGLoginIndexCustomTextField alloc] initWithFrame:CGRectMake(62.5*SCREEN_RADIO, CGRectGetMaxY(self.EmailField.frame)+15*SCREEN_RADIO, screen_width-125*SCREEN_RADIO, 45*SCREEN_RADIO)];
        _passwordField.layer.cornerRadius=45/2*SCREEN_RADIO;
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        // 设置富文本对象的颜色
        attributes[NSForegroundColorAttributeName] = [UIColor whiteColor];
        // 设置UITextField的占位文字
        _passwordField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:attributes];
        _passwordField.textColor=[UIColor whiteColor];
        _passwordField.backgroundColor=[UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:0.2];
        UIImageView *imageViewPassword=[[UIImageView alloc]initWithFrame:CGRectMake(44*SCREEN_RADIO, 13*SCREEN_RADIO, 23*SCREEN_RADIO, 19*SCREEN_RADIO)];
        imageViewPassword.image=[UIImage imageNamed:@"login_Password"];
        _passwordField.rightView=imageViewPassword;
        _passwordField.rightViewMode=UITextFieldViewModeAlways; //此处用来设置leftview现实时机
        _passwordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _passwordField.autocorrectionType = UITextAutocorrectionTypeNo;
    }
    
    return _passwordField;
}

-(CGLoginIndexCustomTextField *)confirmPasswordField{
    if (!_confirmPasswordField) {
        _confirmPasswordField=[[CGLoginIndexCustomTextField alloc] initWithFrame:CGRectMake(62.5*SCREEN_RADIO, CGRectGetMaxY(self.passwordField.frame)+15*SCREEN_RADIO, screen_width-125*SCREEN_RADIO, 45*SCREEN_RADIO)];
        _confirmPasswordField.layer.cornerRadius=45/2*SCREEN_RADIO;
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        // 设置富文本对象的颜色
        attributes[NSForegroundColorAttributeName] = [UIColor whiteColor];
        // 设置UITextField的占位文字
        _confirmPasswordField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Confirm Password" attributes:attributes];
        _confirmPasswordField.textColor=[UIColor whiteColor];
        _confirmPasswordField.backgroundColor=[UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:0.2];
        UIImageView *imageViewPassword=[[UIImageView alloc]initWithFrame:CGRectMake(44*SCREEN_RADIO, 13*SCREEN_RADIO, 23*SCREEN_RADIO, 19*SCREEN_RADIO)];
        imageViewPassword.image=[UIImage imageNamed:@"reg_Ok"];
        _confirmPasswordField.rightView=imageViewPassword;
        _confirmPasswordField.rightViewMode=UITextFieldViewModeAlways; //此处用来设置leftview现实时机
        _confirmPasswordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _confirmPasswordField.autocorrectionType = UITextAutocorrectionTypeNo;
    }
    
    return _confirmPasswordField;
}



-(UILabel *)AgreementLabel{
    if (!_AgreementLabel) {
        _AgreementLabel=[[UILabel alloc] initWithFrame:CGRectMake(57*SCREEN_RADIO, CGRectGetMaxY(self.confirmPasswordField.frame)+25*SCREEN_RADIO, screen_width-113.5*SCREEN_RADIO, 0)];
        _AgreementLabel.font=[UIFont systemFontOfSize:14*SCREEN_RADIO];
        _AgreementLabel.textColor=[UIColor getColor:@"99A3A9"];
        _AgreementLabel.text=@"You further agree with the terms and conditions set forth in this Agreement.";
        _AgreementLabel.textAlignment=NSTextAlignmentCenter;
        _AgreementLabel.numberOfLines=2;
        [_AgreementLabel sizeToFit];
    }
    
    return _AgreementLabel;
}



-(UIButton *)signUpBtn{
    if (!_signUpBtn) {
        _signUpBtn=[[UIButton alloc] initWithFrame:CGRectMake(87.5*SCREEN_RADIO, CGRectGetMaxY(self.AgreementLabel.frame)+24*SCREEN_RADIO, screen_width-87.5*2*SCREEN_RADIO, 52*SCREEN_RADIO)];
        [_signUpBtn setTitle:@"Sign Up" forState:UIControlStateNormal];
        [_signUpBtn addTarget:self action:@selector(singUpClick) forControlEvents:UIControlEventTouchUpInside];
        _signUpBtn.titleLabel.font=[UIFont systemFontOfSize:22*SCREEN_RADIO];
        [_signUpBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _signUpBtn.layer.cornerRadius=52/2*SCREEN_RADIO;
        _signUpBtn.layer.borderWidth=2;
        _signUpBtn.layer.borderColor=[UIColor whiteColor].CGColor;
    }
    
    return _signUpBtn;
}


/**
 *  设置图片透明度
 * @param alpha 透明度
 * @param image 图片
 */
-(UIImage *)imageByApplyingAlpha:(CGFloat )alpha  image:(UIImage*)image
{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSetBlendMode(ctx, kCGBlendModeNormal);

    CGContextSetAlpha(ctx, alpha);

    CGContextDrawImage(ctx, area, image.CGImage);

    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return newImage;
    
}
@end
