//
//  JFNews.m
//  模拟科技头条
//
//  Created by 翟佳阳 on 2021/11/1.
//

#import "JFNews.h"

@implementation JFNews
+ (instancetype)newsWithDict:(NSDictionary *)dic{
    JFNews *news = [JFNews new];
    [news setValuesForKeysWithDictionary:dic];
    return news;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@{title:%@, sum:%@, img:%@,time :%d}", [super description],self.title,self.summary,self.img,self.addtime.intValue];
}

+ (void)newsWithSuccess:(void(^)(NSArray *array))success error:(void(^)(void))error{
    NSURL *url = [NSURL URLWithString:@"<#urlString#>"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if(connectionError){
            NSLog(@"连接错误：%@",connectionError);
            return;
        }
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if(httpResponse.statusCode == 200 || httpResponse.statusCode == 304){
            //解析数据
            NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:10];
            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                            JFNews *news = [JFNews newsWithDict:obj];
                            [mArray addObject:news];
            }];
            
//            self.newsList = mArray.copy;
            //调用成功的回调
            if(success){
            success(mArray.copy);
                //如果success block里面有传值的话，在传参数并调用回调
            }
        }else{
//            NSLog(@"服务器内部错误");
            if(error){
            error();
            }
        }
    }];
}
@end
