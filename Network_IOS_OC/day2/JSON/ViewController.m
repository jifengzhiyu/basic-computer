//
//  ViewController.m
//  JSON
//
//  Created by 翟佳阳 on 2021/10/31.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1/myApache/demo.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
            if(connectionError){
                NSLog(@"连接错误：%@",connectionError);
                return;
            }
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if(httpResponse.statusCode == 200 || httpResponse.statusCode == 304){
                //解析数据
                //data存储（二进制形式）  JSON形式的字符串
                //JSON的解析 反序列化 把JSON形式的字符串转化成OC对象
                NSError *error;
                id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                if(error){
                    NSLog(@"解析JSON错误：%@",error);
                    return;
                }
                //解析
                NSLog(@"%@",json);
                
            }else{
                NSLog(@"服务器内部错误");
            }
    }];
}


@end
