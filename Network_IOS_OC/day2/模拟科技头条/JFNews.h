//
//  JFNews.h
//  模拟科技头条
//
//  Created by 翟佳阳 on 2021/11/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JFNews : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *summary;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *sitename;
@property (nonatomic, strong) NSNumber *addtime;

//处理日期用
@property (nonatomic, copy, readonly) NSString *time;

+ (instancetype)newsWithDict:(NSDictionary *)dic;
//发送异步请求获取数据
+ (void)newsWithSuccess:(void(^)(NSArray *array))success error:(void(^)(void))error;



@end

NS_ASSUME_NONNULL_END
