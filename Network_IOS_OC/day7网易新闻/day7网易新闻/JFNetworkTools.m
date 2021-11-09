//
//  JFNetworkTools.m
//  day7网易新闻
//
//  Created by 翟佳阳 on 2021/11/9.
//

#import "JFNetworkTools.h"

@implementation JFNetworkTools
+ (instancetype)sharedManager{
    static id instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *baseURL = [NSURL URLWithString:@"http://c.m.163.com/nc/"];
        NSURLSessionConfiguration *config =  [NSURLSessionConfiguration defaultSessionConfiguration];
        //配置超时时长
        config.timeoutIntervalForRequest = 15;
        instance = [[self alloc] initWithBaseURL:baseURL sessionConfiguration:config];
    });
    return instance;
}

@end
