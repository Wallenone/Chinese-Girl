//
//  NewsContentTableViewCell.m
//  ChineseGirl
//
//  Created by wallen on 2017/9/6.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "NewsContentTableViewCell.h"

@interface NewsContentTableViewCell()
@property(nonatomic,strong)NewsContentModel *newsContentModel;
@property(nonatomic,strong)UIImageView *iconImgView;
@property(nonatomic,strong)UITextView *textCentent;
@end
@implementation NewsContentTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithModel:(NewsContentModel *)NewsModel{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        self.backgroundColor=[UIColor redColor];
        self.newsContentModel = NewsModel;
        [self creatSubView];
    }
    
    return self;
}

-(void)creatSubView{
    [self addSubview:self.iconImgView];
    [self addSubview:self.textCentent];
}

-(UIImageView *)iconImgView{
    if (!_iconImgView) {
        _iconImgView=[[UIImageView alloc] initWithFrame:CGRectMake(screen_width-53*SCREEN_RADIO, 0, 38*SCREEN_RADIO, 38*SCREEN_RADIO)];
        _iconImgView.layer.cornerRadius=19*SCREEN_RADIO;
        _iconImgView.image=[UIImage imageNamed:self.newsContentModel.icon];
    }
    
    return _iconImgView;
}

-(UITextView *)textCentent{
    if (!_textCentent) {
        
        CGFloat maxWidth =screen_width-140*SCREEN_RADIO;
    
        CGSize constraint = CGSizeMake(maxWidth, 99999.0f);
        CGSize size = [self.newsContentModel.text sizeWithFont:[UIFont systemFontOfSize:22*SCREEN_RADIO] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
        _textCentent=[[UITextView alloc] initWithFrame:CGRectMake((80+(maxWidth-size.width))*SCREEN_RADIO, 0, size.width, size.height)];
        _textCentent.layer.cornerRadius=10*SCREEN_RADIO;
        _textCentent.font=[UIFont systemFontOfSize:22*SCREEN_RADIO];
        _textCentent.textColor = [UIColor getColor:@"ffffff"];
        _textCentent.backgroundColor=[UIColor getColor:@"2979FF"];
        _textCentent.textAlignment = NSTextAlignmentLeft;
        _textCentent.textContainerInset=UIEdgeInsetsMake(12*SCREEN_RADIO, 12*SCREEN_RADIO, 12*SCREEN_RADIO, 12*SCREEN_RADIO);
        _textCentent.layer.masksToBounds = YES;
        _textCentent.userInteractionEnabled=NO;
        _textCentent.text=self.newsContentModel.text;
    }
    
    return _textCentent;
}

@end
