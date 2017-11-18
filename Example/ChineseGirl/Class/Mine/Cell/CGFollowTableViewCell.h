//
//  CGFollowTableViewCell.h
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/11/18.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGUserInfo.h"
@interface CGFollowTableViewCell : UITableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(id)reuseIdentifier withModel:(CGUserInfo *)model withHidden:(BOOL)state;
@end
