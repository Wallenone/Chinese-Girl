//
//  CGPinglun.m
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/11/12.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGPinglun.h"
#import "CGPinglunren.h"
#import "CGPinglunModel.h"
#import "CGSqliteManager.h"
@implementation CGPinglun

+(NSMutableArray *)reloadCommits:(NSArray *)commitS withfromDate:(NSString *)fromDate withShuoshuoId:(NSString *)ids{
    NSMutableArray *newArr=[NSMutableArray new];
    for (NSString *item in commitS) {
        if([item rangeOfString:@"@"].location !=NSNotFound){
            NSArray *array = [item componentsSeparatedByString:@"-"];
            if (array.count>0) {
                NSString *huifu= [[array objectAtIndex:0] stringByReplacingOccurrencesOfString:@"@" withString:@""];
                
                NSString *nickName= [self reloadPinlunRenTableWithIds:huifu];
                NSString *content = [self reloadTableWithIds:[array objectAtIndex:1]];
                NSString *avater=[NSString stringWithFormat:@"https://raw.githubusercontent.com/Wallenone/service/master/manavater/%@",[self reloadPinlunavaterRenTableWithIds:[array objectAtIndex:0]]];
                
                NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
                [dict setObject:[NSString stringWithFormat:@"%@%@",NSLocalizedString(@"reply", nil),nickName] forKey:@"nickName"];
                [dict setObject:content forKey:@"content"];
                [dict setObject:avater forKey:@"avater"];
                [dict setObject:[self randomDateTimeFrom:[CGDateData convertDateFromString:fromDate]] forKey:@"date"];
                [newArr addObject:dict];
            }
            
           
        }else{
            if(item.length>0){
                NSArray *array = [item componentsSeparatedByString:@"-"];
                if (array.count>0) {
                    NSString *nickName= [self reloadPinlunRenTableWithIds:[array objectAtIndex:0]];
                    NSString *content = [self reloadTableWithIds:[array objectAtIndex:1]];
                    NSString *avater=[NSString stringWithFormat:@"%@manavater/%@",applocalHost,[self reloadPinlunavaterRenTableWithIds:[array objectAtIndex:0]]];
                    
                    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
                    [dict setObject:nickName forKey:@"nickName"];
                    [dict setObject:content forKey:@"content"];
                    [dict setObject:avater forKey:@"avater"];
                    [dict setObject:[self randomDateTimeFrom:[CGDateData convertDateFromString:fromDate]] forKey:@"date"];
                    [newArr addObject:dict];
                }
            }
            
        }
    }
    
    for (NSDictionary *model in [CGSingleCommitData sharedInstance].commits) {
        if ([ids isEqualToString:[model stringForKey:@"id"]]) {
            [newArr addObject:model];
        }
    }
    
    return newArr;
    
}

+(NSString *)reloadTableWithIds:(NSString *)ids{
    NSDictionary *dict= [CGSqliteManager getPinglunId:[ids intValue]];
    
    return [dict stringForKey:@"content"];
}


+(NSString *)reloadPinlunRenTableWithIds:(NSString *)ids{
    NSDictionary *dict= [CGSqliteManager getPinglunrenId:[ids intValue]];
    return [dict stringForKey:@"username"];
}

+(NSString *)reloadPinlunavaterRenTableWithIds:(NSString *)ids{
    NSDictionary *dict= [CGSqliteManager getPinglunrenId:[ids intValue]];
    return [dict stringForKey:@"avater"];
}

//随机评论时间
+(NSString *)randomDateTimeFrom:(NSDate *)fromDate{
    int day = [CGDateData dateTimeDifferenceWithStartTime:[CGDateData DateFormatterDate:fromDate] endTime:[CGDateData DateFormatterDate:[CGDateData getCurrentTime]]];
    
    int randomDay=[CGCommonToolsNode getRandomNumber:0 to:day];
    
    NSString *dateStr = [CGDateData DateFormatterDate:[CGDateData datejisuanYear:0 Month:0 Day:+randomDay withData:fromDate]];
    
    return dateStr;
}
@end
