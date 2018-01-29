//
//  CGPinglunren.h
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/11/12.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGPinglunren : NSObject
@property(nonatomic,copy)NSString *ids;
@property(nonatomic,copy)NSString *username;
@property(nonatomic,copy)NSString *avater;
@property(nonatomic,copy)NSString *date;
+ (instancetype)modelWithDic:(NSDictionary *)dic;
+(NSMutableArray *)reloadRandom;
@end
