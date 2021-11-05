//
//  JFDonwnloader.h
//  断点续传
//
//  Created by 翟佳阳 on 2021/11/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JFDonwnloader : NSOperation
+ (instancetype)downloader:(NSString *)urlString successBlcok:(void(^)(NSString *path))successBlcok processBlock:(void(^)(float process))processBlock errorBlock:(void(^)(NSError *error))errorBlcok;

//暂停下载
- (void)pause;
@end

NS_ASSUME_NONNULL_END
