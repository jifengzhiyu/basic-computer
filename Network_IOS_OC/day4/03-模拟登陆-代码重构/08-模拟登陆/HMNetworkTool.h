//
//  HMNetworkTool.h
//  08-模拟登陆
//
//  Created by Apple on 15/10/23.
//  Copyright © 2015年 heima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMNetworkTool : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *pwd;

+ (instancetype)sharedNetworkTool;

//发送异步请求，登陆
- (void)loginWithSuccess:(void(^)())success error:(void(^)())error;
@end
