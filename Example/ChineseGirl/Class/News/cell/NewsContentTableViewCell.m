//
//  NewsContentTableViewCell.m
//  ChineseGirl
//
//  Created by wallen on 2017/9/6.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "NewsContentTableViewCell.h"
#import "NewsContentCustomLabel.h"
@interface NewsContentTableViewCell()
@property(nonatomic,strong)NewsContentModel *newsContentModel;
@property(nonatomic,strong)UIImageView *iconImgView;
@property(nonatomic,strong)NewsContentCustomLabel *textCentent;
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UIImageView *MessageBgImgView;
@end
@implementation NewsContentTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithModel:(NewsContentModel *)NewsModel{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        self.backgroundColor=[UIColor clearColor];
        self.newsContentModel = NewsModel;
        [self creatSubView];
    }
    
    return self;
}

-(void)creatSubView{
    [self addSubview:self.iconImgView];
    [self addSubview:self.timeLabel];
    [self addSubview:self.MessageBgImgView];
    [self addSubview:self.textCentent];
}

-(UIImageView *)iconImgView{
    if (!_iconImgView) {
        _iconImgView=[[UIImageView alloc] initWithFrame:CGRectMake(screen_width-53*SCREEN_RADIO, 15*SCREEN_RADIO, 38*SCREEN_RADIO, 38*SCREEN_RADIO)];
        _iconImgView.layer.cornerRadius=19*SCREEN_RADIO;
        _iconImgView.image=[UIImage imageNamed:self.newsContentModel.icon];
    }
    
    return _iconImgView;
}

-(NewsContentCustomLabel *)textCentent{
    if (!_textCentent) {
        
        CGFloat _textWidth;
        CGFloat maxWidth =screen_width-164*SCREEN_RADIO;
    
        CGSize constraint = CGSizeMake(maxWidth, 99999.0f);
        CGSize size = [self.newsContentModel.text sizeWithFont:[UIFont systemFontOfSize:22*SCREEN_RADIO] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
        
        if (size.width<maxWidth) {
            _textWidth = size.width +24*SCREEN_RADIO;
        }else{
            _textWidth = maxWidth;
        }
        
        _textCentent=[[NewsContentCustomLabel alloc] initWithFrame:CGRectMake((80+(maxWidth-size.width))*SCREEN_RADIO, 15*SCREEN_RADIO, ceil(_textWidth), ceil(size.height+24*SCREEN_RADIO))];
        _textCentent.layer.cornerRadius=_textCentent.frame.size.height*0.1;
        _textCentent.clipsToBounds = YES;
        _textCentent.font=[UIFont systemFontOfSize:22*SCREEN_RADIO];
        _textCentent.textColor = [UIColor getColor:@"ffffff"];
        //_textCentent.backgroundColor=[UIColor getColor:@"2979FF"];
        _textCentent.userInteractionEnabled=NO;
        _textCentent.text=self.newsContentModel.text;
        _textCentent.layer.borderColor=[UIColor clearColor].CGColor;
        _textCentent.numberOfLines=0;
    }
    
    return _textCentent;
}

-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel=[[UILabel alloc] initWithFrame:CGRectMake(screen_width-53*SCREEN_RADIO, CGRectGetMaxY(self.iconImgView.frame)+8*SCREEN_RADIO, 0, 13*SCREEN_RADIO)];
        _timeLabel.text=self.newsContentModel.timeDate;
        _timeLabel.textColor=[UIColor getColor:@"7C858A"];
        _timeLabel.font=[UIFont systemFontOfSize:11*SCREEN_RADIO];
        [_timeLabel sizeToFit];
    }
    
    return _timeLabel;
}

-(UIImageView *)MessageBgImgView{
    CGFloat _textWidth;
    CGFloat maxWidth =screen_width-164*SCREEN_RADIO;
    
    CGSize constraint = CGSizeMake(maxWidth, 99999.0f);
    CGSize size = [self.newsContentModel.text sizeWithFont:[UIFont systemFontOfSize:22*SCREEN_RADIO] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    
    if (size.width<maxWidth) {
        _textWidth = size.width +24*SCREEN_RADIO;
    }else{
        _textWidth = maxWidth;
    }
    
    if (!_MessageBgImgView) {
        _MessageBgImgView=[[UIImageView alloc] initWithFrame:CGRectMake((80+(maxWidth-size.width))*SCREEN_RADIO, 15*SCREEN_RADIO, ceil(_textWidth), ceil(size.height+24*SCREEN_RADIO))];
        

        UIImage * backImage;
        backImage = [[UIImage imageNamed:@"MessageBg"] stretchableImageWithLeftCapWidth:21 topCapHeight:14];
        _MessageBgImgView.image=backImage;
    }
    
    return _MessageBgImgView;
}

@end
