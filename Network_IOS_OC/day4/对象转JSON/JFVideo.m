//
//  JFVideo.m
//  对象转JSON
//
//  Created by 翟佳阳 on 2021/11/4.
//

#import "JFVideo.h"

@implementation JFVideo
//私有成员变量
{
    BOOL _isYellow;
}
- (NSString *)description {
    return [NSString stringWithFormat:@"%@{videoName:%@,size:%d,author:%@,_isYellow:%d}",[super description],self.videoName,self.size,self.author,_isYellow];
}
@end
