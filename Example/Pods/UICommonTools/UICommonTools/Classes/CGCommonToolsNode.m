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
    
    //    if (abs(endNum - startNum) > count) {
    //        return nil;
    //    }
    
    NSMutableArray * data = [[NSMutableArray alloc] init];
    for (int i = 0; i < count; i ++) {
        int x = (int)(startNum + (arc4random() % (endNum - startNum + 1)));
        NSNumber * number = [NSNumber numberWithInt:x];
        if (![data containsObject:number]) {
            [data addObject:number];
        }else{
            i = i - 1; //发现有重复则-1
        }
    }
    
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

+ (NSString *)getLongTime:(long long)timestamp
{
    // 创建日历对象
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 获取当前时间
    NSDate *currentDate = [NSDate date];
    
    // 获取当前时间的年、月、日。利用日历
    NSDateComponents *components = [calendar components:NSCalendarUnitYear| NSCalendarUnitMonth|NSCalendarUnitDay fromDate:currentDate];
    NSInteger currentYear = components.year;
    NSInteger currentMonth = components.month;
    NSInteger currentDay = components.day;
    
    // 获取消息发送时间的年、月、日
    NSDate *msgDate = [NSDate dateWithTimeIntervalSince1970:timestamp / 1000.0];
    components = [calendar components:NSCalendarUnitYear| NSCalendarUnitMonth|NSCalendarUnitDay fromDate:msgDate];
    CGFloat msgYear = components.year;
    CGFloat msgMonth = components.month;
    CGFloat msgDay = components.day;
    
    // 进行判断
    NSDateFormatter *dateFmt = [[NSDateFormatter alloc] init];
    if (currentYear == msgYear && currentMonth == msgMonth && currentDay == msgDay) {
        //今天
        dateFmt.dateFormat = @"HH:mm";
    }else if (currentYear == msgYear && currentMonth == msgMonth && currentDay-1 == msgDay ){
        //昨天
        dateFmt.dateFormat = @"昨天 HH:mm";
    }else{
        //昨天以前
        dateFmt.dateFormat = @"MM-dd HH:mm";
    }
    // 返回处理后的结果
    return [dateFmt stringFromDate:msgDate];
}

+(int)getRandomNumber:(int)from to:(int)to
{
    return (int)(from + (arc4random() % (to-from + 1)));
}

//获取当前屏幕显示的viewcontroller
+(UIViewController *)getCurrentVC
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    
    return currentVC;
}

+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        
        rootVC = [rootVC presentedViewController];
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
        
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
        
    } else {
        // 根视图为非导航类
        
        currentVC = rootVC;
    }
    
    return currentVC;
}
@end


