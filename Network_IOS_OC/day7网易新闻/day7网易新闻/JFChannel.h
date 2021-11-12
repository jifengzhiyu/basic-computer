//
//  JFChannel.h
//  day7网易新闻
//
//  Created by 翟佳阳 on 2021/11/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JFChannel : NSObject
//新闻的分类（频道）
@property (nonatomic, copy) NSString *tname;
@property (nonatomic, copy) NSString *tid;

+ (instancetype)channelWithDic:(NSDictionary *)dic;
//加载本地数据
+ (NSArray *)channels;
@end

NS_ASSUME_NONNULL_END
