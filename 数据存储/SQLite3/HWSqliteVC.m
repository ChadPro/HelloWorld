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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromHex(0x009966, 1.0);
    //********************
    
    NSString *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES).firstObject;
    NSLog(@"documentsPath = %@",documentsPath);
    
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"user.sqlite"];
    
    //将OC字符串 -> C语言字符串
    const char *cfilePath = filePath.UTF8String;
    //1.打开数据库
    int result = sqlite3_open(cfilePath, &_db);    //参数
    if(result == SQLITE_OK){
        NSLog(@"成功打开数据库");
        
    
    //2.创表
    const char *sql = "CREATE TABLE IF NOT EXISTS t_person (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, age integer NOT NULL);";
    char *erroMsg = NULL;
    result = sqlite3_exec(_db, sql, NULL, NULL, &erroMsg);
    if (result == SQLITE_OK) {
        NSLog(@"成功创表");
    } else {
        NSLog(@"创表失败--%s", erroMsg);
      }
        
    }else{
   
        NSLog(@"打开数据库失败");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
