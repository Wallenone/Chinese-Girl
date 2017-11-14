//
//  CGRegisterIndexView.h
//  ChineseGirl
//
//  Created by wallen on 2017/8/31.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^CancelClickBlock)(void);
typedef void (^RegSingUpClickBlock)(BOOL,NSString *);
typedef void (^ChooseCityClickBlock)(void);
@interface CGRegisterIndexView : UIView
- (id)initWithFrame:(CGRect)frame onCancelClick:(CancelClickBlock)cancelBlock onSingUpClick:(RegSingUpClickBlock)singUpBlock onChooseCityBlock:(ChooseCityClickBlock)chooseCityBlock;
-(void)updateCellContent:(NSString *)cellData;
@end
