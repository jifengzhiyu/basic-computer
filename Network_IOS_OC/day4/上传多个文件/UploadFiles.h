//
//  UploadFiles.h
//  上传多个文件
//
//  Created by 翟佳阳 on 2021/11/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UploadFiles : UITableViewCell
//上传单个文件
+ (void)uploadFile:(NSString *)urlString fieldName:(NSString *)fieldName filePath:(NSString *)filePath;

+ (void)uploadFile:(NSString *)urlString fieldName:(NSString *)fieldName filePath:(NSString *)filePath params:(NSDictionary *)params;

//上传多个文件
+ (void)uploadFiles:(NSString *)urlString fieldName:(NSString *)fieldName filePathes:(NSArray *)filePathes params:(NSDictionary *)params;


@end

NS_ASSUME_NONNULL_END
