
//
//  ZhiJieViewController.m
//  HuaHuaNiu
//
//  Created by 洪慧康 on 16/4/5.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "ZhiJieViewController.h"
#import "ZhiJieTableViewCell.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
@interface ZhiJieViewController ()
{
    NSDictionary *dataDic;
}
@end

@implementation ZhiJieViewController
-(void)viewWillAppear:(BOOL)animated{
    [self creat];
    self.title=@"我的城里人";
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
    self.tableView.tableHeaderView = [self setUpHeaderView];
    // Do any additional setup after loading the view from its nib.
}
#pragma mark - 设置header
-(UIView *)setUpHeaderView {
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 40)];
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(55, 5, 40, 30)];
    nameLabel.text = @"姓名";
    UILabel *numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - (kScreenWidth - 80)/4 - 50, 5, 40, 30)];
    numberLabel.text = @"电话";
    [header addSubview:nameLabel];
    [header addSubview:numberLabel];
    return header;
}
-(void)creat{
    NSUserDefaults *userdefault =[NSUserDefaults standardUserDefaults];
    NSString *userID =[userdefault objectForKey:@"Useid"];
    NSString *ShouY = [NSString stringWithFormat:@"http://daiyancheng.cn/appfun/myFirstFuns.do?token=test&member_id=%@",userID];
    ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[RequestManger share]requestDataByPostWithPath:ShouY dictionary:nil complete:^(NSDictionary *data) {
        NSLog(@"%@",data);
        dataDic=[NSDictionary dictionaryWithDictionary:data];
        [_tableView reloadData];
    }];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    NSLog(@"%li",[[dataDic objectForKey:@"funs"] count]);
    return [[dataDic objectForKey:@"funs"] count];
    //return JPdataArr.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZhiJieTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"ZhiJieTableViewCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ZhiJieTableViewCell" owner:self options:nil]lastObject];
    }
//    NSLog(@"%@",array);
    cell.lableName.text=[[[dataDic objectForKey:@"funs"] objectAtIndex:indexPath.row] objectForKey:@"nick_name"];
    NSMutableString *tellStr = [[[dataDic objectForKey:@"funs"] objectAtIndex:indexPath.row] objectForKey:@"mobile"];
    NSString *tell = [tellStr stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    cell.lableTell.text= tell;
//    cell.lableCount.text=[[array objectAtIndex:indexPath.row] objectForKey:@"content"];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    return  cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
