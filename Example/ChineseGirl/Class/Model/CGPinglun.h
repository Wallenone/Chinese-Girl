//
//  CGPinglun.h
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/11/12.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGPinglun : NSObject
@property(nonatomic,strong)NSMutableArray *commits;
+(NSMutableArray *)reloadCommits:(NSArray *)commitS;
@end
