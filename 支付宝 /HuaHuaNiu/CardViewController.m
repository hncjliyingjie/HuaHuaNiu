//
//  CardViewController.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-4-23.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "CardViewController.h"
#import "AFNetworking.h"
#import "MYCardTableViewCell.h"
#import "AddCARDDViewController.h"
#import "Toast+UIView.h"
@interface CardViewController ()

@end

@implementation CardViewController
-(id)initWitHTXian:(BOOL)TX{
    self =[super init];
    if (self) {
        TIXian = TX;
    }

    return  self;

}
- (void)viewDidLoad {
       self.view.backgroundColor =BackColor;
    [super viewDidLoad];
    [self makeMYData];
  
    
    self.navigationItem.title =@"我的银行卡";
    
    UIButton *rightBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame =CGRectMake(0, 0, 15, 15);
    [rightBtn  setBackgroundImage:[UIImage imageNamed:@"app_tianjiakaquan"] forState:UIControlStateNormal];
    // [BackBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    
    [rightBtn addTarget:self action:@selector(RigheBtnAci)  forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *RightItem =[[UIBarButtonItem alloc]initWithCustomView:rightBtn];

    
    self.navigationItem.rightBarButtonItem =RightItem;
    
    
    
    
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
-(void)RigheBtnAci{
    ////(@"添加信用卡");

    AddCARDDViewController * avc =[[AddCARDDViewController alloc]init];
  
    [self.navigationController pushViewController:avc animated:YES];
  
}
-(void)viewWillAppear:(BOOL)animated{
    [self makeMYData];

}
-(void)makeMYData{
    [self.view makeToastActivity];
    NSUserDefaults *  UserDefault =[NSUserDefaults standardUserDefaults];
    NSString * UserID =[UserDefault objectForKey:@"Useid"];
    NSString * ShouY = [NSString stringWithFormat:WODEYINHANGKA,UserID];
    ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //(@"%@",ShouY);
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    
    [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //(@"ddd%@",responseObject);
        
       DataArr =[[NSArray alloc]initWithArray:[responseObject objectForKey:@"retval"]];

       [self.view hideToastActivity];
        
        [self makeTaveleView];
        
        if(DataArr.count == 0){
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

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.view hideToastActivity];
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        failAlView.tag = 11;
        [failAlView show];
        //(@"cook load failed ,%@",error);
    }];
}
-(void)makeTaveleView{
    IOS_Frame
    if (_Tv) {
        if (DataArr.count < 11){
            _Tv.frame =CGRectMake(0, 0, ConentViewWidth,  44*DataArr.count);
        }
        [_Tv reloadData];
    }
   else{
       
       _Tv =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, ConentViewHeight) style:UITableViewStylePlain];
       if (DataArr.count < 11) {
           _Tv.frame =CGRectMake(0, 0, ConentViewWidth, 44*DataArr.count);
       }
       else{
       }
       _Tv.delegate =self;
       _Tv.dataSource =self;
       _Tv.backgroundColor =[UIColor whiteColor];
       

    }
    
    [self.view addSubview: _Tv];

    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 返回银行卡的信息
    if (TIXian) {
      TXBlocks(DataArr[indexPath.row]);
        [self.navigationController popViewControllerAnimated:YES];
    }
    //不是体现进入的删除银行卡
    else{
    
        UIAlertView *DeleBankid =[[UIAlertView alloc]initWithTitle:@"提示" message:@"确定要删除这张银行卡信息" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        deledic =[[NSDictionary alloc]initWithDictionary:DataArr[indexPath.row]];
        [DeleBankid show];
       
    }
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==11) {
        return ;
    }
    else{
    if (buttonIndex == 1) {
 
        // 数据报错
        
        [self.view makeToastActivity];
        NSUserDefaults *  UserDefault =[NSUserDefaults standardUserDefaults];
        NSString * UserID =[UserDefault objectForKey:@"Useid"];
        NSString * ShouY = [NSString stringWithFormat:DELEYHK,UserID,[deledic objectForKey:@"bankcard_id"]];
       
        ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
        
        [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //(@"fff%@",responseObject);
                       
            [self  makeMYData];
            [self.view hideToastActivity];
           
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self.view hideToastActivity];
            UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [failAlView show];
            //(@"cook load failed ,%@",error);
        }];

    }
    else{
    
    
    }
    }
}
-(void)MakeWithBlocks:(void (^)(NSDictionary *))Blocks{
    TXBlocks =[Blocks copy];
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  DataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MYCardTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell =[[[NSBundle mainBundle]loadNibNamed:@"MYCardTableViewCell" owner:self options:nil]lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell MYcellMakeWithDic:DataArr[indexPath.row]];
    
    [cell deleBlockss:^{
       // 刷新数据；
    }];
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
