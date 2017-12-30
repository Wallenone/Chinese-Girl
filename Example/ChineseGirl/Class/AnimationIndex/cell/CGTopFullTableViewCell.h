//
//  CGTopFullTableViewCell.h
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/12/30.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGMoneyTopModel.h"
@interface CGTopFullTableViewCell : UITableViewCell
//type =1 代表财富 type==2 代表活跃

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withModel:(CGMoneyTopModel *)model withType:(NSInteger)type;
@end
