//
//  WSCollectionCell.h
//  瀑布流
//
//  Created by iMac on 16/12/26.
//  Copyright © 2016年 zws. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGShuoShuo.h"
typedef void (^CommitClick)(void);
typedef void (^LikeClickBlock)(BOOL);
@interface MyIndexCell : UITableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithModel:(CGShuoShuo *)indexModel withCommitClick:(CommitClick)block;
-(CGFloat)getCellHeight;
-(void)hiddenPlayView:(BOOL)state;
-(CGRect)getVideoimageViewFrame;
@end
