//
//  JFDonwnloader.m
//  NSFileHandle
//
//  Created by 翟佳阳 on 2021/11/5.
//

#import "JFDonwnloader.h"
@interface JFDonwnloader () <NSURLConnectionDataDelegate>
//文件的总大小
@property (nonatomic, assign) long long expectedContentLength;
//总共下载的文件大小
@property (nonatomic, assign) long long currentFileSize;


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
}

//一点一点接收数据
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    //当前下载的大小
    self.currentFileSize += data.length;
    
    //存一下当前下载的数据
    
    float process = self.currentFileSize * 1.0 / self.expectedContentLength;
    NSLog(@"%f",process);
    
    //一点一点保存文件
    [self saveFile:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //这个方法写文件 如果文件已经存在就替换 没有就创建
//    [self.mutableData writeToFile:@"/Users/kaixin/Documents/my_github/basic_cs_learning/Network_IOS_OC/day5/121.json" atomically:YES];
    NSLog(@"下载完成");
}

//处理错误
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"下载出错 %@",error);
}

#pragma mark -m 其他
- (void)saveFile:(NSData *)data{
    //保存文件路径
    NSString *filePath = @"/Users/kaixin/Documents/my_github/basic_cs_learning/Network_IOS_OC/day5/121.json";
    //如果文件不存在，返回nil
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:filePath];
    if(fileHandle == nil){
        //文件不存在，创建文件
        [data writeToFile:filePath atomically:YES];
    }else{
        //让offset指向文件的末尾
        [fileHandle seekToEndOfFile];
        [fileHandle writeData:data];
        //关闭文件
        [fileHandle closeFile];

    }
}
@end
