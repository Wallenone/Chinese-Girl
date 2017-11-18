//
//  CGIndexMendModel.h
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/11/18.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGIndexMendModel : NSObject
@property(nonatomic,copy)NSString *ids;
@property(nonatomic,copy)NSString *icon;
@property(nonatomic,copy)NSString *nickName;
+ (instancetype)modelWithDic:(NSDictionary *)dic;
+(NSMutableArray *)reloadTable;
@end
