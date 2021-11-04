//
//  ViewController.m
//  JSON序列化
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
    
    //1自己拼json形式的字符串
//    NSString *jsonStr = @"{\"name\":\"zhangsan\",\"age\":18}";
//    [self postJSON:[jsonStr dataUsingEncoding:NSUTF8StringEncoding]];
    
    //2字典 数字需要包装一下
//    NSDictionary *dic = @{@"name":@"zhangsan",@"age":@(20)};
//    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:0 error:NULL];
//    [self postJSON:data];
    
    //3 数组
    NSArray *array = @[
                      @{@"name":@"zhangsan",@"age":@(18)},
                      @{@"name":@"lisi",@"age":@(19)}
                      ];
    //JSON序列化
    NSData *data = [NSJSONSerialization dataWithJSONObject:array options:0 error:NULL];
    [self postJSON:data];
    
}

- (void)postJSON:(NSData *)data{
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1/myApache/php/upload/postjson.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"post";
    request.HTTPBody = data;
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if(connectionError){
            NSLog(@"连接错误：%@",connectionError);
            return;
        }
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if(httpResponse.statusCode == 200 || httpResponse.statusCode == 304){
            //解析数据
            NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@",str);
        }else{
            NSLog(@"服务器内部错误");
        }
    }];
}
@end
