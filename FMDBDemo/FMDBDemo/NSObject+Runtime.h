//
//  NSObject+Runtime.h
//  CarLoan
//
//  Created by sml on 16/6/25.
//  Copyright © 2016年 sml. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MLDatabaseRuntimeIvar.h"
#import "MJExtension.h"

/** 模型属性，建表时字段所加的后缀 */ 
extern NSString *const MLDB_AppendingIDForModelProperty;
/** 所有表的主键默认设置 */
extern NSString *const MLDB_PrimaryKey;

typedef enum{
    /** 字符串类型 */
    RuntimeObjectIvarTypeObject = 64,
    /** 浮点型 */
    RuntimeObjectIvarTypeDoubleAndFloat = 100,
    /** 数组 */
    RuntimeObjectIvarTypeArray = 65,
    /** 流：data */
    RuntimeObjectIvarTypeData = 66,
    /** 其他(在数据库中使用long进行取值) */
    RuntimeObjectIvarTypeOther = -1
}RuntimeObjectIvarType;

typedef void(^RuntimeObjectIvarsOption)(MLDatabaseRuntimeIvar *ivar);

@interface NSObject (Runtime)

/** 设置主键 */
+ (NSDictionary *)ml_primaryKey;

/**
 *  将属性名为数组
 *
 */
+ (NSDictionary *)ml_propertyIsInstanceOfArray;

/**
 *  将属性名为NSDATA
 *
 */
+ (NSDictionary *)ml_propertyIsInstanceOfData;

/**
 *  只有这个数组中的属性名才允许
 */
+ (NSArray *)ml_allowedPropertyNames;

/**
 *  这个数组中的属性名将会被忽略：不进行
 */
+ (NSArray *)ml_ignoredPropertyNames;

/**
 *  将属性名换为其他key
 *
 */
+ (NSDictionary *)ml_replacedKeyFromPropertyName;

/**
 *  将属性是一个模型对象:字典再根据属性名获取value作为字段名
 *
 */
+ (NSDictionary*)ml_replacedKeyFromDictionaryWhenPropertyIsObject;
/**
 *  key : 模型对象的名字
 *  通过key获取类名
 */
+ (NSDictionary *)ml_getClassForKeyIsObject;


/** 获取对象的属性名和属性类型 */
+ (void)ml_objectIvar_nameAndIvar_typeWithOption:(RuntimeObjectIvarsOption )option;

+ (void)ml_replaceKeyWithIvarName:(NSString *)ivar_name ivar_type:(NSInteger )ivar_type option:(RuntimeObjectIvarsOption )option ;

/** 创表 */
+ (NSString *)ml_sqlForCreateTableWithPrimaryKey:(NSString *)primaryKey;

/**创表：除模型的属性之外， 有多余的字段 */
+ (NSString *)ml_sqlForCreateTableWithPrimaryKey:(NSString *)primaryKey extraKeyValues:(NSArray <MLDatabaseRuntimeIvar *> *)extraKeyValues;


+ (NSString *)ml_sqlForExcuteWithPrimaryKey:(NSString *)primaryKey value:(id )value;

@end
