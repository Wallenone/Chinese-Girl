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
#import "CGPinglun.h"
@interface CGShuoShuo()
@property(nonatomic,assign)int commitNum;
@end
@implementation CGShuoShuo
+ (instancetype)modelWithDic:(NSDictionary *)dic{
    CGShuoShuo *model = [[CGShuoShuo alloc]init];
    model.ids = [CGCommonString filterNullString:[dic stringForKey:@"id"]];
    model.uid =[CGCommonString filterNullString:[dic stringForKey:@"uid"]];
    model.videoid=[CGCommonString filterNullString:[dic stringForKey:@"videoid"]];
    model.sort = [CGCommonString filterNullString:[dic stringForKey:@"sort"]];
    model.english = [CGCommonString filterNullString:[dic stringForKey:@"english"]];
    model.france = [CGCommonString filterNullString:[dic stringForKey:@"france"]];
    model.spain = [CGCommonString filterNullString:[dic stringForKey:@"spain"]];
    model.russia = [CGCommonString filterNullString:[dic stringForKey:@"russia"]];
    model.tw = [CGCommonString filterNullString:[dic stringForKey:@"tw"]];
    model.korea = [CGCommonString filterNullString:[dic stringForKey:@"korea"]];
    model.japan = [CGCommonString filterNullString:[dic stringForKey:@"japan"]];
    model.content = [CGCommonString filterNullString:[dic stringForKey:@"content"]];
    model.pictures =  [self getFromString:[CGCommonString filterNullString:[dic stringForKey:@"imgs"]] withId:model.uid];
   // model.pictureBigs = [self getBigFromString:[CGCommonString filterNullString:[dic stringForKey:@"imgs"]] withId:model.uid];
    model.pinglunid = [self getPinglunids:[CGCommonString filterNullString:[dic stringForKey:@"pinglunid"]]];
    model.icon= [CGUserInfo getitemWithID:model.uid].avater;
    model.nickName = [CGUserInfo getitemWithID:model.uid].nickname;
    model.timeDate = [self getDateNum:[model.sort intValue]];
    model.likes= [CGCommonString filterNullString:[dic stringForKey:@"likes"]];
    model.comments= [NSString stringWithFormat:@"%lu",(unsigned long)[CGPinglun reloadCommits:model.pinglunid withfromDate:model.timeDate withShuoshuoId:model.ids].count];
    model.address= [CGUserInfo getitemWithID:model.uid].address;
    model.type = [CGCommonString filterNullString:[dic stringForKey:@"type"]];
    if ([model.type integerValue]==1) {
        model.pictureBigs = [self getBigFromString:[CGCommonString filterNullString:[dic stringForKey:@"imgs"]] withId:model.uid];
        model.videoUrl = @"";
        model.videoPicUrl=@"";
    }else if ([model.type integerValue]==2){
        model.videoUrl = [CGVideoDataModel reloadTableWithIds:[model.videoid integerValue]].videoUrl;
        model.videoPicUrl=[CGVideoDataModel reloadTableWithIds:[model.videoid integerValue]].videoIcon;
        model.pictureBigs=@[];
    }
    
    model.month = [NSString stringWithFormat:@"%d",[CGCommonToolsNode getRandomNumber:1 to:3]];
    NSString *toCityName=@"";
    if ([CGSingleCommitData sharedInstance].cityName.length>0) {
        toCityName=[NSString stringWithFormat:@"%@ %@ %@",model.month,NSLocalizedString(@"duoshaogeyuehou", nil),[CGSingleCommitData sharedInstance].cityName];
    }else{
        if ([CGSingleCommitData sharedInstance].countryName.length>0) {
            toCityName=[NSString stringWithFormat:@"%@ %@ %@",model.month,NSLocalizedString(@"duoshaogeyuehou", nil),[CGSingleCommitData sharedInstance].countryName];
        }
    }
    
    model.toContent =toCityName;
    model.shuoshuoContent = [self getShuoshuoContent:model];
    return model;
}


+(NSString *)getShuoshuoContent:(CGShuoShuo *)dic{
    NSString *language = [NSLocale preferredLanguages].firstObject;
    NSString *content=@"";
    if ([language hasPrefix:@"en"]) {
        content = dic.english;
    } else if ([language hasPrefix:@"zh"]) {
        if ([language rangeOfString:@"Hans"].location != NSNotFound) {
            content = dic.content; // 简体中文
        } else { // zh-Hant\zh-HK\zh-TW
            content = dic.tw; // 繁體中文
        }
    }else if ([language hasPrefix:@"fr"]){
        content = dic.france;
    }else if ([language hasPrefix:@"ko"]){
        content = dic.korea;
    }else if ([language hasPrefix:@"ru"]){
        content = dic.russia;
    }else if ([language hasPrefix:@"ja"]){
        content = dic.japan;
    }else if ([language hasPrefix:@"es"]){
        content = dic.spain;
    }else {
        content = dic.english;
    }
    
    return content;
}

+(NSMutableArray *)reloadTableWithRangeFrom:(int)fromNum rangeTLenth:(int)lenth{

    NSArray *data1=[CGSqliteManager allShuoshuoLimitFrom:fromNum withTo:lenth];
    
    NSMutableArray *newData=[NSMutableArray new];
    for (NSDictionary *model in data1) {
        [newData addObject:[self modelWithDic:model]];
    }
    
    return newData;
}

+(NSMutableArray *)reloadTableWithUid:(int)uid WithRangeFrom:(int)fromNum rangeTLenth:(int)lenth{
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"shuoshuo1" ofType:@"plist"];
//    NSMutableArray *data1 = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    NSMutableArray *newData=[NSMutableArray new];
    
    for (NSDictionary *model in [CGSqliteManager getShuoshuouid:uid withLimitFrom:fromNum withTo:lenth]) {
        CGShuoShuo *model1= [self modelWithDic:model];
        if ([model1.uid intValue]==uid) {
            BOOL _isLike=NO;
            for (NSString *content in [CGSingleCommitData sharedInstance].favourites) {
                if (content.length>0) {
                    NSArray *array = [content componentsSeparatedByString:@"-"];
                    if ([array[0] isEqualToString:model1.uid] && [array[1] isEqualToString:model1.sort]) {
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
    CGShuoShuo *model1= [self modelWithDic:[CGSqliteManager getShuoshuoId:[ids intValue]]];
    if ([model1.ids integerValue]==[ids integerValue]) {
        BOOL _isLike=NO;
        for (NSString *content in [CGSingleCommitData sharedInstance].favourites) {
            if (content.length>0) {
                NSArray *array = [content componentsSeparatedByString:@"-"];
                if ([array[0] isEqualToString:model1.uid] && [array[1] isEqualToString:model1.sort]) {
                    _isLike = YES;
                }
            }
        }
        model1.isLike=_isLike;
        
    }
    return model1;
}

+(void)reloadTableRondom{
    int count=[CGSqliteManager getShuoshuoTotalNum];
    
    NSArray *newarr1= [CGCommonToolsNode genertateRandomNumberStartNum:1 endNum:count count:count];
    [CGSingleCommitData sharedInstance].indexDataArr=[newarr1 mutableCopy];
    
    [self reloadTableWithRangeFrom:0 rangeTLenth:10];
    
}


+(NSArray *)getFromString:(NSString *)string withId:(NSString *)ids{
    NSArray *array = [string componentsSeparatedByString:@"/"];
    NSMutableArray *newArr=[NSMutableArray new];
    for (NSString *icon in array) {
       NSString *newIcon= [NSString stringWithFormat:@"%@%@%@%@%@",@"https://raw.githubusercontent.com/Wallenone/service/master/",[CGSingleCommitData sharedInstance].resultName,ids,@"/Enclosure/",icon];
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
        NSString *newIcon= [NSString stringWithFormat:@"%@%@%@%@%@%@%@",@"https://raw.githubusercontent.com/Wallenone/service/master/",[CGSingleCommitData sharedInstance].resultName,ids,@"/Enclosure/",bstr,@".",[array1 objectAtIndex:1]];
        [newArr addObject:newIcon];
    }
    return newArr;
}

+(NSString *)getDateNum:(int)ids{
    NSDate *dateSr = [CGDateData datejisuanYear:0 Month:0 Day:-ids*5 withData:[CGDateData getCurrentTime]];
    NSString *date = [CGDateData DateFormatterDate:dateSr];
    
    return  date;
}
@end
