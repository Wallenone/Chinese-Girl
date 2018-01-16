//
//  CGVideoDataModel.m
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/11/24.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGVideoDataModel.h"
#import "CGUserInfo.h"
#import "CGSqliteManager.h"
@implementation CGVideoDataModel
+ (instancetype)modelWithDic:(NSDictionary *)dic{
    CGVideoDataModel *model = [[CGVideoDataModel alloc]init];
    model.ids = [CGCommonString filterNullString:[dic stringForKey:@"id"]];
    NSString *videoResource=@"Video";
    if ([model.ids integerValue]>1000 && [model.ids integerValue]<=1999) {
        videoResource=@"Video1";
    }else if ([model.ids integerValue]>2000 && [model.ids integerValue]<=2999){
        videoResource=@"Video2";
    }else if ([model.ids integerValue]>3000 && [model.ids integerValue]<=3999){
        videoResource=@"Video3";
    }else if ([model.ids integerValue]>4000 && [model.ids integerValue]<=4999){
        videoResource=@"Video4";
    }else if ([model.ids integerValue]>5000 && [model.ids integerValue]<=5999){
        videoResource=@"Video5";
    }
    
    model.videoIcon = [NSString stringWithFormat:@"https://raw.githubusercontent.com/Wallenone/service/master/%@/%@/%@",videoResource,model.ids,[CGCommonString filterNullString:[dic stringForKey:@"videoIcon"]]];
    model.videoUrl = [NSString stringWithFormat:@"https://raw.githubusercontent.com/Wallenone/service/master/%@/%@/%@",videoResource,model.ids,[CGCommonString filterNullString:[dic stringForKey:@"videoUrl"]]];
    model.userId = [CGCommonString filterNullString:[dic stringForKey:@"userid"]];
    model.nickName=[CGUserInfo getitemWithID:model.userId].nickname;
    return model;
}

+(NSMutableArray *)reloadTableWithRangeFrom:(NSInteger)fromNum rangeTLenth:(NSInteger)lenth{
    
//    NSMutableArray *data2= [[NSMutableArray alloc] init];
//    NSMutableArray *newData=[NSMutableArray new];
//
//    for (int i=0; i<[CGSingleCommitData sharedInstance].videoListDataArr.count; i++) {
//        if (i%2!=0) {
//            NSMutableArray *newData2=[[NSMutableArray alloc] init];
//            [newData2 addObject:[[CGSingleCommitData sharedInstance].videoListDataArr objectAtIndex:i-1]];
//            [newData2 addObject:[[CGSingleCommitData sharedInstance].videoListDataArr objectAtIndex:i]];
//            [data2 addObject:newData2];
//        }
//    }
//
//    NSInteger currentNum=fromNum+lenth;
//    if (data2.count>currentNum) {
//        newData = [[data2 subarrayWithRange:NSMakeRange(fromNum, lenth)] mutableCopy];
//    }else{
//        NSInteger t_num=data2.count-fromNum;
//        if (t_num>0) {
//            newData = [[data2 subarrayWithRange:NSMakeRange(fromNum, t_num)] mutableCopy];
//        }
//
//    }
//
//
//
//
//    return newData;
    
    NSMutableArray *DataArr= [[NSMutableArray alloc] init];
    NSMutableArray *newData=[NSMutableArray new];
    
    NSInteger currentNum=fromNum+lenth;
    if ([CGSingleCommitData sharedInstance].videoListDataArr.count>currentNum) {
        newData = [[[CGSingleCommitData sharedInstance].videoListDataArr subarrayWithRange:NSMakeRange(fromNum, lenth)] mutableCopy];
    }else{
        NSInteger t_num=[CGSingleCommitData sharedInstance].videoListDataArr.count-fromNum;
        if (t_num>0) {
            newData = [[[CGSingleCommitData sharedInstance].videoListDataArr subarrayWithRange:NSMakeRange(fromNum, t_num)] mutableCopy];
        }
        
    }
    for (int i=0; i<newData.count; i++) {
        if (i%2!=0) {
            NSMutableArray *data2=[[NSMutableArray alloc] init];
            [data2 addObject:[self modelWithDic:[CGSqliteManager getVideoId:[[newData objectAtIndex:i-1] intValue]]]];
            [data2 addObject:[self modelWithDic:[CGSqliteManager getVideoId:[[newData objectAtIndex:i] intValue]]]];
            [DataArr addObject:data2];
        }
    }
 
    return DataArr;
}

+(void)updateReloadRondom{
    int count=1877;
    
    NSArray *newarr1= [CGCommonToolsNode genertateRandomNumberStartNum:1 endNum:count count:count];
    [CGSingleCommitData sharedInstance].videoListDataArr=[newarr1 mutableCopy];
    
    [self reloadTableWithRangeFrom:0 rangeTLenth:20];
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

@end
