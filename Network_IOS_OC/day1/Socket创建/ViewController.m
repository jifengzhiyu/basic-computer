//
//  ViewController.m
//  Socket创建
//
//  Created by 翟佳阳 on 2021/10/30.
//

#import "ViewController.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //创建
    int clientSocket = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
    //连接服务器
    struct sockaddr_in addr;
    addr.sin_family = AF_INET;
    addr.sin_addr.s_addr = inet_addr("127.0.0.1");
    addr.sin_port = htons(12345);
    
    int result = connect(clientSocket, (const struct sockaddr *)&addr, sizeof(addr));
    if(result != 0){
        NSLog(@"失败");
        return;
    }
    
    //向服务器发送数据
    const char *msg = "hello world";
    size_t sendCount = send(clientSocket, msg, strlen(msg), 0);
    NSLog(@"发送的字节数%zd",sendCount);
    
    //接受服务器返回的数据
    //返回实际接收的子节个数
    uint8_t buffer[1024];
    ssize_t recvCount = recv(clientSocket, buffer, sizeof(buffer), 0);
    NSLog(@"接收的字节数:%zd",recvCount);
    //把子节数组转化成字符串
    NSData *data = [NSData dataWithBytes:buffer length:recvCount];
    NSString *recvMsg = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"收到：%@",recvMsg);
    
    //关闭连接
    close(clientSocket);
   
}


@end
