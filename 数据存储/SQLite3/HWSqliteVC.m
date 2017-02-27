//
//  HWSqliteVC.m
//  HelloWorld
//
//  Created by Ji Ling on 2017/2/24.
//  Copyright © 2017年 Ji Ling. All rights reserved.
//
#import "HWSqliteVC.h"
#import <sqlite3.h>


#define UIColorFromHex(s,alp)  [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:alp]

@interface HWSqliteVC ()

@end

@implementation HWSqliteVC

static sqlite3 *_db;    //sqlite数据库 _db

static int callback(void *notUsed, int argc,char **argv,char **colName){
    
    printf("argc = %d",argc);
    printf("argc = %s",argv[1]);
    
    return 1;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromHex(0x009966, 1.0);
    
    NSString *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES).firstObject;
    NSLog(@"documentsPath = %@",documentsPath);
    
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"user.sqlite"];
    
    const char *cfilePath = filePath.UTF8String;
    
    //***************************分割线****************************************
    //打开数据库
    int result = sqlite3_open(cfilePath, &_db);    //参数
    if(result == SQLITE_OK){
        NSLog(@"成功打开数据库");

        //[self searchData];
        
    }else{
        NSLog(@"打开数据库失败");
    }
    
    //关闭数据库
    sqlite3_close(_db);
}

//查询数据
- (void)searchData{
    const char *sql = "SELECT * FROM userTable";
    char *erroMsg = NULL;
    int result = sqlite3_exec(_db, sql, callback, NULL, &erroMsg);
    if(result != SQLITE_OK){
        printf("error = %s",erroMsg);
    }
}

//插入数据
- (void)insertData{
    const char *sql = "INSERT INTO userTable (name,age) VALUES('Jack',26)";
    char *erroMsg = NULL;
    int result = sqlite3_exec(_db, sql, NULL, NULL, &erroMsg);
    if(result == SQLITE_OK){
        NSLog(@"插入成功");
    }else{
        printf("error = %s",erroMsg);
    }
    
    const char *sql1 = "INSERT INTO userTable (name,age) VALUES('Tom',18)";
    char *erroMsg1 = NULL;
    int result1 = sqlite3_exec(_db, sql1, NULL, NULL, &erroMsg1);
    if(result1 == SQLITE_OK){
        NSLog(@"插入成功");
    }else{
        printf("error = %s",erroMsg);
    }
    
    const char *sql2 = "INSERT INTO userTable (name,age) VALUES('Lucy',13)";
    char *erroMsg2 = NULL;
    int result2 = sqlite3_exec(_db, sql2, NULL, NULL, &erroMsg2);
    if(result2 == SQLITE_OK){
        NSLog(@"插入成功");
    }else{
        printf("error = %s",erroMsg);
    }
}

//创建表
- (void)createTable{
      const char *sql = "CREATE TABLE IF NOT EXISTS userTable (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, age integer NOT NULL);";
      char *erroMsg = NULL;
      int result = sqlite3_exec(_db, sql, NULL, NULL, &erroMsg);
    
      if (result == SQLITE_OK) {
                NSLog(@"成功创表");
      } else {
                NSLog(@"创表失败--%s", erroMsg);
      }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
