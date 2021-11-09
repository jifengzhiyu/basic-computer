//
//  JFHeadLineCell.m
//  day7网易新闻
//
//  Created by 翟佳阳 on 2021/11/9.
//

#import "JFHeadLineCell.h"
#import "JFHeadLine.h"
#import <UIImageView+AFNetworking.h>

@interface JFHeadLineCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgsrcView;
@property (weak, nonatomic) IBOutlet UILabel *titleView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@end
@implementation JFHeadLineCell

- (void)setHeadline:(JFHeadLine *)headline{
   
        _headline = headline;
        //解决重用的问题
        self.imgsrcView.image = nil;
        self.titleView.text = nil;
    
        [self.imgsrcView setImageWithURL:[NSURL URLWithString:headline.imgsrc]];
        
        self.titleView.text = headline.title;
        //设置当前是第几张图片
        self.pageControl.currentPage = self.tag;
        
}
@end
