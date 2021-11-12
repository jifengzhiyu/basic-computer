//
//  ViewController.m
//  WebView
//
//  Created by 翟佳阳 on 2021/11/12.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"index.html" withExtension:nil];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
    //自动检测电话号码，网址，邮件地址
    self.webView.dataDetectorTypes = UIDataDetectorTypeAll;
    //缩放网页
    self.webView.scalesPageToFit = YES;
}
- (void)loadView {
    self.webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.webView;
}

@end
