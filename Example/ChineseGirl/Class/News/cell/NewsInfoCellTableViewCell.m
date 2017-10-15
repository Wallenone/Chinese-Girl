//
//  NewsInfoCellTableViewCell.m
//  ChineseGirl
//
//  Created by wallen on 2017/8/29.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "NewsInfoCellTableViewCell.h"
@interface NewsInfoCellTableViewCell()
@property(nonatomic,strong)NewsInfoModel *myIndexModel;
@property(nonatomic,strong)UIImageView *iconImgView;
@property(nonatomic,strong)UILabel *nickNameLable;
@property(nonatomic,strong)UILabel *contentLabel;
@property(nonatomic,strong)UIView *bottomLine;
@property(nonatomic,strong)UILabel *timeLabel;
@end
@implementation NewsInfoCellTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithModel:(NewsInfoModel *)indexModel{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        self.backgroundColor=[UIColor clearColor];
        self.myIndexModel = indexModel;
        [self creatSubView];
    }
    
    return self;
}

-(void)creatSubView{
    [self addSubview:self.iconImgView];
    [self addSubview:self.nickNameLable];
    [self addSubview:self.timeLabel];
    [self addSubview:self.contentLabel];
    [self addSubview:self.bottomLine];
}

-(UIImageView *)iconImgView{
    if(!_iconImgView){
        _iconImgView=[[UIImageView alloc] initWithFrame:CGRectMake(15*SCREEN_RADIO, 10*SCREEN_RADIO, 52*SCREEN_RADIO, 52*SCREEN_RADIO)];
        _iconImgView.image=[UIImage imageNamed:self.myIndexModel.icon];
        _iconImgView.layer.cornerRadius=26*SCREEN_RADIO;
    }
    
    return _iconImgView;
}

-(UILabel *)nickNameLable{
    if(!_nickNameLable){
        _nickNameLable=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImgView.frame)+15*SCREEN_RADIO, 10*SCREEN_RADIO, 0, 27*SCREEN_RADIO)];
        _nickNameLable.text=self.myIndexModel.nickName;
        _nickNameLable.textColor=[UIColor getColor:@"232627"];
        _nickNameLable.font=[UIFont systemFontOfSize:22*SCREEN_RADIO];
        [_nickNameLable sizeToFit];
    }
    
    return _nickNameLable;
}

-(UILabel *)timeLabel{
    if(!_timeLabel){
        _timeLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 15*SCREEN_RADIO, screen_width-10*SCREEN_RADIO, 17*SCREEN_RADIO)];
        _timeLabel.text=self.myIndexModel.timeDate;
        _timeLabel.textColor=[UIColor getColor:@"7C858A"];
        _timeLabel.font=[UIFont systemFontOfSize:17*SCREEN_RADIO];
        _timeLabel.textAlignment=NSTextAlignmentRight;
    }
    
    return _timeLabel;
}

-(UILabel *)contentLabel{
    if(!_contentLabel){
        _contentLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImgView.frame)+15*SCREEN_RADIO, CGRectGetMaxY(self.nickNameLable.frame)+10*SCREEN_RADIO, 0, 27*SCREEN_RADIO)];
        _contentLabel.text=self.myIndexModel.content;
        _contentLabel.textColor=[UIColor getColor:@"7C858A"];
        _contentLabel.font=[UIFont systemFontOfSize:11*SCREEN_RADIO];
        [_contentLabel sizeToFit];
    }
    
    return _contentLabel;
}

-(UIView *)bottomLine{
    if (!_bottomLine) {
        _bottomLine=[[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 0.5)];
        _bottomLine.backgroundColor=[UIColor getColor:@"CED7DB"];
    }
    
    return _bottomLine;
}
@end
