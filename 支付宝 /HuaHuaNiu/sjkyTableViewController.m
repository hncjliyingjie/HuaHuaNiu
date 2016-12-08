//
//  sjkyTableViewController.m
//  HuaHuaNiu
//
//  Created by wcs on 16/1/17.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "sjkyTableViewController.h"
#import "HGHttpTool.h"
#import "czzrTableViewCell.h"
#import "StoreDetailsViewController.h"

extern NSString *str;

@interface sjkyTableViewController ()
{
    UIImage *image1;
}
@property (nonatomic,strong) NSArray *arrays;

@end

@implementation sjkyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loaddata];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    self.title = @"开业庆典";
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView registerNib:[UINib nibWithNibName:@"czzrTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


-(void)loaddata
{
    NSUserDefaults *Userdefaults =[NSUserDefaults standardUserDefaults];

    [HGBaseMethod get:[NSString stringWithFormat:@"http://daiyancheng.cn/appmain/ceremonyList.do?token=test&member_id=%@&ll=%@&currentPage=1&showCount=10",[Userdefaults objectForKey:@"Useid"],str]parms:nil success:^(id json) {
        
        _arrays = json[@"ceremonys"];
        
        NSLog(@"%@",json);
        [self.tableView reloadData];
    } failture:^(id json) {
        
    }];
    
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    return 90;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return _arrays.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     czzrTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"forIndexPath:indexPath];
    
    
    //创建多线程第六种方式
    dispatch_queue_t queue = dispatch_queue_create("name", NULL);
    //创建一个子线程
    dispatch_async(queue, ^{
        // 子线程code... ..
        NSLog(@"GCD多线程");
        image1 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://daiyancheng.cn/%@",_arrays[indexPath.row][@"path"]]]]];

        //回到主线程
        dispatch_sync(dispatch_get_main_queue(), ^{//其实这个也是在子线程中执行的，只是把它放到了主线程的队列中
            Boolean isMain = [NSThread isMainThread];
            if (isMain) {
                NSLog(@"GCD主线程");
                cell.imgview.image = image1;
            }
        });
    });
    
        
                       
                       
                       
    cell.textsss.text = _arrays[indexPath.row][@"summary"];
    
    
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
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * str =[NSString stringWithFormat:@"%@",_arrays[indexPath.row][@"store_id"]];
    StoreDetailsViewController *vc = [[StoreDetailsViewController alloc]initWithStr:str];
    
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

@end
