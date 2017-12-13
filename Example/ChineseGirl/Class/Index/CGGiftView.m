//
//  CGGiftViewController.m
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/12/12.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGGiftView.h"
@interface CGGiftView ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIPageControl *pageControl;
@end

@implementation CGGiftView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor colorWithRed:29/255 green:28/255 blue:30/255 alpha:0.9];
        [self addSubViews];
    }
    return self;
}

-(void)addSubViews{
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
}

-(void)giftClick:(UIButton *)sender{
    NSLog(@"需要%ld元钱",(long)sender.tag);
}

-(UIView *)setGiftItemWithImgView:(NSString *)img withTwoImgView:(NSString *)img2 withItemMoneyNum:(NSString *)num withItemMoneyNum2:(NSString *)num2 withX:(CGFloat)frame_x withY:(CGFloat)frame_y{
    UIView *view=[[UIView alloc] initWithFrame:CGRectZero];

    UIImageView *image=[[UIImageView alloc] initWithFrame:CGRectMake(frame_x, 0, 60*SCREEN_RADIO, 60*SCREEN_RADIO)];
    image.image=[UIImage imageNamed:img];
    [view addSubview:image];
    
    UIImageView *icon1=[[UIImageView alloc] initWithFrame:CGRectMake(frame_x+10*SCREEN_RADIO, CGRectGetMaxY(image.frame), 11*SCREEN_RADIO, 11*SCREEN_RADIO)];
    icon1.image=[UIImage imageNamed:@"leaderboard_coin"];
    [view addSubview:icon1];
    
    UILabel *lable1=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(icon1.frame)+3*SCREEN_RADIO, CGRectGetMaxY(image.frame)-2, 0, 12*SCREEN_RADIO)];
    lable1.text=num;
    lable1.textColor=[UIColor whiteColor];
    lable1.font=[UIFont systemFontOfSize:12*SCREEN_RADIO];
    [lable1 sizeToFit];
    [view addSubview:lable1];
    
    
    
    
    UIImageView *image1=[[UIImageView alloc] initWithFrame:CGRectMake(frame_x, CGRectGetMaxY(image.frame)+20*SCREEN_RADIO, 60*SCREEN_RADIO, 60*SCREEN_RADIO)];
    image1.image=[UIImage imageNamed:img2];
    [view addSubview:image1];
    
    UIImageView *icon2=[[UIImageView alloc] initWithFrame:CGRectMake(frame_x+10*SCREEN_RADIO, CGRectGetMaxY(image1.frame), 11*SCREEN_RADIO, 11*SCREEN_RADIO)];
    icon2.image=[UIImage imageNamed:@"leaderboard_coin"];
    [view addSubview:icon2];
    
    UILabel *lable2=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(icon2.frame)+3*SCREEN_RADIO, CGRectGetMaxY(image1.frame)-2, 0, 12*SCREEN_RADIO)];
    lable2.text=num;
    lable2.textColor=[UIColor whiteColor];
    lable2.font=[UIFont systemFontOfSize:12*SCREEN_RADIO];
    [lable2 sizeToFit];
    [view addSubview:lable2];
    
    
    
    return view;
}


-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 20*SCREEN_RADIO, screen_width, 160*SCREEN_RADIO)];
        _scrollView.backgroundColor=[UIColor clearColor];
        _scrollView.pagingEnabled = YES; //使用翻页属性
        _scrollView.delegate = self;//这个是重点
        _scrollView.showsHorizontalScrollIndicator=NO;
        _scrollView.showsHorizontalScrollIndicator=NO;
        int giftNum=0;
        for (int i=0; i<24; i++) {
            CGFloat _x=20*SCREEN_RADIO+i*93*SCREEN_RADIO;
            
            
            UIView *view= [self setGiftItemWithImgView:[NSString stringWithFormat:@"gift%d",giftNum+1] withTwoImgView:[NSString stringWithFormat:@"gift%d",giftNum+2] withItemMoneyNum:@"100" withItemMoneyNum2:@"200" withX:_x withY:0];
            [_scrollView addSubview:view];
            [_scrollView setContentSize:CGSizeMake(_x+83*SCREEN_RADIO, 160*SCREEN_RADIO)];
            giftNum+=2;
            
            UIButton *btn1=[[UIButton alloc] initWithFrame:CGRectMake(_x, 0, 80*SCREEN_RADIO, 80*SCREEN_RADIO)];
            [btn1 addTarget:self action:@selector(giftClick:) forControlEvents:UIControlEventTouchUpInside];
            btn1.tag=100;
            [_scrollView addSubview:btn1];
            
            UIButton *btn2=[[UIButton alloc] initWithFrame:CGRectMake(_x, CGRectGetMaxY(btn1.frame)+20*SCREEN_RADIO, 80*SCREEN_RADIO, 80*SCREEN_RADIO)];
            [btn2 addTarget:self action:@selector(giftClick:) forControlEvents:UIControlEventTouchUpInside];
            btn2.tag=100;
            [_scrollView addSubview:btn2];
            
            
        }
    }
    
    return _scrollView;
}

-(UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.frame = CGRectMake(screen_width/2, CGRectGetMaxY(self.scrollView.frame)-10*SCREEN_RADIO, 10*SCREEN_RADIO, 10*SCREEN_RADIO);//指定位置大小
        _pageControl.numberOfPages = 7;//指定页面个数
        _pageControl.currentPage = 0;//指定pagecontroll的值，默认选中的小白点（第一个）
        //添加委托方法，当点击小白点就执行此方法
        _pageControl.pageIndicatorTintColor = [UIColor getColor:@"a3a3a4"];// 设置非选中页的圆点颜色
        _pageControl.currentPageIndicatorTintColor = [UIColor getColor:@"05cfd1"]; // 设置选中页的圆点颜色
    }
    
    return _pageControl;

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x / scrollView.frame.size.width;
    // 设置页码
    _pageControl.currentPage = page;
}


@end
