//
//  ViewController.m
//  压缩&解压缩
//
//  Created by 翟佳阳 on 2021/11/6.
//

#import "ViewController.h"
#import "SSZipArchive.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //压缩
    [SSZipArchive createZipFileAtPath:@"/Users/kaixin/Downloads/111.zip" withContentsOfDirectory:@"/Users/kaixin/Downloads/希腊语阅读"];
}
 
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1/myApache/greek.zip"];
    [[[NSURLSession sharedSession] downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //解压
            [SSZipArchive unzipFileAtPath:location.path toDestination:[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]];
            NSLog(@"解压完成%@",location);
        }] resume];
}
@end
