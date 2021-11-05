//
//  JFDonwnloader.m
//  下载
//
//  Created by 翟佳阳 on 2021/11/5.
//

#import "JFDonwnloader.h"

@implementation JFDonwnloader
- (void)download:(NSString *)urlString{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if(connectionError){
            NSLog(@"连接错误：%@",connectionError);
            return;
        }
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if(httpResponse.statusCode == 200 || httpResponse.statusCode == 304){
            //解析数据
            [data writeToFile:@"/Users/kaixin/Documents/my_github/basic_cs_learning/Network_IOS_OC/day5/121.json" atomically:YES];
            NSLog(@"下载成功");
            
        }else{
            NSLog(@"服务器内部错误");
        }
    }];
}
@end
