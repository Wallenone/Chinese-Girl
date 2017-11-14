//
//  CGRegisterIndexViewController.m
//  ChineseGirl
//
//  Created by Wallen on 2017/8/31.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGRegisterIndexViewController.h"
#import "CGRegisterIndexView.h"
#import "UICountryViewController.h"
@interface CGRegisterIndexViewController ()
@property(nonatomic,strong)CGRegisterIndexView *registerIndexView;
@end

@implementation CGRegisterIndexViewController

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    self.navigationItem.hidesBackButton = YES; 
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [self.tabBarController.tabBar setHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getCityName:) name:@"getAreaName" object:nil];
    [self addSubViews];
}

-(void)getCityName:(NSNotification *)obj{
    NSString *str=[NSString stringWithFormat:@"%@ %@",[obj.object stringForKey:@"countryName"],[obj.object stringForKey:@"cityName"]];
    [CGSingleCommitData sharedInstance].countryName=[obj.object stringForKey:@"countryName"];
    [CGSingleCommitData sharedInstance].cityName=[obj.object stringForKey:@"cityName"];
    [self.registerIndexView updateCellContent:str];
}

-(void)addSubViews{
    [self.view addSubview:self.registerIndexView];
}

-(CGRegisterIndexView *)registerIndexView{
    if (!_registerIndexView) {
        __weak typeof(self) weakSelf = self;
        _registerIndexView=[[CGRegisterIndexView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height) onCancelClick:^{
            [weakSelf.navigationController popViewControllerAnimated:NO];
        } onSingUpClick:^(BOOL state,NSString *warningsText){
            if (state) {
                [SVProgressHUD showSuccessWithStatus:warningsText];
                [weakSelf.navigationController dismissViewControllerAnimated:NO completion:nil];
            }else{
                [SVProgressHUD showErrorWithStatus:warningsText];
            }
        }onChooseCityBlock:^{
            UICountryViewController *countryVC=[[UICountryViewController alloc] init];
            [weakSelf.navigationController pushViewController:countryVC animated:NO];
        }];
    }
    
    return _registerIndexView;
}

@end
