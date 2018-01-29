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

+(NSMutableArray *)reloadCommits:(NSArray *)commitS{
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
                [newArr addObject:dict];
            }
            
           
        }else{
            if(item.length>0){
                NSArray *array = [item componentsSeparatedByString:@"-"];
                if (array.count>0) {
                    NSString *nickName= [self reloadPinlunRenTableWithIds:[array objectAtIndex:0]];
                    NSString *content = [self reloadTableWithIds:[array objectAtIndex:1]];
                   NSString *avater=[NSString stringWithFormat:@"https://raw.githubusercontent.com/Wallenone/service/master/manavater/%@",[self reloadPinlunavaterRenTableWithIds:[array objectAtIndex:0]]];
                    
                    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
                    [dict setObject:nickName forKey:@"nickName"];
                    [dict setObject:content forKey:@"content"];
                    [dict setObject:avater forKey:@"avater"];
                    [newArr addObject:dict];
                }
            }
            
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
@end
