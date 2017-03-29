//
//  JARandom.h
//  JARandomData
//
//  Created by Jason on 29/03/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JARandomDelegate <NSObject>


@end

@interface JARandom : NSObject

@property (nonatomic,copy) NSString *tableName;

- (instancetype)initWithTableName:(NSString *)tableName;

/**
 生成一条sqlite语句

 @param model 模型对象
 @return sqlite语句
 */
- (NSString *)randomStringWithModel:(id<JARandomDelegate>)model;


/**
 生成一组sqlite语句

 @param models 模型对象数组
 @return 一组sqlite语句
 */
- (NSString *)randomStringWithModels:(NSArray <id<JARandomDelegate>>*) models;

@end
