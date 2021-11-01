//
//  JFTableViewCell.h
//  模拟科技头条
//
//  Created by 翟佳阳 on 2021/11/1.
//

#import <UIKit/UIKit.h>
@class JFNews;
NS_ASSUME_NONNULL_BEGIN

@interface JFTableViewCell : UITableViewCell
@property (nonatomic, strong) JFNews *news;

+ (NSString *)getReuseID:(JFNews *)news;
@end

NS_ASSUME_NONNULL_END
