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
    model.ids = [CGCommonString filterNullString:[dic stringForKey:@"id"]];
    model.type= [CGCommonString filterNullString:[dic stringForKey:@"type"]];
    model.message = [CGCommonString filterNullString:[dic stringForKey:@"message"]];
    model.message_radio = @"";
    model.message_Bigpicture = @"";
    model.message_videoUrl = @"";
    model.message_videoIcon = @"";
    model.message_radioSecond=@"";
    model.message_radioUrl=@"";
    if ([model.type integerValue]==2){
        model.message_radioSecond = @"3";
        model.message_radioUrl = [NSString stringWithFormat:@"%@%@",@"https://raw.githubusercontent.com/Wallenone/service/master/radio/",model.message];
    }else if ([model.type integerValue]==3){
        NSArray *array = [model.message componentsSeparatedByString:@"/"];
        NSArray *array1 = [array[array.count-1] componentsSeparatedByString:@"."];
        NSString *bstr=[[array1 objectAtIndex:0] stringByReplacingOccurrencesOfString:@"S" withString:@"B"];
        NSString *newIcon= [NSString stringWithFormat:@"%@%@%@%@%@%@",@"https://raw.githubusercontent.com/Wallenone/service/master/imgData/",array[0],@"/Enclosure/",bstr,@".",[array1 objectAtIndex:1]];
        model.message=[NSString stringWithFormat:@"%@%@",@"https://raw.githubusercontent.com/Wallenone/service/master/imgData/",model.message];
        model.message_Bigpicture=newIcon;
    }else if ([model.type integerValue]==4){
        CGVideoDataModel *videoModel =[CGVideoDataModel reloadTableWithIds:[model.ids integerValue]];
        model.message_videoUrl = videoModel.videoUrl;
        model.message_videoIcon = videoModel.videoIcon;
    }
    return model;
}

+(CGMessageModel *)reloadReloadRondomIds:(NSString *)ids{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"message" ofType:@"plist"];
    NSMutableArray *data1 = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    CGMessageModel *model=[self modelWithDic:[data1 objectAtIndex:[ids integerValue]-1]];
    
    return model;
}


@end

