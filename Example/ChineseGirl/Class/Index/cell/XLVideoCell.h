//
//  XLVideoCell.h
//  XLVideoPlayer
//
//  Created by Shelin on 16/3/22.
//  Copyright © 2016年 GreatGate. All rights reserved.
//  https://github.com/ShelinShelin

#import <UIKit/UIKit.h>
#import "CGShuoShuo.h"
@interface XLVideoCell : UITableViewCell
@property(nonatomic,strong)UIImageView *videoImageView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withModel:(CGShuoShuo *)tmodel withImg:(NSString *)imgUrl;
-(void)hiddenPlayView:(BOOL)state;
@end
