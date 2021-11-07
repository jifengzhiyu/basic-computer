//
//  ViewController.m
//  DownloadTask
//
//  Created by 翟佳阳 on 2021/11/6.
//

#import "ViewController.h"

@interface ViewController ()


@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self downloadTask];
}



- (void)downloadTask{
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1//myApache/greek.zip"];
    
    [[[NSURLSession sharedSession] downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@",location);
        NSString *doc = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"123.zip"];
        //复制下载好的文件到其他位置
        [[NSFileManager defaultManager] copyItemAtPath:location.path toPath:doc error:NULL];
        NSLog(@"%@",[NSThread currentThread]);
    }]resume];
}
@end
