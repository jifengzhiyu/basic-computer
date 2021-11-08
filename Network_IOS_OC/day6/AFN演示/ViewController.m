//
//  ViewController.m
//  AFN演示
//
//  Created by 翟佳阳 on 2021/11/8.
//

#import "ViewController.h"
#import "AFHTTPSessionManager.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self get];
    //[self download];
    [self baiDu];
}

- (void)download{
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1/myApache/greek.zip"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [[[AFHTTPSessionManager manager] downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
//            NSLog(@"progress:%@",downloadProgress);
        NSLog(@"progress:%f",downloadProgress.fractionCompleted);
        } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
            NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:response.suggestedFilename];
            //本地文件地址url写法
            NSURL *url = [[NSURL alloc] initFileURLWithPath:path];
            //要写入(保存 的目标文件
            return url;
            
        } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
            NSLog(@"%@",filePath);
        }] resume];
    
}

- (void)get{
    [[AFHTTPSessionManager manager] GET:@"http://127.0.0.1/myApache/demo.json" parameters:nil headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            NSLog(@"progress:%@",downloadProgress);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"success:%@",responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error:%@",error);
        }];
    
    
}

- (void)baiDu{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //修改相应的序列化器
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:@"http://www.baidu.com" parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *html = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",html);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

@end
