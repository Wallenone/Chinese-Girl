//
//  CGaddFriendsModel.m
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/11/15.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGaddFriendsModel.h"
#import "CGUserInfo.h"
@implementation CGaddFriendsModel
+ (instancetype)modelWithDic:(NSDictionary *)dic{
    CGaddFriendsModel *model = [[CGaddFriendsModel alloc]init];
    model.ids = [self filterNullString:[dic stringForKey:@"id"]];
    model.userid = [self filterNullString:[dic stringForKey:@"userid"]];
    model.nickName = [CGUserInfo getitemWithID:model.ids].nickname;
    model.aboutUs = [CGUserInfo getitemWithID:model.ids].aboutus;
    model.avater = [CGUserInfo getitemWithID:model.ids].avater;
    model.pictures = [CGUserInfo getitemWithID:model.ids].pictures;
    model.picturesBig = [CGUserInfo getitemWithID:model.ids].picturesBig;
    return model;
}

+(NSMutableArray *)reloadTable{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"addFriends" ofType:@"plist"];
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
