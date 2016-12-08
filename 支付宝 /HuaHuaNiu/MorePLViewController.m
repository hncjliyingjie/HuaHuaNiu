//
//  MorePLViewController.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-4-24.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "MorePLViewController.h"
#import "AFNetworking.h"
#import "PLVsTableViewCell.h"
#import "Toast+UIView.h"
@interface MorePLViewController ()

@end

@implementation MorePLViewController
-(id)initWithStr:(NSString *)Str{
    self =[super init];
    if ( self) {
        StoreID = Str;
        
        
    }
    return self;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =BackColor;
    DataArr =[[NSArray alloc]init];
    // Do any additional setup after loading the view.s
// 请求评论
      [self makeMorePL];
    
   
    
    
    
    self.navigationItem.title=@"更多评论";
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

-(void)makeMorePL{
//
//    NSUserDefaults *  UserDefault =[NSUserDefaults standardUserDefaults];
//    NSString * UserID =[UserDefault objectForKey:@"Useid"];
//
    
    [self.view makeToastActivity];
    NSString * ShouY = [NSString stringWithFormat:MOREPLA,StoreID];
    
    ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    
    [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
      
        
        DataArr =[[NSArray alloc]initWithArray:[responseObject objectForKey:@"retval"]];
        if(DataArr.count > 0){
            [self makeTV];
        }
        else{
        
        }
        [self.view hideToastActivity];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.view hideToastActivity];
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [failAlView show];
        //(@"cook load failed ,%@",error);
    }];
    




}
-(void)makeTV{

    _Tv = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, ConentViewHeight)style:UITableViewStylePlain] ;
    _Tv.delegate =self;
    _Tv.dataSource =self;
    [self.view addSubview:_Tv];


}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat HIghe  = 35;
//评论Str
    NSString  * PingLunStr =[NSString stringWithFormat:@"%@",[DataArr[indexPath.row] objectForKey:@"comment"]];
//回复Str
    NSString  * HuiFuStr =[NSString stringWithFormat:@"%@",[DataArr[indexPath.row] objectForKey:@"reply"]];
    
    if (HuiFuStr.length == 0) {  // 商家无回复
        CGFloat with = 265*(ConentViewWidth/320.0);
       //  一个字的宽度  265/24
        //回复的行数
      int  hang   = PingLunStr.length*(265/24.0)/with  + 1;
        HIghe  += 15*hang;
    }
    else{// 商家有回复
        CGFloat with = 265*(ConentViewWidth/320.0);
        //  一个字的宽度  265/24
        //回复的行数
        int  hang   = PingLunStr.length*(265/24.0)/with  + 1;
        HIghe   +=  15*hang;
      
        int HuiFuHang = HuiFuStr.length*(265/24.0)/with  + 1;
        HIghe  += 15*HuiFuHang + 10;
        
    
    }
    
    return  HIghe;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
return  DataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PLVsTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell =[[[NSBundle mainBundle ]loadNibNamed:@"PLVsTableViewCell" owner:self options:nil]lastObject];
    }
    
   [cell PLCellMakeWithDic:DataArr[indexPath.row]];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    
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
