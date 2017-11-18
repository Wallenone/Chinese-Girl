//
//  CGIndexMendModel.m
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/11/18.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGIndexMendModel.h"
#import "CGUserInfo.h"
@implementation CGIndexMendModel
+ (instancetype)modelWithDic:(NSDictionary *)dic{
    CGIndexMendModel *model = [[CGIndexMendModel alloc]init];
    model.ids = [self filterNullString:[dic stringForKey:@"id"]];
    model.icon = [NSString stringWithFormat:@"%@%@%@%@",@"https://raw.githubusercontent.com/Wallenone/service/master/imgData/",model.ids,@"/Enclosure/",[self filterNullString:[dic stringForKey:@"icon"]]];
    model.nickName = [CGUserInfo getitemWithID:model.ids].nickname;
    return model;
}

+(NSMutableArray *)reloadTable{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"indexmend" ofType:@"plist"];
    NSMutableArray *data1 = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    
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
