//
//  ViewController.m
//  模拟登录
//
//  Created by 翟佳阳 on 2021/11/2.
//

#import "ViewController.h"
#define JFNAMEKEY @"name"
#define JFPWDKEY @"pwd"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameView;
@property (weak, nonatomic) IBOutlet UITextField *pwdView;

@end

@implementation ViewController


- (IBAction)loginClick:(id)sender {
    NSString *name = self.nameView.text;
    NSString *pwd = self.pwdView.text;
    
    [self login:name andPwd:pwd];
    
}

- (void)login:(NSString *)name andPwd:(NSString *)pwd{
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1/myApache/php/login.php"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //设置post
    request.HTTPMethod = @"post";
    
    //对密码进行加密
    pwd = [self base64Encode:pwd];
    NSLog(@"%@",pwd);
    
    //设置请求体
    NSString *body = [NSString stringWithFormat:@"username=%@&password=%@",name,pwd];
    request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if(connectionError){
            NSLog(@"连接错误：%@",connectionError);
            return;
        }
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if(httpResponse.statusCode == 200 || httpResponse.statusCode == 304){
            //解析数据
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            //判断登录成功还是失败
            if([dic [@"userId"] intValue] > 0){
                NSLog(@"成功");
                //登录成功后，把账号密码记录到沙盒中(偏好设置
                [self saveUserInfo];
            }else{
                NSLog(@"失败");
            }
            
        }else{
            NSLog(@"服务器内部错误");
        }
    }];
}

- (void)saveUserInfo{
    //获取偏好设置对象
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:self.nameView.text forKey:JFNAMEKEY];
    [userDefaults setObject:[self base64Encode:self.pwdView.text] forKey:JFPWDKEY];
    
    //保存
    [userDefaults synchronize];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadUserInfo];
}

//重新加载应用，读取沙盒保存信息
- (void)loadUserInfo{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.nameView.text = [userDefaults objectForKey:JFNAMEKEY];
    NSString *pwd = [userDefaults objectForKey:JFPWDKEY];
    
    //解密
    pwd = [self base64Decode:pwd];
    self.pwdView.text = pwd;
}

//base64 “加密”,直接操作二进制数据
- (NSString *)base64Encode:(NSString *)str{
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}

//base64 “解密”
- (NSString *)base64Decode:(NSString *)str{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:str options:0];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}
@end
