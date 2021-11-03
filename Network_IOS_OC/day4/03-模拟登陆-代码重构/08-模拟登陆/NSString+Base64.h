//
//  NSString+Base64.h
//  08-模拟登陆
//
//  Created by Apple on 15/10/23.
//  Copyright © 2015年 heima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Base64)
- (NSString *)base64Encode;
//base64 "解密"密码
- (NSString *)base64Decode;
@end
