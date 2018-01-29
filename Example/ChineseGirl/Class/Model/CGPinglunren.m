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
    model.avater = [CGCommonString filterNullString:[dic stringForKey:@"avater"]];
    model.date =  [CGCommonString filterNullString:[dic stringForKey:@"date"]];
    return model;
}

+(NSMutableArray *)reloadRandom{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"pinglunren" ofType:@"plist"];
    NSMutableArray *data1 = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    
    int count = [CGCommonToolsNode getRandomNumber:5 to:20];
    
    NSArray *newarr1= [CGCommonToolsNode genertateRandomNumberStartNum:0 endNum:(int)data1.count-1 count:count];
    
    
    NSMutableArray *newData=[NSMutableArray new];
    for (int i=0; i<newarr1.count; i++) {
        NSMutableDictionary *dict=[NSMutableDictionary new];
        dict = [data1 objectAtIndex:[[newarr1 objectAtIndex:i] integerValue]+1];
        [dict setObject:[self getDateNum:i] forKey:@"date"];
        [newData addObject:[self modelWithDic:dict]];
    }

    return newData;
}

+(NSArray *)getDateNum:(int)ids{
    NSArray *arr=@[[NSString stringWithFormat:@"1%@",NSLocalizedString(@"hourfont", nil)],
                   [NSString stringWithFormat:@"2%@",NSLocalizedString(@"hourfont", nil)],
                   [NSString stringWithFormat:@"4%@",NSLocalizedString(@"hourfont", nil)],
                   [NSString stringWithFormat:@"6%@",NSLocalizedString(@"hourfont", nil)],
                   [NSString stringWithFormat:@"10%@",NSLocalizedString(@"hourfont", nil)],
                   [NSString stringWithFormat:@"14%@",NSLocalizedString(@"hourfont", nil)],
                   [NSString stringWithFormat:@"20%@",NSLocalizedString(@"hourfont", nil)],
                   [NSString stringWithFormat:@"1%@",NSLocalizedString(@"dayfont", nil)],
                   [NSString stringWithFormat:@"2%@",NSLocalizedString(@"dayfont", nil)],
                   [NSString stringWithFormat:@"3%@",NSLocalizedString(@"dayfont", nil)],
                   [NSString stringWithFormat:@"4%@",NSLocalizedString(@"dayfont", nil)],
                   [NSString stringWithFormat:@"5%@",NSLocalizedString(@"dayfont", nil)],
                   [NSString stringWithFormat:@"6%@",NSLocalizedString(@"dayfont", nil)],
                   [NSString stringWithFormat:@"8%@",NSLocalizedString(@"dayfont", nil)],
                   [NSString stringWithFormat:@"11%@",NSLocalizedString(@"dayfont", nil)],
                   [NSString stringWithFormat:@"14%@",NSLocalizedString(@"dayfont", nil)],
                   [NSString stringWithFormat:@"15%@",NSLocalizedString(@"dayfont", nil)],
                   [NSString stringWithFormat:@"16%@",NSLocalizedString(@"dayfont", nil)],
                   [NSString stringWithFormat:@"18%@",NSLocalizedString(@"dayfont", nil)],
                   [NSString stringWithFormat:@"19%@",NSLocalizedString(@"dayfont", nil)],
                   [NSString stringWithFormat:@"23%@",NSLocalizedString(@"dayfont", nil)],
                   [NSString stringWithFormat:@"24%@",NSLocalizedString(@"dayfont", nil)],
                   [NSString stringWithFormat:@"27%@",NSLocalizedString(@"dayfont", nil)]];
   
    return  [arr objectAtIndex:ids];
}

@end
