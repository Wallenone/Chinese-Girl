//
//  CGVideoDataModel.m
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/11/24.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGVideoDataModel.h"
#import "CGUserInfo.h"
@implementation CGVideoDataModel
+ (instancetype)modelWithDic:(NSDictionary *)dic{
    CGVideoDataModel *model = [[CGVideoDataModel alloc]init];
    model.ids = [self filterNullString:[dic stringForKey:@"id"]];
    NSString *videoResource=@"Video";
    if ([model.ids integerValue]>1000) {
        videoResource=@"Video1";
    }
    
    model.videoIcon = [NSString stringWithFormat:@"https://raw.githubusercontent.com/Wallenone/service/master/%@/%@/%@",videoResource,model.ids,[self filterNullString:[dic stringForKey:@"videoIcon"]]];
    model.videoUrl = [NSString stringWithFormat:@"https://raw.githubusercontent.com/Wallenone/service/master/%@/%@/%@",videoResource,model.ids,[self filterNullString:[dic stringForKey:@"videoUrl"]]];
    model.userId = [self filterNullString:[dic stringForKey:@"userid"]];
    model.nickName=[CGUserInfo getitemWithID:model.userId].nickname;
    return model;
}

+(NSMutableArray *)reloadTableWithRangeFrom:(NSInteger)fromNum rangeTLenth:(NSInteger)lenth{
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"videoData" ofType:@"plist"];
//    NSMutableArray *data1 = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    NSMutableArray *data2= [[NSMutableArray alloc] init];
    NSMutableArray *newData=[NSMutableArray new];
    
    for (int i=0; i<[CGSingleCommitData sharedInstance].videoListDataArr.count; i++) {
        if (i%2!=0) {
            NSMutableArray *newData2=[[NSMutableArray alloc] init];
            [newData2 addObject:[[CGSingleCommitData sharedInstance].videoListDataArr objectAtIndex:i-1]];
            [newData2 addObject:[[CGSingleCommitData sharedInstance].videoListDataArr objectAtIndex:i]];
            [data2 addObject:newData2];
        }
    }
    
    NSInteger currentNum=fromNum+lenth;
    if (data2.count>currentNum) {
        newData = [[data2 subarrayWithRange:NSMakeRange(fromNum, lenth)] mutableCopy];
    }else{
        NSInteger t_num=data2.count-fromNum;
        if (t_num>0) {
            newData = [[data2 subarrayWithRange:NSMakeRange(fromNum, t_num)] mutableCopy];
        }
        
    }
    
    return newData;
}

+(void)updateReloadRondom{
    [CGSingleCommitData sharedInstance].videoListDataArr= [[self reloadTableRondomCount:99999999] mutableCopy];
}

+(NSArray *)reloadTableRondomCount:(NSInteger)count{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"videoData" ofType:@"plist"];
    NSMutableArray *data1 = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    NSMutableArray *newData=[NSMutableArray new];
    
    if (count>data1.count) {
       NSArray *newarr1= [CGCommonToolsNode genertateRandomNumberStartNum:0 endNum:(int)(data1.count)-1 count:(int)data1.count];
        for (NSString *ids in newarr1) {
           [newData addObject:[self modelWithDic:[data1 objectAtIndex:[ids integerValue]]]];
        }
    }else{
        NSArray *newarr2 = [[CGCommonToolsNode genertateRandomNumberStartNum:0 endNum:(int)(data1.count)-1 count:(int)count] mutableCopy];
        for (NSString *ids in newarr2) {
            [newData addObject:[self modelWithDic:[data1 objectAtIndex:[ids integerValue]]]];
        }
    }
    
    return newData;
}

+(CGVideoDataModel *)reloadTableWithIds:(NSInteger)ids{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"videoData" ofType:@"plist"];
    NSMutableArray *data1 = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    CGVideoDataModel *videoModel;
    if (ids-1<=data1.count) {
        videoModel=[CGVideoDataModel modelWithDic:[data1 objectAtIndex:ids-1]];
    }
    
    return videoModel;
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
