//
//  JFNews.m
//  day7网易新闻
//
//  Created by 翟佳阳 on 2021/11/10.
//

#import "JFNews.h"
#import "JFNetworkTools.h"
@implementation JFNews
+ (instancetype)newsWithDic:(NSDictionary *)dic {
    JFNews *news = [self new];
    
    [news setValuesForKeysWithDictionary:dic];
    return news;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

//发送异步请求，获取数据，字典转模型
+ (void)newsListWithSuccessBlock:(void(^)(NSArray *array))successBlock errorBlock:(void(^)(NSError *error))errorBlock {
    //http://c.m.163.com/nc/article/headline/T1348647853363/0-140.html
    
    [[JFNetworkTools sharedManager] GET:@"article/headline/T1348647853363/0-140.html" parameters:nil headers: nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
            //获取第一个键
            NSString *rootKey = responseObject.keyEnumerator.nextObject;
            NSArray *array = responseObject[rootKey];
            //字典转模型
            NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:10];
            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                JFNews *news = [self newsWithDic:obj];
                [mArray addObject:news];
            }];
            //调用回调的block
            if (successBlock) {
                successBlock(mArray.copy);
            }
            
        }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (errorBlock) {
                       errorBlock(error);
                   }
        }];
}
    
@end
    
