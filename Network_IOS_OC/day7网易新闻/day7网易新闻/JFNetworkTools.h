//
//  JFNetworkTools.h
//  day7网易新闻
//
//  Created by 翟佳阳 on 2021/11/9.
//

#import "AFHTTPSessionManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface JFNetworkTools : AFHTTPSessionManager
+ (instancetype)sharedManager;
@end

NS_ASSUME_NONNULL_END
