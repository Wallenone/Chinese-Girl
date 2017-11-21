//
//  CGIndexModel.m
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/11/12.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGIndexModel.h"
#import "CGUserInfo.h"
#import <AVFoundation/AVFoundation.h>
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
    model.type = [self filterNullString:[dic stringForKey:@"type"]];
    
    if ([model.type integerValue]==1) {
        model.pictureBigs = [self getBigFromString:[self filterNullString:[dic stringForKey:@"bigIcon"]] withId:model.ids];
        model.videoPic=[UIImage imageNamed:@""];
    }else if ([model.type integerValue]==2){
        model.bigIcon = [self filterNullString:[dic stringForKey:@"bigIcon"]];
        model.videoPic=[self thumbnailImageForVideo:[NSURL URLWithString:model.bigIcon] atTime:2.0];
        model.pictureBigs=@[];
    }
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

+ (UIImage*) thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time {
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetImageGenerator =[[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    
    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTime = time;
    NSError *thumbnailImageGenerationError = nil;
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60)actualTime:NULL error:&thumbnailImageGenerationError];
    
    if(!thumbnailImageRef)
        NSLog(@"thumbnailImageGenerationError %@",thumbnailImageGenerationError);
    
    UIImage*thumbnailImage = thumbnailImageRef ? [[UIImage alloc]initWithCGImage: thumbnailImageRef] : nil;
    
    return thumbnailImage;
}


@end
