//
//  CGNewFriendTableViewCell.h
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/11/15.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^AddFriendClickBlock)(NSString *,NSString *);
@interface CGNewFriendTableViewCell : UITableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithModel:(NSString *)userid withAddFriendBlock:(AddFriendClickBlock)block;
@end
