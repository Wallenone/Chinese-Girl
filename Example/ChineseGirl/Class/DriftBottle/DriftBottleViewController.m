//
//  DriftBottleViewController.m
//  ChineseGirl
//
//  Created by wallen on 2017/8/8.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "DriftBottleViewController.h"
#import "CGPickBottleContentView.h"
#import "CGBottleTextView.h"
@interface DriftBottleViewController ()<UITextViewDelegate>{
    NSInteger maxNum;
}
@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIButton *drogBtn;
@property(nonatomic,strong)UIButton *pickUpBtn;
@property(nonatomic,strong)CGPickBottleContentView *bottleContentView;
@property(nonatomic,strong)CGBottleTextView *wirteView;
@property(nonatomic,strong)CALayer *maskLayer;
@property(nonatomic,strong)UIButton *drogedBtn;
@property(nonatomic,strong)UILabel *lbNums;
@end

@implementation DriftBottleViewController

-(void)viewWillAppear:(BOOL)animated
{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    maxNum=220;
    self.view.backgroundColor=[UIColor getColor:@"99A3A9"];
    [self addSubViews];
}

-(void)addSubViews{
    [self.view addSubview:self.headerView];
    [self.headerView addSubview:self.titleLabel];
    [self.view addSubview:self.drogBtn];
    [self.view addSubview:self.pickUpBtn];
}


-(void)drogClick{
    [self.view.layer addSublayer:self.maskLayer];
    [self.view addSubview:self.wirteView];
    [self.view addSubview:self.lbNums];
    [self.view addSubview:self.drogedBtn];
}

-(void)drogedClick{
    [self removeWriteView];
}

-(void)removeWriteView{
    [self.wirteView removeFromSuperview];
    [self.maskLayer removeFromSuperlayer];
    [self.lbNums removeFromSuperview];
    [self.drogedBtn removeFromSuperview];
}

-(void)removeBottleContentView{
    [self.maskLayer removeFromSuperlayer];
    [self.bottleContentView removeFromSuperview];
}

- (void)textViewDidChange:(UITextView *)textView
{
    NSString  *nsTextContent = textView.text;
    NSInteger existTextNum = nsTextContent.length;
    
    if (existTextNum > maxNum)
    {
        //截取到最大位置的字符
        NSString *s = [nsTextContent substringToIndex:maxNum];
        
        [textView setText:s];
    }
    
    //不让显示负数
    self.lbNums.text = [NSString stringWithFormat:@"%ld",MAX(0,maxNum - existTextNum)];

    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSString *comcatstr = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    NSInteger caninputlen = maxNum - comcatstr.length;
    
    if (caninputlen >= 0)
    {
        return YES;
    }
    else
    {
        NSInteger len = text.length + caninputlen;
        //防止当text.length + caninputlen < 0时，使得rg.length为一个非法最大正数出错
        NSRange rg = {0,MAX(len,0)};
        
        if (rg.length > 0)
        {
            NSString *s = [text substringWithRange:rg];
            
            [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:s]];
        }
        return NO;
    }
    
}

-(void)getBottleClick{  //捡起来的瓶子
    [self.view.layer addSublayer:self.maskLayer];
    [self.view addSubview:self.bottleContentView];
    
}

-(UIView *)headerView{
    if (!_headerView) {
        _headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 64)];
        _headerView.backgroundColor=[UIColor whiteColor];
    }
    return _headerView;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 29*SCREEN_RADIO, screen_width, 24*SCREEN_RADIO)];
        _titleLabel.text=@"漂流瓶";
        _titleLabel.textColor=[UIColor getColor:@"232627"];
        _titleLabel.font=[UIFont systemFontOfSize:18*SCREEN_RADIO];
        _titleLabel.textAlignment=NSTextAlignmentCenter;
    }
    
    return _titleLabel;
}

-(UIButton *)drogBtn{
    if (!_drogBtn) {
        _drogBtn=[[UIButton alloc] initWithFrame:CGRectMake(screen_width/2-110*SCREEN_RADIO, 194*SCREEN_RADIO, 220*SCREEN_RADIO, 52*SCREEN_RADIO)];
        [_drogBtn setBackgroundColor:[UIColor getColor:@"2979FF"]];
        [_drogBtn addTarget:self action:@selector(drogClick) forControlEvents:UIControlEventTouchUpInside];
        [_drogBtn setTitle:@"扔一个(剩余2次)" forState:UIControlStateNormal];
        [_drogBtn setTitleColor:[UIColor getColor:@"ffffff"] forState:UIControlStateNormal];
        _drogBtn.titleLabel.font=[UIFont systemFontOfSize:22*SCREEN_RADIO];
        _drogBtn.layer.cornerRadius=26*SCREEN_RADIO;
    }
    return _drogBtn;
}

-(UIButton *)pickUpBtn{
    if (!_pickUpBtn) {
        _pickUpBtn=[[UIButton alloc] initWithFrame:CGRectMake(screen_width/2-110*SCREEN_RADIO, CGRectGetMaxY(self.drogBtn.frame)+20*SCREEN_RADIO, 220*SCREEN_RADIO, 52*SCREEN_RADIO)];
        [_pickUpBtn setBackgroundColor:[UIColor getColor:@"2979FF"]];
        [_pickUpBtn addTarget:self action:@selector(getBottleClick) forControlEvents:UIControlEventTouchUpInside];
        [_pickUpBtn setTitle:@"捡一个(剩余1次)" forState:UIControlStateNormal];
        [_pickUpBtn setTitleColor:[UIColor getColor:@"ffffff"] forState:UIControlStateNormal];
        _pickUpBtn.titleLabel.font=[UIFont systemFontOfSize:22*SCREEN_RADIO];
        _pickUpBtn.layer.cornerRadius=26*SCREEN_RADIO;
    }
    return _pickUpBtn;
}



-(CGPickBottleContentView *)bottleContentView{
    if (!_bottleContentView) {
        __weak __typeof(self)weakSelf = self;
        _bottleContentView=[[CGPickBottleContentView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height) withDrogBlock:^{
            [weakSelf removeBottleContentView];
        }];
        
    }
    
    return _bottleContentView;
}

-(CGBottleTextView *)wirteView{
    if (!_wirteView) {
        _wirteView=[[CGBottleTextView alloc] initWithFrame:CGRectMake(15*SCREEN_RADIO, CGRectGetMaxY(self.headerView.frame)+15*SCREEN_RADIO, screen_width-30*SCREEN_RADIO, 220*SCREEN_RADIO)];
        _wirteView.backgroundColor=[UIColor whiteColor];
        _wirteView.textColor=[UIColor blackColor];
        _wirteView.font=[UIFont systemFontOfSize:16*SCREEN_RADIO];
        _wirteView.delegate=self;
        _wirteView.layer.cornerRadius=5;
        
    }
    
    return _wirteView;
}

-(CALayer *)maskLayer{
    if(!_maskLayer){
        _maskLayer = [CALayer layer];
        [_maskLayer setFrame:CGRectMake(0, 0, screen_width, screen_height)];
        [_maskLayer setBackgroundColor:[[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6] CGColor]];
    }
    
    return _maskLayer;
}

-(UIButton *)drogedBtn{
    if (!_drogedBtn) {
        _drogedBtn=[[UIButton alloc] initWithFrame:CGRectMake(screen_width/2-110*SCREEN_RADIO, CGRectGetMaxY(self.wirteView.frame)+10*SCREEN_RADIO, 220*SCREEN_RADIO, 52*SCREEN_RADIO)];
        [_drogedBtn setBackgroundColor:[UIColor getColor:@"2979FF"]];
        [_drogedBtn addTarget:self action:@selector(drogedClick) forControlEvents:UIControlEventTouchUpInside];
        [_drogedBtn setTitle:@"扔出" forState:UIControlStateNormal];
        [_drogedBtn setTitleColor:[UIColor getColor:@"ffffff"] forState:UIControlStateNormal];
        _drogedBtn.titleLabel.font=[UIFont systemFontOfSize:22*SCREEN_RADIO];
        _drogedBtn.layer.cornerRadius=26*SCREEN_RADIO;
    }
    return _drogedBtn;
}

-(UILabel *)lbNums{
    if (!_lbNums) {
        _lbNums=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.wirteView.frame)-25*SCREEN_RADIO, screen_width-30*SCREEN_RADIO, 18*SCREEN_RADIO)];
        _lbNums.text=[NSString stringWithFormat:@"%ld",(long)maxNum];
        _lbNums.textColor=[UIColor getColor:@"99A3A9"];
        _lbNums.font=[UIFont systemFontOfSize:18*SCREEN_RADIO];
        _lbNums.textAlignment=NSTextAlignmentRight;
    }
    
    return _lbNums;
}

@end
