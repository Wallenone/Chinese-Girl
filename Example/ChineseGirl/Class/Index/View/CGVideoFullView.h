//
//  CGVideoFullView.h
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/11/18.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WMPlayer.h"
typedef void (^CloseClickBlock)(void);
@interface CGVideoFullView : UICollectionViewCell
- (void)WMPlayer:(WMPlayer *)player withCloseBlock:(CloseClickBlock)closeBlock;
@end
