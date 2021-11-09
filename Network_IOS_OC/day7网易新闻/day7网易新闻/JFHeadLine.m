//
//  JFHeadLine.m
//  day7网易新闻
//
//  Created by 翟佳阳 on 2021/11/9.
//

#import "JFHeadLine.h"
#import "JFNetworkTools.h"
@implementation JFHeadLine
+ (instancetype)headLineWithDic:(NSDictionary *)dic{
    JFHeadLine *headline = [self new];
    [headline setValuesForKeysWithDictionary:dic];
    return headline;
}
//因为    [headline setValuesForKeysWithDictionary:dic];
//键的数量 小于 对应的网页信息
//需要 下面一个空的方法 消除警告
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

//发送异步请求，获取数据，字典转模型
//异步不需要返回数据，采用block回调
+ (void)headlinesWithSuccess:(void(^)(NSArray *array))success error:(void(^)(void))error{
    
    [[JFNetworkTools sharedManager] GET:@"ad/headline/0-4.html" parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        //获取返回的数组
        //获取字典的第一个键
        NSString *rootKey = responseObject.keyEnumerator.nextObject;
        NSArray *array = responseObject[rootKey];
        
        //字典转模型
        NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:4];
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    JFHeadLine *headline = [self headLineWithDic:obj];
                    [mArray addObject:headline];
        }];
        //调用成功的回调
        if(success){
            success(mArray.copy);
        }
        
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull er) {
            if(error){
                error();
            }
        }];
}
@end
