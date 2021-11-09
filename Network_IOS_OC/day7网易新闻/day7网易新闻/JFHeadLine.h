//
//  JFHeadLine.h
//  day7网易新闻
//
//  Created by 翟佳阳 on 2021/11/9.
//

#import "AFHTTPSessionManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface JFHeadLine : AFHTTPSessionManager
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imgsrc;

+ (instancetype)headLineWithDic:(NSDictionary *)dic;
//发送异步请求，获取数据，字典转模型
//异步不需要返回数据，采用block回调
+ (void)headlinesWithSuccess:(void(^)(NSArray *array))success error:(void(^)(void))error;
@end

NS_ASSUME_NONNULL_END
