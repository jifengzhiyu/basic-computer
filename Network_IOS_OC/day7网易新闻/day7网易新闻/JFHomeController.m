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
@interface JFHomeController ()<UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
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
    
    // ⚠️
    // 这里你对比原来的你写的 horizontal 你自己写错了 其实你 sb 设置了 vertical 就不用在这里设置了
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal ;
    self.flowLayout.minimumInteritemSpacing = 10;
    self.flowLayout.minimumLineSpacing = 10;
    // 这里很多设置都改为优先级更高的代理方法返回了
    // ⚠️ 一般现在修改属性有两个途径 一个是赋值 另一个是通过代理方法返回, 一般代理方法返回的优先级更高
    //self.flowLayout.itemSize = CGSizeMake(300, 300);
    
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
//    self.collectionView.collectionViewLayout = self.flowLayout;
    
    //加载新闻分类
    [self loadChannels];
}
#pragma mark viewDidLayoutSubviews

// ⚠️ 这个有点憨批设置 可能是以前的接口更改了 反正我没试过这样设置的
//当计算好collectionView的大小。再设置cell的大小
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
//    self.flowLayout.itemSize = self.collectionView.bounds.size;
    
//    NSLog(@"collectionView高度:%f",self.collectionView.bounds.size.height);
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
    
//    return 300;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JFHomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"news" forIndexPath:indexPath];
    
    cell.backgroundColor = UIColor.orangeColor;
    return cell;
}

// 🚀 🔥 
// 改为这里返回 item size 记得遵守 uicollection view delegate flow layout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.collectionView.bounds.size;
   // return CGSizeMake(300, 300);
}

@end
