//
//  Message.h
//  JSON数据转模型
//
//  Created by 翟佳阳 on 2021/10/31.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Message : NSObject
@property (nonatomic, copy) NSString *message;
//@property (nonatomic, assign) int messageId;
//即使服务器给的id是空，程序也不会崩，使用NSMumber
@property (nonatomic, strong) NSNumber *messageId;



+ (instancetype)messageWithDic:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
