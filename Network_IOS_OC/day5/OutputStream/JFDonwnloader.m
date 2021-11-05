//
//  JFDonwnloader.m
//  OutputStream
//
//  Created by 翟佳阳 on 2021/11/5.
//

#import "JFDonwnloader.h"
@interface JFDonwnloader () <NSURLConnectionDataDelegate>
//文件的总大小
@property (nonatomic, assign) long long expectedContentLength;
//总共下载的文件大小
@property (nonatomic, assign) long long currentFileSize;

@property (nonatomic, strong) NSOutputStream *stream;


@end


@implementation JFDonwnloader


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
    
    //创建流
    self.stream = [NSOutputStream outputStreamToFileAtPath:@"/Users/kaixin/Documents/my_github/basic_cs_learning/Network_IOS_OC/day5/121.json" append:YES];
    
    //打开流
    [self.stream open];
}

//一点一点接收数据
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    //当前下载的大小
    self.currentFileSize += data.length;
    
    //存一下当前下载的数据
    
    float process = self.currentFileSize * 1.0 / self.expectedContentLength;
    NSLog(@"%f",process);
    
    //一点一点保存文件
    //unit8_t 一个字节
    //unit8_t* 一个地址 数组本身就是一个地址，传一个字节数组
    [self.stream write:data.bytes maxLength:data.length];
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //这个方法写文件 如果文件已经存在就替换 没有就创建
//    [self.mutableData writeToFile:@"/Users/kaixin/Documents/my_github/basic_cs_learning/Network_IOS_OC/day5/121.json" atomically:YES];
    NSLog(@"下载完成");
    
    //关闭流
    [self.stream close];
}

//处理错误
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"下载出错 %@",error);
}

#pragma mark -m 其他
  

@end
