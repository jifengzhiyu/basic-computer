//
//  ViewController.m
//  模拟聊天
//
//  Created by 翟佳阳 on 2021/10/30.
//

#import "ViewController.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *ipView;
//接口
@property (weak, nonatomic) IBOutlet UITextField *portView;
@property (weak, nonatomic) IBOutlet UITextField *sendMsgView;
@property (weak, nonatomic) IBOutlet UILabel *recvMsgView;

@property (nonatomic, assign) int clientSocket;


@end

@implementation ViewController
//连接服务器
- (IBAction)connectClick:(id)sender {
    [self connect:self.ipView.text port:[self.portView.text intValue]];
}
- (IBAction)sendClick:(id)sender {
    self.recvMsgView.text = [self sendAndRecv:self.sendMsgView.text];
}
//关闭连接
- (IBAction)closeClick:(id)sender {
    close(self.clientSocket);
    NSLog(@"关闭");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    ssize_t recvCount = recv(self.clientSocket, buffer, sizeof(buffer), 0);
    NSLog(@"接收的字节数:%zd",recvCount);
    //把子节数组转化成字符串
    NSData *data = [NSData dataWithBytes:buffer length:recvCount];
    NSString *recvMsg = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    NSLog(@"收到：%@",recvMsg);
    return recvMsg;
}
@end
