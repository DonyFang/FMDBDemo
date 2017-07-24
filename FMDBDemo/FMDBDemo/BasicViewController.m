//
//  BasicViewController.m
//  FMDBDemo
//
//  Created by 方冬冬 on 2017/7/24.
//  Copyright © 2017年 方冬冬. All rights reserved.
//
#define DBNAME    @"student.sqlite"
#define ID        @"id"
#define NAME      @"name"
#define AGE       @"age"
#define ADDRESS   @"address"
#define TABLENAME @"t_student"


#import "BasicViewController.h"
#import "FMDB.h"
#import "FMDBHelper.h"

@interface BasicViewController ()
 @property(nonatomic,strong)FMDatabase *db;

@end

@implementation BasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"常规增删改查";
    
    //1.获取文件路径
    NSString *dbPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;

    //2 数据库名称
    NSString *dbName = [dbPath stringByAppendingString:@"student.sqlite"];
     //3.获得数据库
    FMDatabase *dataBase = [FMDatabase databaseWithPath:dbName];
    //4.打开数据库
    if ([dataBase open]) {
    //5.创建表
        BOOL  result = [dataBase executeUpdate:@"CREATE TABLE IF NOT EXISTS t_student(id integer PRIMARY KEY AUTOINCREMENT, name text not null ,age text not null,address text not null);"];
        
        if (result) {
            NSLog(@"建表成功");
        }else{
            NSLog(@"建表失败");

        }
    }
        self.db=dataBase;
}

- (void)createTable{


}


- (IBAction)insert:(id)sender {
    
    if ([self.db open]) {
        NSString *insertSql1= [NSString stringWithFormat:
                               @"INSERT INTO '%@' ('%@', '%@', '%@') VALUES ('%@', '%@', '%@')",
                               TABLENAME, NAME, AGE, ADDRESS, @"张三", @"13", @"济南"];
        BOOL res = [self.db executeUpdate:insertSql1];
        NSString *insertSql2 = [NSString stringWithFormat:
                                @"INSERT INTO '%@' ('%@', '%@', '%@') VALUES ('%@', '%@', '%@')",
                                TABLENAME, NAME, AGE, ADDRESS, @"李四", @"12", @"济南"];
//        BOOL res2 = [self.db executeUpdate:insertSql2];
        if (!res) {
            NSLog(@"error when insert db table");
        } else {
            NSLog(@"success to insert db table");
        }
        [self.db close];
        
    }
    
}

- (IBAction)deleta:(id)sender {
    
    if ([self.db open]) {
        NSString *deleteSql = [NSString stringWithFormat:@"delete from %@ where %@ = '%@'",TABLENAME,NAME,@"张三"];
        
        BOOL res = [self.db executeUpdate:deleteSql];
        
        if (!res) {
            NSLog(@"error when delete frome table");
        } else {
            NSLog(@"success to delete frome table");
        }
    }

      [self.db close];
}
- (IBAction)update:(id)sender {
    
    if ([self.db open]) {
        NSString *updateSql = [NSString stringWithFormat:@"update  %@ set  %@ = %@ where %@ = '%@'",TABLENAME,AGE,@"15",AGE,@"12"];
        
        BOOL res = [self.db executeUpdate:updateSql];
        if (!res) {
            NSLog(@"error when update frome table");
        } else {
            NSLog(@"success to update frome table");
        }
    }

      [self.db close];
}

- (IBAction)search:(id)sender {
    if ([self.db open]) {
        
        NSString *searchSql = [NSString stringWithFormat:@"select * from %@",TABLENAME];
        
        FMResultSet *rs = [self.db executeQuery:searchSql];
        while ([rs next]) {
            
            NSInteger id = [rs intForColumn:ID];
            
            NSString *name = [rs stringForColumn:NAME];
            
            NSString *age = [rs stringForColumn:AGE];
            
            NSString *address = [rs stringForColumn:ADDRESS];

            
            NSLog(@"id=%ld name=%@ age=%@ address=%@",(long)id,name,age,address);
            
        }
    }
        [self.db close];
}

@end
