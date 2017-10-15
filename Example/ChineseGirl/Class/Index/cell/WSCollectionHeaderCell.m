//
//  WSCollectionHeaderCell.m
//  ChineseGirl
//
//  Created by Wallen on 2017/10/15.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "WSCollectionHeaderCell.h"
@interface WSCollectionHeaderCell()
@property(nonatomic,strong)UIScrollView *scrollViewPointView;
@end
@implementation WSCollectionHeaderCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubViews];
        [self setScrollViewPoint];
    }
    return self;
}

-(void)addSubViews{
    [self addSubview:self.scrollViewPointView];
}

-(void)setScrollViewPoint{
    int _num=10;
    for (int i=0; i<_num; i++) {
        UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(10*SCREEN_RADIO+i*(15+60)*SCREEN_RADIO, 10*SCREEN_RADIO, 60*SCREEN_RADIO, 60*SCREEN_RADIO)];
        imgView.layer.cornerRadius=30*SCREEN_RADIO;
        imgView.image=[UIImage imageNamed:@"Avatar"];
        imgView.layer.borderWidth=2;
        imgView.layer.borderColor=[UIColor getColor:@"FF7D44"].CGColor;
        [self.scrollViewPointView addSubview:imgView];
        
        UILabel *nickName=[[UILabel alloc] initWithFrame:CGRectMake(10*SCREEN_RADIO+i*(15+60)*SCREEN_RADIO, CGRectGetMaxY(imgView.frame)+5*SCREEN_RADIO, 60*SCREEN_RADIO, 12*SCREEN_RADIO)];
        nickName.text=[NSString stringWithFormat:@"Avatar%d-%d",i,i];
        nickName.textColor=[UIColor getColor:@"333333"];
        nickName.textAlignment=NSTextAlignmentCenter;
        nickName.font=[UIFont systemFontOfSize:12*SCREEN_RADIO];
        [self.scrollViewPointView addSubview:nickName];
    }
    self.scrollViewPointView.contentSize=CGSizeMake(10*SCREEN_RADIO+_num*75*SCREEN_RADIO, 90*SCREEN_RADIO);
}

-(UIScrollView *)scrollViewPointView{
    if (!_scrollViewPointView) {
        _scrollViewPointView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 90*SCREEN_RADIO)];
        //_scrollViewPointView.contentSize=CGSizeMake(screen_width*2, 90*SCREEN_RADIO);
        _scrollViewPointView.showsVerticalScrollIndicator = NO;
        _scrollViewPointView.showsHorizontalScrollIndicator = NO;
    }
    
    return _scrollViewPointView;
}
@end
