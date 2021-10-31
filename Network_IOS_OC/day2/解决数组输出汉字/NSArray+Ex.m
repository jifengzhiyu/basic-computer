//
//  NSArray+Ex.m
//  解决数组输出汉字
//
//  Created by 翟佳阳 on 2021/10/31.
//

#import "NSArray+Ex.h"

@implementation NSArray (Ex)
- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level{
    NSMutableString *mStr = [NSMutableString string];
    [mStr appendString:@"(\r\n"];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // /t相当于4个空格
            [mStr appendFormat:@"\t%@,\r\n",obj];
    }];
    [mStr appendString:@")"];
    return mStr.copy;
}
@end

@implementation NSDictionary (Ex)
- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level{
    NSMutableString *mStr = [NSMutableString string];
    [mStr appendString:@"(\r\n"];
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [mStr appendFormat:@"\t%@,\r\n",obj];
    }];
    [mStr appendString:@")"];
    return mStr.copy;
}

@end

