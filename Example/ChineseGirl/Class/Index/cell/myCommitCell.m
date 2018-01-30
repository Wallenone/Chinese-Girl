//
//  myHeaderViewCell.m
//  ChineseGirl
//
//  Created by Wallen on 2017/8/26.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "myCommitCell.h"

@interface myCommitCell()
@property(nonatomic,strong)id myCommitModel;
@property(nonatomic,strong)UIView *topLineView;
@property(nonatomic,strong)UIImageView *AvatarImgView;
@property(nonatomic,strong)UILabel *nickName;
@property(nonatomic,strong)UILabel *date;
@property(nonatomic,strong)UILabel *commitLabel;

@end
@implementation myCommitCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithModel:(id)commitModel{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        self.myCommitModel = commitModel;
        [self creatSubView];
    }
    
    return self;
}

- (void)creatSubView {
    [self addSubview:self.topLineView];
    [self addSubview:self.AvatarImgView];
    [self addSubview:self.nickName];
    [self addSubview:self.date];
    [self addSubview:self.commitLabel];
}



-(UIView *)topLineView{
    if (!_topLineView) {
        _topLineView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
        _topLineView.backgroundColor=[UIColor getColor:@"CED7DB"];
    }
    
    return _topLineView;
}

-(UIImageView *)AvatarImgView{
    if (!_AvatarImgView) {
        _AvatarImgView=[[UIImageView alloc] initWithFrame:CGRectMake(15*SCREEN_RADIO, 10*SCREEN_RADIO, 34*SCREEN_RADIO, 34*SCREEN_RADIO)];
        if ([[self.myCommitModel stringForKey:@"avater"] isEqualToString:@"avater"]) {
            _AvatarImgView.image=[CGSingleCommitData sharedInstance].avatar;
        }else{
           [_AvatarImgView sd_setImageWithURL:[NSURL URLWithString:[self.myCommitModel objectForKey:@"avater"]] placeholderImage:[UIImage imageNamed:@"default_nor_avatar"]];
        }
        
        _AvatarImgView.layer.cornerRadius=17*SCREEN_RADIO;
        _AvatarImgView.clipsToBounds=YES;
    }
    
    return _AvatarImgView;
}

-(UILabel *)nickName{
    if (!_nickName) {
        _nickName=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.AvatarImgView.frame)+10*SCREEN_RADIO, 10*SCREEN_RADIO, 0, 27*SCREEN_RADIO)];
        _nickName.font=[UIFont systemFontOfSize:14*SCREEN_RADIO];
        _nickName.text=[self.myCommitModel objectForKey:@"nickName"];
        _nickName.textColor=[UIColor getColor:@"7C858A"];
        [_nickName sizeToFit];
    }
    return _nickName;
}

-(UILabel *)date{
    if (!_date) {
        _date=[[UILabel alloc] initWithFrame:CGRectMake(0, 10*SCREEN_RADIO, SCREEN_WIDTH-15*SCREEN_RADIO, 18*SCREEN_RADIO)];
        _date.font=[UIFont systemFontOfSize:11*SCREEN_RADIO];
        _date.textColor=[UIColor getColor:@"7C858A"];
        _date.text=[self.myCommitModel objectForKey:@"date"];;
        _date.textAlignment=NSTextAlignmentRight;
    }
    
    return _date;
}

-(UILabel *)commitLabel{
    if (!_commitLabel) {
        _commitLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.AvatarImgView.frame)+15*SCREEN_RADIO, CGRectGetMaxY(self.nickName.frame)+10*SCREEN_RADIO, SCREEN_WIDTH-69*SCREEN_RADIO, 0*SCREEN_RADIO)];
        _commitLabel.font=[UIFont systemFontOfSize:14*SCREEN_RADIO];
        _commitLabel.textColor=[UIColor getColor:@"232627"];
        _commitLabel.text=[self.myCommitModel objectForKey:@"content"];
        _commitLabel.numberOfLines=0;
        [_commitLabel sizeToFit];
    }
    
    return _commitLabel;
}


@end
