//
//  HMNetworkTool.m
//  08-模拟登陆
//
//  Created by Apple on 15/10/23.
//  Copyright © 2015年 heima. All rights reserved.
//

#import "HMNetworkTool.h"
#import "NSString+Hash.h"
#import "SSKeychain.h"
@implementation HMNetworkTool
//单例方法
+ (instancetype)sharedNetworkTool {
    static id instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
    });
    
    return instance;
}

//对象初始化的时候，调用loadUserInfo 给属性赋值
- (instancetype)init {
    if (self = [super init]) {
        [self loadUserInfo];
    }
    return self;
}

//登陆
- (void)loginWithSuccess:(void (^)())success error:(void (^)())error {
    
    [NSThread sleepForTimeInterval:1.0];
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1/myApache/php/loginhmac.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //设置post
    request.HTTPMethod = @"post";
    //4 密码+time
    NSString *password = [self getPWD:self.pwd];
    
    //设置请求体
    NSString *body = [NSString stringWithFormat:@"username=%@&password=%@",self.name,password];
    request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (connectionError) {
            NSLog(@"连接错误 %@",connectionError);
            return;
        }
        
        //
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (httpResponse.statusCode == 200 || httpResponse.statusCode == 304) {
            //解析数据
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            //判断登陆成功，还是失败
            if ([dic[@"userId"] intValue] > 0) {
                if (success) {
                    success();
                }
                
                //登陆成功之后，把账号和密码记录到沙盒中
                [self saveUserInfo];
            }else{
                if (error) {
                    error();
                }
            }
            
        }else{
            NSLog(@"服务器内部错误");
        }
    }];
}


//获取pwd + time 的一个密码
- (NSString *)getPWD:(NSString *)pwd {
    //  1  一个字符串key    md5计算
    NSString *md5Key = [@"itcast" md5String];
    //  2  把原密码和之前生成的md5值再进行hmac加密
    NSString *hmacKey = [pwd hmacMD5StringWithKey:md5Key];
    //  3  从服务器获取当前时间 到分钟 的字符串
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1/myApache/php/hmackey.php"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    //JSON的反序列化
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    NSString *time = dic[@"key"];
    
    // 4   第二步产生的hmac值+时间      和第一步产生的md5值进行hmac加密
    return [[hmacKey stringByAppendingString:time] hmacMD5StringWithKey:md5Key];
}

#define kHMUSERNAMEKEY @"name"
#define kHMPASSWORDKEY @"pwd"

#define kBUNDLEID [NSBundle mainBundle].bundleIdentifier

//登陆成功之后，把账号和密码记录到沙盒中（偏好设置）
- (void)saveUserInfo {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:self.name forKey:kHMUSERNAMEKEY];
    //    [userDefaults setObject:[self base64Encode:self.pwdView.text] forKey:kHMPASSWORDKEY];
    
    //把密码保存到钥匙串
    [SSKeychain setPassword:self.pwd forService:kBUNDLEID account:self.name];
    //立即保存
    [userDefaults synchronize];
}

//当重新加载应用，读取沙盒中的用户信息
- (void)loadUserInfo {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.name = [userDefaults objectForKey:kHMUSERNAMEKEY];
    
    //从钥匙串读取密码
    self.pwd = [SSKeychain passwordForService:kBUNDLEID account:self.name];
}


@end
