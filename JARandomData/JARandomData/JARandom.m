//
//  JARandom.m
//  JARandomData
//
//  Created by Jason on 29/03/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import "JARandom.h"
#import <objc/message.h>

@interface JARandom ()

@end

@implementation JARandom

- (instancetype)initWithTableName:(NSString *)tableName {
    if (self) {
        self.tableName = tableName;
    }
    return self;
}

- (NSString *)randomStringWithModel:(id<JARandomDelegate>)model {
    NSMutableString *ptString = [NSMutableString stringWithFormat:@"INSERT INTO"];
    NSArray *pList = [self p_propertyList:false];
    for (int i = 0; i < pList.count; ++i) {
        
    }
    return ptString;
}

- (NSString *)randomStringWithModels:(NSArray <id<JARandomDelegate>>*) models {
    NSMutableString *ptStrings = [NSMutableString string];
    for (id<JARandomDelegate> model in models) {
        [ptStrings appendFormat:@"%@", [self randomStringWithModel:model]];
    }
    return ptStrings;
}

#pragma mark - 运行时获取属性

const void* propertiesKey = "com.coder.lldb-exclusive.propertiesKey";

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

#pragma mark - 随机生成数据 


@end
