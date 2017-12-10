//
//  CGAnimationIndexCell.h
//  ChineseGirl_Example
//
//  Created by wallen on 2017/11/24.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGVideoDataModel.h"

typedef void (^PlayVideoBlock)(NSString *,NSString *);
@interface CGAnimationIndexCell : UITableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withModel:(NSArray *)model withPlayCell:(PlayVideoBlock)block;
@end
