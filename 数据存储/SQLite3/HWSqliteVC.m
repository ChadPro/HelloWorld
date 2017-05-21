//
//  HWSqliteVC.m
//  HelloWorld
//
//  Created by Ji Ling on 2017/2/24.
//  Copyright © 2017年 Ji Ling. All rights reserved.
//
#import "HWSqliteVC.h"
#import <sqlite3.h>
#import "LJKJGoodClassManager.h"


#define UIColorFromHex(s,alp)  [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:alp]

@interface HWSqliteVC ()

@end

@implementation HWSqliteVC

static sqlite3 *_db;    //sqlite数据库 _db

static int callback(void *notUsed, int argc,char **argv,char **colName){
    //printf("argc = %d \n",argc);
    //printf("id = %s \n",argv[0]);
    printf("name = %s \n",argv[1]);
    printf("num = %s \n",argv[4]);
    return 0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromHex(0x009966, 1.0);


//    LJKJGoodClassManager *manager = [LJKJGoodClassManager shareManager];
//    
//    NSDictionary *dic = @{@"name":@"iPhone5s-black",@"type":@"4",@"color":@"black",@"num":@"2"};
//    [manager createTabelWithParameter:dic];
//    NSArray *array = [NSArray arrayWithObjects:dic, nil];
//    [manager addDataWith:array];
//    
//      NSInteger result = [manager dropTabel];
//      NSLog(@"result = %ld",result);
//    
//    NSDictionary *dic = @{@"type":@"4",@"color":@"black"};
//    NSArray *array = [manager queryDataWith:dic];
//    NSLog(@"goods = %@",array);
    


    
//    NSString *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES).firstObject;
//    //NSLog(@"documentsPath = %@",documentsPath);
//    
//    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"user.sqlite"];
//    
//    const char *cfilePath = filePath.UTF8String;
//    
//    //***************************分割线****************************************
//    //打开数据库
//    int result = sqlite3_open(cfilePath, &_db);    //参数
//    if(result == SQLITE_OK){
//        NSLog(@"成功打开数据库");
//
//        [self searchData2];
//
//        
//    }else{
//        NSLog(@"打开数据库失败");
//    }
//    
//
//    //关闭数据库
//    sqlite3_close(_db);
}

//查询数据-id
- (void)searchData{
    const char *sql = "SELECT name FROM iPhone";
    char *erroMsg = NULL;
    int result = sqlite3_exec(_db, sql, callback, NULL, &erroMsg);
    if(result != SQLITE_OK){
        printf("error = %s",erroMsg);
    }
}

//查询数据-color and type
- (void)searchData2{
    const char *sql = "select * from iPhone where color = 'black' AND type = '4'";
    char *erroMsg = NULL;
    int result = sqlite3_exec(_db, sql, callback, NULL, &erroMsg);
    if(result != SQLITE_OK){
        printf("error = %s",erroMsg);
    }
}

//插入数据
- (void)insertData{
    const char *sql = "INSERT INTO iPhone (name,type,color,num) VALUES('iPhone5s-gold','4','gold','5')";
    char *erroMsg = NULL;
    int result = sqlite3_exec(_db, sql, NULL, NULL, &erroMsg);
    if(result == SQLITE_OK){
        NSLog(@"插入成功");
    }else{
        printf("error = %s",erroMsg);
    }
    
    const char *sql1 = "INSERT INTO iPhone (name,type,color,num) VALUES('iPhone5s-black','4','black','2')";
    char *erroMsg1 = NULL;
    int result1 = sqlite3_exec(_db, sql1, NULL, NULL, &erroMsg1);
    if(result1 == SQLITE_OK){
        NSLog(@"插入成功");
    }else{
        printf("error = %s",erroMsg1);
    }
    
    const char *sql2 = "INSERT INTO iPhone (name,type,color,num) VALUES('iPhone5s-white','4','white','10')";
    char *erroMsg2 = NULL;
    int result2 = sqlite3_exec(_db, sql2, NULL, NULL, &erroMsg2);
    if(result2 == SQLITE_OK){
        NSLog(@"插入成功");
    }else{
        printf("error = %s",erroMsg2);
    }
    
    const char *sql3 = "INSERT INTO iPhone (name,type,color,num) VALUES('iPhone6-black','4.7','black','6')";
    char *erroMsg3 = NULL;
    int result3 = sqlite3_exec(_db, sql3, NULL, NULL, &erroMsg3);
    if(result3 == SQLITE_OK){
        NSLog(@"插入成功");
    }else{
        printf("error = %s",erroMsg3);
    }
    
    const char *sql4 = "INSERT INTO iPhone (name,type,color,num) VALUES('iPhone6-white','4.7','white','8')";
    char *erroMsg4 = NULL;
    int result4 = sqlite3_exec(_db, sql4, NULL, NULL, &erroMsg4);
    if(result4 == SQLITE_OK){
        NSLog(@"插入成功");
    }else{
        printf("error = %s",erroMsg4);
    }
    
    const char *sql5 = "INSERT INTO iPhone (name,type,color,num) VALUES('iPhone6Plus-black','5.5','black','3')";
    char *erroMsg5 = NULL;
    int result5 = sqlite3_exec(_db, sql5, NULL, NULL, &erroMsg5);
    if(result5 == SQLITE_OK){
        NSLog(@"插入成功");
    }else{
        printf("error = %s",erroMsg5);
    }
    
    const char *sql6 = "INSERT INTO iPhone (name,type,color,num) VALUES('iPhone6Plus-white','5.5','white','7')";
    char *erroMsg6 = NULL;
    int result6 = sqlite3_exec(_db, sql6, NULL, NULL, &erroMsg6);
    if(result6 == SQLITE_OK){
        NSLog(@"插入成功");
    }else{
        printf("error = %s",erroMsg6);
    }
    
//    const char *sql1 = "INSERT INTO userTable (name,age) VALUES('Tom',18)";
//    char *erroMsg1 = NULL;
//    int result1 = sqlite3_exec(_db, sql1, NULL, NULL, &erroMsg1);
//    if(result1 == SQLITE_OK){
//        NSLog(@"插入成功");
//    }else{
//        printf("error = %s",erroMsg);
//    }
//    
//    const char *sql2 = "INSERT INTO userTable (name,age) VALUES('Lucy',13)";
//    char *erroMsg2 = NULL;
//    int result2 = sqlite3_exec(_db, sql2, NULL, NULL, &erroMsg2);
//    if(result2 == SQLITE_OK){
//        NSLog(@"插入成功");
//    }else{
//        printf("error = %s",erroMsg);
//    }
}

//创建表
- (void)createTable{
      const char *sql = "CREATE TABLE IF NOT EXISTS iPhone (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, type text not NULL , color text not NULL , num integer NOT NULL);";
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
