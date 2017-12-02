//
//  CGCommonToolsNode.m
//  ChineseGirl
//
//  Created by Wallen on 2017/12/2.
//

#import "CGCommonToolsNode.h"

@implementation CGCommonToolsNode
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

@end
