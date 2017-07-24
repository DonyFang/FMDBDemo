# FMDBDemo

详细的使用案例，demo中有，可以查看demo.

Public APIs in FMDBHelper

／／创建单例
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

