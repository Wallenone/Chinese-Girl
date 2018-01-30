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
+ (UIImage*) thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time;  //取出一个视频中某个时间中的缩略图
//字典转json格式字符串：
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;
//字符串转字典
+(NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString;
@end
