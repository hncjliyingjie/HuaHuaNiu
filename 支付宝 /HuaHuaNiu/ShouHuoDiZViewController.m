//
//  ShouHuoDiZViewController.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-3.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "ShouHuoDiZViewController.h"
#import "AddAddressViewController.h"
#import "DiZhiTableViewCell.h"
#import "AddAddressViewController.h"
#import "AFNetworking.h"
#import "Toast+UIView.h"
@interface ShouHuoDiZViewController ()

@end

@implementation ShouHuoDiZViewController
-(id)initWithDingDan:(BOOL)Ding{
    self =[super init];
    if ( self) {
        Dingdan =Ding;
    }

    return self;
}
- (void)viewDidLoad {
    isTJBack = NO;
    self.view.backgroundColor =[UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
    [super viewDidLoad];
    [self makeDIZhiData];
    [self makeUI];
       UIButton *BackBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    BackBtn.frame =CGRectMake(0, 0, 64, 27);
    [BackBtn  setBackgroundImage:[UIImage imageNamed:@"app_fanhui"] forState:UIControlStateNormal];
    // [BackBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    
    [BackBtn addTarget:self action:@selector(BackAction)  forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem =[[UIBarButtonItem alloc]initWithCustomView:BackBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    self.navigationItem.title=@"收货地址";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       
       NSForegroundColorAttributeName:[UIColor colorWithRed:0.047 green:0.364 blue:0.663 alpha:1]}];
//    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:0.047 green:0.364 blue:0.663 alpha:1];
    

}
-(void)makeDIZhiData{
    [self.view makeToastActivity];
    NSUserDefaults * userDefault =[NSUserDefaults standardUserDefaults];
    
    NSString * userid =[userDefault objectForKey:@"Useid"];
    
    NSString *ShouY = [NSString stringWithFormat:SHOUHUODIZHISR, userid];
    //(@"%@",ShouY);
    ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    
    [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
     
        
        dataArr =[[NSMutableArray alloc]initWithArray:responseObject];
     // 添加地址返回本界面 实现刷新
       if (isTJBack) {
            if (dataArr.count <4) {
                _tv.frame=CGRectMake(0, 0, ConentViewWidth, 149*dataArr.count);
                _tv.scrollEnabled = NO;
                
            }
            else{
                _tv.frame=CGRectMake(0, 0, ConentViewWidth, ConentViewHeight);
                
            }
 
            [_tv reloadData];
        }
        else{
            [self makeTbView];
            isTJBack= YES;
        
        }
        if(dataArr.count == 0){
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

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.view hideToastActivity];
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [failAlView show];
        //(@"cook load failed ,%@",error);
    }];

}
-(void)BackAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)makeTbView{

    IOS_Frame
 
    if(_tv){
        _tv.frame = CGRectMake(0, 0, ConentViewWidth, ConentViewHeight);
        
    }
    else{
        _tv  =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, ConentViewHeight) style:UITableViewStylePlain];

    }
        _tv.delegate =self;
    _tv.dataSource =self;
   
    if (dataArr.count <4) {
        _tv.frame=CGRectMake(0, 0, ConentViewWidth, 149*dataArr.count);
        _tv.scrollEnabled = NO;
        
    }
    
    [self.view addSubview:_tv];

}
-(void)viewWillAppear:(BOOL)animated{
    if (isTJBack) {
        // 添加地址返回的   重新请求地址
        
        
        [self  makeDIZhiData];
    }
    else{
    
           }

}
-(void)makeUI{
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame =CGRectMake(0, 0,15,15);
    [btn addTarget:self action:@selector(BtnAction) forControlEvents:UIControlEventTouchUpInside];
   // [btn setTitle:@"添加" forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"app_tianjiakaquan"] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    UIBarButtonItem *RightItem =[[UIBarButtonItem alloc]initWithCustomView:btn];
    
    self.navigationItem.rightBarButtonItem = RightItem;
    

}
// 添加收货地址
-(void)BtnAction{
    AddAddressViewController *avc =[[AddAddressViewController alloc]init];
    [self.navigationController pushViewController:avc animated:YES];
}

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  dataArr.count;
    
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DiZhiTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell ==nil) {
        cell =[[[NSBundle mainBundle]loadNibNamed:@"DiZhiTableViewCell" owner:nil options:nil]lastObject];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    [cell dizhiCellWithDic:dataArr[indexPath.row]];
    
    // 设置默认的  传一个 ID
    [cell qingqiushuuBlocks:^(NSDictionary *Dic) {
        
        NSUserDefaults * userDefault =[NSUserDefaults standardUserDefaults];
        NSString * userid =[userDefault objectForKey:@"Useid"];
        NSString *ShouY = [NSString stringWithFormat:MOreAddRESS, userid,[Dic objectForKey:@"chongxinJZ"]];
        //(@"%@",ShouY);
        ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
        [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
           
            //(@"%@",responseObject);
            [self makeDIZhiData];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [failAlView show];
       }];
    }];
    
    // 修改
  [cell ChangeBlocks:^(NSDictionary *dic) {
      AddAddressViewController *avc =[[AddAddressViewController alloc]initWithDic:dic AndChang:YES];
      [self.navigationController pushViewController:avc animated:YES];
  }];
    
    // 删除
    [cell deleBlocks:^(NSDictionary *dic) {
       
        NSString *Str =[dic objectForKey:@"chongxinJZ"];
        if ([Str isEqualToString:@"10"]) {
            // 修改了默认的地址 重新加载
            //(@" 请求数据重新加载");
         }
        else{
        //发送删除 请求  请求数据重新加载
        //(@"发送删除 请求  请求数据重新加载");
            
            wodeset =[NSString stringWithFormat:@"%@",[dic objectForKey:@"address_id"]];
           
            UIAlertView * deleAview =[[UIAlertView alloc]initWithTitle:@"提示" message:@"确定删除该地址信息" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            deleAview.tag =112;
            [deleAview show];
         
        }
    
        
    }];
    return cell;
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
        if (alertView.tag == 112) {
            if (buttonIndex ==1) {
                //(@"sdsfasss");
                
                NSUserDefaults * userDefault =[NSUserDefaults standardUserDefaults];
                
                NSString * userid =[userDefault objectForKey:@"Useid"];
                
                NSString *ShouY = [NSString stringWithFormat:@"http://daiyancheng.cn/appmember/address_del.do?token=test&member_id=%@&address_id=%@",userid,wodeset];
                //(@"%@",ShouY);
                ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
                [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    [self makeDIZhiData];
                   
                    
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    
                    UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    [failAlView show];
                }];
                

            }
   
    
    
    }
}
-(void)makedataWithBlocks:(void (^)(NSDictionary *))Blocks{
    DicBlocks =[Blocks copy];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (Dingdan) {

    NSDictionary *dic =dataArr[indexPath.row];
    DicBlocks(dic);
    [self.navigationController popViewControllerAnimated:YES];
}
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
