//
//  WSCollectionCell.m
//  瀑布流
//
//  Created by iMac on 16/12/26.
//  Copyright © 2016年 zws. All rights reserved.
//

#import "WSCollectionCell.h"
#import "UIImageView+WebCache.h"
#import "WMPlayer.h"
#import "CGVideoFullView.h"
#import "MyIndexViewController.h"
@interface WSCollectionCell()<WMPlayerDelegate>{

}
@end

@implementation WSCollectionCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor getColor:@"EBEBEB"];
        [self creatSubView];
        
    }
    return self;
}

-(void)iconClick{
    MyIndexViewController *indexVC=[[MyIndexViewController alloc] init];
    indexVC.ids=[self.model.ids integerValue];
    [[self getCurrentVC].navigationController pushViewController:indexVC animated:NO];
}

- (void)creatSubView {
    UIView *menuView=[[UIView alloc] initWithFrame:CGRectMake(0, 0.5, screen_width, 56*SCREEN_RADIO)];
    menuView.backgroundColor=[UIColor whiteColor];
    
    UIImageView *iconImgView=[[UIImageView alloc] initWithFrame:CGRectMake(10*SCREEN_RADIO, 12*SCREEN_RADIO, 32*SCREEN_RADIO, 32*SCREEN_RADIO)];
    iconImgView.image=[UIImage imageNamed:@"Avatar"];
    iconImgView.layer.cornerRadius=16*SCREEN_RADIO;
    iconImgView.tag=11;
    iconImgView.layer.borderWidth=1;
    iconImgView.layer.borderColor=[UIColor getColor:@"DCDCDC"].CGColor;
    iconImgView.clipsToBounds=YES;
    [menuView addSubview:iconImgView];
    
    UILabel *nickName=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(iconImgView.frame)+10*SCREEN_RADIO , 13*SCREEN_RADIO, 150*SCREEN_RADIO, 15*SCREEN_RADIO)];
    nickName.text=@"wallen";
    nickName.textColor=[UIColor getColor:@"000000"];
    nickName.font=[UIFont systemFontOfSize:13*SCREEN_RADIO];
    nickName.tag=12;
    [menuView addSubview:nickName];
   
    UILabel *location=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(iconImgView.frame)+10*SCREEN_RADIO , CGRectGetMaxY(nickName.frame), 150*SCREEN_RADIO, 15*SCREEN_RADIO)];
    location.text=@"China.BeiJing";
    location.textColor=[UIColor getColor:@"BAB8B8"];
    location.font=[UIFont systemFontOfSize:13*SCREEN_RADIO];
    location.tag=13;
    [menuView addSubview:location];
                                                                
    UILabel *content=[[UILabel alloc] initWithFrame:CGRectMake(0, 19*SCREEN_RADIO, screen_width-10*SCREEN_RADIO,15*SCREEN_RADIO)];
    content.text=@"3个月后打算去美国";
    content.textColor=[UIColor getColor:@"000000"];
    content.font=[UIFont systemFontOfSize:13*SCREEN_RADIO];
    content.textAlignment=NSTextAlignmentRight;
    content.tag=14;
    [menuView addSubview:content];

    [self addSubview:menuView];
    
    
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(menuView.frame), screen_width, 284*SCREEN_RADIO)];
    imgV.contentMode =  UIViewContentModeScaleAspectFill;
    imgV.clipsToBounds=YES;
    imgV.tag = 10;
    
    [self addSubview:imgV];
}


-(void)setModel:(CGIndexModel *)model {
    _model = model;
    UIImageView *imgV = (UIImageView *)[self viewWithTag:10];
    [imgV sd_setImageWithURL:[NSURL URLWithString:_model.bigIcon]];
    
    UIImageView *imgIcon = (UIImageView *)[self viewWithTag:11];
    [imgIcon sd_setImageWithURL:[NSURL URLWithString:_model.icon]];
    UILabel *labelNickName=(UILabel *)[self viewWithTag:12];
    labelNickName.text=_model.nickName;
    UILabel *labelBirthday=(UILabel *)[self viewWithTag:13];
    labelBirthday.text=_model.address;
    UILabel *labelContent=(UILabel *)[self viewWithTag:14];
    labelContent.text=_model.toContent;
}


//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    
    return currentVC;
}

- (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        
        rootVC = [rootVC presentedViewController];
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
        
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
        
    } else {
        // 根视图为非导航类
        
        currentVC = rootVC;
    }
    
    return currentVC;
}



@end
