//
//  JFHomeController.m
//  day7网易新闻
//
//  Created by 翟佳阳 on 2021/11/11.
//

#import "JFHomeController.h"
#import "JFChannel.h"
#import "JFChannelLable.h"
#import "JFHomeCell.h"
@interface JFHomeController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) NSArray *channels;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

@end

@implementation JFHomeController
#pragma mark 懒加载
//从本地获取数据（不需要考虑网络的线程
//懒加载
- (NSArray *)channels {
    if (_channels == nil) {
        _channels = [JFChannel channels];
    }
    return _channels;
}
#pragma mark viewDidLoad

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //NSLog(@"%@",self.channels);
    
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal ;
    self.flowLayout.minimumInteritemSpacing = 0;
    self.flowLayout.minimumLineSpacing = 0;
    
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    //加载新闻分类
    [self loadChannels];

}
#pragma mark viewDidLayoutSubviews

//当计算好collectionView的大小。再设置cell的大小
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.flowLayout.itemSize = self.collectionView.bounds.size;
    NSLog(@"collectionView高度:%f",self.collectionView.bounds.size.height);
}

#pragma mark loadChannels

//在导航控制器中如果出现了scrollView，会自动加上64的偏移
- (void)loadChannels {
    //不让控制器自动生成64的偏移
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    CGFloat marginX = 5;
    CGFloat x = marginX;
    CGFloat h = self.scrollView.bounds.size.height;
    
    
    for (JFChannel *channel in self.channels) {
        JFChannelLable *lbl = [JFChannelLable channelLabelWithTName:channel.tname];
        [self.scrollView addSubview:lbl];
        
        lbl.frame = CGRectMake(x, 0, lbl.bounds.size.width, h);
        x += lbl.bounds.size.width + marginX;
    }
    
    //设置滚动范围
    self.scrollView.contentSize = CGSizeMake(x, 0);
    self.scrollView.showsHorizontalScrollIndicator = NO;
}

#pragma mark 数据源方法

//数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.channels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JFHomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"news" forIndexPath:indexPath];
    
    
    return cell;
}
@end
