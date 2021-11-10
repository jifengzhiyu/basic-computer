//
//  JFNews.h
//  day7网易新闻
//
//  Created by 翟佳阳 on 2021/11/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JFNews : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *digest;

@property (nonatomic, copy) NSNumber *replyCount;
@property (nonatomic, copy) NSString *imgsrc;


+ (instancetype)newsWithDic:(NSDictionary *)dic;
//发送异步请求，获取数据，字典转模型
+ (void)newsListWithSuccessBlock:(void(^)(NSArray *array))successBlock errorBlock:(void(^)(NSError *error))errorBlock;

@end

NS_ASSUME_NONNULL_END
