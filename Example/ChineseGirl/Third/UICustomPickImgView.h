//
//  UICustomPickImgView.h
//  ChineseGirl
//
//  Created by Wallen on 2017/10/21.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^GetImgCallBack)(UIImage *);
@interface UICustomPickImgView : UIView

-(void)onGetImg:(GetImgCallBack)block;
@end
