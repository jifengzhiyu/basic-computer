//
//  ViewController.m
//  Head请求
//
//  Created by 翟佳阳 on 2021/11/4.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //发送同步请求
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1/myApache/demo.json"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
       request.HTTPMethod = @"head";
    
    NSURLResponse *response = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:NULL];
    NSLog(@"%@",response);
    
    //发送异步请求
    {
//    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1/myApache/demo.json"];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    request.HTTPMethod = @"head";
//
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
//        if(connectionError){
//            NSLog(@"连接错误：%@",connectionError);
//            return;
//        }
//        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
//        if(httpResponse.statusCode == 200 || httpResponse.statusCode == 304){
//            //解析数据
//            NSLog(@"response:%@",response);
//
//            NSLog(@"fileName:%@",response.suggestedFilename);
//            NSLog(@"%lld",response.expectedContentLength);
//
//        }else{
//            NSLog(@"服务器内部错误");
//        }
//    }];
    }
    
}


@end
