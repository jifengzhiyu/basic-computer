//
//  DownloaderManager.m
//  断点续传
//
//  Created by 翟佳阳 on 2021/11/5.
//

#import "DownloaderManager.h"
#import "JFDonwnloader.h"

@interface DownloaderManager ()

//下载操作缓存池
@property (nonatomic, strong) NSMutableDictionary *downloadCache;


@end



@implementation DownloaderManager
//懒加载
- (NSMutableDictionary *)downloadCache
{
    if(_downloadCache == nil)
    {
        _downloadCache = [[NSMutableDictionary alloc] initWithCapacity:10];
    }
    return _downloadCache;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (instancetype)sharedManager
{
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
    });
    return instance;
}

- (void)download:(NSString *)urlString successBlcok:(void(^)(NSString *path))successBlcok processBlock:(void(^)(float process))processBlock errorBlock:(void(^)(NSError *error))errorBlcok{

    //判断操作缓存池里是否有 下载操作
    if(self.downloadCache[urlString]){
        NSLog(@"正在下载");
        return;
    }
    //下载文件
    JFDonwnloader *downloader = [JFDonwnloader downloader:urlString successBlcok:^(NSString * _Nonnull path) {
        //移除下载操作
        [self.downloadCache removeObjectForKey:urlString];
        if(successBlcok){
            successBlcok(path);
        }
    } processBlock:processBlock errorBlock:^(NSError * _Nonnull error) {
        //移除下载操作
        [self.downloadCache removeObjectForKey:urlString];
        if(errorBlcok){
            errorBlcok(error);
        }
    }];
    
    [[NSOperationQueue new] addOperation:downloader];
    
    //添加到缓存池
    [self.downloadCache setObject:downloader forKey:urlString];
    
    
   
}

- (void)pause:(NSString *)urlString{
    JFDonwnloader *downloader = self.downloadCache[urlString];
    if(downloader == nil){
        NSLog(@"没有下载操作来暂停");
        return;
    }
    //取消connection（取消正在下载的 操作
    
    [downloader pause];
   
    //删除缓存池的下载操作
    [self.downloadCache removeObjectForKey:urlString];
}
@end
