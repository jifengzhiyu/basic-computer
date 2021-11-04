//
//  JFVideo.h
//  对象转JSON
//
//  Created by 翟佳阳 on 2021/11/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JFVideo : NSObject
@property (nonatomic, copy) NSString *videoName;
@property (nonatomic, assign) int size;
@property (nonatomic, copy) NSString *author;
@end

NS_ASSUME_NONNULL_END
