//
//  CGOptionsTableViewCell.m
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/11/15.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGOptionsTableViewCell.h"
@interface CGOptionsTableViewCell(){
    NSInteger _answerNum;
    NSString *_content;
}
@end
@implementation CGOptionsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithModel:(id)commitModel withPage:(NSInteger)num{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        _answerNum=num;
        _content=commitModel;
        [self creatSubView];
    }
    
    return self;
}

-(void)creatSubView{
    UIImageView *icon=[[UIImageView alloc] initWithFrame:CGRectMake(15*SCREEN_RADIO, 10*SCREEN_RADIO, 42*SCREEN_RADIO, 30*SCREEN_RADIO)];
    icon.image=[UIImage imageNamed:[NSString stringWithFormat:@"answer%ld",(long)_answerNum]];
    [self addSubview:icon];
    
    UILabel *content=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(icon.frame)+15*SCREEN_RADIO, 23*SCREEN_RADIO, screen_width-CGRectGetMaxX(icon.frame)+15*SCREEN_RADIO, 16*SCREEN_RADIO)];
    content.text=_content;
    content.textColor=[UIColor blackColor];
    content.font=[UIFont systemFontOfSize:16*SCREEN_RADIO];
    [self addSubview:content];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        self.backgroundColor=[UIColor getColor:@"ECEEF8"];
    }else{
        self.backgroundColor=[UIColor whiteColor];
    }
    
}
@end
