//
//  NewsInfoCellTableViewCell.h
//  ChineseGirl
//
//  Created by wallen on 2017/8/29.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGMessageModel.h"
@interface NewsInfoCellTableViewCell : UITableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithModel:(CGMessageModel *)indexModel;
@end
