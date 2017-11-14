//
//  CGLocationTableViewCell.h
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/11/14.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGLocationTableViewCell : UITableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
-(void)updateCellData:(NSString *)cellData;
@end
