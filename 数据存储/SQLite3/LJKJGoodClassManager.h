//
//  LJKJGoodClassManager.h
//  HelloWorld
//
//  Created by Ji Ling on 2017/3/3.
//  Copyright © 2017年 Ji Ling. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJKJGoodClassManager : NSObject

+(instancetype)shareManager;   //获取管理类manager的单例

- (NSInteger)createTabelWithParameter:(NSDictionary *)dic;   //根据属性dic创建商品缓存表

- (NSInteger)addDataWith:(NSArray *)dicArray;   //把商品加入表中

-(NSArray *)queryDataWith:(NSDictionary *)parameter;   //根据属性字典，返回符合商品数组

-(NSInteger)dropTabel;   //删除tmp数据库中的商品表

@end
