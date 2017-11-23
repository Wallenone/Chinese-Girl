//
//  myHeaderViewCell.h
//  ChineseGirl
//
//  Created by Wallen on 2017/8/26.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGUserInfo.h"
typedef void (^TalkCallBlock)(void);
@interface myHeaderViewCell : UITableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithModel:(CGUserInfo *)indexModel withTalkCallBack:(TalkCallBlock)block;
@end
