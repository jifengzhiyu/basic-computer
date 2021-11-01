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

- (void)setNews:(JFNews *)news
{
    _news = news;
    self.titleView.text = news.title;
    self.summaryView.text = news.summary;
    self.sitenameView.text = news.sitename;
    self.addtimeView.text = [NSString stringWithFormat:@"%d",news.addtime.intValue];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:news.img]];
    
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
