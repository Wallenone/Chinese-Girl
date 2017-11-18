//
//  CGUserInfo.m
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/11/12.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGUserInfo.h"

@implementation CGUserInfo
+ (instancetype)modelWithDic:(NSDictionary *)dic{
    CGUserInfo *model = [[CGUserInfo alloc]init];
    model.ids = [self filterNullString:[dic stringForKey:@"id"]];
    model.nickname = [self filterNullString:[dic stringForKey:@"nickname"]];
    model.sex = [self filterNullString:[dic stringForKey:@"sex"]];
    model.birthday = [self filterNullString:[dic stringForKey:@"birthday"]];
    model.aboutus = [self filterNullString:[dic stringForKey:@"aboutus"]];
    model.avater = [NSString stringWithFormat:@"%@%@%@%@",@"https://raw.githubusercontent.com/Wallenone/service/master/imgData/",model.ids,@"/Enclosure/",[self filterNullString:[dic stringForKey:@"avater"]]];
    model.address = [NSString stringWithFormat:@"China,%@",[self filterNullString:[dic stringForKey:@"city"]]] ;
    model.bigAvater = [self getBigAvater:model.avater withIds:model.ids];
    return model;
}

+(NSMutableArray *)reloadTableWithRangeFrom:(NSInteger)fromNum rangeTLenth:(NSInteger)lenth{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"userinfo" ofType:@"plist"];
    NSMutableArray *data1 = [[[[NSMutableArray alloc] initWithContentsOfFile:filePath] subarrayWithRange:NSMakeRange(fromNum, lenth)] mutableCopy];
    
    NSMutableArray *newData=[NSMutableArray new];
    for (NSDictionary *model in data1) {
        [newData addObject:[self modelWithDic:model]];
    }
    
    return newData;
}


+(CGUserInfo *)getitemWithID:(NSString *)ids{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"userInfo" ofType:@"plist"];
    NSMutableArray *data1 = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    NSDictionary *dict= [data1 objectAtIndex:[ids intValue]-1];
    
    CGUserInfo *model1= [self modelWithDic:dict];
    if ([model1.ids isEqualToString:ids]) {
        BOOL _isLike=NO;
        for (NSString *content in [CGSingleCommitData sharedInstance].follows) {
            if (content.length>0) {
                if ([content isEqualToString:model1.ids]) {
                    _isLike = YES;
                }
            }
        }
        model1.followed=_isLike;
    }
    
    return model1;
}

+(NSString *)getBigAvater:(NSString *)icon withIds:(NSString *)ids{
    NSArray *array = [icon componentsSeparatedByString:@"/"];
    NSString *iconTstr=[array objectAtIndex:array.count-1];
    NSArray *array1 = [iconTstr componentsSeparatedByString:@"."];
    NSString *bstr=[[array1 objectAtIndex:0] stringByReplacingOccurrencesOfString:@"S" withString:@"B"];
    NSString *newIcon= [NSString stringWithFormat:@"%@%@%@%@%@%@",@"https://raw.githubusercontent.com/Wallenone/service/master/imgData/",ids,@"/Enclosure/",bstr,@".",[array1 objectAtIndex:1]];
    
    return newIcon;
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
