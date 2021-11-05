//
//  JFDonwnloader.m
//  DownloadDelegate
//
//  Created by 翟佳阳 on 2021/11/5.
//

#import "JFDonwnloader.h"
//只有报刊杂志类型的应用才能使用NSURLConnectionDownloadDelegate，否则的话文件不会保存
//#import <NewsstandKit/NewsstandKit.h>
@interface JFDonwnloader () <NSURLConnectionDownloadDelegate>


@end

@implementation JFDonwnloader
- (void)download:(NSString *)urlString{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
   
    //NSURLConnection 下载过程是在当前线程(代理设置的线程）的消息循环中下载的
    //不合理 耗时操作会卡死
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    //If you don’t schedule the connection in a run loop or an operation queue before calling this method, the connection is scheduled in the current run loop in the default mode.
    //就只能进行一种操作，滚动啥的就不会下载了
    //[conn start];
}

#pragma mark - m 代理方法
//下载进度
- (void)connection:(NSURLConnection *)connection didWriteData:(long long)bytesWritten totalBytesWritten:(long long)totalBytesWritten expectedTotalBytes:(long long) expectedTotalBytes{
    //bytesWritten 本次下载了多少字节
    //totalBytesWritten  总共下载了多少字节
    //expectedTotalBytes  文件的大小
    float process = totalBytesWritten * 1.0 / expectedTotalBytes;
    NSLog(@"下载进度 %f",process);
    //默认主线程
    //NSLog(@"%@",[NSThread currentThread]);
}

//续传文件
- (void)connectionDidResumeDownloading:(NSURLConnection *)connection totalBytesWritten:(long long)totalBytesWritten expectedTotalBytes:(long long) expectedTotalBytes{
    
}
//下载完成
- (void)connectionDidFinishDownloading:(NSURLConnection *)connection destinationURL:(NSURL *) destinationURL{
    NSLog(@"下载完成 %@",destinationURL);

}

//处理错误
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"error:%@",error);
}
@end
