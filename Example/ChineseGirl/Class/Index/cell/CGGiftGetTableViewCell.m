//
//  CGGiftGetTableViewCell.m
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/12/21.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGGiftGetTableViewCell.h"

@interface CGGiftGetTableViewCell()
@property(nonatomic,strong)CGPinglunren *model;
@property(nonatomic,strong)UIImageView *iconImg;
@property(nonatomic,strong)UILabel *nickName;
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UILabel *contentLabel;
@property(nonatomic,strong)UIView *lineView;
@end
@implementation CGGiftGetTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withModel:(CGPinglunren *)model{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        self.model=model;
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        [self creatSubView];
    }
    
    return self;
}

-(void)creatSubView{
    [self addSubview:self.iconImg];
    [self addSubview:self.nickName];
    [self addSubview:self.timeLabel];
    [self addSubview:self.contentLabel];
    [self addSubview:self.lineView];
}

-(UIImageView *)iconImg{
    if (!_iconImg) {
        _iconImg=[[UIImageView alloc] initWithFrame:CGRectMake(15*SCREEN_RADIO, 10*SCREEN_RADIO, 45*SCREEN_RADIO, 45*SCREEN_RADIO)];
        [_iconImg sd_setImageWithURL:[NSURL URLWithString:self.model.avater] placeholderImage:[UIImage imageNamed:@"default_nor_avatar"]];
        _iconImg.layer.cornerRadius=23.5*SCREEN_RADIO;
        _iconImg.clipsToBounds=YES;
    }
    
    return _iconImg;
}

-(UILabel *)nickName{
    if (!_nickName) {
        _nickName=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImg.frame)+8*SCREEN_RADIO, 10*SCREEN_RADIO, 0, 12*SCREEN_RADIO)];
        _nickName.text=self.model.username;
        _nickName.font=[UIFont boldSystemFontOfSize:12*SCREEN_RADIO];
        _nickName.textColor=[UIColor getColor:@"9b9b99"];
        [_nickName sizeToFit];
    }
    
    return _nickName;
}

-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.nickName.frame)+10*SCREEN_RADIO, 10*SCREEN_RADIO, 0, 12*SCREEN_RADIO)];
        _timeLabel.text=self.model.date;
        _timeLabel.font=[UIFont systemFontOfSize:12*SCREEN_RADIO];
        _timeLabel.textColor=[UIColor getColor:@"9b9b99"];
        [_timeLabel sizeToFit];
    }
    
    return _timeLabel;
}

-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImg.frame)+20*SCREEN_RADIO, CGRectGetMaxY(self.timeLabel.frame)+10*SCREEN_RADIO, 0, 14*SCREEN_RADIO)];
        int goldNum=[CGCommonToolsNode getRandomNumber:10 to:100];
        _contentLabel.text=[NSString stringWithFormat:@"+ %d",goldNum];
        _contentLabel.font=[UIFont systemFontOfSize:14*SCREEN_RADIO];
        _contentLabel.textColor=[UIColor getColor:@"ffffff"];
        [_contentLabel sizeToFit];
    }
    
    return _contentLabel;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView=[[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImg.frame)+8*SCREEN_RADIO, 65*SCREEN_RADIO-0.5, screen_width-CGRectGetMaxX(self.iconImg.frame)+8*SCREEN_RADIO, 0.5)];
        _lineView.backgroundColor=[UIColor getColor:@"9b9b99"];
    }
    
    return _lineView;
}
@end
