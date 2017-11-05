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
    BOOL _lineState;
}
@property(nonatomic,strong)UILabel *leftLabel;
@property(nonatomic,strong)UILabel *rightLabel;
@property(nonatomic,strong)UIButton *allowBtn;
@property(nonatomic,strong)UIView *lineView;
@end
@implementation MySettingTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(id)reuseIdentifier withModel:(id)model withLineHidden:(BOOL)state{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        _lineState=state;
        [self setData:model];
        [self addSubViews];
    }
    
    return self;
}

-(void)setData:(id)model{
    if ([model isKindOfClass:[NSDictionary class]]) {
        _title=[model objectForKey:@"left"];
        [self updateCellContent:[model objectForKey:@"right"]];
    }else{
        _title=model;
    }

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
        _leftLabel=[[UILabel alloc] initWithFrame:CGRectMake(17*SCREEN_RADIO, 14*SCREEN_RADIO, 0, 20*SCREEN_RADIO)];
        _leftLabel.text=_title;
        _leftLabel.textColor=[UIColor getColor:@"686868"];
        _leftLabel.font=[UIFont systemFontOfSize:13*SCREEN_RADIO];
        [_leftLabel sizeToFit];
    }
    return _leftLabel;
}

-(UILabel *)rightLabel{
    if (!_rightLabel) {
        _rightLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 14*SCREEN_RADIO, screen_width-30*SCREEN_RADIO, 20*SCREEN_RADIO)];
        //_rightLabel.text=self.settigModel.rightItem;
        _rightLabel.textColor=[UIColor getColor:@"5E7785"];
        _rightLabel.font=[UIFont systemFontOfSize:13*SCREEN_RADIO];
        _rightLabel.textAlignment=NSTextAlignmentRight;
    }
    return _rightLabel;
}

-(UIButton *)allowBtn{
    if (!_allowBtn) {
        _allowBtn=[[UIButton alloc] initWithFrame:CGRectMake(screen_width-16*SCREEN_RADIO, 18.5*SCREEN_RADIO, 6*SCREEN_RADIO, 11*SCREEN_RADIO)];
        [_allowBtn setBackgroundImage:[UIImage imageNamed:@"myAllowLeft"] forState:UIControlStateNormal];
        _allowBtn.userInteractionEnabled=NO;
    }
    
    return _allowBtn;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView=[[UIView alloc] initWithFrame:CGRectMake(16*SCREEN_RADIO, 49*SCREEN_RADIO, screen_width-16*SCREEN_RADIO, 0.5)];
        _lineView.backgroundColor=[UIColor getColor:@"FDFDFD"];
        _lineView.hidden=_lineState;
        
    }
    
    return _lineView;
}

@end
