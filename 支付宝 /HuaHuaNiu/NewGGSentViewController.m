//
//  NewGGSentViewController.m
//  HuaHuaNiu
//
//  Created by alex on 15/12/26.
//  Copyright © 2015年 张燕. All rights reserved.
//

#import "NewGGSentViewController.h"
#import "ADViewController.h"
#import "AFNetworking.h"
#import "Toast+UIView.h"
#import "MJRefresh.h"
#import "LogViewController.h"
#import "SentTableViewCell.h"
@interface NewGGSentViewController ()

@end

@implementation NewGGSentViewController

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
    NSString *userID =[NSString stringWithFormat:@"%@",[userdefault objectForKey:@"Useid"]];

    NSString *ShouY = [NSString stringWithFormat:GGList, userID,page];
    NSLog(@"%@",ShouY);
    ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    
    [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
            if (page ==1) {
                
                
                [dataArr removeAllObjects];
                
                dataArr =[[NSMutableArray alloc]initWithArray:[responseObject objectForKey:@"ads"]];
                
                [self makeUI];
            }else{
                _tv.bounces = YES;
                [dataArr addObjectsFromArray:[responseObject objectForKey:@"ads"]];
                
                [_tv reloadData];
                
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
        NSLog(@"cook load failed ,%@",error);
    }];
    
    
    
    
    
    
    
    
    
}
-(void)makeItem{
    
    
    
    
    //    UIButton * Rightbtn =[UIButton buttonWithType:UIButtonTypeCustom];
    //    Rightbtn.frame =CGRectMake(0, 0, 15, 15);
    //    [Rightbtn addTarget:self action:@selector(WnFa) forControlEvents:UIControlEventTouchUpInside];
    //    [Rightbtn setImage:[UIImage imageNamed:@"app_wendangshuoming"] forState:UIControlStateNormal];
    //    UIBarButtonItem *RightItem =[[UIBarButtonItem alloc]initWithCustomView:Rightbtn];
    //    self.navigationItem.rightBarButtonItem = RightItem;
    
    
    self.navigationItem.title=@"我的广告";
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
    NSLog(@"%d",page);
    // [_tv footerBeginRefreshing];
    [self makelookData];
}
-(void)PageResh{
    page =1;
    
    
    [self makelookData];
    
}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSUserDefaults *UserDefault =[NSUserDefaults standardUserDefaults];
//    NSString * UserIDs =[UserDefault objectForKey:@"Useid"];
//    int denglu  = UserIDs.length;
//    if (denglu ==  0) {// 未登录 进入登陆
//        LogViewController *logview =[[LogViewController alloc]init];
//        [self.navigationController pushViewController:logview animated:YES];
//    }
//    else{
//        
//        NSString * str =[NSString stringWithFormat:@"%@",[dataArr[indexPath.row] objectForKey:@"advalue"]];
//        NSLog(@"%@",str);
//        NSString *type =[NSString stringWithFormat:@"%@",[dataArr[indexPath.row] objectForKey:@"adtype"]];
//        ADViewController *Avc =[[ADViewController alloc]initWithADStr:str andType:type];
//        Avc.hidesBottomBarWhenPushed =YES;
//        [self.navigationController pushViewController:Avc animated:YES];
//        
//    }
//}

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  dataArr.count;
    
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SentTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell ==nil) {
        cell =[[[NSBundle mainBundle]loadNibNamed:@"SentTableViewCell" owner:nil options:nil]lastObject];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
