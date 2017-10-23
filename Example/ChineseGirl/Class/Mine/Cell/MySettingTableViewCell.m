//
//  MySettingTableViewCell.m
//  ChineseGirl
//
//  Created by Wallen on 2017/10/15.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "MySettingTableViewCell.h"
@interface MySettingTableViewCell(){
    NSString *_title;
}
@property(nonatomic,strong)UILabel *leftLabel;
@property(nonatomic,strong)UILabel *rightLabel;
@property(nonatomic,strong)UIButton *allowBtn;
@property(nonatomic,strong)UIView *lineView;
@end
@implementation MySettingTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withModel:(NSString *)model{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        _title=model;
        [self addSubViews];
    }
    
    return self;
}

-(void)addSubViews{
    [self addSubview:self.leftLabel];
    [self addSubview:self.rightLabel];
    [self addSubview:self.allowBtn];
    [self addSubview:self.lineView];
}

-(void)updateCellContent:(NSString *)content{
    if (content.length>0) {
        self.rightLabel.text=content;
    }
}

-(NSString *)getContent{
    if (self.rightLabel.text.length>0) {
        return self.rightLabel.text;
    }
    
    return @"";
}

-(UILabel *)leftLabel{
    if (!_leftLabel) {
        _leftLabel=[[UILabel alloc] initWithFrame:CGRectMake(17*SCREEN_RADIO, 18*SCREEN_RADIO, 0, 20*SCREEN_RADIO)];
        _leftLabel.text=_title;
        _leftLabel.textColor=[UIColor getColor:@"5E7785"];
        _leftLabel.font=[UIFont systemFontOfSize:13*SCREEN_RADIO];
        [_leftLabel sizeToFit];
    }
    return _leftLabel;
}

-(UILabel *)rightLabel{
    if (!_rightLabel) {
        _rightLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 11.5*SCREEN_RADIO, 303*SCREEN_RADIO, 20*SCREEN_RADIO)];
        //_rightLabel.text=self.settigModel.rightItem;
        _rightLabel.textColor=[UIColor getColor:@"5E7785"];
        _rightLabel.font=[UIFont systemFontOfSize:13*SCREEN_RADIO];
        _rightLabel.textAlignment=NSTextAlignmentRight;
    }
    return _rightLabel;
}

-(UIButton *)allowBtn{
    if (!_allowBtn) {
        _allowBtn=[[UIButton alloc] initWithFrame:CGRectMake(screen_width-32*SCREEN_RADIO-20*SCREEN_RADIO, 18.5*SCREEN_RADIO, 6*SCREEN_RADIO, 11*SCREEN_RADIO)];
        [_allowBtn setBackgroundImage:[UIImage imageNamed:@"myAllowLeft"] forState:UIControlStateNormal];
        _allowBtn.userInteractionEnabled=NO;
    }
    
    return _allowBtn;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView=[[UIView alloc] initWithFrame:CGRectMake(16*SCREEN_RADIO, 49*SCREEN_RADIO, screen_width-72*SCREEN_RADIO, 0.5)];
        _lineView.backgroundColor=[UIColor getColor:@"CED7DB"];
        if ([_title isEqualToString:@"关于我"]) {
            _lineView.hidden=YES;
        }
    }
    
    return _lineView;
}

@end
