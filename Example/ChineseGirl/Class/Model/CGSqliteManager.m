#import "CGSqliteManager.h"
#import "CGShuoShuo.h"
#import <sqlite3.h>
static CGSqliteManager *tool = nil;

@implementation CGSqliteManager

// 创建数据库指针
static sqlite3 *t_db = nil;

// 打开数据库
+ (sqlite3 *)open:(NSString *)dbname {
    if (t_db != nil) {
        return t_db;
    }
    
//    NSString *pathDocuments = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
//    NSString *sqlPath = [NSString stringWithFormat:@"%@/%@.sqlite",pathDocuments,dbname];
    
    
     NSString *sqlPath = [[NSBundle mainBundle] pathForResource:dbname ofType:@"sqlite"];

    sqlite3_open([sqlPath UTF8String], &t_db);
    
    return t_db;
}

+ (NSDictionary *)getShuoshuoId:(int)ids{
    NSDictionary *shuoshuoModel;
    // 打开数据库
    sqlite3 *db = [CGSqliteManager open:@"Shuoshuo"];
    // 创建一个语句对象
    sqlite3_stmt *stmt = nil;
    
    // 此函数的作用是生成一个语句对象，此时sql语句并没有执行，创建的语句对象，保存了关联的数据库，执行的sql语句，sql语句的长度等信息
    const char *sql=[[NSString stringWithFormat:@"select * from Shuoshuo where id=%d",ids] UTF8String];
    int result = sqlite3_prepare_v2(db, sql, -1, &stmt, nil);
    if (result == SQLITE_OK){
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            shuoshuoModel=[self getShuoshuoModel:stmt];
        }

    }
   
    // 关闭数据库
    sqlite3_finalize(stmt);
    [self close];
    
    return shuoshuoModel;
}


+ (NSMutableArray *)getShuoshuouid:(int)uid withLimitFrom:(int)from withTo:(int)to{
    // 打开数据库
    sqlite3 *db = [CGSqliteManager open:@"Shuoshuo"];
    // 创建一个语句对象
    sqlite3_stmt *stmt = nil;
    
    // 声明数组对象
    NSMutableArray *mArr = nil;
    // 此函数的作用是生成一个语句对象，此时sql语句并没有执行，创建的语句对象，保存了关联的数据库，执行的sql语句，sql语句的长度等信息
    const char *sql=[[NSString stringWithFormat:@"select * from Shuoshuo where uid=%d limit %d,%d",uid,from,to] UTF8String];
    int result = sqlite3_prepare_v2(db, sql, -1, &stmt, nil);
    if (result == SQLITE_OK){
        // 为数组开辟空间
        mArr = [NSMutableArray arrayWithCapacity:0];
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            [mArr addObject:[self getShuoshuoModel:stmt]];
        }
        
    }
    
    // 关闭数据库
    sqlite3_finalize(stmt);
    [self close];
    return mArr;
}

+ (NSMutableArray *)getShuoshuoAll{
    // 打开数据库
    sqlite3 *db = [CGSqliteManager open:@"Shuoshuo"];
    // 创建一个语句对象
    sqlite3_stmt *stmt = nil;
    
    // 声明数组对象
    NSMutableArray *mArr = nil;
    // 此函数的作用是生成一个语句对象，此时sql语句并没有执行，创建的语句对象，保存了关联的数据库，执行的sql语句，sql语句的长度等信息
    const char *sql=[[NSString stringWithFormat:@"select * from Shuoshuo"] UTF8String];
    int result = sqlite3_prepare_v2(db, sql, -1, &stmt, nil);
    if (result == SQLITE_OK){
        // 为数组开辟空间
        mArr = [NSMutableArray arrayWithCapacity:0];
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            [mArr addObject:[self getShuoshuoModel:stmt]];
        }
        
    }
    
    // 关闭数据库
    sqlite3_finalize(stmt);
    [self close];
    return mArr;
}

+ (int)getShuoshuoTotalNum{
    
    return [self getTotalNumTable:@"Shuoshuo"];
}

+(NSDictionary *)getShuoshuoModel:(sqlite3_stmt *)stmt{
    NSDictionary *shuoshuoModel;
    
    NSString *ID = ((char *)sqlite3_column_text(stmt, 0)) ?
    [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 0)] :
    nil;
    
    NSString *uid = ((char *)sqlite3_column_text(stmt, 1)) ?
    [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 1)] :
    nil;
    
    NSString *sort = ((char *)sqlite3_column_text(stmt, 2)) ?
    [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 2)] :
    nil;
    
    NSString *english = ((char *)sqlite3_column_text(stmt, 3)) ?
    [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 3)] :
    nil;
    
    NSString *france = ((char *)sqlite3_column_text(stmt, 4)) ?
    [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 4)] :
    nil;
    
    NSString *spain = ((char *)sqlite3_column_text(stmt, 5)) ?
    [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 5)] :
    nil;
    
    NSString *russia = ((char *)sqlite3_column_text(stmt, 6)) ?
    [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 6)] :
    nil;
    
    NSString *tw = ((char *)sqlite3_column_text(stmt, 7)) ?
    [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 7)] :
    nil;
    
    NSString *korea = ((char *)sqlite3_column_text(stmt, 8)) ?
    [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 8)] :
    nil;
    
    NSString *japan = ((char *)sqlite3_column_text(stmt, 9)) ?
    [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 9)] :
    nil;
    
    NSString *content = ((char *)sqlite3_column_text(stmt, 10)) ?
    [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 10)] :
    nil;
    
    NSString *videoid = ((char *)sqlite3_column_text(stmt, 11)) ?
    [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 11)] :
    nil;
    
    NSString *imgs = ((char *)sqlite3_column_text(stmt, 12)) ?
    [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 12)] :
    nil;
    
    NSString *pinglunid = ((char *)sqlite3_column_text(stmt, 13)) ?
    [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 13)] :
    nil;
    
    NSString *likes = ((char *)sqlite3_column_text(stmt, 14)) ?
    [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 14)] :
    nil;
    
    NSString *comments = ((char *)sqlite3_column_text(stmt, 15)) ?
    [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 15)] :
    nil;
    
    NSString *type = ((char *)sqlite3_column_text(stmt, 16)) ?
    [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 16)] :
    nil;
    
    NSString *quanzhong = ((char *)sqlite3_column_text(stmt, 17)) ?
    [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 17)] :
    nil;
    
    // 将获取到的C语言字符串转换成OC字符串
    NSString *c_uid = [CGCommonString filterNullString:uid];
    NSString *c_sort = [CGCommonString filterNullString:sort];
    NSString *c_english = [CGCommonString filterNullString:english];
    NSString *c_france = [CGCommonString filterNullString:france];
    NSString *c_spain = [CGCommonString filterNullString:spain];
    NSString *c_russia = [CGCommonString filterNullString:russia];
    NSString *c_tw = [CGCommonString filterNullString:tw];
    NSString *c_korea = [CGCommonString filterNullString:korea];
    NSString *c_japan = [CGCommonString filterNullString:japan];
    NSString *c_content = [CGCommonString filterNullString:content];
    NSString *c_videoid = [CGCommonString filterNullString:videoid];
    NSString *c_imgs = [CGCommonString filterNullString:imgs];
    NSString *c_pinglunid = [CGCommonString filterNullString:pinglunid];
    NSString *c_likes = [CGCommonString filterNullString:likes];
    NSString *c_comments = [CGCommonString filterNullString:comments];
    NSString *c_type = [CGCommonString filterNullString:type];
    NSString *c_quanzhong = [CGCommonString filterNullString:quanzhong];
    
    shuoshuoModel= @{@"id":ID,@"uid":c_uid,@"sort":c_sort,@"english":c_english,@"france":c_france,@"spain":c_spain,@"russia":c_russia,@"tw":c_tw,@"korea":c_korea,@"japan":c_japan,@"content":c_content,@"videoid":c_videoid,@"imgs":c_imgs,@"pinglunid":c_pinglunid,@"likes":c_likes,@"comments":c_comments,@"type":c_type,@"quanzhong":c_quanzhong};
    return shuoshuoModel;
}

+ (NSArray *)allShuoshuoLimitFrom:(int)from withTo:(int)to{
    // 打开数据库
    sqlite3 *db = [CGSqliteManager open:@"Shuoshuo"];
    
    // 创建一个语句对象
    sqlite3_stmt *stmt = nil;
    
    // 声明数组对象
    NSMutableArray *mArr = nil;
    
    // 此函数的作用是生成一个语句对象，此时sql语句并没有执行，创建的语句对象，保存了关联的数据库，执行的sql语句，sql语句的长度等信息
    const char *sql=[[NSString stringWithFormat:@"select * from Shuoshuo limit %d,%d",from,to] UTF8String];
    int result = sqlite3_prepare_v2(db, sql, -1, &stmt, nil);
    if (result == SQLITE_OK) {
        
        // 为数组开辟空间
        mArr = [NSMutableArray arrayWithCapacity:0];
        
        // SQLite_ROW仅用于查询语句，sqlite3_step()函数执行后的结果如果是SQLite_ROW，说明结果集里面还有数据，会自动跳到下一条结果，如果已经是最后一条数据，再次执行sqlite3_step()，会返回SQLite_DONE，结束整个查询
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            [mArr addObject:[self getShuoshuoModel:stmt]];
        }
    }
    
    // 关闭数据库
    sqlite3_finalize(stmt);
    [self close];
    return mArr;
}


+ (NSArray *)allVideoDataLimitFrom:(int)from withTo:(int)to{
    
    // 打开数据库
    sqlite3 *db = [CGSqliteManager open:@"videoData"];
    
    // 创建一个语句对象
    sqlite3_stmt *stmt = nil;
    
    // 声明数组对象
    NSMutableArray *mArr = nil;
    
    // 此函数的作用是生成一个语句对象，此时sql语句并没有执行，创建的语句对象，保存了关联的数据库，执行的sql语句，sql语句的长度等信息
    const char *sql=[[NSString stringWithFormat:@"select * from Shuoshuo limit %d,%d",from,to] UTF8String];
    int result = sqlite3_prepare_v2(db, sql, -1, &stmt, nil);
    if (result == SQLITE_OK) {
        
        // 为数组开辟空间
        mArr = [NSMutableArray arrayWithCapacity:0];
        
        // SQLite_ROW仅用于查询语句，sqlite3_step()函数执行后的结果如果是SQLite_ROW，说明结果集里面还有数据，会自动跳到下一条结果，如果已经是最后一条数据，再次执行sqlite3_step()，会返回SQLite_DONE，结束整个查询
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            // 获取记录中的字段值
            // 第一个参数是语句对象，第二个参数是字段的下标，从0开始
            int ID = sqlite3_column_int(stmt, 0);
            NSString *videoIcon = ((char *)sqlite3_column_text(stmt, 1)) ?
            [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 1)] :
            nil;
            
            NSString *videoUrl = ((char *)sqlite3_column_text(stmt, 2)) ?
            [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 2)] :
            nil;
            
            NSString *userid = ((char *)sqlite3_column_text(stmt, 3)) ?
            [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 3)] :
            nil;
            
            
        
            // 将获取到的C语言字符串转换成OC字符串
            NSString *c_videoIcon = [CGCommonString filterNullString:videoIcon];
            NSString *c_videoUrl = [CGCommonString filterNullString:videoUrl];
            NSString *c_userid = [CGCommonString filterNullString:userid];
            [mArr addObject:@{@"id":@(ID),@"videoIcon":c_videoIcon,@"videoUrl":c_videoUrl,@"userid":c_userid}];
        }
    }
    // 关闭数据库
    sqlite3_finalize(stmt);
    [self close];
    return mArr;
}

+ (NSDictionary *)getVideoId:(int)ids{
    NSDictionary *videoModel;
    // 打开数据库
    sqlite3 *db = [CGSqliteManager open:@"VideoData"];
    // 创建一个语句对象
    sqlite3_stmt *stmt = nil;
    
    // 此函数的作用是生成一个语句对象，此时sql语句并没有执行，创建的语句对象，保存了关联的数据库，执行的sql语句，sql语句的长度等信息
    const char *sql=[[NSString stringWithFormat:@"select * from VideoData where id=%d",ids] UTF8String];
    int result = sqlite3_prepare_v2(db, sql, -1, &stmt, nil);
    if (result == SQLITE_OK){
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            videoModel=[self getVideoModel:stmt];
        }
        
    }else {
        NSAssert1(0,@"Error:%s",sqlite3_errmsg(db));
    }
    
    // 关闭数据库
    sqlite3_finalize(stmt);
    [self close];
    return videoModel;
}

+ (int)getVideoTotalNum{
    return [self getTotalNumTable:@"VideoData"];
}

+ (NSMutableArray *)getVideouid:(int)uid{
    // 打开数据库
    sqlite3 *db = [CGSqliteManager open:@"VideoData"];
    // 创建一个语句对象
    sqlite3_stmt *stmt = nil;
    
    // 声明数组对象
    NSMutableArray *mArr = nil;
    // 此函数的作用是生成一个语句对象，此时sql语句并没有执行，创建的语句对象，保存了关联的数据库，执行的sql语句，sql语句的长度等信息
    const char *sql=[[NSString stringWithFormat:@"select * from VideoData where uid=%d",uid] UTF8String];
    int result = sqlite3_prepare_v2(db, sql, -1, &stmt, nil);
    if (result == SQLITE_OK){
        // 为数组开辟空间
        mArr = [NSMutableArray arrayWithCapacity:0];
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            [mArr addObject:[self getVideoModel:stmt]];
        }
        
    }
    
    // 关闭数据库
    sqlite3_finalize(stmt);
    [self close];
    return mArr;
}


+(NSDictionary *)getVideoModel:(sqlite3_stmt *)stmt{
    NSDictionary *videoModel;
    
    int ID = sqlite3_column_int(stmt, 0);
    NSString *videoIcon = ((char *)sqlite3_column_text(stmt, 1)) ?
    [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 1)] :
    nil;
    
    NSString *videoUrl = ((char *)sqlite3_column_text(stmt, 2)) ?
    [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 2)] :
    nil;
    
    NSString *userid = ((char *)sqlite3_column_text(stmt, 3)) ?
    [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 3)] :
    nil;
    
    
    
    // 将获取到的C语言字符串转换成OC字符串
    NSString *c_videoIcon = [CGCommonString filterNullString:videoIcon];
    NSString *c_videoUrl = [CGCommonString filterNullString:videoUrl];
    NSString *c_userid = [CGCommonString filterNullString:userid];
    videoModel= @{@"id":@(ID),@"videoIcon":c_videoIcon,@"videoUrl":c_videoUrl,@"userid":c_userid};
    
    return videoModel;
}


+ (NSDictionary *)getPinglunrenId:(int)ids{
    NSDictionary *pinglunrenModel;
    // 打开数据库
    sqlite3 *db = [CGSqliteManager open:@"Pinglunren"];
    // 创建一个语句对象
    sqlite3_stmt *stmt = nil;
    
    // 此函数的作用是生成一个语句对象，此时sql语句并没有执行，创建的语句对象，保存了关联的数据库，执行的sql语句，sql语句的长度等信息
    const char *sql=[[NSString stringWithFormat:@"select * from Pinglunren where id=%d",ids] UTF8String];
    int result = sqlite3_prepare_v2(db, sql, -1, &stmt, nil);
    if (result == SQLITE_OK){
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            int ID = sqlite3_column_int(stmt, 0);
            NSString *username = ((char *)sqlite3_column_text(stmt, 1)) ?
            [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 1)] :
            nil;
            
            NSString *avater = ((char *)sqlite3_column_text(stmt, 2)) ?
            [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 2)] :
            nil;
            
            // 将获取到的C语言字符串转换成OC字符串
            NSString *c_username = [CGCommonString filterNullString:username];
            NSString *c_avater = [CGCommonString filterNullString:avater];
            
            pinglunrenModel= @{@"id":@(ID),@"username":c_username,@"avater":c_avater};
        }
        
    }
    
    // 关闭数据库
    sqlite3_finalize(stmt);
    [self close];
    return pinglunrenModel;
}
+ (NSDictionary *)getPinglunId:(int)ids{
    NSDictionary *pinglunModel;
    // 打开数据库
    sqlite3 *db = [CGSqliteManager open:@"Pinglun"];
    // 创建一个语句对象
    sqlite3_stmt *stmt = nil;
    
    // 此函数的作用是生成一个语句对象，此时sql语句并没有执行，创建的语句对象，保存了关联的数据库，执行的sql语句，sql语句的长度等信息
    const char *sql=[[NSString stringWithFormat:@"select * from Pinglun where id=%d",ids] UTF8String];
    int result = sqlite3_prepare_v2(db, sql, -1, &stmt, nil);
    if (result == SQLITE_OK){
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            int ID = sqlite3_column_int(stmt, 0);
            NSString *content = ((char *)sqlite3_column_text(stmt, 1)) ?
            [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 1)] :
            nil;
            
            // 将获取到的C语言字符串转换成OC字符串
            NSString *c_content = [CGCommonString filterNullString:content];
            
            pinglunModel= @{@"id":@(ID),@"content":c_content};
        }
        
    }
    
    // 关闭数据库
    sqlite3_finalize(stmt);
    [self close];
    return pinglunModel;
}

//+(int)getPinglunTotalNum{
//    return 461;
//}
//
//+(int)getPinglunRenTotalNum{
//    return 108;
//}
//
//
//+ (NSString *)getRandomItemCommits{
//    NSString *commitStr=@"";
//    int totalNum=[CGCommonToolsNode getRandomNumber:2 to:20];
//    NSArray *rodomPinglunrenArr= [CGCommonToolsNode genertateRandomNumberStartNum:1 endNum:[self getPinglunRenTotalNum] count:totalNum];
//    
//    NSArray *rodomPinglunArr= [CGCommonToolsNode genertateRandomNumberStartNum:1 endNum:[self getPinglunTotalNum] count:totalNum];
//    
//    for (int i=0; i<rodomPinglunrenArr.count; i++) {
//        int pinglunrenId=[[rodomPinglunrenArr objectAtIndex:i] intValue];
//        int pinglunId=[[rodomPinglunArr objectAtIndex:i] intValue];
//        
//        if (i==rodomPinglunrenArr.count-1) {
//            commitStr=[NSString stringWithFormat:@"%@%d-%d",commitStr,pinglunrenId,pinglunId];
//        }else{
//            commitStr=[NSString stringWithFormat:@"%@%d-%d/",commitStr,pinglunrenId,pinglunId];
//        }
//        
//        
//    }
//    
//    return commitStr;
//}

+ (int)getTotalNumTable:(NSString *)table{
    sqlite3 *db = [CGSqliteManager open:table];
    char *errmsg=NULL;    //用来存储错误信息字符串
    char ret=0;
    char **dbResult;
    int nRow=0, nColumn=0;     //nRow 查找出的总行数,nColumn 存储列
    
    const char *sql=[[NSString stringWithFormat:@"select * from %@",table] UTF8String];
    
    ret=sqlite3_get_table(db, sql, &dbResult, &nRow, &nColumn, &errmsg);
    
    NSLog(@"num:=%d",nRow);
    
    if(1 == ret)     //数据库创建未成功
    {
        fprintf(stderr, "Can't open this database: %s\n", sqlite3_errmsg(db));    //用sqlite3_errmsg()得到错误字符串
        [self close];
        return -1;
    }
    
    
    
    if(NULL!=errmsg)
    {
        sqlite3_free_table(dbResult);
        errmsg=NULL;
        [self close];
        return -1;
    }
    
    sqlite3_free_table(dbResult);
    [self close];
    return nRow;
}


// 关闭数据库
+ (void)close {
    // 关闭数据库
    sqlite3_close(t_db);
    // 将数据库的指针置空
    t_db = nil;
}

@end
