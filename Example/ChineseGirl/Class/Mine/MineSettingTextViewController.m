//
//  MineSettingNickNameViewController.m
//  ChineseGirl
//
//  Created by Wallen on 2017/10/15.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "MineSettingTextViewController.h"
#import "MineSettingTextView.h"
@interface MineSettingTextViewController (){
    SettingTextBlock settingTextBlock;
}
@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)RkyExtendedHitButton *leftIcon;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)MineSettingTextView *textView;
@property(nonatomic,strong)NSString *textViewStr;
@end

@implementation MineSettingTextViewController

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
    self.view.backgroundColor=[UIColor getColor:@"F8F8F8"];
    [super viewDidLoad];
    [self addHeaderView];
    [self addSubViews];
}

-(void)addHeaderView{
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.leftIcon];
}

-(void)addSubViews{
    [self.view addSubview:self.textView];
}

-(void)back{
    if (self.textViewStr.length>0) {
        if (settingTextBlock) {
            settingTextBlock(self.textViewStr);
        }
    }
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)onTextBlock:(SettingTextBlock)textBlock{
    settingTextBlock=textBlock;
}

-(UIView *)headerView{
    if (!_headerView) {
        _headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, 64)];
        _headerView.backgroundColor=[UIColor whiteColor];
    }
    
    return _headerView;
}



-(RkyExtendedHitButton *)leftIcon{
    if (!_leftIcon) {
        _leftIcon=[[RkyExtendedHitButton alloc] initWithFrame:CGRectMake(16*SCREEN_RADIO, 33*SCREEN_RADIO, 10*SCREEN_RADIO, 19*SCREEN_RADIO)];
        [_leftIcon setImage:[UIImage imageNamed:@"BlackArrowleft"] forState:UIControlStateNormal];
        [_leftIcon addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        _leftIcon.hitTestEdgeInsets = UIEdgeInsetsMake(-25, -25, -25, -25);
    }
    return _leftIcon;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 29*SCREEN_RADIO, screen_width, 24*SCREEN_RADIO)];
        _titleLabel.text=self.titleText;
        _titleLabel.font=[UIFont systemFontOfSize:18*SCREEN_RADIO];
        _titleLabel.textColor=[UIColor getColor:@"232627"];
        _titleLabel.textAlignment=NSTextAlignmentCenter;
    }
    return _titleLabel;
}

-(MineSettingTextView *)textView{
    if (!_textView) {
         __weak typeof(self) weakSelf = self;
        _textView=[[MineSettingTextView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headerView.frame)+10*SCREEN_RADIO, screen_width, 150*SCREEN_RADIO) withMaxNum:40 withTextBlock:^(NSString *text) {
            weakSelf.textViewStr=text;
        } withTextStr:self.textStr];
        
    }
    return _textView;
}
@end
