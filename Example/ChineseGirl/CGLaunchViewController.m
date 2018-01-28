//
//  CGLaunchViewController.m
//  ChineseGirl_Example
//
//  Created by Wallen on 2018/1/27.
//  Copyright © 2018年 wanjiehuizhaofang. All rights reserved.
//

#import "CGLaunchViewController.h"

@interface CGLaunchViewController ()
@property(nonatomic,strong)UIImageView *imgView;
@end

@implementation CGLaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.imgView];
}

-(UIImageView *)imgView{
    if(!_imgView){
        _imgView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
       // _imgView.image=[UIImage imageNamed:@"forget_Bitmap"];
    }
    
    return _imgView;
}

@end
