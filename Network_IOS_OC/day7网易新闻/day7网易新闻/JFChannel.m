//
//  JFChannel.m
//  day7网易新闻
//
//  Created by 翟佳阳 on 2021/11/11.
//

#import "JFChannel.h"

@implementation JFChannel
+ (instancetype)channelWithDic:(NSDictionary *)dic {
    JFChannel *channel = [self new];
    
    [channel setValuesForKeysWithDictionary:dic];
    return channel;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

//加载本地数据
+ (NSArray *)channels {
    //加载json
    NSString *path = [[NSBundle mainBundle] pathForResource:@"topic_news.json" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    NSArray *array = dic[@"tList"];
    //字典转模型
    NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:10];
    
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        JFChannel *channel = [self channelWithDic:obj];
        [mArray addObject:channel];
    }];
    
    //比较数组 里对象的属性（字符串）（根据ask||）
    return [mArray sortedArrayUsingComparator:^NSComparisonResult(JFChannel  *obj1, JFChannel *obj2) {
        return [obj1.tid compare:obj2.tid];
    }];}
@end
