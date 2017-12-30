//
//  CGMoneyTopModel.m
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/12/30.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGMoneyTopModel.h"
@implementation CGMoneyTopModel
+ (instancetype)modelWithDic:(NSDictionary *)dic{
    CGMoneyTopModel *model = [[CGMoneyTopModel alloc]init];
    model.ids = [CGCommonString filterNullString:[dic stringForKey:@"id"]];
    model.moneyuserid = [CGCommonString filterNullString:[dic stringForKey:@"moneyuserid"]];
    model.hotuserid = [CGCommonString filterNullString:[dic stringForKey:@"hotuserid"]];
    model.moneyNum = [CGCommonString filterNullString:[dic stringForKey:@"moneyNum"]];
    model.hotNum = [CGCommonString filterNullString:[dic stringForKey:@"hotNum"]];
    model.moneyUserInfo =[CGUserInfo getitemWithID:model.moneyuserid];
    model.hotUserInfo =[CGUserInfo getitemWithID:model.hotuserid];
    return model;
}

+(NSMutableArray *)reloadTable{
    NSMutableArray *newData=[NSMutableArray new];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"moneyTop" ofType:@"plist"];
    NSMutableArray *data1 = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    for (NSDictionary *model in data1) {
        CGMoneyTopModel *model1= [self modelWithDic:model];
        [newData addObject:model1];
    }
    return newData;
}
@end
