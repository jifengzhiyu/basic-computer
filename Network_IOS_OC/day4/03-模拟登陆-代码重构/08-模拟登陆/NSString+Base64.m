//
//  NSString+Base64.m
//  08-模拟登陆
//
//  Created by Apple on 15/10/23.
//  Copyright © 2015年 heima. All rights reserved.
//

#import "NSString+Base64.h"

@implementation NSString (Base64)
//base64 “加密”密码     无论是编码解码还是加密解密 都是直接操作的二进制数据
- (NSString *)base64Encode {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}
//base64 "解密"密码
- (NSString *)base64Decode {
    //base64解码
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:0];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}
@end
