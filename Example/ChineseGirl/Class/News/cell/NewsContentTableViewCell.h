//
//  NewsContentTableViewCell.h
//  ChineseGirl
//
//  Created by wallen on 2017/9/6.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGMessageModel.h"
typedef enum {
    FrontLeft=1,
    FrontRight
}FrontModel;

@interface NewsContentTableViewCell : UITableViewCell
//front  方向
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithModel:(CGMessageModel *)model withUserId:(NSString *)userid;
@end

