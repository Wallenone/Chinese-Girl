//
//  CGCommonString.m
//  Huifenqi
//
//  Created by wallen on 2017/10/30.
//  Copyright © 2017年 qiuyu wang. All rights reserved.
//

#import "CGCommonString.h"
#import <AVFoundation/AVFoundation.h>
@implementation CGCommonString
+(NSString *)filterNullString:(NSString *)str{
    NSString *filterStr=str;
    BOOL filterState= [self isBlankString:str];
    if (filterState) {
        filterStr=@"";
    }
    return filterStr;
}

+ (BOOL) isBlankString:(NSString *)string {
    string=[string stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (string == nil || string == NULL || [string isEqualToString:@"<null>"]) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

+ (NSArray *)genertateRandomNumberStartNum:(int)startNum endNum:(int)endNum count:(int)count
{
    if (startNum > endNum) {
        return nil;
    }
    
    if (abs(endNum - startNum) > count) {
        return nil;
    }
    
    NSMutableArray * data = [[NSMutableArray alloc] init];
    for (int i = 0; i < count; i ++) {
        int x = (int)(startNum + (arc4random() % (endNum - startNum + 1)));
        NSLog(@"x:%d",x);
        NSNumber * number = [NSNumber numberWithInt:x];
        if (![data containsObject:number]) {
            [data addObject:number];
        }else{
            i = i - 1; //发现有重复则-1
        }
    }
    
    NSLog(@"data:%@",data);
    return (NSArray *)data;
    
    //排序
    NSNumber * temp;
    for (int i = 0; i < [data count]; i++) {
        for (int j = 0; j < i; j++) {
            if ([[data objectAtIndex:i] intValue] < [[data objectAtIndex:j] intValue]) {
                temp = [data objectAtIndex:i];
                [data replaceObjectAtIndex:i withObject:[data objectAtIndex:j]];
                [data replaceObjectAtIndex:j withObject:temp];
            }
        }
    }
    for (int i = 0; i < [data count]; i ++) {
        NSLog(@"intValue:::%d",[[data objectAtIndex:i] intValue]);
    }
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

+(int)getRandomNumber:(int)from to:(int)to
{
    return (int)(from + (arc4random() % (to-from + 1)));
}
@end
