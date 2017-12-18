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
    model.ids = [CGCommonString filterNullString:[dic stringForKey:@"id"]];
    model.title = [CGCommonString filterNullString:[dic stringForKey:@"title"]];
    model.answercontent = [CGCommonString filterNullString:[dic stringForKey:@"answercontent"]];
    model.answerArr = [self getAnswerArr:model.answercontent];
    
    return model;
}


+(NSMutableArray *)reloadTable{
    NSMutableArray *newData=[NSMutableArray new];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"answer" ofType:@"plist"];
    NSMutableArray *data1 = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    for (NSString *ids in [CGCommonToolsNode genertateRandomNumberStartNum:1 endNum:(int)data1.count count:3]) {
        for (NSDictionary *model in data1) {
            CGAnswerModel *model1= [self modelWithDic:model];
            if ([model1.ids integerValue]==[ids integerValue]) {
                [newData addObject:model1];
            }
            
        }
    }
    return newData;
}


+(NSArray *)getAnswerArr:(NSString *)content{
    NSArray *array = [content componentsSeparatedByString:@"/"];
    NSMutableArray *newArr=[NSMutableArray new];
    for (NSString *answer in array) {
        [newArr addObject:answer];
    }
    return newArr;
}

@end
