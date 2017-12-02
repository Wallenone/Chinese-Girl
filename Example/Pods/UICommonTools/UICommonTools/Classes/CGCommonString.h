//
//  CGCommonString.h
//  Huifenqi
//
//  Created by wallen on 2017/10/30.
//  Copyright © 2017年 qiuyu wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGCommonString : NSObject
+(NSString *)filterNullString:(NSString *)str;
+ (BOOL) isBlankString:(NSString *)string;
+ (NSArray *)genertateRandomNumberStartNum:(int)startNum endNum:(int)endNum count:(int)count;
+ (UIImage*) thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time;
+(int)getRandomNumber:(int)from to:(int)to;
@end
