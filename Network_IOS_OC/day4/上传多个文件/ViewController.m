//
//  ViewController.m
//  上传多个文件
//
//  Created by 翟佳阳 on 2021/11/4.
//

#import "ViewController.h"
#import "UploadFiles.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //获取文件的路径
    NSString *path1 = [[NSBundle mainBundle] pathForResource:@"01.jpg" ofType:nil];
    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"06.jpg" ofType:nil];
    NSArray *filePaths = @[path1,path2];
    
    //获取参数
    NSDictionary *params = @{@"username":@"zhangsan"};
    
    [UploadFiles uploadFiles:@"http:/127.0.0.1/myApache/php/upload/upload-m.php" fieldName:@"userfile[]" filePathes:filePaths  params:params];
    
}



@end
