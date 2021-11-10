//
//  JFNewsCell.m
//  day7网易新闻
//
//  Created by 翟佳阳 on 2021/11/10.
//
#import <UIImageView+AFNetworking.h>
#import "JFNewsCell.h"
#import "JFNews.h"
@interface JFNewsCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgsrcView;
@property (weak, nonatomic) IBOutlet UILabel *titleView;
@property (weak, nonatomic) IBOutlet UILabel *digestView;
@property (weak, nonatomic) IBOutlet UILabel *replyCount;

@end
@implementation JFNewsCell
- (void)setNews:(JFNews *)news {
    [self.imgsrcView setImageWithURL:[NSURL URLWithString:news.imgsrc]];
    
    self.titleView.text = news.title;
    self.digestView.text = news.digest;
    self.replyCount.text = [NSString stringWithFormat:@"%d人回帖",news.replyCount.intValue];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
