//
//  JARandom.h
//  JARandomData
//
//  Created by Jason on 29/03/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#if DEBUG

#import <Foundation/Foundation.h>

@protocol JARandomDelegate <NSObject>

@optional
- (NSDictionary *)mapper;

@end

@interface JARandom : NSObject

@property (nonatomic,copy) NSString *tableName;
@property (nonatomic,copy) NSString *createSqlCmd;
@property (nonatomic,copy) NSString *insertSqlCmd;

/// 已填充数据的对象数组
@property (nonatomic,strong) NSArray *stub;

+ (instancetype)genWithName:(NSString *)tableName
                      class:(Class)cls
                       nums:(NSInteger)nums;

/**
 随机生成符合规则的数据去填充若干条指定类型的记录

 @param tableName 表名
 @param cls 类
 @param nums 记录数
 @param matcher 数据填充规则
 @return JARandom对象
 
 matcher 
 
 正则
 {
	numerical:@"[0-9]",       // 数值类型
	alphabet:@"[a-zA-Z0-9]",  // 字符类型
	property1:@""             // 指定属性的生成规则
	property2:@""
	...
 },
 
 预定义随机数据库,能力有限，先做这个
 {
    property1:@[@"a",@"b",@"c"]
    property2:@[@"d",@"e",@"f"]
    property3:@[@"g",@"h",@"i"]
 },
 
 */
+ (instancetype)genWithName:(NSString *)tableName
                      class:(Class)cls
                       nums:(NSInteger)nums
                    matcher:(NSDictionary *)matcher ;

@end

#endif
