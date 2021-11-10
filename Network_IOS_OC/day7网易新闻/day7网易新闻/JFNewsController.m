//
//  JFNewsController.m
//  day7网易新闻
//
//  Created by 翟佳阳 on 2021/11/10.
//

#import "JFNewsController.h"
#import "JFNews.h"
#import "JFNewsCell.h"
@interface JFNewsController ()
@property (nonatomic, strong) NSArray *newsList;

@end

@implementation JFNewsController
- (void)setNewsList:(NSArray *)newsList {
    _newsList = newsList;
    //重新加载tableview
    [self.tableView reloadData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //异步加载数据
    [JFNews newsListWithSuccessBlock:^(NSArray * _Nonnull array) {
//            NSLog(@"%@",array);
        self.newsList = array;

        } errorBlock:^(NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
    
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.newsList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //1
    JFNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"news"];
    //2
    cell.news = self.newsList[indexPath.row];
    //3
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
