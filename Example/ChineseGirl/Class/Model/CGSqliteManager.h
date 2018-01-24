


#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

#import "FMDB.h"

@interface CGSqliteManager : NSObject

// 获取表中所有的说说:(from)
+ (NSArray *)allShuoshuoLimitFrom:(int)from withTo:(int)to;
+ (NSDictionary *)getShuoshuoId:(int)ids;
+ (int)getShuoshuoTotalNum;
+ (NSMutableArray *)getShuoshuouid:(int)uid withLimitFrom:(int)from withTo:(int)to;
+ (NSMutableArray *)getShuoshuoAll;
//获取表中所有的视频
+ (NSArray *)allVideoDataLimitFrom:(int)from withTo:(int)to;
+ (NSDictionary *)getVideoId:(int)ids;
+ (int)getVideoTotalNum;
+ (NSMutableArray *)getVideouid:(int)uid;
//获取表中所有的评论内容
+ (NSDictionary *)getPinglunrenId:(int)ids;
+ (NSDictionary *)getPinglunId:(int)ids;
//+ (NSString *)getRandomItemCommits;  //随机得到一个item的评论
//+ (void)updateCommitFromShuoshuoId:(int)ids;
@end
