//
//  WSCollectionHeaderCell.m
//  ChineseGirl
//
//  Created by Wallen on 2017/10/15.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "WSCollectionHeaderCell.h"
#import "CGIndexMendModel.h"
#import "MyIndexViewController.h"
@interface WSCollectionHeaderCell()
@property(nonatomic,strong)UIScrollView *scrollViewPointView;
@property(nonatomic,strong)NSMutableArray *indexMendArr;
@end
@implementation WSCollectionHeaderCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor getColor:@"fafafa"];
        [self getData];
        [self addSubViews];
        [self setScrollViewPoint];
    }
    return self;
}

-(void)getData{
    self.indexMendArr= [CGIndexMendModel reloadTable];
}

-(void)addSubViews{
    [self addSubview:self.scrollViewPointView];
}

-(void)setScrollViewPoint{
    for (int i=0; i<self.indexMendArr.count; i++) {
        CGIndexMendModel *indexMend=[self.indexMendArr objectAtIndex:i];
        UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(17.5*SCREEN_RADIO+i*(26+57)*SCREEN_RADIO, 15*SCREEN_RADIO, 58*SCREEN_RADIO, 58*SCREEN_RADIO)];
        imgView.layer.cornerRadius=29*SCREEN_RADIO;
        [imgView sd_setImageWithURL:[NSURL URLWithString:indexMend.icon]];
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
        iconBtn.tag=[indexMend.ids integerValue];
        [iconBtn addTarget:self action:@selector(iconClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollViewPointView addSubview:iconBtn];
    }
    self.scrollViewPointView.contentSize=CGSizeMake(14*SCREEN_RADIO+self.indexMendArr.count*83*SCREEN_RADIO, 104*SCREEN_RADIO);
}

-(void)iconClick:(UIButton *)button{
    NSInteger ids=button.tag;
    MyIndexViewController *indexVC=[[MyIndexViewController alloc] init];
    indexVC.ids=ids;
    [[self getCurrentVC].navigationController pushViewController:indexVC animated:NO];
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

-(NSMutableArray *)indexMendArr{
    if (!_indexMendArr) {
        _indexMendArr=[[NSMutableArray alloc] init];
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
