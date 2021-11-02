//
//  ViewController.m
//  post请求
//
//  Created by 翟佳阳 on 2021/11/2.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self post];
}


- (void)post{
    NSString *strUrl = @"http://127.0.0.1/myApache/php/login.php";
    
    NSURL *url = [NSURL URLWithString:strUrl];
    
    //改成可变，接下来可以编辑
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //请求行
    request.HTTPMethod = @"post";
    //请求体
    NSString *body = @"username=123&password=abc";
    //把字符串对象 转化成NSData(二进制
    request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if(connectionError){
            NSLog(@"连接错误：%@",connectionError);
            return;
        }
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if(httpResponse.statusCode == 200 || httpResponse.statusCode == 304){
            //解析数据
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            NSLog(@"%@",dic);
        }else{
            NSLog(@"服务器内部错误");
        }
    }];
}

@end
