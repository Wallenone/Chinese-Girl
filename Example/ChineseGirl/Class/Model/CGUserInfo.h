//
//  CGUserInfo.h
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/11/12.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGUserInfo : NSObject
@property(nonatomic,copy)NSString *ids;
@property(nonatomic,copy)NSString *nickname;
@property(nonatomic,copy)NSString *sex;
@property(nonatomic,copy)NSString *birthday;
@property(nonatomic,copy)NSString *aboutus;
@property(nonatomic,copy)NSString *avater;
@property(nonatomic,copy)NSString *address;
+ (instancetype)modelWithDic:(NSDictionary *)dic;
+(NSMutableArray *)reloadTableWithRangeFrom:(NSInteger)fromNum rangeTLenth:(NSInteger)lenth;
+(CGUserInfo *)getitemWithID:(NSString *)ids;
@end
