//
//  ViewController.m
//  04-新闻详细页面
//
//  Created by Apple on 15/10/29.
//  Copyright © 2015年 heima. All rights reserved.
//

#import "ViewController.h"
#import "AFHTTPSessionManager.h"
@interface ViewController ()
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation ViewController
//使用代码创建webView
- (void)loadView {
    self.webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //__block修饰的变量可以在block内部访问
    __block NSString *title = @"标题";
    __block NSString *time = @"shijian";
    __block NSString *body = @"新闻内容";
   
    
    //发送异步请求，获取新闻详细内容
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //增加所需的acceptableContentTypes
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/html",@"text/javascript", nil];
    
    [manager GET:@"http://c.3g.163.com/nc/article/B6UBJBU600031H2L/full.html" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        //获取第一个键
        NSString *rootKey = responseObject.keyEnumerator.nextObject;
        NSDictionary *news = responseObject[rootKey];
        
        
        title = news[@"title"];
        time = news[@"ptime"];
        body = news[@"body"];
        
        //获取返回的图片
        NSArray *array = news[@"img"];
        
        //遍历图片，替换掉body中的图片占位符
        [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *ref = obj[@"ref"];//占位符
            NSString *src = obj[@"src"];//图片的地址
            
            NSString *img = [NSString stringWithFormat:@"<img src='%@' width='90%%'>",src];
            body = [body stringByReplacingOccurrencesOfString:ref withString:img];
            
            
        }];
        
        //加载网页模板
        NSString *path = [[NSBundle mainBundle] pathForResource:@"index.html" ofType:nil];
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSString *html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        //字符串替换
        html = [html stringByReplacingOccurrencesOfString:@"@title" withString:title];
        html = [html stringByReplacingOccurrencesOfString:@"@time" withString:time];
        html = [html stringByReplacingOccurrencesOfString:@"@body" withString:body];
        
        [self.webView loadHTMLString:html baseURL:nil];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
  
    
}



@end
