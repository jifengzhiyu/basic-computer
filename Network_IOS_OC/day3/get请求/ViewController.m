//
//  ViewController.m
//  get请求
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
    [self get];
    
}

- (void)get{
    //地址中出现 空格 或 汉字 返回空
    //需要对汉字和空格做特殊处理 转译
    NSString *name = @"张三";
    NSString *pwd = @"zhang";
    
    NSString *strUrl = [NSString stringWithFormat: @"http://127.0.0.1/myApache/php/login.php?username=%@&password=%@",name,pwd];
    //指定位置 进行转译
    strUrl = [strUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSURL *url = [NSURL URLWithString:strUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
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
