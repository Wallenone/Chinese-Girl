//
//  CGShuoShuo.h
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/11/12.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGShuoShuo : NSObject
@property(nonatomic,copy)NSString *ids;
@property(nonatomic,copy)NSString *uid;
@property(nonatomic,copy)NSString *sort;
@property(nonatomic,copy)NSString *content;
@property(nonatomic,strong)NSArray *pictures;
@property(nonatomic,strong)NSArray *pictureBigs;
@property(nonatomic,strong)NSArray *pinglunid;
@property(nonatomic,copy)NSString *icon;
@property(nonatomic,copy)NSString *nickName;
@property(nonatomic,copy)NSString *timeDate;
@property(nonatomic,copy)NSString *likes;
@property(nonatomic,copy)NSString *comments;
@property(nonatomic,copy)NSString *address;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *videoUrl;
@property(nonatomic,copy)NSString *videoPicUrl;
@property(nonatomic,copy)NSString *videoid;
@property(nonatomic,copy)NSString *month;
@property(nonatomic,copy)NSString *toContent;
@property(nonatomic,assign)BOOL isLike;   //点赞
+(CGShuoShuo *)getTableWithId:(NSString *)ids;
+ (instancetype)modelWithDic:(NSDictionary *)dic;
+(NSMutableArray *)reloadTableWithId:(int)uid;
+(NSMutableArray *)reloadTableWithRangeFrom:(int)fromNum rangeTLenth:(int)lenth;
+(void)reloadTableRondom;//随机排序说说内容，主要用在首页数据
@end
