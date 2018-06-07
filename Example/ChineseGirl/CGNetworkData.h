//
//  CGNetworkData.h
//  ChineseGirl_Example
//
//  Created by wallen on 2018/5/25.
//  Copyright © 2018年 wanjiehuizhaofang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGNetworkData : NSObject
+(void)postData:(NSDictionary *)dict withUrl:(NSString *)url;
@end
