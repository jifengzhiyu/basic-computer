//
//  ViewController.m
//  解决数组输出汉字
//
//  Created by 翟佳阳 on 2021/10/31.
//

#import "ViewController.h"
#import "Person.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    NSArray *names = @[@"嗷嗷",@"不变",@"存储"];
//    NSLog(@"%@",names);
    
    Person *peron1 = [Person new];
    peron1.name = @"爱不爱";
    peron1.age = 20;
    NSLog(@"%@",peron1);
}


@end
