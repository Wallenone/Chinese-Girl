//
//  CGAnswerModel.m
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/11/17.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGAnswerModel.h"
@interface CGAnswerModel()
@end
@implementation CGAnswerModel
+ (instancetype)modelWithDic:(NSDictionary *)dic{
    CGAnswerModel *model = [[CGAnswerModel alloc]init];
    model.ids = [self filterNullString:[dic stringForKey:@"id"]];
    model.title = [self filterNullString:[dic stringForKey:@"title"]];
    model.answercontent = [self filterNullString:[dic stringForKey:@"answercontent"]];
    model.answerArr = [self getAnswerArr:model.answercontent];
    
    return model;
}


+(NSMutableArray *)reloadTable{
    NSMutableArray *newData=[NSMutableArray new];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"answer" ofType:@"plist"];
    NSMutableArray *data1 = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    for (NSString *ids in [self genertateRandomNumberStartNum:1 endNum:(int)data1.count count:3]) {
        for (NSDictionary *model in data1) {
            CGAnswerModel *model1= [self modelWithDic:model];
            if ([model1.ids integerValue]==[ids integerValue]) {
                [newData addObject:model1];
            }
            
        }
    }
    return newData;
}

+ (NSArray *)genertateRandomNumberStartNum:(int)startNum endNum:(int)endNum count:(int)count
{
    if (startNum > endNum) {
        return nil;
    }
    
    if (abs(endNum - startNum) > count) {
        return nil;
    }
    
    NSMutableArray * data = [[NSMutableArray alloc] init];
    for (int i = 0; i < count; i ++) {
        int x = (int)(startNum + (arc4random() % (endNum - startNum + 1)));
        NSLog(@"x:%d",x);
        NSNumber * number = [NSNumber numberWithInt:x];
        if (![data containsObject:number]) {
            [data addObject:number];
        }else{
            i = i - 1; //发现有重复则-1
        }
    }
    
    NSLog(@"data:%@",data);
    return (NSArray *)data;
    
    //排序
    NSNumber * temp;
    for (int i = 0; i < [data count]; i++) {
        for (int j = 0; j < i; j++) {
            if ([[data objectAtIndex:i] intValue] < [[data objectAtIndex:j] intValue]) {
                temp = [data objectAtIndex:i];
                [data replaceObjectAtIndex:i withObject:[data objectAtIndex:j]];
                [data replaceObjectAtIndex:j withObject:temp];
            }
        }
    }
    for (int i = 0; i < [data count]; i ++) {
        NSLog(@"intValue:::%d",[[data objectAtIndex:i] intValue]);
    }
}




+(NSArray *)getAnswerArr:(NSString *)content{
    NSArray *array = [content componentsSeparatedByString:@"/"];
    NSMutableArray *newArr=[NSMutableArray new];
    for (NSString *answer in array) {
        [newArr addObject:answer];
    }
    return newArr;
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
