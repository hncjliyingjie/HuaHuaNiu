//
//  WoDeViewController.m
//  HuaHuaNiu
//
//  Created by 洪慧康 on 16/3/30.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "WoDeViewController.h"
#import "WoDeTableViewCell.h"
#import "AFNetworking.h"
#import "YHMessageViewCon.h"

@interface WoDeViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSArray *array;
}

@end

@implementation WoDeViewController

-(void)viewWillAppear:(BOOL)animated{
    [self creat];
    self.title=@"我的消息";
    UIButton *BackBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    BackBtn.frame =CGRectMake(0, 0, 64, 27);
    [BackBtn  setBackgroundImage:[UIImage imageNamed:@"app_fanhui"] forState:UIControlStateNormal];
    // [BackBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    
    [BackBtn addTarget:self action:@selector(BackAction)  forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem =[[UIBarButtonItem alloc]initWithCustomView:BackBtn];
    self.navigationItem.leftBarButtonItem = backItem;
}
-(void)BackAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creat];
    // Do any additional setup after loading the view from its nib.
}
-(void)creat{
    NSUserDefaults * userdefault =[NSUserDefaults standardUserDefaults];
//    NSString * longstttr=[NSString stringWithFormat:@"%@",[userdefault objectForKey:@"ZUOBIAO"]];
    //http://daiyancheng.cn/appmember/mymsg.do?token=test&page=1&member_id=1511061222272510000
    //daiyancheng.cn/appmember/helpTip.do?token=test
    NSString *ShouY = [NSString stringWithFormat:@"http://daiyancheng.cn/appmember/mymsg.do?token=test&page=%d&member_id=%@",1,[userdefault objectForKey:@"Useid"]];
    ShouY =[[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
      //(@"%@",ShouY);
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        array=[NSArray arrayWithArray:[responseObject objectForKey:@"list"]];
        NSLog(@"%@",array);
        [_tableView reloadData];
//        DataArr =[responseObject objectForKey:@"goods"];
//        [self makeFenLei];
//        [self.view hideToastActivity];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [self.view hideToastActivity];
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [failAlView show];
        //(@"cook load failed ,%@",error);
    }];

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 90;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%li",array.count);
    return array.count;
    //return JPdataArr.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WoDeTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"PeiSoncell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"WoDeTableViewCell" owner:self options:nil]lastObject];
    }
//    NSLog(@"%@",array);
    
    NSString * status = [NSString stringWithFormat:@"%@",[[array objectAtIndex:indexPath.row] objectForKey:@"status"]];
    
    if ([status isEqualToString:@"2"]) {
        cell.readView.hidden = NO;
    }
    
    cell.lableTitle.text=[[array objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.lableTime.text=[[array objectAtIndex:indexPath.row] objectForKey:@"add_time_x"];
    cell.lableCount.text=[[array objectAtIndex:indexPath.row] objectForKey:@"content"];
    
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    return  cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //打开消息 并将消息置为已读
    //http://daiyancheng.cn/appmember/setmsg.do?token=test&msg_id=352
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://daiyancheng.cn/appmember/setmsg.do?token=test&msg_id=%@",[[array objectAtIndex:indexPath.row] objectForKey:@"message_id"]]]];
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    }] resume];
    
    YHMessageViewCon *message = [[[NSBundle mainBundle] loadNibNamed:@"YHMessageViewCon" owner:nil options:nil] firstObject];
    message.contentLable.text = [[array objectAtIndex:indexPath.row] objectForKey:@"content"];
    message.titleLable.text = [[array objectAtIndex:indexPath.row] objectForKey:@"title"];
    message.timeLable.text = [[array objectAtIndex:indexPath.row] objectForKey:@"add_time_x"];
    
    [self.navigationController pushViewController:message animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
