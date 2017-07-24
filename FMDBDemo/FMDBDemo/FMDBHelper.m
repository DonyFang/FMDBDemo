//
//  FMDBHelper.m
//  FMDBDemo
//
//  Created by 方冬冬 on 2017/7/24.
//  Copyright © 2017年 方冬冬. All rights reserved.
//

#import "FMDBHelper.h"
@interface FMDBHelper()
@property(nonatomic,strong)NSString *fileName;//数据库文件的路径
@property(nonatomic,strong)FMDatabase *database; //数据库对象
//创建tabled的语句
@property(nonatomic,strong)NSString *creatSql;

@end
@implementation FMDBHelper
#pragma mark - 单例
+ (FMDBHelper *)sharedFMDBHelp {
    static FMDBHelper *help = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        help = [[FMDBHelper alloc] init];
    });
    return help;
}

#pragma mark - 让用户来命名数据库的名称
- (void)createDBWithName:(NSString*)dbName andCreatTableSql:(NSString *)creatSql{
    if (dbName.length == 0) {
        //是防止用户直接传值为nil 或者 NULL
        self.fileName = @"";
    } else {
        //判断用户是否为数据库文件添加后缀名
        if ([dbName containsString:@".sqlite"]) {
            self.fileName = dbName;
        } else {
            self.fileName = [dbName stringByAppendingString:@".sqlite"];
        }
    }
    if (creatSql.length) {
        self.creatSql = creatSql;
    }
}
//
#pragma amrk - 根据名称创建沙盒路径用来保存数据库文件
- (NSString*)dbPath {
    //说明fileName不为空
    if (self.fileName.length) {
        //获取沙盒主路径
        NSString *homePath = NSHomeDirectory();
        //完整路径
        NSString *savePath = [homePath stringByAppendingPathComponent:[NSString stringWithFormat:@"documents/%@",self.fileName]];
        NSLog(@"%@",savePath);
        
        
        return savePath;
    } else {
        return @"";
    }
}



#pragma mark - 创建数据库对象
//懒加载
- (FMDatabase*)database {
    if (!_database) {
        _database = [FMDatabase databaseWithPath:[self dbPath]];
        //4.打开数据库
        if ([_database open]) {
            //5.创建表
            BOOL  result = [_database executeUpdate:self.creatSql];
            if (result) {
                NSLog(@"建表成功");
            }else{
                NSLog(@"建表失败");
            }
        }
    }
    return _database;
}

#pragma mark - 打开或者创建数据库
- (BOOL)openOrCreateDB {
    if ([self.database open]) {
        NSLog(@"数据库打开成功");
        return YES;
    } else {
        NSLog(@"数据库打开失败");
        return NO;
    }
}

#pragma mark - 无返回结果集的操作
- (BOOL)notResultSetWithSql:(NSString*)sql {
    //打开数据库
    BOOL isOpen = [self openOrCreateDB];
    if (isOpen) {
        //进行操作
        BOOL isSuccess = [self.database executeUpdate:sql];
        [self closeDB];
        NSLog(@"打开数据库成功");
        return isSuccess;
    } else {
        NSLog(@"打开数据库失败");
        return NO;
    }
}

#pragma mark - 关闭数据库的方法
- (void)closeDB {
    BOOL isClose = [self.database close];
    if (isClose) {
        NSLog(@"关闭数据库成功");
    } else {
        NSLog(@"关闭数据库失败");
    }
}

#pragma mark - 通用的查询方法
- (NSArray *)qureyWithSql:(NSString*)sql {
    //打开数据库
    BOOL isOpen = [self openOrCreateDB];
    if (isOpen) {
        //得到所有记录的结果集
        FMResultSet *set = [self.database executeQuery:sql];
        //声明一个可变数组,用来存放所有的记录
        NSMutableArray *array = [NSMutableArray array];
        //遍历结果集,取出每一条记录,将每一条记录转换为字典类型,并且存储到可变数组中
        while ([set next]) {
            //直接将一条记录转换为字典类型
            NSDictionary *dic = [set resultDictionary];
            [array addObject:dic];
        }
        //释放结果集
        [set close];
        [self closeDB];
        return array;
    } else {
        NSLog(@"打开数据库失败");
        return nil;
    }
}
//插入数据
- (void)insetqueryWithSql:(NSString *)sql{

    BOOL isOpen = [self openOrCreateDB];
    if (isOpen) {
      BOOL res  =   [self.database executeUpdate:sql];
        if (!res) {
        NSLog(@"error when update frome table");
        } else {
        NSLog(@"success to update frome table");
        }
        [self closeDB];
    }
}

//删除数据
- (void)deleteFromqueryWithSql:(NSString *)sql{
    if ([self.database open]) {
        BOOL res = [self.database executeUpdate:sql];
        if (!res) {
            NSLog(@"error when delete frome table");
        } else {
            NSLog(@"success to delete frome table");
        }
    }
    [self.database close];
}

//更新操作

- (void)updateFromqueryWithSql:(NSString *)sql{

    if ([self.database open]) {
        BOOL res = [self.database executeUpdate:sql];
        if (!res) {
            NSLog(@"error when update frome table");
        } else {
            NSLog(@"success to update frome table");
        }
    }
    [self.database close];
}

@end
