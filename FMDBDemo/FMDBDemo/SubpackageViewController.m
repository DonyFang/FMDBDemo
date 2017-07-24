//
//  SubpackageViewController.m
//  FMDBDemo
//
//  Created by 方冬冬 on 2017/7/24.
//  Copyright © 2017年 方冬冬. All rights reserved.
//

#define DBNAME    @"person.sqlite"
#define ID        @"id"
#define NAME      @"name"
#define AGE       @"age"
#define ADDRESS   @"address"
#define TABLENAME @"person"


#import "SubpackageViewController.h"
#import "FMDBHelper.h"


@interface SubpackageViewController ()
@property(nonatomic,strong)FMDBHelper *dbhelper;
@end

@implementation SubpackageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.title = @"封装FMDB";
    
    self.dbhelper = [FMDBHelper sharedFMDBHelp];
    
    [self.dbhelper createDBWithName:@"person" andCreatTableSql:@"CREATE TABLE IF NOT EXISTS person(id integer PRIMARY KEY AUTOINCREMENT, name text not null ,age text not null,address text not null);"];
    
    
    
    
}

- (IBAction)insert:(id)sender {
    NSString *insertSql1= [NSString stringWithFormat:
                           @"INSERT INTO '%@' ('%@', '%@', '%@') VALUES ('%@', '%@', '%@')",
                           TABLENAME, NAME, AGE, ADDRESS, @"张三", @"13", @"济南"];
    [self.dbhelper insetqueryWithSql:insertSql1];
    
}


- (IBAction)delete:(id)sender {
    
    NSString *deleteSql = [NSString stringWithFormat:@"delete from %@ where %@ = '%@'",TABLENAME,NAME,@"张三"];
    [self.dbhelper deleteFromqueryWithSql:deleteSql];
    
}


- (IBAction)update:(id)sender {
            
    NSString *updateSql = [NSString stringWithFormat:@"update  %@ set  %@ = %@ where %@ = '%@'",TABLENAME,AGE,@"15",AGE,@"13"];

    [self.dbhelper updateFromqueryWithSql:updateSql];
}



- (IBAction)search:(id)sender {
    NSString *searchSql = [NSString stringWithFormat:@"select * from %@",TABLENAME];

    NSArray *arr = [self.dbhelper  qureyWithSql:searchSql];
    
    NSLog(@"%@",arr);
    
    
}


@end
