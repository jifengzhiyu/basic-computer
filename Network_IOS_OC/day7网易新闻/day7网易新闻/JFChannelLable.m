//
//  JFChannelLable.m
//  day7网易新闻
//
//  Created by 翟佳阳 on 2021/11/12.
//

#import "JFChannelLable.h"
#define kBIGFONT 18
#define kSMALLFONT 14
@implementation JFChannelLable
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (instancetype)channelLabelWithTName:(NSString *)tname {
    JFChannelLable *lbl = [self new];
    lbl.text = tname;
    lbl.textAlignment = NSTextAlignmentCenter;
    //让label的大小和大字体一样
    lbl.font = [UIFont systemFontOfSize:kBIGFONT];
    [lbl sizeToFit];
    
    //
    lbl.font = [UIFont systemFontOfSize:kSMALLFONT];
    return lbl;
}
@end
