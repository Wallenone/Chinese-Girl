//
//  MySettingTableViewCell.h
//  ChineseGirl
//
//  Created by Wallen on 2017/10/15.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface MySettingTableViewCell : UITableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withModel:(NSString *)model;
-(void)updateCellContent:(NSString *)content;
-(NSString *)getContent;
@end
