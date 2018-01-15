//
//  CGShuoShuo.m
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/11/12.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGShuoShuo.h"
#import "CGUserInfo.h"
#import <AVFoundation/AVFoundation.h>
#import "CGIndexModel.h"
#import "CGVideoDataModel.h"
#import "CGSqliteManager.h"
@implementation CGShuoShuo
+ (instancetype)modelWithDic:(NSDictionary *)dic{
    CGShuoShuo *model = [[CGShuoShuo alloc]init];
    model.ids = [CGCommonString filterNullString:[dic stringForKey:@"id"]];
    model.videoid=[CGCommonString filterNullString:[dic stringForKey:@"videoid"]];
    model.sort = [CGCommonString filterNullString:[dic stringForKey:@"sort"]];
    model.content = [CGCommonString filterNullString:[dic stringForKey:@"content"]];
    model.pictures =  [self getFromString:[CGCommonString filterNullString:[dic stringForKey:@"imgs"]] withId:model.ids];
   // model.pictureBigs = [self getBigFromString:[CGCommonString filterNullString:[dic stringForKey:@"imgs"]] withId:model.ids];
    model.pinglunid = [self getPinglunids:[CGCommonString filterNullString:[dic stringForKey:@"pinglunid"]]];
    model.icon= [CGUserInfo getitemWithID:model.ids].avater;
    model.nickName = [CGUserInfo getitemWithID:model.ids].nickname;
    model.timeDate = @"1999-09-09";
    model.likes= [CGCommonString filterNullString:[dic stringForKey:@"likes"]];
    model.comments= [CGCommonString filterNullString:[dic stringForKey:@"comments"]];
    model.address= [CGUserInfo getitemWithID:model.ids].address;
    model.type = [CGCommonString filterNullString:[dic stringForKey:@"type"]];
    if ([model.type integerValue]==1) {
        model.pictureBigs = [self getBigFromString:[CGCommonString filterNullString:[dic stringForKey:@"imgs"]] withId:model.ids];
        model.videoUrl = @"";
        model.videoPicUrl=@"";
    }else if ([model.type integerValue]==2){
        model.videoUrl = [CGVideoDataModel reloadTableWithIds:[model.videoid integerValue]].videoUrl;
        model.videoPicUrl=[CGVideoDataModel reloadTableWithIds:[model.videoid integerValue]].videoIcon;
        model.pictureBigs=@[];
    }
    
    return model;
}


+(NSMutableArray *)reloadTableWithRangeFrom:(NSInteger)fromNum rangeTLenth:(NSInteger)lenth{
    
   // NSString *filePath = [[NSBundle mainBundle] pathForResource:@"shuoshuo1" ofType:@"plist"];
    NSArray *data1;
    if (fromNum==0 && lenth==0) {
        data1=[CGSqliteManager allShuoshuo];
    }else{
        data1 = [[CGSqliteManager allShuoshuo] subarrayWithRange:NSMakeRange(fromNum, lenth)];
    }
    
    NSMutableArray *newData=[NSMutableArray new];
    for (NSDictionary *model in data1) {
        [newData addObject:[self modelWithDic:model]];
    }
    
    return newData;
}

+(NSMutableArray *)reloadTableWithId:(NSInteger)ids{
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"shuoshuo1" ofType:@"plist"];
//    NSMutableArray *data1 = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    NSArray *data1=[CGSqliteManager allShuoshuo];
    NSMutableArray *newData=[NSMutableArray new];
    for (NSDictionary *model in data1) {
        CGShuoShuo *model1= [self modelWithDic:model];
        if ([model1.ids integerValue]==ids) {
            BOOL _isLike=NO;
            for (NSString *content in [CGSingleCommitData sharedInstance].favourites) {
                if (content.length>0) {
                    NSArray *array = [content componentsSeparatedByString:@"-"];
                    if ([array[0] isEqualToString:model1.ids] && [array[1] isEqualToString:model1.sort]) {
                        _isLike = YES;
                    }
                }
            }
            model1.isLike=_isLike;
            
           [newData addObject:model1];
        }
    }
    
    return newData;
}

+(CGShuoShuo *)getTableWithId:(NSString *)ids{
    NSArray *array = [ids componentsSeparatedByString:@"-"];
    if (array>0) {
       NSMutableArray *newData = [[self reloadTableWithId:[array[0] integerValue]] mutableCopy];
        if (newData.count>0) {
            for (CGShuoShuo *model in newData) {
                if ([array[1] isEqualToString:model.sort]) {
                    return model;
                }
            }
        }
    }
    
    
    return [CGShuoShuo new];
}

+(void)reloadTableRondom{
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"shuoshuo" ofType:@"plist"];
//    NSMutableArray *data1 = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    NSArray *data1=[CGSqliteManager allShuoshuo];
    NSMutableArray *newData=[NSMutableArray new];
    
    NSArray *newarr1= [CGCommonToolsNode genertateRandomNumberStartNum:0 endNum:(int)(data1.count)-1 count:(int)data1.count];
    for (NSString *ids in newarr1) {
        NSDictionary *model=[data1 objectAtIndex:[ids integerValue]];
        NSString *ids=[CGCommonString filterNullString:[model stringForKey:@"id"]];
        NSString *month=[NSString stringWithFormat:@"%d",[CGCommonToolsNode getRandomNumber:1 to:3]];
        NSString *bigIcon=[CGCommonString filterNullString:[model stringForKey:@"imgs"]];
        NSString *type=[CGCommonString filterNullString:[model stringForKey:@"type"]];
        NSString *videoid=[CGCommonString filterNullString:[model stringForKey:@"videoid"]];
        NSDictionary *newModel=@{@"id":ids,@"month":month,@"bigIcon":bigIcon,@"type":type,@"videoid":videoid};
        
        CGIndexModel *indexModel=[CGIndexModel modelWithDic:newModel];
        [newData addObject:indexModel];
    }

    [CGSingleCommitData sharedInstance].indexDataArr=[newData mutableCopy];
}


+(NSArray *)getFromString:(NSString *)string withId:(NSString *)ids{
    NSArray *array = [string componentsSeparatedByString:@"/"];
    NSMutableArray *newArr=[NSMutableArray new];
    for (NSString *icon in array) {
       NSString *newIcon= [NSString stringWithFormat:@"%@%@%@%@",@"https://raw.githubusercontent.com/Wallenone/service/master/imgData/",ids,@"/Enclosure/",icon];
       [newArr addObject:newIcon];
    }
    return newArr;
}

+(NSArray *)getPinglunids:(NSString *)pinglunids{
    NSArray *array = [pinglunids componentsSeparatedByString:@"/"];
    NSMutableArray *newArr=[NSMutableArray new];
    for (NSString *pinlunStr in array) {
        NSString * newpinlunStr=[pinlunStr stringByReplacingOccurrencesOfString:@" " withString:@""];
        [newArr addObject:newpinlunStr];
    }
    
    return newArr;
}

+(NSArray *)getBigFromString:(NSString *)string withId:(NSString *)ids{
    NSArray *array = [string componentsSeparatedByString:@"/"];
    NSMutableArray *newArr=[NSMutableArray new];
    for (NSString *icon in array) {
        NSArray *array1 = [icon componentsSeparatedByString:@"."];
        NSString *bstr=[[array1 objectAtIndex:0] stringByReplacingOccurrencesOfString:@"S" withString:@"B"];
        NSString *newIcon= [NSString stringWithFormat:@"%@%@%@%@%@%@",@"https://raw.githubusercontent.com/Wallenone/service/master/imgData/",ids,@"/Enclosure/",bstr,@".",[array1 objectAtIndex:1]];
        [newArr addObject:newIcon];
    }
    return newArr;
}

@end
