//
//  NewsInfoCellTableViewCell.m
//  ChineseGirl
//
//  Created by wallen on 2017/8/29.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "NewsInfoCellTableViewCell.h"
#import "CGUserInfo.h"
@interface NewsInfoCellTableViewCell()
@property(nonatomic,strong)CGUserInfo *myIndexModel;
@property(nonatomic,strong)UIImageView *iconImgView;
@property(nonatomic,strong)UILabel *nickNameLable;
@property(nonatomic,strong)UILabel *contentLabel;
@property(nonatomic,strong)UIView *bottomLine;
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)id talkListModel;
@end
@implementation NewsInfoCellTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithModel:(NSDictionary *)indexModel{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        self.backgroundColor=[UIColor whiteColor];
        self.myIndexModel=[CGUserInfo getitemWithID:[indexModel stringForKey:@"userid"]];
        self.talkListModel=indexModel;
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
        
        _iconImgView=[[UIImageView alloc] initWithFrame:CGRectMake(15*SCREEN_RADIO, 10*SCREEN_RADIO, 42*SCREEN_RADIO, 42*SCREEN_RADIO)];
        [_iconImgView sd_setImageWithURL:[NSURL URLWithString:self.myIndexModel.avater]];
        _iconImgView.layer.cornerRadius=21*SCREEN_RADIO;
        _iconImgView.clipsToBounds=YES;
    }
    
    return _iconImgView;
}

-(UILabel *)nickNameLable{
    if(!_nickNameLable){
        _nickNameLable=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImgView.frame)+15*SCREEN_RADIO, 12*SCREEN_RADIO, 0, 16*SCREEN_RADIO)];
        _nickNameLable.text=self.myIndexModel.nickname;
        _nickNameLable.textColor=[UIColor getColor:@"171616"];
        _nickNameLable.font=[UIFont systemFontOfSize:16*SCREEN_RADIO];
        [_nickNameLable sizeToFit];
    }
    
    return _nickNameLable;
}

-(UILabel *)timeLabel{
    if(!_timeLabel){
        _timeLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 15*SCREEN_RADIO, screen_width-10*SCREEN_RADIO, 14*SCREEN_RADIO)];
        _timeLabel.text=@"1992.10.24";
        _timeLabel.textColor=[UIColor getColor:@"777777"];
        _timeLabel.font=[UIFont systemFontOfSize:14*SCREEN_RADIO];
        _timeLabel.textAlignment=NSTextAlignmentRight;
    }
    
    return _timeLabel;
}

-(UILabel *)contentLabel{
    if(!_contentLabel){
        _contentLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImgView.frame)+15*SCREEN_RADIO, CGRectGetMaxY(self.nickNameLable.frame)+3*SCREEN_RADIO, screen_width-(CGRectGetMaxX(self.iconImgView.frame)+15*SCREEN_RADIO)-30*SCREEN_RADIO, 11*SCREEN_RADIO)];
        NSString *message=@"";
        if ([self.talkListModel arrayForKey:@"item"].count>0) {
            NSArray *itemArr=[self.talkListModel arrayForKey:@"item"];
            NSDictionary *dict= itemArr[itemArr.count-1];
            if ([[dict stringForKey:@"type"] integerValue]==0) {
                if (self.myIndexModel.messageids.count>0) {
                    CGMessageModel *messageDict=self.myIndexModel.messageids[0];
                    
                    if ([messageDict.type integerValue]==1) {
                        message=messageDict.message;
                    }else if ([messageDict.type integerValue]==2){
                        message=[NSString stringWithFormat:@"[%@]",NSLocalizedString(@"yuying", nil)];
                    }else if ([messageDict.type integerValue]==3){
                        message=[NSString stringWithFormat:@"[%@]",NSLocalizedString(@"tupian", nil)];
                    }else if ([messageDict.type integerValue]==4){
                        message=[NSString stringWithFormat:@"[%@]",NSLocalizedString(@"shiping", nil)];
                    }
                }
  
            }else if([[dict stringForKey:@"type"] integerValue]==1){
                message=[dict stringForKey:@"message"];
            }
        }
        _contentLabel.text=message;
        _contentLabel.textColor=[UIColor getColor:@"7C858A"];
        _contentLabel.lineBreakMode=NSLineBreakByTruncatingTail;
        _contentLabel.font=[UIFont systemFontOfSize:11*SCREEN_RADIO];
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
