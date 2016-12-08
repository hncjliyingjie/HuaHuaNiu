//
//  sqqViewController.m
//  HuaHuaNiu
//
//  Created by Vking on 16/1/19.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "sqqViewController.h"
#import "sqqTableViewCell.h"
#import "HGHttpTool.h"
#import "DQQupdataViewController.h"
#import "SQCommentViewController.h"
#import "HGFindModel.h"
#import "HGFindFrameModel.h"

#import "YHSheQuXQ.h"

extern NSString *str;

@interface sqqViewController ()
{
    UIImage  *image2;
    NSMutableArray *image3;
    
    
}
@property (strong,nonatomic) NSArray *array;

@end

@implementation sqqViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",str);
    image3 = [NSMutableArray array];
    
    //自动适应行高
    
    self.tableView.estimatedRowHeight = 40;
    //自动计算行高 需要有自上而下的约束
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self shuju];
    self.title = @"社区";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_camera"] style:(UIBarButtonItemStylePlain) target:self action:@selector(fabu)];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"sqqTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    
}


-(void)fabu
{
    DQQupdataViewController *postup = [[DQQupdataViewController alloc]init];
    //postup.member = [[NSUserDefaults standardUserDefaults] objectForKey:@"Useid"];
    [self.navigationController pushViewController:postup animated:YES];
    
    
}


-(void)shuju
{
    NSUserDefaults *Userdefaults =[NSUserDefaults standardUserDefaults];
    
    //http://daiyancheng.cn/appvideo/pic_my.do?token=test&member_id=1&currentPage=1&showCount=5
    NSString *urlStr;
    if (self.count == 1) {
        urlStr =[NSString stringWithFormat:@"http://daiyancheng.cn/appvideo/pic_my.do?token=test&member_id=%@&currentPage=1&showCount=50",self.member];
    }else{
        urlStr = [NSString stringWithFormat:@"http://daiyancheng.cn/appvideo/video_list.do?token=test&member_id=%@&currentPage=1&showCount=50&ll=%@&type_id=0",[Userdefaults objectForKey:@"Useid"],str];
    }
    
    [HGHttpTool getWirhUrl:urlStr parms:nil success:^(id json) {
        
        NSLog(@"%@",str);
        
        NSLog(@"%@",json);
        
        _array  = json[@"videos"];
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
    return _array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    sqqTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    ///写返回值对应的数组里面的数据  _array[indexpath.row][@"path"];

    [cell.imagelable sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://daiyancheng.cn/%@",_array[indexPath.row][@"img_path"]]]];
    cell.namelable.text = _array[indexPath.row][@"member_name"];
    cell.titilelable.text = _array[indexPath.row][@"title"];
    cell.dianzanlable.text = [NSString stringWithFormat:@"%@",_array[indexPath.row][@"comment_num"]];
    cell.wieguanlable.text = [NSString stringWithFormat:@"%@",_array[indexPath.row][@"on_lookers"]];
    cell.timelable.text = _array[indexPath.row][@"add_time_x"];
    return cell;
}
#pragma mark 单元格点击的方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults *Userdefaults =[NSUserDefaults standardUserDefaults];
    
    
    YHSheQuXQ *VC = [[YHSheQuXQ alloc]init];

    VC.image1 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://daiyancheng.cn/%@",_array[indexPath.row][@"img_path"]]]]];
    
    VC.member = [Userdefaults objectForKey:@"Useid"];
    VC.video_id = _array[indexPath.row][@"video_id"];
    VC._on_looks = _array[indexPath.row][@"on_lookers"];
    VC.comment_num = _array[indexPath.row][@"comment_num"];
    VC.path = _array[indexPath.row][@"img_path"];
    VC.titles = _array[indexPath.row][@"title"];
    VC.addtime = _array[indexPath.row][@"add_time_x"];
    
    [self.navigationController pushViewController:VC animated:YES];
    
}

@end
