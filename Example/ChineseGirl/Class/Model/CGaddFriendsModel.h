//
//  CGaddFriendsModel.h
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/11/15.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGaddFriendsModel : NSObject
@property(nonatomic,copy)NSString *ids;
@property(nonatomic,copy)NSString *userid;
@property(nonatomic,copy)NSString *avater;
@property(nonatomic,copy)NSString *nickName;
@property(nonatomic,copy)NSString *aboutUs;
@property(nonatomic,strong)NSMutableArray *pictures;
@property(nonatomic,strong)NSMutableArray *picturesBig;
+ (instancetype)modelWithDic:(NSDictionary *)dic;
+(NSMutableArray *)reloadTable;
@end
