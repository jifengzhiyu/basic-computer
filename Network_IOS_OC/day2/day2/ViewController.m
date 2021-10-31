//
//  ViewController.m
//  day2
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
    //法1 获取网络数据
//    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1/myApache/demo.json"];
//    NSData *data = [NSData dataWithContentsOfURL:url];
//    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    NSLog(@"%@",str);
    
    //法2 获取网络数据
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1/myApache/demo.json"];
    //控制缓存方式 控制等待时长
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:15];
    
    //设置请求头
    //User-Agent: Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Mobile Safari/537.36
    [request setValue:@"Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Mobile Safari/537.36" forHTTPHeaderField:@"User-Agent"];
    //connection会自动发送合成请求头的 socket
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        //response响应头：响应码 200 304时可以正常看到文件
        //data相应体
        NSLog(@"%@",response);
        if(!connectionError){
            //判断 是否正常接收服务器的数据
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if(httpResponse.statusCode == 200 || httpResponse.statusCode == 304){
            NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"%@",str);
            }else{
                NSLog(@"服务器内部有问题");
            }
        }else{
            NSLog(@"%@",connectionError);
        }
    }];
}


@end
