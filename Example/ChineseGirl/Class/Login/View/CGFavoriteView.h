//
//  CGFavoriteView.h
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/11/29.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^CellClickBlock)(NSInteger);
@interface CGFavoriteView : UIView
- (instancetype)initWithFrame:(CGRect)frame withCellBlock:(CellClickBlock)block;
-(void)updateTable;
@end
