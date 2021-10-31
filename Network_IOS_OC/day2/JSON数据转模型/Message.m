//
//  Message.m
//  JSON数据转模型
//
//  Created by 翟佳阳 on 2021/10/31.
//

#import "Message.h"

@implementation Message
+ (instancetype)messageWithDic:(NSDictionary *)dic{
    Message *msg = [Message new];
    [msg setValuesForKeysWithDictionary:dic];
    return msg;
}
- (NSString *)description
{
    return [NSString stringWithFormat:@"%@{message:%@, messageId:%d}", [super description],self.message,self.messageId.intValue];
}
@end
