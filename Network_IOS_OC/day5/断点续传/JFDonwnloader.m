//
//  JFDonwnloader.m
//  断点续传
//
//  Created by 翟佳阳 on 2021/11/5.
//

//断点续传 思路
//1 判断是否存在文件，如果文件不存在 从0开始下载
//2 如果文件存在
    //判断本地的文件大小 == 服务器文件大小  不需要下载
    //判断本地的文件大小 <  服务器文件大小  从当前位置开始下载
    //判断本地的文件大小 >  服务器文件大小  删除文件，从0开始下载
#import "JFDonwnloader.h"
@interface JFDonwnloader () <NSURLConnectionDataDelegate>
//文件的总大小
@property (nonatomic, assign) long long expectedContentLength;
//总共下载的文件大小
@property (nonatomic, assign) long long currentFileSize;

@property (nonatomic, strong) NSOutputStream *stream;

//要保存文件的路径
@property (nonatomic, copy) NSString *filePath;

//回调的block
@property (nonatomic, copy) void (^successBlock)(NSString *path);
@property (nonatomic, copy) void (^processBlock)(float process);
@property (nonatomic, copy) void (^errorBlock)(NSError *error);

@property (nonatomic, strong) NSURLConnection *conn;

@property (nonatomic, copy) NSString *urlString;

@end


@implementation JFDonwnloader
+ (instancetype)downloader:(NSString *)urlString successBlcok:(void(^)(NSString *path))successBlcok processBlock:(void(^)(float process))processBlock errorBlock:(void(^)(NSError *error))errorBlcok{

    JFDonwnloader *downloader = [JFDonwnloader new];
    downloader.successBlock = successBlcok;
    downloader.processBlock = processBlock;
    downloader.errorBlock = errorBlcok;
    
    downloader.urlString = urlString;
    
    return downloader;
}

# pragma mark  代理方法

//接收到响应头
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    //文件总大小
    self.expectedContentLength = response.expectedContentLength;
    
    //创建流
    self.stream = [NSOutputStream outputStreamToFileAtPath:self.filePath append:YES];
    
    //打开流
    [self.stream open];
}

//一点一点接收数据
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    //当前下载的大小
    self.currentFileSize += data.length;
    
    //存一下当前下载的数据
    
    float process = self.currentFileSize * 1.0 / self.expectedContentLength;
//    NSLog(@"%f---%@",process,[NSThread currentThread]);
    
    //一点一点保存文件
    //unit8_t 一个字节
    //unit8_t* 一个地址 数组本身就是一个地址，传一个字节数组
    [self.stream write:data.bytes maxLength:data.length];
    
    if(self.processBlock){
        self.processBlock(process);
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //这个方法写文件 如果文件已经存在就替换 没有就创建
//    [self.mutableData writeToFile:@"/Users/kaixin/Documents/my_github/basic_cs_learning/Network_IOS_OC/day5/121.json" atomically:YES];
    //NSLog(@"下载完成");
    
    //关闭流
    [self.stream close];
    
    if(self.successBlock){
        //回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            self.successBlock(self.filePath);
        });
    }
}

//处理错误
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"下载出错 %@",error);
    if(self.errorBlock){
        self.errorBlock(error);
    }
}

#pragma mark  其他
//下载之前，获取服务器文件的大小和名称
- (void)getServerFileInfo:(NSURL *)url{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"head";
    //如果不设置，默认get，会把文件先下载下来
    
    NSURLResponse *response = nil;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:NULL];
    
    self.expectedContentLength = response.expectedContentLength;
    self.filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:response.suggestedFilename];
}

//获取本地文件的大小，并且和服务器文件比较
//1 判断文件是否存在，如果文件不存在 返回0  从开始位置下载
//2 本地文件的大小
//3 本地文件的大小  服务器文件大小比较
    //本地文件的大小 == 服务器文件大小比较  返回-1  已经下载完毕
    //本地文件的大小 <  服务器文件大小比较  返回fileSize
    //本地文件的大小 >  服务器文件大小比较  删除文件，返回0  从开始位置下载
- (long long)checkLocalFileInfo{
    long long fileSize = 0;
    NSFileManager *fileMnager = [NSFileManager defaultManager];
    if([fileMnager fileExistsAtPath:self.filePath]){
        //如果文件存在，比较服务器文件大小
        //本地文件的大小
        NSDictionary *attrs = [fileMnager attributesOfItemAtPath:self.filePath error:NULL];
        fileSize = attrs.fileSize;
       // NSLog(@"%@",attrs);
        
        if(fileSize == self.expectedContentLength){
            fileSize = -1;
        }
        
        if(fileSize > self.expectedContentLength){
            fileSize = 0;
            
            //删除文件
            [fileMnager removeItemAtPath:self.filePath error:NULL];
        }
    }
    return fileSize;
}



- (void)pause{
    [self.conn cancel];
    //取消自定义操作，取消没有执行的操作
    //和自定义操作的cancel和用，可以最大限度地达到取消的效果
    [self cancel];
    //    [self cancel];无法取消正在进行的 conn

}
#pragma mark 自定义operaton
//重写main
//把自定义操作添加到队列，自动执行main，在子线程
- (void)main{
    @autoreleasepool {
        
        NSURL *url = [NSURL URLWithString:self.urlString];
        
        //下载之前，获取服务器文件的大小和名称
        [self getServerFileInfo:url];
        
        //也取消正在进行的操作
        if(self.isCancelled){
            return;
        }
        
        //获取本地文件的大小，并且和服务器文件比较
        self.currentFileSize = [self checkLocalFileInfo];
        if(self.currentFileSize == -1){
    //        NSLog(@"已下载，请不要重复下载");
            if(self.successBlock){
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.successBlock(self.filePath);
                });
            }
            return;
        }
        //也取消正在进行的操作
        if(self.isCancelled){
            return;
        }
        //请求头
        //Range:bytes=x-y  从x个字节下载到y个字节
        //Range:bytes=x-   从x个字节下到最后
        //Range:bytes=-y   从头下到第y个字节
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setValue:[NSString stringWithFormat:@"bytes=%lld-",self.currentFileSize] forHTTPHeaderField:@"Range"];

        //NSURLConnection 下载过程是在当前线程的消息循环中下载的
        //设置connection的代理。下载过程是在当前线程的消息循环中下载的
        NSURLConnection *conn =  [[NSURLConnection alloc] initWithRequest:request delegate:self];
    self.conn = conn;
    
    //子线程的runLoop需要手动开启
    [[NSRunLoop currentRunLoop] run];
    }
}
@end
