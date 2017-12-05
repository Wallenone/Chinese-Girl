//
//  CGMessageModel.m
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/12/5.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGMessageModel.h"

@implementation CGMessageModel
+ (instancetype)modelWithDic:(NSDictionary *)dic{
    CGMessageModel *model = [[CGMessageModel alloc]init];
    model.ids = [self filterNullString:[dic stringForKey:@"id"]];
    model.type= [self filterNullString:[dic stringForKey:@"type"]];
    model.userModel = [CGUserInfo getitemWithID:@"1"];
    if ([model.type integerValue]==1) {
        model.message = [self filterNullString:[dic stringForKey:@"message"]];
    }else if ([model.type integerValue]==2){
        model.message_radio = [NSString stringWithFormat:@"%@%@",@"https://raw.githubusercontent.com/Wallenone/service/master/radio/",model.message];
    }else if ([model.type integerValue]==3){
        model.message_picture=[NSString stringWithFormat:@"%@%@",@"https://raw.githubusercontent.com/Wallenone/service/master/imgData/",model.message];
    }else if ([model.type integerValue]==4){
       model.videoModel = [CGVideoDataModel reloadTableWithIds:[model.ids integerValue]];
    }
    return model;
}

+(CGMessageModel *)reloadReloadRondom{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"message" ofType:@"plist"];
    NSMutableArray *data1 = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    CGMessageModel *model=[CGMessageModel new];
    NSArray *newarr1= [CGCommonToolsNode genertateRandomNumberStartNum:0 endNum:(int)(data1.count)-1 count:1];
//    for (NSString *ids in newarr1) {
//        model=[self modelWithDic:[data1 objectAtIndex:[ids integerValue]]];
//    }
    model=[self modelWithDic:[data1 objectAtIndex:5]];
    return model;
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
