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
    model.month = [self filterNullString:[dic stringForKey:@"month"]];
    model.icon =[CGUserInfo getitemWithID:model.ids].avater;
    model.nickName =[CGUserInfo getitemWithID:model.ids].nickname;
    model.birthday =[CGUserInfo getitemWithID:model.ids].birthday;
    model.toContent =[NSString stringWithFormat:@"%@个月后去%@",model.month,[CGSingleCommitData sharedInstance].cityName];
    model.address =[CGUserInfo getitemWithID:model.ids].address;
    model.bigIcon = [NSString stringWithFormat:@"%@%@%@%@",@"https://raw.githubusercontent.com/Wallenone/service/master/imgData/",model.ids,@"/Enclosure/",[self filterNullString:[dic stringForKey:@"bigIcon"]]];
    return model;
}

+(NSMutableArray *)reloadTableWithRangeFrom:(NSInteger)fromNum rangeTLenth:(NSInteger)lenth{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"plist"];
    NSMutableArray *data1 = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    NSMutableArray *newData=[NSMutableArray new];
    
    NSInteger currentNum=fromNum+lenth;
    if (data1.count>currentNum) {
        NSMutableArray *data2 = [[data1 subarrayWithRange:NSMakeRange(fromNum, lenth)] mutableCopy];
        for (NSDictionary *model in data2) {
            [newData addObject:[self modelWithDic:model]];
        }
    }else{
        NSInteger t_num=data1.count-fromNum;
        if (t_num>0) {
            NSMutableArray *data2 = [[data1 subarrayWithRange:NSMakeRange(fromNum, data1.count-fromNum)] mutableCopy];
            for (NSDictionary *model in data2) {
                [newData addObject:[self modelWithDic:model]];
            }
        }
        
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
