//
//  MyCommitHeaderView.m
//  ChineseGirl
//
//  Created by Wallen on 2017/9/2.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "MyCommitHeaderView.h"

@interface MyCommitHeaderView()
@property(nonatomic,strong)CGShuoShuo *commitModel;
@property(nonatomic,strong)UIImageView *iconImgView;
@property(nonatomic,strong)UILabel *nickName;
@property(nonatomic,strong)UILabel *commitLabel;
@property(nonatomic,strong)UILabel *dateLabel;
@end
@implementation MyCommitHeaderView

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithModel:(CGShuoShuo *)commitModel{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        self.commitModel=commitModel;
        [self addsuViewS];
        [self setData];
    }
    
    return self;
}

-(void)addsuViewS{
    [self addSubview:self.iconImgView];
    [self addSubview:self.nickName];
    [self addSubview:self.dateLabel];
    [self addSubview:self.commitLabel];
}

-(void)setData{
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, CGRectGetMaxY(self.commitLabel.frame)+15*SCREEN_RADIO);
}

-(UIImageView *)iconImgView{
    if (!_iconImgView) {
        _iconImgView=[[UIImageView alloc] initWithFrame:CGRectMake(15*SCREEN_RADIO, 15*SCREEN_RADIO, 52*SCREEN_RADIO, 52*SCREEN_RADIO)];
        [_iconImgView sd_setImageWithURL:[NSURL URLWithString:self.commitModel.icon]];
        _iconImgView.layer.cornerRadius=26*SCREEN_RADIO;
        _iconImgView.clipsToBounds=YES;
    }
    
    return _iconImgView;
}


-(UILabel *)nickName{
    if (!_nickName) {
        _nickName=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImgView.frame)+15*SCREEN_RADIO, 17*SCREEN_RADIO, 0, 27*SCREEN_RADIO)];
        _nickName.font=[UIFont systemFontOfSize:22*SCREEN_RADIO];
        _nickName.textColor=[UIColor getColor:@"232627"];
        _nickName.text=self.commitModel.nickName;
        [_nickName sizeToFit];
    }
    
    return _nickName;
}

-(UILabel *)dateLabel{
    if (!_dateLabel) {
        _dateLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImgView.frame)+15*SCREEN_RADIO,CGRectGetMaxY(self.nickName.frame)+2*SCREEN_RADIO, screen_width, 18*SCREEN_RADIO)];
        _dateLabel.font=[UIFont systemFontOfSize:11*SCREEN_RADIO];
        _dateLabel.textColor=[UIColor getColor:@"7C858A"];
        _dateLabel.text=@"2017-04-09 17:09.in China BeiJing";
    }
    
    return _dateLabel;
}

-(UILabel *)commitLabel{
    if (!_commitLabel) {
        _commitLabel=[[UILabel alloc] initWithFrame:CGRectMake(15*SCREEN_RADIO, CGRectGetMaxY(self.dateLabel.frame)+18*SCREEN_RADIO, screen_width-30*SCREEN_RADIO, 0)];
        _commitLabel.font=[UIFont systemFontOfSize:14*SCREEN_RADIO];
        _commitLabel.textColor=[UIColor getColor:@"232627"];
        _commitLabel.text=self.commitModel.content;
        _commitLabel.numberOfLines=0;
        [_commitLabel sizeToFit];
    }
    
    return _commitLabel;
}

@end
