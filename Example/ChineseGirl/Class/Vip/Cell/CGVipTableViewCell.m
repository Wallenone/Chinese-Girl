//
//  CGVipTableViewCell.m
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/11/17.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGVipTableViewCell.h"
@interface CGVipTableViewCell(){
    NSString *_contenLabel;
    NSString *_moneyNum;
}
@property(nonatomic,strong)UILabel *contentLabel;
@property(nonatomic,strong)RkyExtendedHitButton *moneyBtn;
@property(nonatomic,strong)UIView *lineView;
@end

@implementation CGVipTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withLabel:(NSString *)content withMoney:(NSString *)moneyNum{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        _contenLabel=content;
        _moneyNum=moneyNum;
        [self creatSubView];
    }
    
    return self;
}

-(void)creatSubView{
    [self addSubview:self.contentLabel];
    [self addSubview:self.moneyBtn];
    [self addSubview:self.lineView];
}

-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel=[[UILabel alloc] initWithFrame:CGRectMake(15*SCREEN_RADIO, 23*SCREEN_RADIO, 0, 16*SCREEN_RADIO)];
        _contentLabel.text=_contenLabel;
        _contentLabel.textColor=[UIColor blackColor];
        _contentLabel.font=[UIFont systemFontOfSize:16*SCREEN_RADIO];
        [_contentLabel sizeToFit];
    }
    
    return _contentLabel;
}

-(RkyExtendedHitButton *)moneyBtn{
    if (!_moneyBtn) {
        _moneyBtn=[[RkyExtendedHitButton alloc] initWithFrame:CGRectMake(screen_width-85*SCREEN_RADIO, 16*SCREEN_RADIO, 70*SCREEN_RADIO, 30*SCREEN_RADIO)];
        [_moneyBtn setTitle:[NSString stringWithFormat:@"$%@",_moneyNum] forState:UIControlStateNormal];
        [_moneyBtn setTitleColor:[UIColor getColor:@"ffffff"] forState:UIControlStateNormal];
        _moneyBtn.backgroundColor=[UIColor getColor:@"00aeff"];
        _moneyBtn.layer.cornerRadius=3*SCREEN_RADIO;
        _moneyBtn.userInteractionEnabled=NO;
        _moneyBtn.hitTestEdgeInsets = UIEdgeInsetsMake(-25, -25, -25, -25);
    }
    
    return _moneyBtn;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView=[[UIView alloc] initWithFrame:CGRectMake(0, 62*SCREEN_RADIO-0.5, screen_width, 0.5)];
        _lineView.backgroundColor=[UIColor getColor:@"Ececeb"];
    }
    
    return _lineView;
}
@end
