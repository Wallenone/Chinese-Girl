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
    model.ids = [self filterNullString:[dic stringForKey:@"id"]];
    model.month = [self filterNullString:[dic stringForKey:@"month"]];
    model.icon =[CGUserInfo getitemWithID:model.ids].avater;
    model.nickName =[CGUserInfo getitemWithID:model.ids].nickname;
    model.birthday =[CGUserInfo getitemWithID:model.ids].birthday;
    model.toContent =[NSString stringWithFormat:@"%@个月后去%@",model.month,[CGSingleCommitData sharedInstance].cityName];
    model.address =[CGUserInfo getitemWithID:model.ids].address;
    model.type = [self filterNullString:[dic stringForKey:@"type"]];
    model.videoid=[self filterNullString:[dic stringForKey:@"videoid"]];
    if ([model.type integerValue]==1) {
        model.pictureBigs = [self getBigFromString:[self filterNullString:[dic stringForKey:@"bigIcon"]] withId:model.ids];
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
        for (CGIndexModel *model in data2) {
            [newData addObject:model];
        }
    }else{
        NSInteger t_num=[CGSingleCommitData sharedInstance].indexDataArr.count-fromNum;
        if (t_num>0) {
            NSMutableArray *data2 = [[[CGSingleCommitData sharedInstance].indexDataArr subarrayWithRange:NSMakeRange(fromNum, [CGSingleCommitData sharedInstance].indexDataArr.count-fromNum)] mutableCopy];
            for (CGIndexModel *model in data2) {
                [newData addObject:model];
            }
        }
        
    }
    
    
    return newData;
}

+(void)reloadTableRondom{
    [CGShuoShuo reloadTableRondom];
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
