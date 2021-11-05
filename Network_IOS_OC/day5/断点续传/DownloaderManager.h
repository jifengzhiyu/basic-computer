//
//  DownloaderManager.h
//  断点续传
//
//  Created by 翟佳阳 on 2021/11/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DownloaderManager : UIButton
+ (instancetype)sharedManager;

- (void)download:(NSString *)urlString successBlcok:(void(^)(NSString *path))successBlcok processBlock:(void(^)(float process))processBlock errorBlock:(void(^)(NSError *error))errorBlcok;

//暂停
- (void)pause:(NSString *)urlString;
@end

NS_ASSUME_NONNULL_END
