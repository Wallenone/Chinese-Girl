//
//  NewsContentTableViewCell.m
//  ChineseGirl
//
//  Created by wallen on 2017/9/6.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "NewsContentTableViewCell.h"
#import "NewsContentCustomLabel.h"
#import "ShapedImageView.h"
#import "UIImage+Color.h"
@interface NewsContentTableViewCell(){
    int _type;
    NSString *_message;
    NSString *_avater;
    FrontModel _front; //方向
}
@property(nonatomic,strong)UIImageView *iconImgView;
@property(nonatomic,strong)NewsContentCustomLabel *textCentent;
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)ShapedImageView *MessageBgImgView;
@end
@implementation NewsContentTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithType:(NSString *)type withMessage:(NSString *)message withAvater:(NSString *)avater withTurnFront:(FrontModel)front{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        self.backgroundColor=[UIColor redColor];
        _type=[type intValue];
        _message=message;
        _avater=avater;
        _front=front;
        [self creatSubView];
    }
    
    return self;
}

-(void)creatSubView{
    [self addSubview:self.iconImgView];
    [self addSubview:self.timeLabel];
    [self addSubview:self.MessageBgImgView];
    if (_type==1) {
        [self addSubview:self.textCentent];
    }
    
}

-(UIImageView *)iconImgView{
    if (!_iconImgView) {
        CGFloat _textX;
        if (_front==FrontLeft) {
            _textX=15*SCREEN_RADIO;
        }else {
            _textX=screen_width-53*SCREEN_RADIO;
        }
        
        _iconImgView=[[UIImageView alloc] initWithFrame:CGRectMake(_textX, 15*SCREEN_RADIO, 38*SCREEN_RADIO, 38*SCREEN_RADIO)];
        _iconImgView.layer.cornerRadius=19*SCREEN_RADIO;
        [_iconImgView sd_setImageWithURL:[NSURL URLWithString:_avater]];
    }
    
    return _iconImgView;
}

-(NewsContentCustomLabel *)textCentent{
    if (!_textCentent) {
        
        CGFloat _textWidth;
        CGFloat maxWidth =screen_width-144*SCREEN_RADIO;
    
        CGSize constraint = CGSizeMake(maxWidth, 99999.0f);
        CGSize size = [_message sizeWithFont:[UIFont systemFontOfSize:16*SCREEN_RADIO] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
        
        if (size.width<maxWidth) {
            _textWidth = size.width +24*SCREEN_RADIO;
        }else{
            _textWidth = maxWidth;
        }
        
        CGFloat _textX;
        if (_front==FrontLeft) {
            _textX=60*SCREEN_RADIO;
        }else {
            _textX=(80+(maxWidth-size.width))*SCREEN_RADIO;
        }
        
        _textCentent=[[NewsContentCustomLabel alloc] initWithFrame:CGRectMake(_textX, 15*SCREEN_RADIO, ceil(_textWidth), ceil(size.height+24*SCREEN_RADIO))];
        _textCentent.layer.cornerRadius=ceil(size.height+24*SCREEN_RADIO)*0.1;
        _textCentent.clipsToBounds = YES;
        _textCentent.font=[UIFont systemFontOfSize:16*SCREEN_RADIO];
        _textCentent.textColor = [UIColor blackColor];
        _textCentent.backgroundColor=[UIColor getColor:@"2979FF"];
        _textCentent.userInteractionEnabled=NO;
        _textCentent.text=_message;
        _textCentent.numberOfLines=0;
        //[_textCentent sizeToFit];
    }
    
    return _textCentent;
}

-(UILabel *)timeLabel{
    if (!_timeLabel) {
        CGFloat _textX;
        if (_front==FrontLeft) {
            _textX=15*SCREEN_RADIO;
        }else {
            _textX=screen_width-53*SCREEN_RADIO;
        }
        _timeLabel=[[UILabel alloc] initWithFrame:CGRectMake(_textX, CGRectGetMaxY(self.iconImgView.frame)+8*SCREEN_RADIO, 0, 13*SCREEN_RADIO)];
        _timeLabel.text=[self getCurrentTime];
        _timeLabel.textColor=[UIColor getColor:@"7C858A"];
        _timeLabel.font=[UIFont systemFontOfSize:11*SCREEN_RADIO];
        [_timeLabel sizeToFit];
    }
    
    return _timeLabel;
}


//获取当地时间
- (NSString *)getCurrentTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}


@end
