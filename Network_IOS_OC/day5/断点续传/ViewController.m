//
//  ViewController.m
//  断点续传
//
//  Created by 翟佳阳 on 2021/11/5.
//

#import "ViewController.h"
#import "JFProcessView.h"
#import "DownloaderManager.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet JFProcessView *processView;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[DownloaderManager sharedManager] download:@"http://127.0.0.1/myApache/greek.zip" successBlcok:^(NSString * _Nonnull path) {
            NSLog(@"下载完成");
        } processBlock:^(float process) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.processView.process = process;
            });
        } errorBlock:^(NSError * _Nonnull error) {
            NSLog(@"error:%@",error);
        }];
}

- (IBAction)pause:(id)sender {
    [[DownloaderManager sharedManager] pause:@"http://127.0.0.1/myApache/greek.zip"];
}
@end
