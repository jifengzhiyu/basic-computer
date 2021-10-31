//
//  ViewController.m
//  plist的解析
//
//  Created by 翟佳阳 on 2021/10/31.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //NSArray *array = NSArray arrayWithContentsOfFile:<#(nonnull NSString *)#>];
    
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1/myApache/videos.plist"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if(connectionError){
            NSLog(@"连接错误：%@",connectionError);
            return;
        }
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if(httpResponse.statusCode == 200 || httpResponse.statusCode == 304){
            //解析数据
            id plist = [NSPropertyListSerialization propertyListWithData:data options:0 format:0 error:NULL];
            NSLog(@"%@",plist);
            NSLog(@"%@",[plist class]);
        }else{
            NSLog(@"服务器内部错误");
        }
    }];
}


@end
