//
//  ViewController.m
//  DataTask
//
//  Created by 翟佳阳 on 2021/11/6.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self dataTask3];
}

//post
- (void)dataTask3{
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1/myApache/php/login.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"post";
    NSString *body = @"username=123&password=123";
    request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                NSLog(@"%@",json);
    }]resume];
}

//获取JSON 简化版
- (void)dataTask2{
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1/myApache/demo.json"];
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                NSLog(@"%@",json);
    }] resume];
}


//获取JSON
- (void)dataTask1{
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1/myApache/demo.json"];
    NSURLSession *session = [NSURLSession sharedSession];
    //任务默认都是挂起的 ,需要手动开启任务
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        NSLog(@"%@",json);
    }];
    //开始任务
    [dataTask resume];

}
@end
