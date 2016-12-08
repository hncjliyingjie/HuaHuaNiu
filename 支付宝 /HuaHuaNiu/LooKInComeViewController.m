//
//  LooKInComeViewController.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-13.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "LooKInComeViewController.h"
#import "InComeTableViewCell.h"
#import "ADViewController.h"
#import "AFNetworking.h"
#import "Toast+UIView.h"
#import "MJRefresh.h"
#import "LogViewController.h"
@interface LooKInComeViewController ()

@end

@implementation LooKInComeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeItem];
    self.view.backgroundColor =BackColor;
    dataArr =[[NSMutableArray alloc]init];
    page = 1;
    
    [self makelookData];
     
    // Do any additional setup after loading the view.
}
-(void)makelookData{
    [self.view hideToastActivity];
    NSUserDefaults * userdefault =[NSUserDefaults standardUserDefaults];
    //http://daiyancheng.cn/appprize/prize_list.do?token=test&ll=34.763815678878,113.63489789543&page=1
    DingWeistr =[NSString stringWithFormat:@"%@",[userdefault objectForKey:@"ZUOBIAO"]];
    NSString *ShouY = [NSString stringWithFormat:LOOKSTR, DingWeistr,page,[userdefault objectForKey:@"Useid"]];
    //(@"%@",ShouY);
    ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];

    [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *str =[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"result"]];
        if ([str isEqualToString:@"1"]) {
            
            if (page ==1) {
               
              [dataArr removeAllObjects];
                
                dataArr =[[NSMutableArray alloc]initWithArray:[responseObject objectForKey:@"list"]];
                
                 [self makeUI];
            }
            
            else{
                _tv.bounces = YES;
                [dataArr addObjectsFromArray:[responseObject objectForKey:@"list"]];
                
                [_tv reloadData];

            }
        }
        else {
        
                   //数据请求错误
        }
        if (dataArr.count == 0) {
            
            UILabel * tisishsl =[[UILabel alloc]initWithFrame:CGRectMake(30, ConentViewHeight/2 - 100 , ConentViewWidth - 60  , 30)];
            tisishsl.textAlignment = NSTextAlignmentCenter;
            tisishsl.text =@"暂无数据";
            tisishsl.font =[UIFont systemFontOfSize:13];
            [self.view addSubview:tisishsl];
            tisishsl.tag =100;
        }
        else{
            UILabel * tisi =(UILabel *)[self.view  viewWithTag:100];
            
            tisi.hidden = YES;
        }
        [self.view hideToastActivity];
        
        [_tv footerEndRefreshing];
        [_tv headerEndRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.view hideToastActivity];
        [_tv footerEndRefreshing];
        [_tv headerEndRefreshing];
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [failAlView show];
        //(@"cook load failed ,%@",error);
    }];
}
-(void)makeItem{
    self.navigationItem.title=@"看看有奖";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
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
-(void)makeUI{
    _tv  =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, ConentViewHeight ) style:UITableViewStylePlain];
    _tv.delegate =self;
    _tv.dataSource =self;
    
     int a =ConentViewHeight/184 +1;
   
    if (dataArr.count <a) {
        _tv.frame =CGRectMake(0, 0, ConentViewWidth, 184*dataArr.count);
         _tv.bounces = NO;
     }
    
    
    [_tv addFooterWithTarget:self action:@selector(PageAdd)];
    [_tv addHeaderWithTarget:self action:@selector(PageResh)];
    [self.view addSubview:_tv];
}

-(void)PageAdd{
    page ++;
    //(@"%d",page);
   // [_tv footerBeginRefreshing];
    [self makelookData];
}
-(void)PageResh{
    page =1;
   
    [self makelookData];

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUserDefaults *UserDefault =[NSUserDefaults standardUserDefaults];
    NSString * UserIDs =[UserDefault objectForKey:@"Useid"];
    int denglu  = UserIDs.length;
    if (denglu ==  0) {// 未登录 进入登陆
        LogViewController *logview =[[LogViewController alloc]init];
        [self.navigationController pushViewController:logview animated:YES];
    }
    else{

 //   //(@"选中了 %ld",(long)indexPath.row);
    NSString * str =[NSString stringWithFormat:@"%@",[dataArr[indexPath.row] objectForKey:@"advalue"]];
        NSLog(@"%@",str);
    NSString *type =[NSString stringWithFormat:@"%@",[dataArr[indexPath.row] objectForKey:@"adtype"]];
        NSLog(@"%@",type);
    ADViewController *Avc =[[ADViewController alloc]initWithADStr:str andType:type];
    Avc.hidesBottomBarWhenPushed =YES;
    [self.navigationController pushViewController:Avc animated:YES];
    
    }
}
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    
    return  dataArr.count;
    
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 184;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    InComeTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell ==nil) {
        cell =[[[NSBundle mainBundle]loadNibNamed:@"InComeTableViewCell" owner:nil options:nil]lastObject];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    NSDictionary *dic = dataArr[indexPath.row];
    [cell INcellmakeWithDic:dic];
    return cell;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
