//
//  MyCommitHeaderView.h
//  ChineseGirl
//
//  Created by Wallen on 2017/9/2.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MycommitModel.h"
@interface MyCommitHeaderView : UITableViewCell;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithModel:(MycommitModel *)commitModel;
@end
