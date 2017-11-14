//
//  CGLocationTableViewCell.m
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/11/14.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGLocationTableViewCell.h"
@interface CGLocationTableViewCell()
@property(nonatomic,strong)UILabel *locationName;
@end
@implementation CGLocationTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        [self creatSubView];
    }
    
    return self;
}

-(void)creatSubView{
    [self addSubview:self.locationName];
}

-(void)updateCellData:(NSString *)cellData{
    self.locationName.text=cellData;
}

-(UILabel *)locationName{
    if (!_locationName) {
        _locationName=[[UILabel alloc] initWithFrame:CGRectMake(30*SCREEN_RADIO, 12*SCREEN_RADIO, SCREEN_WIDTH, 16*SCREEN_RADIO)];
        _locationName.text=[CGSingleCommitData sharedInstance].countryName;
        _locationName.textColor=[UIColor blackColor];
        _locationName.font=[UIFont systemFontOfSize:16*SCREEN_RADIO];
    }
    
    return _locationName;
}
@end
