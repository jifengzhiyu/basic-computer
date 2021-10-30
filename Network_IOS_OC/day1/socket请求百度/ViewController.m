//
//  ViewController.m
//  socket请求百度
//
//  Created by 翟佳阳 on 2021/10/30.
//

#import "ViewController.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, assign) int clientSocket;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //连接百度服务器
    BOOL result = [self connect:@"61.135.169.125" port:80];
    if(!result){
        NSLog(@"连接失败");
        return;
    }
    NSLog(@"连接成功");
    
    //构造http请求 头
    NSString *request = @"GET / HTTP/1.1\r\n"
                        "Host: www.baidu.com\r\n"
                        "Connection: close\r\n\r\n";
    //服务器返回的响应头
    NSString *respose = [self sendAndRecv:request];
    NSLog(@"%@",respose);
    
    //关闭连接
    close(self.clientSocket);
    
    //截取响应体 \r\n\r\n\n<!
    //找到\r\n\r\n\n 的范围
    NSRange range = [respose rangeOfString:@"\r\n\r\n"];
    //从\r\n\r\n\n之后的第一个位置开始截取 响应体
    NSString *html = [respose substringFromIndex:range.length + range.location];
    
    //baseURL到哪里取其他文件
    [self.webView loadHTMLString:html baseURL:[NSURL URLWithString:@"http://www.baidu.com"]];
    
}

//连接服务器
- (BOOL)connect:(NSString *)ip port:(int)port{
    //创建
    int clientSocket = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
    self.clientSocket = clientSocket;
    //连接服务器
    struct sockaddr_in addr;
    addr.sin_family = AF_INET;
    addr.sin_addr.s_addr = inet_addr(ip.UTF8String);
    addr.sin_port = htons(port);

    int result = connect(clientSocket, (const struct sockaddr *)&addr, sizeof(addr));
        if(result == 0){
            return YES;
        }else{
            return NO;
        }
}

//发送接收数据
- (NSString *)sendAndRecv:(NSString *)senfMsg{
    //向服务器发送数据
    const char *msg = senfMsg.UTF8String;
    size_t sendCount = send(self.clientSocket, msg, strlen(msg), 0);
    NSLog(@"发送的字节数%zd",sendCount);
    
    //接受服务器返回的数据
    //返回实际接收的子节个数
    uint8_t buffer[1024];
    NSMutableData *mData = [NSMutableData data];
    //recvCount最后一次收到数据0
    //收不到数据 -1
    ssize_t recvCount = recv(self.clientSocket, buffer, sizeof(buffer), 0);
    [mData appendBytes:buffer length:recvCount];
    //服务器返回多次数据，直到返回完成
    while (recvCount != 0) {
        recvCount = recv(self.clientSocket, buffer, sizeof(buffer), 0);
        [mData appendBytes:buffer length:recvCount];
    }
    NSLog(@"接收的字节数:%zd",recvCount);
    //把子节数组转化成字符串
    NSString *recvMsg = [[NSString alloc] initWithData:mData encoding:NSUTF8StringEncoding];
//    NSLog(@"收到：%@",recvMsg);
    return recvMsg;
}

@end
