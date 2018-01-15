#import "CGSqliteManager.h"
#import <sqlite3.h>
static CGSqliteManager *tool = nil;

@implementation CGSqliteManager

// 创建数据库指针
static sqlite3 *db = nil;

// 打开数据库
+ (sqlite3 *)open {
    
    // 此方法的主要作用是打开数据库
    // 返回值是一个数据库指针
    // 因为这个数据库在很多的SQLite API（函数）中都会用到，我们声明一个类方法来获取，更加方便
    
    // 懒加载
    if (db != nil) {
        return db;
    }
    
     NSString *sqlPath = [[NSBundle mainBundle] pathForResource:@"Shuoshuo" ofType:@"sqlite"];
        
    // 打开数据库需要使用一下函数
    // 第一个参数是数据库的路径（因为需要的是C语言的字符串，而不是NSString所以必须进行转换）
    // 第二个参数是指向指针的指针
    sqlite3_open([sqlPath UTF8String], &db);
    
    return db;
}

// 获取表中保存的所有学生
+ (NSArray *)allShuoshuo {
    
    // 打开数据库
    sqlite3 *db = [CGSqliteManager open];
    
    // 创建一个语句对象
    sqlite3_stmt *stmt = nil;
    
    // 声明数组对象
    NSMutableArray *mArr = nil;
    
    // 此函数的作用是生成一个语句对象，此时sql语句并没有执行，创建的语句对象，保存了关联的数据库，执行的sql语句，sql语句的长度等信息
    int result = sqlite3_prepare_v2(db, "select * from Shuoshuo", -1, &stmt, nil);
    if (result == SQLITE_OK) {
        
        // 为数组开辟空间
        mArr = [NSMutableArray arrayWithCapacity:0];
        
        // SQLite_ROW仅用于查询语句，sqlite3_step()函数执行后的结果如果是SQLite_ROW，说明结果集里面还有数据，会自动跳到下一条结果，如果已经是最后一条数据，再次执行sqlite3_step()，会返回SQLite_DONE，结束整个查询
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            // 获取记录中的字段值
            // 第一个参数是语句对象，第二个参数是字段的下标，从0开始
            int ID = sqlite3_column_int(stmt, 0);
            NSString *sort = ((char *)sqlite3_column_text(stmt, 1)) ?
            [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 1)] :
            nil;
            
            NSString *content = ((char *)sqlite3_column_text(stmt, 2)) ?
            [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 2)] :
            nil;
            
            NSString *videoid = ((char *)sqlite3_column_text(stmt, 3)) ?
            [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 3)] :
            nil;
            
            NSString *imgs = ((char *)sqlite3_column_text(stmt, 4)) ?
            [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 4)] :
            nil;
            
            NSString *pinglunid = ((char *)sqlite3_column_text(stmt, 5)) ?
            [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 5)] :
            nil;
            
            NSString *likes = ((char *)sqlite3_column_text(stmt, 6)) ?
            [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 6)] :
            nil;
            
            NSString *comments = ((char *)sqlite3_column_text(stmt, 7)) ?
            [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 7)] :
            nil;
            
            NSString *type = ((char *)sqlite3_column_text(stmt, 8)) ?
            [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 8)] :
            nil;
            
            NSString *quanzhong = ((char *)sqlite3_column_text(stmt, 9)) ?
            [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 9)] :
            nil;
        
            // 将获取到的C语言字符串转换成OC字符串
            NSString *c_sort = [CGCommonString filterNullString:sort];
            NSString *c_content = [CGCommonString filterNullString:content];
            NSString *c_videoid = [CGCommonString filterNullString:videoid];
            NSString *c_imgs = [CGCommonString filterNullString:imgs];
            NSString *c_pinglunid = [CGCommonString filterNullString:pinglunid];
            NSString *c_likes = [CGCommonString filterNullString:likes];
            NSString *c_comments = [CGCommonString filterNullString:comments];
            NSString *c_type = [CGCommonString filterNullString:type];
            NSString *c_quanzhong = [CGCommonString filterNullString:quanzhong];
            // 添加学生信息到数组中
            [mArr addObject:@{@"id":@(ID),@"sort":c_sort,@"content":c_content,@"videoid":c_videoid,@"imgs":c_imgs,@"pinglunid":c_pinglunid,@"likes":c_likes,@"comments":c_comments,@"type":c_type,@"quanzhong":c_quanzhong}];
        }
    }
    
    // 关闭数据库
    sqlite3_finalize(stmt);
    
    return mArr;
    
}



// 关闭数据库
+ (void)close {
    
    // 关闭数据库
    sqlite3_close(db);
    
    // 将数据库的指针置空
    db = nil;
    
}

@end
