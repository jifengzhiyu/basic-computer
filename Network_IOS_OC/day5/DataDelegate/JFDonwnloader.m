//
//  JFDonwnloader.m
//  DataDelegate
//
//  Created by 翟佳阳 on 2021/11/5.
//

#import "JFDonwnloader.h"
@interface JFDonwnloader () <NSURLConnectionDataDelegate>
//文件的总大小
@property (nonatomic, assign) long long expectedContentLength;
//总共下载的文件大小
@property (nonatomic, assign) long long currentFileSize;

@property (nonatomic, strong) NSMutableData *mutableData;

@end
@implementation JFDonwnloader

//初始化 对象必须自己初始化
- (NSMutableData *)mutableData{
    if(_mutableData == nil)
    {
        _mutableData = [NSMutableData new];
    }
    return _mutableData;
}

- (void)download:(NSString *)urlString{

    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //NSURLConnection 下载过程是在当前线程的消息循环中下载的
    NSURLConnection *conn =  [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

# pragma mark -m 代理方法

//接收到响应头
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    //文件总大小
    self.expectedContentLength = response.expectedContentLength;
}

//一点一点接收数据
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    //当前下载的大小
    self.currentFileSize += data.length;
    
    //存一下当前下载的数据
    [self.mutableData appendData:data];
    
    float process = self.currentFileSize * 1.0 / self.expectedContentLength;
    NSLog(@"%f",process);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //这个方法写文件 如果文件已经存在就替换 没有就创建
    [self.mutableData writeToFile:@"/Users/kaixin/Documents/my_github/basic_cs_learning/Network_IOS_OC/day5/121.json" atomically:YES];
    NSLog(@"下载完成");
}

//处理错误
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"下载出错 %@",error);
}
@end
