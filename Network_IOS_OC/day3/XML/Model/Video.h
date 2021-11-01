#import <Foundation/Foundation.h>

@interface Video : NSObject

@property (nonatomic, strong) NSNumber *videoId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSNumber *length;
@property (nonatomic, copy) NSString *videoURL;
@property (nonatomic, copy) NSString *imageURL;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *teacher;

@property (nonatomic, readonly) NSString *time;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)videoWithDict:(NSDictionary *)dict;

@end
