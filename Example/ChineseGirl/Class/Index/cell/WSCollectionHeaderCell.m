//
//  WSCollectionHeaderCell.m
//  ChineseGirl
//
//  Created by Wallen on 2017/10/15.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "WSCollectionHeaderCell.h"
#import "CGVideoDataModel.h"
#import "MyIndexViewController.h"
#import "CGVideoViewController.h"
#import "CGUserInfo.h"
@interface WSCollectionHeaderCell()
@property(nonatomic,strong)UIScrollView *scrollViewPointView;
@property(nonatomic,strong)NSArray *indexMendArr;
@end
@implementation WSCollectionHeaderCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor=[UIColor getColor:@"fafafa"];
        [self getData];
        [self addSubViews];
        [self setScrollViewPoint];
    }
    
    return self;
}

-(void)getData{
    self.indexMendArr= [CGVideoDataModel reloadTableRondomCount:15];
}

-(void)addSubViews{
    [self addSubview:self.scrollViewPointView];
}

-(void)setScrollViewPoint{
    for (int i=0; i<self.indexMendArr.count; i++) {
        CGVideoDataModel *indexMend=[self.indexMendArr objectAtIndex:i];
        UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(17.5*SCREEN_RADIO+i*(26+57)*SCREEN_RADIO, 15*SCREEN_RADIO, 58*SCREEN_RADIO, 58*SCREEN_RADIO)];
        imgView.layer.cornerRadius=29*SCREEN_RADIO;
        [imgView sd_setImageWithURL:[NSURL URLWithString:indexMend.videoIcon]];
        imgView.layer.borderWidth=1;
        imgView.layer.borderColor=[UIColor getColor:@"DCDCDC"].CGColor;
        imgView.contentMode =  UIViewContentModeScaleAspectFill;
        imgView.clipsToBounds=YES;
        [self.scrollViewPointView addSubview:imgView];
        
        UIImageView *imgViewQuan=[[UIImageView alloc] initWithFrame:CGRectMake(14*SCREEN_RADIO+i*(18+65)*SCREEN_RADIO, 12*SCREEN_RADIO, 65*SCREEN_RADIO, 65*SCREEN_RADIO)];
        imgViewQuan.image=[UIImage imageNamed:@"unseen"];
        [self.scrollViewPointView addSubview:imgViewQuan];
        
        
        UILabel *nickName=[[UILabel alloc] initWithFrame:CGRectMake(14*SCREEN_RADIO+i*(18+65)*SCREEN_RADIO, CGRectGetMaxY(imgViewQuan.frame)+4*SCREEN_RADIO, 65*SCREEN_RADIO, 14*SCREEN_RADIO)];
        nickName.text=indexMend.nickName;
        nickName.textColor=[UIColor getColor:@"4D4D4D"];
        nickName.textAlignment=NSTextAlignmentCenter;
        nickName.font=[UIFont systemFontOfSize:12*SCREEN_RADIO];
        [self.scrollViewPointView addSubview:nickName];
        
        UIButton *iconBtn=[[UIButton alloc] initWithFrame:CGRectMake(14*SCREEN_RADIO+i*(18+65)*SCREEN_RADIO, 10*SCREEN_RADIO, 65*SCREEN_RADIO, 65*SCREEN_RADIO)];
        iconBtn.tag=i;
        [iconBtn addTarget:self action:@selector(iconClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollViewPointView addSubview:iconBtn];
    }
    self.scrollViewPointView.contentSize=CGSizeMake(14*SCREEN_RADIO+self.indexMendArr.count*83*SCREEN_RADIO, 104*SCREEN_RADIO);
}

-(void)iconClick:(UIButton *)button{
    NSInteger index=button.tag;
    CGVideoDataModel *indexMend=[self.indexMendArr objectAtIndex:index];
    
    CGVideoViewController *videoVC=[[CGVideoViewController alloc] init];
    UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:videoVC];
    videoVC.videoIcon=indexMend.videoIcon;
    videoVC.videoStr=indexMend.videoUrl;;
    videoVC.userInfo=[CGUserInfo getitemWithID:indexMend.userId];
    [[self getCurrentVC].navigationController presentViewController:nav animated:YES completion:nil];
}

-(UIScrollView *)scrollViewPointView{
    if (!_scrollViewPointView) {
        _scrollViewPointView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 104*SCREEN_RADIO)];
        //_scrollViewPointView.contentSize=CGSizeMake(screen_width*2, 90*SCREEN_RADIO);
        _scrollViewPointView.showsVerticalScrollIndicator = NO;
        _scrollViewPointView.showsHorizontalScrollIndicator = NO;
    }
    
    return _scrollViewPointView;
}

-(NSArray *)indexMendArr{
    if (!_indexMendArr) {
        _indexMendArr=[[NSArray alloc] init];
    }
    
    return _indexMendArr;
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
