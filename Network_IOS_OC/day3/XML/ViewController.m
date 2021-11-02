//
//  ViewController.m
//  XML
//
//  Created by 翟佳阳 on 2021/11/1.
//

#import "ViewController.h"
#import "Video.h"
@interface ViewController ()<NSXMLParserDelegate>
@property (nonatomic, copy) NSMutableArray *videos;
@property (nonatomic, strong) Video *currentVideo;
//存储当前节点的内容
@property (nonatomic, copy) NSMutableString *mString;



@end

@implementation ViewController
- (NSMutableArray *)videos{
    if(_videos == nil){
        _videos = [NSMutableArray arrayWithCapacity:10];
    }
    return _videos;
}

- (NSMutableString *)mString{
    if(_mString == nil){
        _mString = [NSMutableString string];
    }
    return _mString;
}

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
            NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
            //设置代理
            parser.delegate = self;
            //执行代理方法 解析
            [parser parse];
            
            
               
        }else{
            NSLog(@"服务器内部错误");
        }
    }];
}


#pragma mark - 代理方法
- (void)parserDidStartDocument:(NSXMLParser *)parser{
    NSLog(@"1开始解析文档");
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict{
    //elementName节点的名称
    //attributeDict标签的属性
    NSLog(@"2找开始的节点%@--%@",elementName,attributeDict);
    
    if([elementName isEqualToString:@"video"]){
         self.currentVideo = [Video new];
         self.currentVideo.videoId = @(attributeDict[@"videoId"].intValue);
        
        [self.videos addObject:self.currentVideo];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    NSLog(@"3找到节点之间的内容");
    //拼接字符串
    [self.mString appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    NSLog(@"4找到结束节点%@",elementName);
    //先判断
//    if ([elementName isEqualToString:@"name"]) {
//        self.currentVideo.name = self.mString;
//    }else if([elementName isEqualToString:@"length"]) {
//        self.currentVideo.length = @(self.mString.intValue);
//    }else if([elementName isEqualToString:@"videoURL"]) {
//        self.currentVideo.videoURL = self.mString;
//    }else if([elementName isEqualToString:@"imageURL"]) {
//        self.currentVideo.imageURL = self.mString;
//    }else if([elementName isEqualToString:@"desc"]) {
//        self.currentVideo.desc = self.mString;
//    }else if([elementName isEqualToString:@"teacher"]) {
//        self.currentVideo.teacher = self.mString;
//    }
    if(![elementName isEqualToString:@"video"] && ![elementName isEqualToString:@"videos"]){
        //把self.mString地址 赋给 对应属性的地址, 数值会随着原始变量值 的改变而改变
        //不会做 类型的转换
        [self.currentVideo setValue:self.mString forKey:elementName];
    }
    
    //清空可变字符串
    [self.mString setString:@""];
}

- (void)parserDidEndDocument:(NSXMLParser *)parser{
    NSLog(@"5结束解析文档");
    NSLog(@"%@",self.videos);
}


- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    NSLog(@"出错");
}

@end
