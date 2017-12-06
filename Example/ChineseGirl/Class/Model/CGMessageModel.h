//
//  CGMessageModel.h
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/12/5.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CGVideoDataModel.h"
#import "CGUserInfo.h"
@interface CGMessageModel : NSObject
@property(nonatomic,copy)NSString *ids;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *message;
@property(nonatomic,copy)NSString *message_radio;
@property(nonatomic,copy)NSString *message_Bigpicture;
@property(nonatomic,copy)NSString *message_videoUrl;
@property(nonatomic,copy)NSString *message_videoIcon;
@property(nonatomic,copy)NSString *message_radioSecond;
@property(nonatomic,copy)NSString *message_radioUrl;
@property(nonatomic,strong)CGUserInfo *userModel;
+ (instancetype)modelWithDic:(NSDictionary *)dic;
+(CGMessageModel *)reloadReloadRondom;
@end

