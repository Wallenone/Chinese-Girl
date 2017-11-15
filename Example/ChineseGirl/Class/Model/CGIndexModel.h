//
//  CGIndexModel.h
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/11/12.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGIndexModel : NSObject
@property(nonatomic,copy)NSString *ids;
@property(nonatomic,copy)NSString *bigIcon;
@property(nonatomic,copy)NSString *month;
@property(nonatomic,copy)NSString *icon;
@property(nonatomic,copy)NSString *nickName;
@property(nonatomic,copy)NSString *birthday;
@property(nonatomic,copy)NSString *toContent;  //打算几个月去哪个国家
+ (instancetype)modelWithDic:(NSDictionary *)dic;
+(NSMutableArray *)reloadTableWithRangeFrom:(NSInteger)fromNum rangeTLenth:(NSInteger)lenth;
@end