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
@property(nonatomic,strong)UIImageView *bgImgView;
@property(nonatomic,strong)UIButton *backBtn;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)CGLoginIndexCustomTextField *EmailField;
@property(nonatomic,strong)UIButton *recoverBtn;
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
    [self addSubViews];
}

-(void)addSubViews{
    [self.view addSubview:self.bgImgView];
    UIView *_view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _view.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [self.bgImgView addSubview:_view];
    [self.view addSubview:self.backBtn];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.EmailField];
    [self.view addSubview:self.recoverBtn];
}

-(void)backClick{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)recoverClick{
    
}

-(UIImageView *)bgImgView{
    if (!_bgImgView) {
        _bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        _bgImgView.image= [self imageByApplyingAlpha:0.9 image: [UIImage imageNamed:@"forget_Bitmap"]];
    }
    
    return _bgImgView;
}

-(UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn=[[UIButton alloc] initWithFrame:CGRectMake(16*SCREEN_RADIO, 33*SCREEN_RADIO, 10*SCREEN_RADIO, 19*SCREEN_RADIO)];
        [_backBtn setBackgroundImage:[UIImage imageNamed:@"Arrowleft"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _backBtn;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(50*SCREEN_RADIO, CGRectGetMaxY(self.backBtn.frame)+12*SCREEN_RADIO, screen_width-100*SCREEN_RADIO, 174*SCREEN_RADIO)];
        _titleLabel.text=@"PASSWORD \nRECOVERY";
        _titleLabel.textColor=[UIColor getColor:@"FFFFFF"];
        _titleLabel.font=[UIFont systemFontOfSize:32*SCREEN_RADIO];
        _titleLabel.numberOfLines=0;
        _titleLabel.textAlignment=NSTextAlignmentCenter;
    }
    
    return _titleLabel;
}

-(CGLoginIndexCustomTextField *)EmailField{
    if (!_EmailField) {
        _EmailField=[[CGLoginIndexCustomTextField alloc] initWithFrame:CGRectMake(62.5*SCREEN_RADIO, CGRectGetMaxY(self.titleLabel.frame)+24*SCREEN_RADIO, screen_width-125*SCREEN_RADIO, 45*SCREEN_RADIO)];
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

-(UIButton *)recoverBtn{
    if (!_recoverBtn) {
        _recoverBtn=[[UIButton alloc] initWithFrame:CGRectMake(87.5*SCREEN_RADIO, CGRectGetMaxY(self.EmailField.frame)+139*SCREEN_RADIO, screen_width-87.5*2*SCREEN_RADIO, 52*SCREEN_RADIO)];
        [_recoverBtn setTitle:@"Recover" forState:UIControlStateNormal];
        [_recoverBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _recoverBtn.titleLabel.font=[UIFont systemFontOfSize:22*SCREEN_RADIO];
        _recoverBtn.layer.cornerRadius=26*SCREEN_RADIO;
        _recoverBtn.layer.borderWidth=2;
        _recoverBtn.layer.borderColor=[UIColor whiteColor].CGColor;
        [_recoverBtn addTarget:self action:@selector(recoverClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _recoverBtn;
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
