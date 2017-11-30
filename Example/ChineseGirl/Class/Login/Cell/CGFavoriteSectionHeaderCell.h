//
//  CGFavoriteSectionHeaderCell.h
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/11/30.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CGUserInfo.h"
typedef void (^AddFriendClickBlock)(NSString *,NSString *);
@interface CGFavoriteSectionHeaderCell : UITableViewCell

//type ==1是加好友  2是聊天
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithModel:(CGUserInfo *)commitModel withtouType:(NSInteger)type withAddFriendBlock:(AddFriendClickBlock)block;
@end
