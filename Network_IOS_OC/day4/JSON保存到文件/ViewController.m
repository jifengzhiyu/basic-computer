//
//  ViewController.m
//  JSON保存到文件
//
//  Created by 翟佳阳 on 2021/11/4.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self saveJSON];
    [self readJSON];
}

- (void)saveJSON{
    NSDictionary *dic = @{@"name":@"aba",@"age":@(12)};
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:0 error:NULL];
    
    [data writeToFile:@"/Users/kaixin/Documents/my_github/basic_cs_learning/Network_IOS_OC/day4/123.json" atomically:YES];
}

- (void)readJSON{
    NSData *data = [NSData dataWithContentsOfFile:@"/Users/kaixin/Documents/my_github/basic_cs_learning/Network_IOS_OC/day4/123.json"];
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    NSLog(@"%@",json);
}
@end
