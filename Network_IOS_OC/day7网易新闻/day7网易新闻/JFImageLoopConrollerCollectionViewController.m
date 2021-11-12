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
//当前图片的索引
@property (nonatomic, assign) NSInteger currentIndex;
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

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    //NSLog(@"%@",self.collectionView);
    //等待collectionView的大小重新计算之后，再设置cell的大小
    self.flowlayout.itemSize = self.collectionView.frame.size;

}

//设置colletionview的样式
- (void)setCollectionViewStyle {
    //NSLog(@"%f,%f",self.collectionView.frame.size.width,self.collectionView.frame.size.height);

    self.flowlayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

    self.flowlayout.minimumInteritemSpacing = 0;
    self.flowlayout.minimumLineSpacing = 0;

    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.bounces = NO;
}

- (void)setHeadlines:(NSArray *)headlines{
    _headlines = headlines;
    //异步请求，需要刷新
    [self.collectionView reloadData];

    //始终显示第二个cell
    //首先显示第二个cell
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:1 inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:0 animated:NO];
}

#pragma mark -数据源方法

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //异步请求，需要刷新
    return self.headlines.count;
}



- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //sb法 设置id
    //headline
    JFHeadLineCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"headline" forIndexPath:indexPath];

    //在滚动过程中下一张图片的索引
    //当滚动的过程中item的值只可能是 0 或者 2
    //取余 防止越界
    //indexPath 对应cell
    //index 对应 图片
    NSInteger index = (self.currentIndex
                       + indexPath.item - 1 + self.headlines.count) % self.headlines.count;
    //滚动进度
    cell.tag = index;
    cell.headline = self.headlines[index];

//    NSLog(@"indexPath = %zd",indexPath.item);
//    NSLog(@"index = %zd",index);

    return cell;
}
   
#pragma mark -数据源方法

//collectionView的代理方法
//滚动停止之后，把cell换成第二个cell
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //计算下一张图片的索引 (+1  -1)
    //返回的值始终是 （0  2） - 1
    int offset = scrollView.contentOffset.x / scrollView.bounds.size.width - 1;
    self.currentIndex = (self.currentIndex + offset + self.headlines.count ) % self.headlines.count;


    //始终显示第二个cell
    //主队列的执行特点：先等待主线程上的代码都执行完毕，再执行队列中的任务
    dispatch_async(dispatch_get_main_queue(), ^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:1 inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:0 animated:NO];
        
        [self.collectionView reloadData];

    });
}

@end
