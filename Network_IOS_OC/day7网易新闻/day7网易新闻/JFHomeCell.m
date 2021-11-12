//
//  JFHomeCell.m
//  day7网易新闻
//
//  Created by 翟佳阳 on 2021/11/12.
//

#import "JFHomeCell.h"
#import "JFNewsController.h"
@interface JFHomeCell ()
//对它强引用
@property (nonatomic, strong) JFNewsController *newsController;


@end
@implementation JFHomeCell
//当cell从xib或sb中加载完成，加载另一个sb中的新闻列表
- (void)awakeFromNib {
    [super awakeFromNib];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"News" bundle:nil];
    self.newsController = [sb instantiateInitialViewController];
    //强引用，就不会改方法结束后就销毁
    [self.contentView addSubview:self.newsController.view];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //让控制器的view的大小和cell的大小一样
    self.newsController.view.frame = self.bounds;
    
    NSLog(@"单元格高度:%f",self.bounds.size.height);
}

@end
