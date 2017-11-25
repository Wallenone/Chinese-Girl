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
@implementation CGShuoShuo
+ (instancetype)modelWithDic:(NSDictionary *)dic{
    CGShuoShuo *model = [[CGShuoShuo alloc]init];
    model.ids = [self filterNullString:[dic stringForKey:@"id"]];
    model.sort = [self filterNullString:[dic stringForKey:@"sort"]];
    model.content = [self filterNullString:[dic stringForKey:@"content"]];
    model.pictures =  [self getFromString:[self filterNullString:[dic stringForKey:@"imgs"]] withId:model.ids];
   // model.pictureBigs = [self getBigFromString:[self filterNullString:[dic stringForKey:@"imgs"]] withId:model.ids];
    model.pinglunid = [self getPinglunids:[self filterNullString:[dic stringForKey:@"pinglunid"]]];
    model.icon= [CGUserInfo getitemWithID:model.ids].avater;
    model.nickName = [CGUserInfo getitemWithID:model.ids].nickname;
    model.timeDate = @"1999-09-09";
    model.likes= [self filterNullString:[dic stringForKey:@"likes"]];
    model.comments= [self filterNullString:[dic stringForKey:@"comments"]];
    model.address= [CGUserInfo getitemWithID:model.ids].address;
    model.type = [self filterNullString:[dic stringForKey:@"type"]];
    if ([model.type integerValue]==1) {
        model.pictureBigs = [self getBigFromString:[self filterNullString:[dic stringForKey:@"imgs"]] withId:model.ids];
        model.videoUrl = @"";
        model.videoPic=nil;
    }else if ([model.type integerValue]==2){
        model.videoUrl = [self filterNullString:[dic stringForKey:@"imgs"]];
        model.videoPic=[self thumbnailImageForVideo:[NSURL URLWithString:model.videoUrl] atTime:2.0];
        model.pictureBigs=@[];
    }
    
    return model;
}


+(NSMutableArray *)reloadTableWithRangeFrom:(NSInteger)fromNum rangeTLenth:(NSInteger)lenth{
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"shuoshuo" ofType:@"plist"];
    NSMutableArray *data1;
    if (fromNum==0 && lenth==0) {
        data1=[[NSMutableArray alloc] initWithContentsOfFile:filePath];
    }else{
        data1 = [[[[NSMutableArray alloc] initWithContentsOfFile:filePath] subarrayWithRange:NSMakeRange(fromNum, lenth)] mutableCopy];
    }
    
    NSMutableArray *newData=[NSMutableArray new];
    for (NSDictionary *model in data1) {
        [newData addObject:[self modelWithDic:model]];
    }
    
    return newData;
}

+(NSMutableArray *)reloadTableWithId:(NSInteger)ids{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"shuoshuo" ofType:@"plist"];
    NSMutableArray *data1 = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
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

+(NSString *)filterNullString:(NSString *)str{
    NSString *filterStr=str;
    BOOL filterState= [CGCommonString isBlankString:str];
    if (filterState) {
        filterStr=@"";
    }
    return filterStr;
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
