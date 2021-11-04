//
//  ViewController.m
//  上传单个文件
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
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"06.jpg" ofType:nil];
    [self uploadFile:@"http://127.0.0.1/myApache/php/upload/upload.php" fieldName:@"userfile" filePath:path];
}
//http://127.0.0.1/myApache/php/upload/upload.php
#define kBOUNDARY @"ababa"
//上传单个文件
- (void)uploadFile:(NSString *)urlString fieldName:(NSString *)fieldName filePath:(NSString *)filePath{
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //设置post
    request.HTTPMethod = @"post";
    //设置请求头
    [request setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@",kBOUNDARY] forHTTPHeaderField:@"Content-Type"];
    //设置请求体
    request.HTTPBody = [self makeBody:fieldName filePath:filePath];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if(connectionError){
            NSLog(@"连接错误：%@",connectionError);
            return;
        }
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if(httpResponse.statusCode == 200 || httpResponse.statusCode == 304){
            //解析数据
            id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            NSLog(@"%@",json);
        }else{
            NSLog(@"服务器内部错误");
        }
    }];
}

//body
- (NSData *)makeBody:(NSString *)fieldName filePath:(NSString *)filePath{
    NSMutableData *mData = [NSMutableData data];
    //第一部分
    NSMutableString *mString = [NSMutableString string];
    [mString appendFormat:@"--%@\r\n",kBOUNDARY];
    [mString appendFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n",fieldName,[filePath lastPathComponent]];
    [mString appendString:@"Content-Type: application/octet-stream\r\n"];
    [mString appendString:@"\r\n"];
    
    //
    [mData appendData:[mString dataUsingEncoding:NSUTF8StringEncoding]];
    //第二部分
    //加载文件
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    //
    [mData appendData:data];
    
    //第三部分
    NSString *end = [NSString stringWithFormat:@"\r\n--%@--",kBOUNDARY];
    [mData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    return mData.copy;
}
@end
