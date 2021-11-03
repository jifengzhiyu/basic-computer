//
//  JFTableViewCell.m
//  模拟科技头条
//
//  Created by 翟佳阳 on 2021/11/1.
//

#import "JFNews.h"
#import "JFTableViewCell.h"
#import "UIImageView+WebCache.h"
@interface JFTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleView;
@property (weak, nonatomic) IBOutlet UILabel *summaryView;
@property (weak, nonatomic) IBOutlet UILabel *sitenameView;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *addtimeView;




@end


@implementation JFTableViewCell

//根据模型数据 返回可重用标识
+ (NSString *)getReuseID:(JFNews *)news{
    if(news.img.length == 0){
        return @"news1";
    }
    return @"news";
}

- (void)setNews:(JFNews *)news
{
    _news = news;
    self.titleView.text = news.title;
    self.summaryView.text = news.summary;
    self.sitenameView.text = news.sitename;
    self.addtimeView.text = news.time;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:news.img]];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    //判断news.title的长度，和lable的长度比较
    //title>labl，隐藏摘要
    //获取title的长度
    
    //lbl不会在第一次加载的时候 计算自动布局
    [self.titleView layoutIfNeeded];
    
    CGFloat titleLength = [self.news.title sizeWithAttributes:@{NSFontAttributeName : self.titleView.font}].width;
    if(titleLength > self.titleView.frame.size.width){
        self.summaryView.hidden = YES;
    }else{
        self.summaryView.hidden = NO;
    }
}

@end
