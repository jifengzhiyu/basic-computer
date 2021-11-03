//
//  ViewController.m
//  08-模拟登陆
//
//  Created by Apple on 15/10/22.
//  Copyright © 2015年 heima. All rights reserved.
//

#import "ViewController.h"
#import "HMNetworkTool.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameView;
@property (weak, nonatomic) IBOutlet UITextField *pwdView;

@end

@implementation ViewController
//点击登陆
- (IBAction)loginClick:(id)sender {
    [HMNetworkTool sharedNetworkTool].name = self.nameView.text;
    [HMNetworkTool sharedNetworkTool].pwd = self.pwdView.text;
    
    
    [[HMNetworkTool sharedNetworkTool] loginWithSuccess:^{
//        NSLog(@"登陆成功");
        
        //从sb中加载控制器
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *vc = [sb instantiateInitialViewController];
        
        [UIApplication sharedApplication].keyWindow.rootViewController = vc;
        
    } error:^{
        NSLog(@"登陆失败");
    }];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.nameView.text = [HMNetworkTool sharedNetworkTool].name;
    self.pwdView.text = [HMNetworkTool sharedNetworkTool].pwd;
    
    
}



@end
