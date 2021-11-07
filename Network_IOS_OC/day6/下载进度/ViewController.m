//
//  ViewController.m
//  下载进度
//
//  Created by 翟佳阳 on 2021/11/6.
//

#import "ViewController.h"

@interface ViewController ()<NSURLSessionDownloadDelegate>
@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask;
@property (nonatomic, strong) NSData *resumeData;

@property (weak, nonatomic) IBOutlet UIProgressView *progressView;



@end

@implementation ViewController


#pragma mark 按钮的点击事件
- (IBAction)start:(id)sender {
    [self download];
}
- (IBAction)pause:(id)sender {
    [self.downloadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
        //保存续传的data
        self.resumeData = resumeData;
        //保存到沙盒 文件格式一定是 tmp
        NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:@"121.tmp"];
        [self.resumeData writeToFile:path atomically:YES];
        //但是点击多次暂停 第二次第三次，，没有下载任务downloadTask，没有resumeData
        self.downloadTask = nil;
        //给nil发送消息 不做任何处理
        NSLog(@"%@",resumeData);
    }];
}
- (IBAction)resume:(id)sender {
    //从沙盒中获取续传数据
    NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:@"121.tmp"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]){
        self.resumeData = [NSData dataWithContentsOfFile:path];
    }
    if(self.resumeData == nil){
        return;
    }
    self.downloadTask = [self.session downloadTaskWithResumeData:self.resumeData];
    [self.downloadTask resume];
    //防止狂点继续 重复从之前暂停的地方下载
    self.resumeData = nil;
}
#pragma mark session属性懒加载
//单例对象 设置代理
- (NSURLSession *)session{
    if(_session == nil){
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    }
    return _session;
}

#pragma mark downloadTask
- (void)download{
    //如果设置代理，还用之前项目的方法（有回调的方法） ，就不会执行代理方法
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1//myApache/greek.zip"];
    
    NSURLSessionDownloadTask *downloadTask = [self.session downloadTaskWithURL:url];
    self.downloadTask = downloadTask;
    [downloadTask resume];
    
//    [[self.session downloadTaskWithURL:url] resume];
}

#pragma mark 代理方法
//下载完成
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    NSLog(@"下载完成:%@",location);
}

//续传
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes{
    NSLog(@"续传");
}

//获取进度
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    float process = totalBytesWritten * 1.0 / totalBytesExpectedToWrite;
    NSLog(@"下载进度：%f",process);
    self.progressView.progress = process;
}
@end
