//
//  ViewController.m
//  JSON数据转模型
//
//  Created by 翟佳阳 on 2021/10/31.
//

#import "ViewController.h"
#import "Message.h"
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
            //JSON反序列化
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            //字典转模型
            Message *msg = [Message messageWithDic:dic];
            NSLog(@"%@",msg);
            
        }else{
            NSLog(@"服务器内部错误");
        }
    }];
}


@end
