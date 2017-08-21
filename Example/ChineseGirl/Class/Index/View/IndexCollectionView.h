//
//  IndexCollectionView.h
//  ChineseGirl
//
//  Created by wallen on 2017/8/14.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^CellSelectedIndexBlock)(NSIndexPath *);
@interface IndexCollectionView : UIView
- (id)initWithFrame:(CGRect)frame onCellSelected:(CellSelectedIndexBlock)block;
@end
