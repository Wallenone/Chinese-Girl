//
//  CGDateData.h
//  ChineseGirl_Example
//
//  Created by wallen on 2018/1/30.
//  Copyright © 2018年 wanjiehuizhaofang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGDateData : NSObject

#pragma mark -得到当前时间
+ (NSDate *)getCurrentTime;
/**
 *  时间算法
 *
 *
 *  @param date  要转换的日期
 *  @param dateFormatterString 日期转换格式 比如@"yyyy-MM-dd HH:mm:ss"
 *
 *  @return 计算好的时间
 */
+(NSString *)DateFormatterDate:(NSDate *)date;

+(NSDate*) convertDateFromString:(NSString*)uiDate;

/**
 *  时间算法
 *
 *  @author Aron
 *  @date 2016-01-06
 *
 *  @param year  计算年=》加1年：1；减1年：-1
 *  @param month 计算月=》加1月：1；减1月：-1
 *  @param day   计算天=》加一周：7；减一周：-7
 *  @param date  要计算的时间
 *
 *  @return 计算好的时间
 */
+(NSDate *)datejisuanYear:(int)year Month:(int)month Day:(int)day withData:(NSDate *)date;

/**
 
 * 开始到结束的时间差(差多少天)
 
 */

+ (int)dateTimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime;
@end
