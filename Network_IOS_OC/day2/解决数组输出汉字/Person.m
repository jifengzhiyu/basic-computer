//
//  Person.m
//  解决数组输出汉字
//
//  Created by 翟佳阳 on 2021/10/31.
//

#import "Person.h"

@implementation Person
- (NSString *)description
{
    return [NSString stringWithFormat:@"%@{name:%@, age:%d}",[super description], _name,_age];
}
@end
