//
//  CGPinglunModel.m
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/11/12.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGPinglunModel.h"
@implementation CGPinglunModel
+ (instancetype)modelWithDic:(NSDictionary *)dic{
    CGPinglunModel *model = [[CGPinglunModel alloc]init];
    model.ids = [self filterNullString:[dic stringForKey:@"id"]];
    model.content = [self filterNullString:[dic stringForKey:@"content"]];
    return model;
}

+(NSMutableArray *)reloadTableWithRangeFrom:(NSInteger)fromNum rangeTLenth:(NSInteger)lenth{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"pinglun" ofType:@"plist"];
    NSMutableArray *data1 = [[[[NSMutableArray alloc] initWithContentsOfFile:filePath] subarrayWithRange:NSMakeRange(fromNum, lenth)] mutableCopy];
    
    NSMutableArray *newData=[NSMutableArray new];
    for (NSDictionary *model in data1) {
        [newData addObject:[self modelWithDic:model]];
    }
    
    return newData;
}



+(NSString *)filterNullString:(NSString *)str{
    NSString *filterStr=str;
    BOOL filterState= [CGCommonString isBlankString:str];
    if (filterState) {
        filterStr=@"";
    }
    return filterStr;
}
@end
