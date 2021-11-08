//
//  ViewController.m
//  AFN演示
//
//  Created by 翟佳阳 on 2021/11/8.
//

#import "ViewController.h"
#import "AFHTTPSessionManager.h"
@interface ViewController ()<NSXMLParserDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self get];
    //[self download];
    //[self baiDu];
    [self getXML];
}

- (void)getXML{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //默认json反序列化，所以这里要修改
    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    [manager GET:@"http://127.0.0.1/myApache/videos.xml" parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSXMLParser *responseObject) {
            responseObject.delegate = self;
            [responseObject parse];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
}
#pragma mark NSXMLParser 的代理方法

- (void)parserDidStartDocument:(NSXMLParser *)parser{
    NSLog(@"1 开始解析");
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict{
    NSLog(@"2 开始节点 %@  %@",elementName,attributeDict);
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    NSLog(@"3 节点之间的内容 %@",string);
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    NSLog(@"4 结束节点 %@",elementName);
}

- (void)parserDidEndDocument:(NSXMLParser *)parser{
    NSLog(@"5 结束解析");
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    NSLog(@"6 错误");
}

#pragma mark NSXMLParser 的代理方法
- (void)download{
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1/myApache/greek.zip"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [[[AFHTTPSessionManager manager] downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
//            NSLog(@"progress:%@",downloadProgress);
        NSLog(@"progress:%f",downloadProgress.fractionCompleted);
        } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
            NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:response.suggestedFilename];
            //本地文件地址url写法
            NSURL *url = [[NSURL alloc] initFileURLWithPath:path];
            //要写入(保存 的目标文件
            return url;
            
        } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
            NSLog(@"%@",filePath);
        }] resume];
    
}

- (void)get{
    [[AFHTTPSessionManager manager] GET:@"http://127.0.0.1/myApache/demo.json" parameters:nil headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            NSLog(@"progress:%@",downloadProgress);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"success:%@",responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error:%@",error);
        }];
    
    
}

- (void)baiDu{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //修改相应的序列化器
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:@"http://www.baidu.com" parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *html = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",html);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

@end
