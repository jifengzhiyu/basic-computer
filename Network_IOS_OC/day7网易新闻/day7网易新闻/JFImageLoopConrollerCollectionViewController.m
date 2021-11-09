//
//  JFImageLoopConrollerCollectionViewController.m
//  day7网易新闻
//
//  Created by 翟佳阳 on 2021/11/9.
//

#import "JFImageLoopConrollerCollectionViewController.h"
#import "JFHeadLine.h"
#import "JFHeadLineCell.h"
@interface JFImageLoopConrollerCollectionViewController ()

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowlayout;
@property (nonatomic, strong) NSArray *headlines;

@end
//使用collectionView注意
//1 必须设置flowLayout,cell大小/间距，滚动方向
//2 必须注册cell（从sb中加载cell，注册自定义cell，注册xib）
//自定义cell
@implementation JFImageLoopConrollerCollectionViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    [JFHeadLine headlinesWithSuccess:^(NSArray * _Nonnull array) {
            self.headlines = array;
        } error:^{
            NSLog(@"error");
        }];
    
    //设置flowlayout
    [self setCollectionViewStyle];
}


//设置colletionview的样式
- (void)setCollectionViewStyle {
    self.flowlayout.itemSize = self.collectionView.frame.size;
    //NSLog(@"%f,%f",self.collectionView.frame.size.width,self.collectionView.frame.size.height);
    self.flowlayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.flowlayout.minimumInteritemSpacing = 0;
    self.flowlayout.minimumLineSpacing = 0;
    
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.bounces = NO;
}
#pragma mark -数据源方法

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //异步请求，需要刷新
    return self.headlines.count;
}

- (void)setHeadlines:(NSArray *)headlines{
    _headlines = headlines;
    //异步请求，需要刷新
    [self.collectionView reloadData];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //sb法 设置id
    //headline
    JFHeadLineCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"headline" forIndexPath:indexPath];
    cell.tag = indexPath.item;
    cell.headline = self.headlines[indexPath.item];
    
    return cell;
}

#pragma mark -数据源方法

@end
