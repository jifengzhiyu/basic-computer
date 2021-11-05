//
//  JFProcessView.m
//  断点续传
//
//  Created by 翟佳阳 on 2021/11/5.
//

#import "JFProcessView.h"

@implementation JFProcessView
- (void)setProcess:(float)process
{
    _process = process;

        [self setTitle:[NSString stringWithFormat:@"%0.2f%%",process * 100] forState:UIControlStateNormal];
        [self setNeedsDisplay];
    
    
    
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint center = CGPointMake(rect.size.width / 2, rect.size.height / 2);
    CGFloat radius = MIN(center.x, center.y) - 5;
    CGFloat startAngle = -M_PI_2;
    CGFloat endAngle = 2 * M_PI * self.process + startAngle;
    
    [path addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    
    path.lineWidth = 5;
    path.lineCapStyle = kCGLineCapRound;
    [[UIColor orangeColor] setStroke];
    
    [path stroke];
}


@end
