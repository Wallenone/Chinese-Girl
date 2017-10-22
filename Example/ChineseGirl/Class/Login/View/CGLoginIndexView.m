//
//  CGLoginIndexView.m
//  ChineseGirl
//
//  Created by wallen on 2017/8/31.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGLoginIndexView.h"
#import "CGLoginIndexCustomTextField.h"
@interface CGLoginIndexView(){
    SingUpClickBlock singUpClickBlock;
    ForgotPasswordClickBlock forgotPasswordClickBlock;
    SignInClickBlock signInClickBlock;
    GooleClickBlock gooleClickBlock;
    FacebookClickBlock facebookClickBlock;
    TwitterClickBlock twitterClickBlock;
    CanCelClickBlock canCelClickBlock;
}
@property(nonatomic,strong)UIButton *leftIcon;
@property(nonatomic,strong)UIImageView *bgImgView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIButton *SignupBtn;
@property(nonatomic,strong)CGLoginIndexCustomTextField *userNameField;
@property(nonatomic,strong)CGLoginIndexCustomTextField *passwordField;
@property(nonatomic,strong)UIButton *forgotPassword;
@property(nonatomic,strong)UIButton *signInBtn;
@property(nonatomic,strong)UILabel *acccoutLabel;  //第三方
@property(nonatomic,strong)UIButton *googleBtn;
@property(nonatomic,strong)UIButton *facebookBtn;
@property(nonatomic,strong)UIButton *twitterBtn;
@end
@implementation CGLoginIndexView


- (id)initWithFrame:(CGRect)frame onSingUpClick:(SingUpClickBlock)singUpBlock onForgotPasswordClick:(ForgotPasswordClickBlock)forgotPasswordBlock onSignInClick:(SignInClickBlock)signInkBlock onGooleClick:(GooleClickBlock)gooleBlock  onFacebookClick:(FacebookClickBlock)facebookBlock onwitterClick:(TwitterClickBlock)witterBlock onCanCelClick:(CanCelClickBlock)canCelClick{
    self.backgroundColor=[UIColor clearColor];
    if (self=[super initWithFrame:frame]) {
        singUpClickBlock = singUpBlock;
        forgotPasswordClickBlock = forgotPasswordBlock;
        signInClickBlock = signInkBlock;
        gooleClickBlock = gooleBlock;
        facebookClickBlock= facebookBlock;
        twitterClickBlock = witterBlock;
        canCelClickBlock = canCelClick;
        [self addSubViews];
    }
    
    return self;
    
}

-(void)addSubViews{
    
    [self addSubview:self.bgImgView];
    UIView *_view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _view.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [self.bgImgView addSubview:_view];
    [self addSubview:self.leftIcon];
    [self addSubview:self.titleLabel];
    [self addSubview:self.SignupBtn];
    [self addSubview:self.userNameField];
    [self addSubview:self.passwordField];
    [self addSubview:self.forgotPassword];
    [self addSubview:self.signInBtn];
    [self addSubview:self.acccoutLabel];
    [self addSubview:self.googleBtn];
    [self addSubview:self.facebookBtn];
    [self addSubview:self.twitterBtn];
}

-(void)back{
    if (canCelClickBlock) {
        canCelClickBlock();
    }
}


-(void)singUpClick{
    if (singUpClickBlock) {
        singUpClickBlock();
    }
}

-(void)forgotPasswordClick{
    if (forgotPasswordClickBlock) {
        forgotPasswordClickBlock();
    }
}

-(void)signInClick{
    if(self.userNameField.text.length>0 && self.passwordField.text.length>0){
        if (signInClickBlock) {
            signInClickBlock();
        }
    }
}

-(void)gooleClick{
    if (gooleClickBlock) {
        gooleClickBlock();
    }
}

-(void)facebookClick{
    if (facebookClickBlock) {
        facebookClickBlock();
    }
}

-(void)twitterClick{
    if (twitterClickBlock) {
        twitterClickBlock();
    }
}

-(void)checkRespons{
    if (self.userNameField.isFirstResponder) {
        [self.userNameField resignFirstResponder];
    }
    
    if (self.passwordField.isFirstResponder) {
        [self.passwordField resignFirstResponder];
    }
}

-(UIButton *)leftIcon{
    if (!_leftIcon) {
        _leftIcon=[[UIButton alloc] initWithFrame:CGRectMake(16*SCREEN_RADIO, 33*SCREEN_RADIO, 10*SCREEN_RADIO, 19*SCREEN_RADIO)];
        [_leftIcon setImage:[UIImage imageNamed:@"Arrowleft"] forState:UIControlStateNormal];
        [_leftIcon addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftIcon;
}




-(UIImageView *)bgImgView{
    if (!_bgImgView) {
        _bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _bgImgView.image= [self imageByApplyingAlpha:0.9 image: [UIImage imageNamed:@"login_Bitmap"]];
    }
    
    return _bgImgView;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(60*SCREEN_RADIO, 168*SCREEN_RADIO, 0, 26*SCREEN_RADIO)];
        _titleLabel.textAlignment=NSTextAlignmentCenter;
        _titleLabel.textColor=[UIColor getColor:@"F4F8FA"];
        _titleLabel.font=[UIFont systemFontOfSize:17*SCREEN_RADIO];
        NSString *cg_text=@"Have no account yet? ";
        _titleLabel.text=cg_text;
        [_titleLabel sizeToFit];
    }
    
    return _titleLabel;
}

-(UIButton *)SignupBtn{
    if (!_SignupBtn) {
        _SignupBtn=[[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.titleLabel.frame), 166*SCREEN_RADIO, 100, 26*SCREEN_RADIO)];
        [_SignupBtn setTitle:@"Signup" forState:UIControlStateNormal];
        [_SignupBtn setTitleColor:[UIColor getColor:@"F4F8FA"] forState:UIControlStateNormal];
        _SignupBtn.titleLabel.font=[UIFont boldSystemFontOfSize:24*SCREEN_RADIO];
         [_SignupBtn addTarget:self action:@selector(singUpClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _SignupBtn;
}

-(CGLoginIndexCustomTextField *)userNameField{
    if (!_userNameField) {
        _userNameField=[[CGLoginIndexCustomTextField alloc] initWithFrame:CGRectMake(62.5*SCREEN_RADIO, CGRectGetMaxY(self.titleLabel.frame)+53*SCREEN_RADIO, screen_width-125*SCREEN_RADIO, 45*SCREEN_RADIO)];
        _userNameField.layer.cornerRadius=45/2*SCREEN_RADIO;
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        // 设置富文本对象的颜色
        attributes[NSForegroundColorAttributeName] = [UIColor whiteColor];
        // 设置UITextField的占位文字
        _userNameField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email" attributes:attributes];
        _userNameField.textColor=[UIColor whiteColor];
        _userNameField.backgroundColor=[UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:0.2];
        UIImageView *imageViewuserName=[[UIImageView alloc]initWithFrame:CGRectMake(44*SCREEN_RADIO, 13*SCREEN_RADIO, 23*SCREEN_RADIO, 19*SCREEN_RADIO)];
        imageViewuserName.image=[UIImage imageNamed:@"login_Mail"];
        _userNameField.rightView=imageViewuserName;
        _userNameField.rightViewMode=UITextFieldViewModeAlways; //此处用来设置leftview现实时机
        _userNameField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _userNameField.autocorrectionType = UITextAutocorrectionTypeNo;
    }
    
    return _userNameField;
}

-(CGLoginIndexCustomTextField *)passwordField{
    if (!_passwordField) {
        _passwordField=[[CGLoginIndexCustomTextField alloc] initWithFrame:CGRectMake(62.5*SCREEN_RADIO, CGRectGetMaxY(self.userNameField.frame)+15*SCREEN_RADIO, screen_width-125*SCREEN_RADIO, 45*SCREEN_RADIO)];
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

-(UIButton *)forgotPassword{
    if (!_forgotPassword) {
        _forgotPassword=[[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.passwordField.frame)+25*SCREEN_RADIO, screen_width, 22*SCREEN_RADIO)];
        _forgotPassword.titleLabel.font=[UIFont systemFontOfSize:14*SCREEN_RADIO];
        [_forgotPassword setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_forgotPassword setTitle:@"Forgot your Password?" forState:UIControlStateNormal];
        [_forgotPassword addTarget:self action:@selector(forgotPasswordClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _forgotPassword;
}

-(UIButton *)signInBtn{
    if (!_signInBtn) {
        _signInBtn=[[UIButton alloc] initWithFrame:CGRectMake(87.5*SCREEN_RADIO, CGRectGetMaxY(self.forgotPassword.frame)+39*SCREEN_RADIO, screen_width-87.5*2*SCREEN_RADIO, 52*SCREEN_RADIO)];
        [_signInBtn setTitle:@"Sign In" forState:UIControlStateNormal];
        [_signInBtn addTarget:self action:@selector(signInClick) forControlEvents:UIControlEventTouchUpInside];
        _signInBtn.titleLabel.font=[UIFont systemFontOfSize:22*SCREEN_RADIO];
        [_signInBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _signInBtn.layer.cornerRadius=52/2*SCREEN_RADIO;
        _signInBtn.layer.borderWidth=2;
        _signInBtn.layer.borderColor=[UIColor whiteColor].CGColor;
    }
    
    return _signInBtn;
}

-(UILabel *)acccoutLabel{
    if (!_acccoutLabel) {
        _acccoutLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.signInBtn.frame)+30*SCREEN_RADIO, screen_width, 22*SCREEN_RADIO)];
        _acccoutLabel.font=[UIFont systemFontOfSize:14*SCREEN_RADIO];
        _acccoutLabel.textColor=[UIColor getColor:@"99A3A9"];
        _acccoutLabel.text=@"OR SIGN WITH A SOCIAL ACCOUNT";
        _acccoutLabel.textAlignment=NSTextAlignmentCenter;
    }
    
    return _acccoutLabel;
}

-(UIButton *)googleBtn{
    if (!_googleBtn) {
        _googleBtn=[[UIButton alloc] initWithFrame:CGRectMake(105*SCREEN_RADIO, CGRectGetMaxY(self.acccoutLabel.frame)+13*SCREEN_RADIO, 45*SCREEN_RADIO, 45*SCREEN_RADIO)];
        [_googleBtn setBackgroundImage:[UIImage imageNamed:@"login_Google+"] forState:UIControlStateNormal];
        [_googleBtn addTarget:self action:@selector(gooleClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _googleBtn;
}

-(UIButton *)facebookBtn{
    if (!_facebookBtn) {
        _facebookBtn=[[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.googleBtn.frame)+15*SCREEN_RADIO, CGRectGetMaxY(self.acccoutLabel.frame)+13*SCREEN_RADIO, 45*SCREEN_RADIO, 45*SCREEN_RADIO)];
        [_facebookBtn setBackgroundImage:[UIImage imageNamed:@"login_Facebook"] forState:UIControlStateNormal];
        [_facebookBtn addTarget:self action:@selector(facebookClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _facebookBtn;
}

-(UIButton *)twitterBtn{
    if (!_twitterBtn) {
        _twitterBtn=[[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.facebookBtn.frame)+15*SCREEN_RADIO, CGRectGetMaxY(self.acccoutLabel.frame)+13*SCREEN_RADIO, 45*SCREEN_RADIO, 45*SCREEN_RADIO)];
        [_twitterBtn setBackgroundImage:[UIImage imageNamed:@"login_Twitter"] forState:UIControlStateNormal];
        [_twitterBtn addTarget:self action:@selector(twitterClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _twitterBtn;
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
