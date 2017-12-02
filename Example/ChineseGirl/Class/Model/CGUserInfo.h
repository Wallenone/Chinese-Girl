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
@property(nonatomic,copy)NSString *bigAvater;
@property(nonatomic,strong)NSMutableArray *pictures;
@property(nonatomic,strong)NSMutableArray *picturesBig;
@property(nonatomic,assign)BOOL followed;   //是否加关注
+ (instancetype)modelWithDic:(NSDictionary *)dic;
+(NSMutableArray *)reloadTableWithRangeFrom:(NSInteger)fromNum rangeTLenth:(NSInteger)lenth;
+(CGUserInfo *)getitemWithID:(NSString *)ids;
+(NSArray *)reloadTableRondomCount:(NSInteger)count;//随机用户
@end
