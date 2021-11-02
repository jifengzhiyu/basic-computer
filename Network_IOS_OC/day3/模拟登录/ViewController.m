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
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
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
            if([dic [@"userId"] intValue] != -1){
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
    [userDefaults setObject:self.pwdView.text forKey:JFPWDKEY];
    
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
    self.pwdView.text = [userDefaults objectForKey:JFPWDKEY];
}

@end
