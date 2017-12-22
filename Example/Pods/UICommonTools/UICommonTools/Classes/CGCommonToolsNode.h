//
//  CGCommonToolsNode.h
//  ChineseGirl
//
//  Created by Wallen on 2017/12/2.
//

#import <Foundation/Foundation.h>

@interface CGCommonToolsNode : NSObject
+ (NSArray *)genertateRandomNumberStartNum:(int)startNum endNum:(int)endNum count:(int)count;
+ (NSString *)getLongTime:(long long)timestamp;
+(int)getRandomNumber:(int)from to:(int)to;
+(UIViewController *)getCurrentVC;
@end
