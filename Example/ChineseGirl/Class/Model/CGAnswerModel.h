//
//  CGAnswerModel.h
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/11/17.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGAnswerModel : NSObject
@property(nonatomic,copy)NSString *ids;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *answercontent;
@property(nonatomic,strong)NSArray *answerArr;
+ (instancetype)modelWithDic:(NSDictionary *)dic;
+(NSMutableArray *)reloadTable;
@end
