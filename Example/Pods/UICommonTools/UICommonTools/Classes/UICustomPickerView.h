//
//  UICustomPickerView.h
//  Huifenqi
//
//  Created by wallen on 2017/9/19.
//  Copyright © 2017年 qiuyu wang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^CheckBlock)(id);
@interface UICustomPickerView : UIView
-(instancetype)initWithFrame:(CGRect)frame withArray:(NSArray *)pickerArray withTitle:(NSString *)title withCheckBlock:(CheckBlock)block;
@end
