//
//  ViewController.m
//  下载进度
//
//  Created by 翟佳阳 on 2021/11/6.
//

#import "ViewController.h"

@interface ViewController ()<NSURLSessionDownloadDelegate>
@property (nonatomic, strong) NSURLSession *session;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self downloadTask];
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
- (void)downloadTask{
    //如果设置代理，还用之前项目的方法（有回调的方法） ，就不会执行代理方法
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1//myApache/greek.zip"];
    [[self.session downloadTaskWithURL:url] resume];
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
}
@end
