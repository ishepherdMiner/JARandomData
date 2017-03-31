//
//  JARandom.m
//  JARandomData
//
//  Created by Jason on 29/03/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#if DEBUG

#import "JARandom.h"
#import <objc/message.h>

NSString *kNumericalField = @"[0-9]{4}";
NSString *kAlphabetField = @"[a-zA-Z0-9]{8}";

@interface JARandom ()

@property (nonatomic,copy) NSDictionary *matcher;

@end

@implementation JARandom

+ (instancetype)genWithName:(NSString *)tableName
                      class:(Class)cls
                       nums:(NSInteger)nums {
    
    return [self genWithName:tableName
                       class:cls
                        nums:nums
                     matcher:@{
                                @"numerical":kNumericalField,
                                @"alphabet":kAlphabetField,
                             }];
}

+ (instancetype)genWithName:(NSString *)tableName
                      class:(Class)cls
                       nums:(NSInteger)nums
                    matcher:(id)matcher {
    
    JARandom *instance = [[self alloc] init];
    instance.matcher = matcher;
    
    if (instance) {
        NSAssert(tableName, @"You must transfer the tableName parameter");
        
        instance.tableName = tableName;
        
        if (nums > 0) {
            instance.insertSqlCmd = [instance generateStringWithClass:cls nums:nums];
        }else {
            instance.insertSqlCmd = [instance generateStringWithClass:cls nums:1];
        }
    }
    return instance;
}

- (NSString *)generateStringWithClass:(Class)cls {
    NSMutableString *ptString = [NSMutableString stringWithFormat:@"INSERT INTO %@",_tableName];
    NSArray *pList = [self p_propertyList:false];
    
    id instance = [[cls alloc] init];
    
    for (int i = 0; i < pList.count; ++i) {
        NSString *plistEle = pList[i];
        if ([instance respondsToSelector:@selector(mapper)]) {
            
        }else {
            
            plistEle = [plistEle capitalizedString];
            NSString *setString = [[@"set" stringByAppendingString:plistEle] stringByAppendingString:@":"];
            SEL setSel = NSSelectorFromString(setString);
            
            // 判断类型
            ((void (*)(id, SEL, id))(void *) objc_msgSend)(instance, setSel,@"123");
        }
    }
    return ptString;
}

- (NSString *)generateStringWithClass:(Class)cls nums:(NSInteger)nums {
    NSMutableString *ptStrings = [NSMutableString string];
    for (int i = 0; i < nums; ++i) {
        [ptStrings appendFormat:@"%@\n", [self generateStringWithClass:cls]];
    }
    return ptStrings;
}

#pragma mark - 运行时获取属性

const void* propertiesKey = "com.coder.random.propertiesKey";

/**
 运行时获取属性
 
 @param recursive 是否递归遍历
 @return 属性名称字符串数组
 */
- (NSArray *)p_propertyList:(BOOL)recursive {
    
    NSArray *glist = objc_getAssociatedObject([self class], propertiesKey);
    
    return glist == nil ? ^{
        
        unsigned int count = 0;
        NSMutableArray *plistM = [NSMutableArray arrayWithCapacity:count];
        
        Class cls = [self class];
        do {
            objc_property_t *list = class_copyPropertyList(cls, &count);
            for (int i = 0; i < count; ++i) {
                objc_property_t pty = list[i];
                const char *pname = property_getName(pty);
                [plistM addObject:[NSString stringWithUTF8String:pname]];
            }
            free(list);
            cls = [cls superclass];
        } while (cls && recursive);
        objc_setAssociatedObject([self class],propertiesKey, plistM, OBJC_ASSOCIATION_COPY_NONATOMIC);
        NSLog(@"Found %ld properties on %@",(unsigned long)plistM.count,[self class]);
        return plistM.copy;
        
    }() : glist;
}

- (void)p_cleanCacheList {
    objc_removeAssociatedObjects([self class]);
}

#pragma mark - 利用正则表达式随机生成数据
// http://www.paper.edu.cn/download/downPaper/200905-716
// 论文: 基于正则语言的数据生成

// http://dinosaur.compilertools.net/yacc/ yacc
- (NSString *)randomString:(NSString *)val {
    
    // 自定义规则
    if ([self.matcher valueForKey:val]) {
        
        
    }else if ([self.matcher valueForKey:@"alphabet"]) {
        
        // 1.获得正则规则
        NSString *regx = [self.matcher valueForKey:@"alphabet"];
        
        // 2.解析规则生成树
        
        // 3.根据树生成具体的数据
        
    }else {
        
    }
    return @"123";
}

- (NSNumber *)randomNumber:(NSString *)val {
    
    // 自定义规则
    if ([self.matcher valueForKey:val]) {
        
        
    }else if ([self.matcher valueForKey:@"numerical"]) {
        
    }
    
    return nil;
}

@end

#endif
