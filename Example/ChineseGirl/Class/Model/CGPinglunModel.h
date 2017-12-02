//
//  CGPinglunModel.h
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/11/12.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import <Foundation/Foundation.h>

//评论表
@interface CGPinglunModel : NSObject
@property(nonatomic,copy)NSString *ids;  //id
@property(nonatomic,copy)NSString *content;  //content
+ (instancetype)modelWithDic:(NSDictionary *)dic;
+(NSMutableArray *)reloadTableWithRangeFrom:(NSInteger)fromNum rangeTLenth:(NSInteger)lenth;
@end
