//
//  ViewController.m
//  NSFileHandle
//
//  Created by 翟佳阳 on 2021/11/5.
//

#import "ViewController.h"
#import "JFDonwnloader.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    JFDonwnloader *downloader = [JFDonwnloader new];
    [downloader download:@"http://127.0.0.1/myApache/videos.plist"];
     
}


@end
