//
//  CGMoneyTopModel.h
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/12/30.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CGUserInfo.h"
@interface CGMoneyTopModel : NSObject
@property(nonatomic,copy)NSString *ids;
@property(nonatomic,copy)NSString *moneyuserid;
@property(nonatomic,copy)NSString *hotuserid;
@property(nonatomic,copy)NSString *moneyNum;
@property(nonatomic,copy)NSString *hotNum;
@property(nonatomic,strong)CGUserInfo *moneyUserInfo;
@property(nonatomic,strong)CGUserInfo *hotUserInfo;
+ (instancetype)modelWithDic:(NSDictionary *)dic;
+(NSMutableArray *)reloadTable;
@end
