//
//  JFTableViewController.m
//  模拟科技头条
//
//  Created by 翟佳阳 on 2021/11/1.
//

#import "JFTableViewController.h"
#import "JFNews.h"
#import "JFTableViewCell.h"

@interface JFTableViewController ()
@property (nonatomic, strong) NSArray *newsList;

@end

@implementation JFTableViewController

- (void)setNewsList:(NSArray *)newsList{
    _newsList = newsList;
    //等到数据加载完毕，给它赋值的时候，重新把cell更新
    [self.tableView reloadData];
    //结束下拉刷新
    [self.refreshControl endRefreshing];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置refreshControl显示的内容
    self.refreshControl.tintColor = [UIColor blueColor];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"加载ing" attributes:@{NSForegroundColorAttributeName : [UIColor redColor]}];
    
    //发送异步请求，获取数据
    [self loadNews];
}

//开始下拉刷新
- (IBAction)loadNews{
    [JFNews newsWithSuccess:^(NSArray * _Nonnull array) {
            self.newsList = array;
        } error:^{
            NSLog(@"获取数据出错");
        }];
}

# pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.newsList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //返回不同的可重用标识 根据是否有图片来返回
    JFNews *news = self.newsList[indexPath.row];
    
    
    JFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[JFTableViewCell getReuseID:news]];
   
    cell.news = news;
    
    return cell;
}
@end
