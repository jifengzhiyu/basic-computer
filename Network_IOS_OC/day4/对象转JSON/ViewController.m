//
//  ViewController.m
//  对象转JSON
//
//  Created by 翟佳阳 on 2021/11/4.
//

#import "ViewController.h"
#import "JFVideo.h"
@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
        [super viewDidLoad];
        // Do any additional setup after loading the view.
        
    //一个对象
    {
//    JFVideo *v1 = [JFVideo new];
//    v1.videoName = @"0000.avi";
//    v1.size = 304004;
//    v1.author = @"me";
//
//    //KKC可以给内部的成员变量赋值
//    [v1 setValue:@(YES) forKey:@"_isYellow"];
//
////    NSLog(@"%@",v1);
////自定义对象不能进行JSON序列化， 必须先把自定义对象转换成字典或数组
//    //    //把自定义对象转换成字典 KVC
//        NSDictionary *dic = [v1 dictionaryWithValuesForKeys:@[@"videoName",@"size",@"author",@"_isYellow"]];
//
//        NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:0 error:NULL];
//        [self postJSON:data];
    }
    
    //多个对象 自定义对象数组
    JFVideo *v1 = [[JFVideo alloc] init];
    v1.videoName = @"ll-001.avi";
    v1.size = 500;
    v1.author = @"lilei";
    //KVC给对象内部的成员变量赋值
    [v1 setValue:@(YES) forKey:@"_isYellow"];
    
    JFVideo *v2 = [[JFVideo alloc] init];
    v2.videoName = @"hmm-001.avi";
    v2.size = 500;
    v2.author = @"韩梅梅";
    //KVC给对象内部的成员变量赋值
    [v2 setValue:@(NO) forKey:@"_isYellow"];
    
    NSArray *array = @[v1,v2];
    
//        if (![NSJSONSerialization isValidJSONObject:array]) {
//            NSLog(@"sorry,不能进行JSON序列化");
//            return;
//        }
    
    //把自定义对象的数组，所有的对象都转换成字典
    NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:2];
    for (JFVideo *video in array) {
        //把自定义对象转换成字典 KVC
        NSDictionary *dic = [video dictionaryWithValuesForKeys:@[@"videoName",@"size",@"author",@"_isYellow"]];
        [mArray addObject:dic];
    }
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:mArray options:0 error:NULL];
    [self postJSON:data];
    
    }

    - (void)postJSON:(NSData *)data{
        NSURL *url = [NSURL URLWithString:@"http://127.0.0.1/myApache/php/upload/postjson.php"];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        request.HTTPMethod = @"post";
        request.HTTPBody = data;
        
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
            if(connectionError){
                NSLog(@"连接错误：%@",connectionError);
                return;
            }
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if(httpResponse.statusCode == 200 || httpResponse.statusCode == 304){
                //解析数据
                NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"%@",str);
            }else{
                NSLog(@"服务器内部错误");
            }
        }];
    }



@end
