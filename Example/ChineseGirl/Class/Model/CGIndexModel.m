//
//  CGIndexModel.m
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/11/12.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGIndexModel.h"
#import "CGUserInfo.h"
#import "CGShuoShuo.h"
#import "CGVideoDataModel.h"
#import <AVFoundation/AVFoundation.h>
@implementation CGIndexModel
+ (instancetype)modelWithDic:(NSDictionary *)dic{
    CGIndexModel *model = [[CGIndexModel alloc]init];
    model.uid = [CGCommonString filterNullString:[dic stringForKey:@"uid"]];
    model.month = [CGCommonString filterNullString:[dic stringForKey:@"month"]];
    model.icon =[CGUserInfo getitemWithID:model.uid].avater;
    model.nickName =[CGUserInfo getitemWithID:model.uid].nickname;
    model.birthday =[CGUserInfo getitemWithID:model.uid].birthday;
    NSString *toCityName=@"";
    if ([CGSingleCommitData sharedInstance].cityName.length>0) {
        toCityName=[NSString stringWithFormat:@"%@%@%@",model.month,NSLocalizedString(@"duoshaogeyuehou", nil),[CGSingleCommitData sharedInstance].cityName];
    }else{
        if ([CGSingleCommitData sharedInstance].countryName.length>0) {
            toCityName=[NSString stringWithFormat:@"%@%@%@",model.month,NSLocalizedString(@"duoshaogeyuehou", nil),[CGSingleCommitData sharedInstance].countryName];
        }
    }
    
    model.toContent =toCityName;
    model.address =[CGUserInfo getitemWithID:model.uid].address;
    model.type = [CGCommonString filterNullString:[dic stringForKey:@"type"]];
    model.videoid=[CGCommonString filterNullString:[dic stringForKey:@"videoid"]];
    model.userInfo=[CGUserInfo getitemWithID:model.uid];
    if ([model.type integerValue]==1) {
        model.pictureBigs = [self getBigFromString:[CGCommonString filterNullString:[dic stringForKey:@"bigIcon"]] withId:model.uid];
        model.videoPicUrl=@"";
        model.videoUrl=@"";
    }else if ([model.type integerValue]==2){
        model.videoPicUrl=[CGVideoDataModel reloadTableWithIds:[model.videoid integerValue]].videoIcon;
        model.videoUrl=[CGVideoDataModel reloadTableWithIds:[model.videoid integerValue]].videoUrl;
        model.pictureBigs=@[];
    }
    return model;
}



+(NSMutableArray *)reloadTableWithRangeFrom:(NSInteger)fromNum rangeTLenth:(NSInteger)lenth{
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"plist"];
//    NSMutableArray *data1 = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    NSMutableArray *newData=[NSMutableArray new];
    
    NSInteger currentNum=fromNum+lenth;
    if ([CGSingleCommitData sharedInstance].indexDataArr.count>currentNum) {
        NSMutableArray *data2 = [[[CGSingleCommitData sharedInstance].indexDataArr subarrayWithRange:NSMakeRange(fromNum, lenth)] mutableCopy];
        
        for (NSString *ids in data2) {
            [newData addObject:[CGShuoShuo getTableWithId:ids]];
        }
    }else{
        NSInteger t_num=[CGSingleCommitData sharedInstance].indexDataArr.count-fromNum;
        if (t_num>0) {
            NSMutableArray *data2 = [[[CGSingleCommitData sharedInstance].indexDataArr subarrayWithRange:NSMakeRange(fromNum, [CGSingleCommitData sharedInstance].indexDataArr.count-fromNum)] mutableCopy];
            for (NSString *ids in data2) {
                [newData addObject:[CGShuoShuo getTableWithId:ids]];
            }
        }
        
    }
    
    
    return newData;
}

+(void)reloadTableRondom{
    [CGShuoShuo reloadTableRondom];
}


+(NSArray *)getBigFromString:(NSString *)string withId:(NSString *)ids{
    NSArray *array = [string componentsSeparatedByString:@"/"];
    NSMutableArray *newArr=[NSMutableArray new];
    for (NSString *icon in array) {
        NSArray *array1 = [icon componentsSeparatedByString:@"."];
        NSString *bstr=[[array1 objectAtIndex:0] stringByReplacingOccurrencesOfString:@"S" withString:@"B"];
        NSString *newIcon= [NSString stringWithFormat:@"%@%@%@%@%@%@%@",applocalHost,[CGSingleCommitData sharedInstance].resultName,ids,@"/Enclosure/",bstr,@".",[array1 objectAtIndex:1]];
        [newArr addObject:newIcon];
    }
    return newArr;
}


@end
