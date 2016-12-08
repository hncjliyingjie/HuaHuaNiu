//
//  esmmTableViewController.m
//  HuaHuaNiu
//
//  Created by wcs on 16/1/17.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "esmmTableViewController.h"
#import "czzrTableViewCell.h"
#import "HGHttpTool.h"
#import "FBViewController.h"
#import "NRXQViewController.h"

extern NSString *str;


@interface esmmTableViewController ()
{
    UIImage  *image1;
}
@property (strong,nonatomic) NSArray *array;
@end

@implementation esmmTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
       NSLog(@"%@",NSHomeDirectory());
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.title = @"二手买卖";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"发布"] style:(UIBarButtonItemStylePlain) target:self action:@selector(fabu)];
    
    [self shuju];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"czzrTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
-(void)fabu
{
    FBViewController *fabu = [[FBViewController alloc]init];
    fabu.fabuleixing = @"secondhand";
    [self.navigationController pushViewController:fabu animated:YES];
    
    
}

-(void)shuju
{
    NSUserDefaults *Userdefaults =[NSUserDefaults standardUserDefaults];
    NSLog(@"%@",Userdefaults);
    
//    NSDictionary * dict =[NSDictionary dictionaryWithObjectsAndKeys:@"ll",nil];
//    NSLog(@"dict is =%@",dict);
    
    
    [HGBaseMethod get:[NSString stringWithFormat:@"http://daiyancheng.cn/appinfo/info_list.do?token=test&member_id=%@&ll=%@&currentPage=1&showCount=10&type=0",[Userdefaults objectForKey:@"Useid"],str] parms:nil success:^(id json) {
        NSLog(@"%@",[Userdefaults objectForKey:@"Useid"]);
        NSLog(@"%@",[Userdefaults objectForKey:@"userlocatll"]);
        NSLog(@"%@",json);
        _array  = json[@"infos"];
        [self.tableView reloadData];
        
        
        
    } failture:^(id json) {
        
    }];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return _array.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellId=@"czzrTableViewCell";
    
    czzrTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"czzrTableViewCell" owner:self options:nil];
        cell = [array objectAtIndex:0];
//        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    
    ///写返回值对应的数组里面的数据  _array[indexpath.row][@"path"];

    //创建多线程第六种方式
    dispatch_queue_t queue = dispatch_queue_create("name", NULL);
    //创建一个子线程
    dispatch_async(queue, ^{
        // 子线程code... ..
        NSLog(@"GCD多线程");
//        NSLog(@"%@",_array[indexPath.row]);
        image1 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://daiyancheng.cn/%@",_array[indexPath.row][@"path"]]]]];
//
        //回到主线程
        dispatch_sync(dispatch_get_main_queue(), ^{//其实这个也是在子线程中执行的，只是把它放到了主线程的队列中
//            Boolean isMain = [NSThread isMainThread];
//            if (isMain) {
                NSLog(@"GCD主线程");
                cell.imgview.image = image1;
            cell.timeLabel.text =  _array[indexPath.row][@"add_time"];
            cell.timeLabel.adjustsFontSizeToFitWidth = YES;
            cell.priceLabel.text = [NSString stringWithFormat:@"%@元",[_array[indexPath.row][@"price"] stringValue]];
            if (_array[indexPath.row][@"add_time"]) {
                cell.addressLable.text =  _array[indexPath.row][@"address"];
            }
//            }
        });
    });
//     cell.imgview.image = image1;
//    image1 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://daiyancheng.cn/%@",_array[indexPath.row][@"path"]]]]];
    cell.textsss.text = _array[indexPath.row][@"title"];
//    NSLog(@"dasdasda=========%@",_array[indexPath.row][@"title"]);
    
    }
    return cell;
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NRXQViewController *vc = [[NRXQViewController alloc]init];
    
    vc.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://daiyancheng.cn/%@",_array[indexPath.row][@"path"]]]]];;
//    vc.array = _array[indexPath.row];
    vc.infoId = _array[indexPath.row][@"info_id"];
    
    //http://daiyancheng.cn/appinfo/info_show.do?token=test&member_id=1&info_id=11
    
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
}
@end
