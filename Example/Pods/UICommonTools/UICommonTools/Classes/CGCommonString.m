//
//  CGCommonString.m
//  Huifenqi
//
//  Created by wallen on 2017/10/30.
//  Copyright © 2017年 qiuyu wang. All rights reserved.
//

#import "CGCommonString.h"

@implementation CGCommonString
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
@end
