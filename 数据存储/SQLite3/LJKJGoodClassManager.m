//
//  LJKJGoodClassManager.m
//  HelloWorld
//
//  Created by Ji Ling on 2017/3/3.
//  Copyright © 2017年 Ji Ling. All rights reserved.
//

#import "LJKJGoodClassManager.h"
#import <sqlite3.h>

@interface LJKJGoodClassManager()

@end

@implementation LJKJGoodClassManager

static LJKJGoodClassManager *singleton = nil;
static NSString *tableName = @"goodTable ";
static NSString *fileName = @"goodClass.sqlite";
static sqlite3 *_db;
static NSMutableArray *backArray;

//查询回调函数
static int callback(void *notUsed, int argc,char **argv,char **colName){
    NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc]init];
    
    for(int i=1;i<argc;i++){
        char *key = colName[i];
        char *value = argv[i];
        NSString *keyString = [NSString stringWithUTF8String:key];
        NSString *valueString = [NSString stringWithUTF8String:value];
        [mutableDic setValue:valueString forKey:keyString];
    }
    
    NSDictionary *dic = [mutableDic copy];
    [backArray addObject:dic];
    return 0;
}

#pragma mark- 数据库管理
//创建数据库及表
- (NSInteger)createTabelWithParameter:(NSDictionary *)dic{
    NSString *tmpPath = NSTemporaryDirectory();
    NSLog(@"tmpPath = %@",tmpPath);
    //拼接数据库文件path
    NSString *filePath = [tmpPath stringByAppendingPathComponent:@"goodClass.sqlite"];
    const char *cfilePath = filePath.UTF8String;
    
    //打开数据库-创建表
    int result = sqlite3_open(cfilePath, &_db);
    if(result == SQLITE_OK){
        NSString *ocSql = @"CREATE TABLE goodTable (id integer PRIMARY KEY AUTOINCREMENT";
        NSArray *keys = [dic allKeys];
        
        for(NSString *key in keys){
            NSString *keySql = [NSString stringWithFormat:@", %@ text",key];
            ocSql = [ocSql stringByAppendingString:keySql];
        }
        
        ocSql = [ocSql stringByAppendingString:@");"];
        
        const char *sql = ocSql.UTF8String;
        char *erroMsg = NULL;
        int result = sqlite3_exec(_db, sql, NULL, NULL, &erroMsg);
        
        if (result == SQLITE_OK) {
            sqlite3_close(_db);
            return 1;
        } else {
            sqlite3_close(_db);
            return 0;
        }
    }else{
        sqlite3_close(_db);
        return -1;
    }
    return -1;
}

//添加数据
- (NSInteger)addDataWith:(NSArray *)dicArray{
    NSString *tmpPath = NSTemporaryDirectory();
    //拼接数据库文件path
    NSString *filePath = [tmpPath stringByAppendingPathComponent:@"goodClass.sqlite"];
    const char *cfilePath = filePath.UTF8String;
    
    //打开数据库
    int result = sqlite3_open(cfilePath, &_db);
    if(result == SQLITE_OK){
    NSString *insertSql0 = @"INSERT INTO goodTable (";
    NSString *insertSql1 =@"";
    NSString *insertSql2 = @") VALUES(";
    NSString *insertSql3 = @"";
        
        for(NSDictionary *dic in dicArray){
            NSArray *keys = [dic allKeys];
            
            NSInteger keysCount = [keys count];
            for(NSInteger i=0;i<keysCount;i++){
                insertSql1 = [insertSql1 stringByAppendingString:[keys objectAtIndex:i]];
                NSString *s1 = @"'";
                s1 = [s1 stringByAppendingString:[dic valueForKey:[keys objectAtIndex:i]]];
                s1 = [s1 stringByAppendingString:@"'"];
                insertSql3 = [insertSql3 stringByAppendingString:s1];
                if(i != (keysCount-1)){
                    insertSql3 = [insertSql3 stringByAppendingString:@","];
                    insertSql1 = [insertSql1 stringByAppendingString:@","];
                }
            }
        }
        
        NSString *ocSql = [NSString stringWithFormat:@"%@%@%@%@);",insertSql0,insertSql1,insertSql2,insertSql3];
        const char *sql = ocSql.UTF8String;
        char *erroMsg = NULL;
        int result = sqlite3_exec(_db, sql, NULL, NULL, &erroMsg);
        if(result == SQLITE_OK){
            sqlite3_close(_db);
            return 1;
        }else{
            sqlite3_close(_db);
            return 0;
        }
        
    }else{
        sqlite3_close(_db);
        return -1;
    }

    return -1;
}

//删除缓存数据库
-(NSInteger)dropTabel{
    NSString *tmpPath = NSTemporaryDirectory();
    //拼接数据库文件path
    NSString *filePath = [tmpPath stringByAppendingPathComponent:@"goodClass.sqlite"];
    const char *cfilePath = filePath.UTF8String;
    
    //打开数据库
    int result = sqlite3_open(cfilePath, &_db);
    if(result == SQLITE_OK){
        NSString *ocSql = @"DROP TABLE goodTable";
        const char* sql = ocSql.UTF8String;
        char *erroMsg = NULL;
        int result = sqlite3_exec(_db, sql, NULL, NULL, &erroMsg);
        if(result == SQLITE_OK){
            sqlite3_close(_db);
            return 1;
        }else{
            sqlite3_close(_db);
            return 0;
        }
        
    }else{
        sqlite3_close(_db);
        return -1;
    }
    return -1;
}

#pragma mark- 搜索查找
//查询所有数据-返回一个多字典数组
-(NSArray *)queryDataWith:(NSDictionary *)parameter{
    NSString *tmpPath = NSTemporaryDirectory();
    //拼接数据库文件path
    NSString *filePath = [tmpPath stringByAppendingPathComponent:@"goodClass.sqlite"];
    const char *cfilePath = filePath.UTF8String;
    
    //打开数据库
    int resultOpen = sqlite3_open(cfilePath, &_db);
    if(resultOpen == SQLITE_OK){
        
        
        backArray = [[NSMutableArray alloc]init];
        
        NSString *ocSql = @"SELECT * FROM goodTable WHERE";
        
        NSArray *keys = [parameter allKeys];
        
        NSInteger count = [keys count];
        
        for(NSInteger i = 0;i<count;i++){
            NSString *key = [keys objectAtIndex:i];
            NSString *value = [parameter valueForKey:key];
            NSString *querySql = [NSString stringWithFormat:@" %@='%@' ",key,value];
            if(i != (count-1)){
                querySql = [querySql stringByAppendingString:@"AND"];
            }
            ocSql = [ocSql stringByAppendingString:querySql];
        }
       
        
        const char *sql = ocSql.UTF8String;
        char *erroMsg = NULL;
        int result = sqlite3_exec(_db, sql, callback, NULL, &erroMsg);
        if(result != SQLITE_OK){
            NSLog(@"query wrong");
            sqlite3_close(_db);
            return nil;
        }
        NSArray *array = [backArray copy];
        sqlite3_close(_db);
        return array;
    }else{
        sqlite3_close(_db);
        return nil;
    }
}


#pragma mark- 单例
+(instancetype)shareManager{
    static dispatch_once_t onceT;
    dispatch_once(&onceT, ^{
        singleton = [[LJKJGoodClassManager alloc]init];
    });
    return singleton;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceT;
    dispatch_once(&onceT, ^{
        singleton = [super allocWithZone:zone];
    });
    return singleton;
}

-(id)copyWithZone:(NSZone *)zone{
    return singleton;
}

-(id)mutableCopyWithZone:(NSZone *)zone{
    return singleton;
}


@end
