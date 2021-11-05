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
    
    // **作为参数的含义
    //求数组中的最大值，最小值
    //当参数是地址的时候，输出结果。 输出参数（用来返回结果的参数
    {
//    int m;
//    int m1;
//    [self getMaxAndMin:@[@(53),@(45),@(42),@(5)] max:&m min:&m1];
//    NSLog(@"max = %d,min = %d",m,m1);
    }
    
    NSString *str = nil;
    [self demo:&str];
    NSLog(@"%@",str);
    
    //发送同步请求
    {
//    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1/myApache/demo.json"];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//       request.HTTPMethod = @"head";
//
//    NSURLResponse *response = nil;
//    //NULL空地址 ((void *)0) 把0强转成空地址
//    //nil空对象 nil==NULL
//    //两者本质一样
//    //NSMull
//    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:NULL];
//    NSLog(@"%@",response);
    //nil不能给字典的键赋值，[NSNull null]可以
//   { NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    [dic setObject:[NSNull null] forKey:@"k4"];
//    NSLog(@"%@",dic);
    //}
    }
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

//求数组中的最大值，最小值,(平均值）
//基本数据类型 * 就是地址
- (void) getMaxAndMin:(NSArray *)array max:(int *)max min:(int *)min{
    //假设第一个数是最大值
    //max是地址
    *max = [array[0] intValue];
    *min = [array[0] intValue];
    
    for(NSNumber *num in array){
        if (*max < num.intValue) {
            *max = num.intValue;
        }
        
        if (*min > num.intValue) {
            *min = num.intValue;
        }
    }
}

//对象 输出参数
- (void)demo:(NSString **)str{
    *str = @"ababa";
}
@end
