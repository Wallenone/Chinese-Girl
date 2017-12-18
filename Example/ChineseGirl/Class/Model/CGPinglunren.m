//
//  CGPinglunren.m
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/11/12.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGPinglunren.h"
@implementation CGPinglunren
+ (instancetype)modelWithDic:(NSDictionary *)dic{
    CGPinglunren *model = [[CGPinglunren alloc]init];
    model.ids = [CGCommonString filterNullString:[dic stringForKey:@"id"]];
    model.username = [CGCommonString filterNullString:[dic stringForKey:@"username"]];
    return model;
}

+(NSMutableArray *)reloadTableWithRangeFrom:(NSInteger)fromNum rangeTLenth:(NSInteger)lenth{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"pinglunren" ofType:@"plist"];
    NSMutableArray *data1 = [[[[NSMutableArray alloc] initWithContentsOfFile:filePath] subarrayWithRange:NSMakeRange(fromNum, lenth)] mutableCopy];
    
    NSMutableArray *newData=[NSMutableArray new];
    for (NSDictionary *model in data1) {
        [newData addObject:[self modelWithDic:model]];
    }

    return newData;
}

@end
