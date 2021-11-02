//
//  ViewController.m
//  DOM方式解析
//
//  Created by 翟佳阳 on 2021/11/2.
//

#import "ViewController.h"
#import "GDataXMLNode.h"
#import "Video.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadXML];
}

- (void)loadXML{
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1/myApache/videos.xml"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if(connectionError){
            NSLog(@"连接错误：%@",connectionError);
            return;
        }
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if(httpResponse.statusCode == 200 || httpResponse.statusCode == 304){
            //解析数据
            GDataXMLDocument *document = [[GDataXMLDocument alloc]initWithData:data error:NULL];
            //获取XML 跟元素
            GDataXMLElement *rootElement = document.rootElement;
//            NSLog(@"%@",rootElement);
            //遍历所有 video节点
            NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:10];
            for (GDataXMLElement *element in rootElement.children) {
                Video *v = [Video new];
                [mArray addObject:v];
                
                //给对象的属性赋值
                //1遍历video的子标签
                for (GDataXMLElement *subElement in element.children) {
                    [v setValue:subElement.stringValue forKey:subElement.name];
                }
                
                //2遍历video的属性 id之类
                for (GDataXMLNode *attr in element.attributes) {
                    [v setValue:attr.stringValue forKey:attr.name];
                }
            }
            NSLog(@"%@",mArray);
        }else{
            NSLog(@"服务器内部错误");
        }
    }];
}

@end
