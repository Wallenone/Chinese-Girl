//
//  CGVideoDataModel.h
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/11/24.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGVideoDataModel : NSObject
@property(nonatomic,copy)NSString *ids;
@property(nonatomic,copy)NSString *videoIcon;
@property(nonatomic,copy)NSString *videoUrl;
@property(nonatomic,copy)NSString *userId;
@property(nonatomic,copy)NSString *nickName;
+ (instancetype)modelWithDic:(NSDictionary *)dic;
+(NSMutableArray *)reloadTableWithRangeFrom:(NSInteger)fromNum rangeTLenth:(NSInteger)lenth;
+(NSArray *)reloadTableRondomCount:(NSInteger)count;
+(CGVideoDataModel *)reloadTableWithIds:(NSInteger)ids;
+(void)updateReloadRondom;
@end
