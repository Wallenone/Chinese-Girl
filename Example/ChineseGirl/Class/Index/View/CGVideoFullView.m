//
//  CGVideoFullView.m
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/11/18.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGVideoFullView.h"
@interface CGVideoFullView(){
    CloseClickBlock closeClickBlock;
}
@property(nonatomic,strong)UIButton *closeBtn;
@end
@implementation CGVideoFullView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor blackColor];
        [self addSubview:self.closeBtn];
    }
    return self;
}

- (void)WMPlayer:(WMPlayer *)player withCloseBlock:(CloseClickBlock)closeBlock{
    closeClickBlock=closeBlock;
    [self setFullView:player];
}

-(void)setFullView:(WMPlayer *)player{
    player.frame=CGRectMake(0, 60*SCREEN_RADIO, screen_width, 300*SCREEN_RADIO);
    player.player.volume=5;
    [self addSubview:player];
}

-(void)close{
    if (closeClickBlock) {
        closeClickBlock();
    }
    [self removeFromSuperview];
}

-(UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn=[[UIButton alloc] initWithFrame:CGRectMake(screen_width-40*SCREEN_RADIO, 20*SCREEN_RADIO, 30*SCREEN_RADIO, 30*SCREEN_RADIO)];
        [_closeBtn setImage:[UIImage imageNamed:@"reg_Ok"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _closeBtn;
}
@end
