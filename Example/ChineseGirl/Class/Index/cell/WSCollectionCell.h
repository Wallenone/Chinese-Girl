//
//  WSCollectionCell.h
//  瀑布流
//
//  Created by iMac on 16/12/26.
//  Copyright © 2016年 zws. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CGIndexModel.h"
@interface WSCollectionCell : UITableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithModel:(CGIndexModel *)commitModel;
@end
