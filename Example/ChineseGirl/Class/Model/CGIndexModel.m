//
//  CGIndexModel.m
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/11/12.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGIndexModel.h"
#import "CGUserInfo.h"
@implementation CGIndexModel
+ (instancetype)modelWithDic:(NSDictionary *)dic{
    CGIndexModel *model = [[CGIndexModel alloc]init];
    model.ids = [self filterNullString:[dic stringForKey:@"id"]];
    model.bigIcon = [NSString stringWithFormat:@"%@%@%@%@",@"https://raw.githubusercontent.com/Wallenone/service/master/imgData/",model.ids,@"/Enclosure/",[self filterNullString:[dic stringForKey:@"bigIcon"]]];
    model.month = [self filterNullString:[dic stringForKey:@"month"]];
    model.icon =[CGUserInfo getitemWithID:model.ids].avater;
    model.nickName =[CGUserInfo getitemWithID:model.ids].nickname;
    model.birthday =[CGUserInfo getitemWithID:model.ids].birthday;
    model.toContent =[NSString stringWithFormat:@"%@个月后去%@",model.month,[CGSingleCommitData sharedInstance].cityName];
    return model;
}

+(NSMutableArray *)reloadTableWithRangeFrom:(NSInteger)fromNum rangeTLenth:(NSInteger)lenth{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"plist"];
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
