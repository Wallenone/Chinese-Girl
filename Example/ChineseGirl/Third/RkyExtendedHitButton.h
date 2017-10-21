//
//  RkyExtendedHitButton.h
//  EasyJieApp
//
//  Created by eson on 14-9-24.
//  Copyright (c) 2014年 easyjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RkyExtendedHitButton : UIButton
//扩大点击区域
@property(nonatomic, assign) UIEdgeInsets hitTestEdgeInsets;

@property(nonatomic, copy)NSIndexPath *currentIndexPath;

@end
