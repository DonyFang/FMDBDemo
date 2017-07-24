//
//  FMDBHelper.h
//  FMDBDemo
//
//  Created by 方冬冬 on 2017/7/24.
//  Copyright © 2017年 方冬冬. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
@interface FMDBHelper : NSObject
+ (FMDBHelper *)sharedFMDBHelp;
//给数据库命名
- (void)createDBWithName:(NSString*)dbName andCreatTableSql:(NSString *)creatSql;
//无返回结果集的操作
- (BOOL)notResultSetWithSql:(NSString*)sql;
//查询操作
- (NSArray*)qureyWithSql:(NSString*)sql;
//插入操作
- (void)insetqueryWithSql:(NSString *)sql;
//删除操作
- (void)deleteFromqueryWithSql:(NSString *)sql;

//更新操作
- (void)updateFromqueryWithSql:(NSString *)sql;

@end
