//
//  HelpViewController.m
//  HuaHuaNiu
//
//  Created by alex on 15/12/25.
//  Copyright © 2015年 张燕. All rights reserved.
//

#import "HelpViewController.h"
#import "AFNetworking.h"
#import "Toast+UIView.h"
#import "HelpTableViewCell.h"
#import "HelpDetailViewController.h"
#import "YHHelpDetailViewController.h"
@interface HelpViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView * _tv;
    NSArray * _dataArr;
    NSArray * _childArr;
}

@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _dataArr =[NSArray array];
    _childArr =[NSArray array];
    [self requestData];
    self.view.backgroundColor =BackColor;
    // Do any additional setup after loading the view from its nib.
    
    //返回按钮
    UIImage *lbbImage = [UIImage imageNamed:@"back_new"];
    lbbImage = [lbbImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem * lbbItem = [[UIBarButtonItem alloc] initWithImage:lbbImage style:UIBarButtonItemStylePlain target:self action:@selector(BackAction)];
    self.navigationItem.leftBarButtonItem = lbbItem;
    
    self.navigationItem.title=@"帮助中心";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       
       NSForegroundColorAttributeName:[UIColor colorWithRed:0.047 green:0.364 blue:0.663 alpha:1]}];
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
    
}
-(void)BackAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)createUI{
    _tv =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, ConentViewHeight) style:UITableViewStylePlain];
    _tv.dataSource =self;
    _tv.delegate =self;
    _tv.separatorStyle =UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tv];
    
}

-(void)requestData{
//    NSString *ShouY = [NSString stringWithFormat:UpProfit];
    NSString * ShouY;
    NSUserDefaults *Userdefaults =[NSUserDefaults standardUserDefaults];
    if ([self.idStr isEqualToString:@"帮助详情"]) {
        ShouY = [NSString stringWithFormat:HelpCenter,[Userdefaults objectForKey:@"Useid"]];
    }else{
        
        ShouY = [NSString stringWithFormat:UpProfit];
    }
    
    
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *dataArray = [NSMutableArray array];
        NSMutableArray *contentArray = [NSMutableArray array];
        if ([self.idStr isEqualToString:@"帮助详情"]) {
            NSArray *arr =[responseObject objectForKey:@"list"];
            
            [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                [dataArray addObject:obj[@"title"]];
                [contentArray addObject:obj[@"content"]];
            }];
        }else{
            [dataArray addObject:[responseObject objectForKey:@"title"]];
            [contentArray addObject:[responseObject objectForKey:@"content"]];
        }
        _dataArr = dataArray;
        
        _childArr=contentArray;

        [self createUI];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [failAlView show];
        
        //(@"cook load failed ,%@",error);
    }];
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HelpTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell =[[[NSBundle mainBundle]loadNibNamed:@"HelpTableViewCell" owner:self options:nil]lastObject];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.nameLB.text =_dataArr[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * str =_childArr[indexPath.row];
    YHHelpDetailViewController * hdvc =[[YHHelpDetailViewController alloc] init];
    
    hdvc.currentStr =str;
    hdvc.hidesBottomBarWhenPushed= YES;
    [self.navigationController pushViewController:hdvc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
