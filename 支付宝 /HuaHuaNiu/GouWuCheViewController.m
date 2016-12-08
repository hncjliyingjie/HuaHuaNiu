//
//  GouWuCheViewController.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-18.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "GouWuCheViewController.h"
#import "gouwucellTableViewCell.h"
#import "AFNetworking.h"
#import "Toast+UIView.h"
#import "MJRefresh.h"
#import "GWTJViewController.h"



@interface GouWuCheViewController ()

@end

@implementation GouWuCheViewController

- (void)viewDidLoad {
    self.navigationItem.title=@"购物车";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];

    
    isdelegate = NO;
    self.view.backgroundColor =BackColor;
    [super viewDidLoad];
    [self makeGOdata];

    // Do any additional setup after loading the view.
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
-(void)makeGOdata{
    [self.view makeToastActivity];
    NSUserDefaults * userdefault =[NSUserDefaults standardUserDefaults];
   NSString *users_ID =[NSString stringWithFormat:@"%@",[userdefault objectForKey:@"Useid"]];

    NSString * ShouY = [NSString stringWithFormat:MYGWC,users_ID];

    ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //(@"%@",ShouY);
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    
    [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        JieSuandic =[[NSDictionary alloc]initWithDictionary:responseObject];
        DataArr =[[NSMutableArray alloc]initWithArray:[responseObject objectForKey:@"list"]];
        if(DataArr.count == 0){
        [self.view hideToastActivity];
            if(DataArr.count == 0){
                UILabel * tisishsl =[[UILabel alloc]initWithFrame:CGRectMake(30, ConentViewHeight/2 - 100 , ConentViewWidth - 60  , 30)];
                
                tisishsl.textAlignment = NSTextAlignmentCenter;
                tisishsl.text =@"暂无数据";
                tisishsl.font =[UIFont systemFontOfSize:13];
                [self.view addSubview:tisishsl];
                _tv.hidden = YES;
                tisishsl.tag =100;
            }
            else{
                UILabel * tisi =(UILabel *)[self.view  viewWithTag:100];
                
                tisi.hidden = YES;
            }

        }
        else{
            
        [self.view hideToastActivity];
            _tv.hidden = NO;
            
        priceStr =[NSString stringWithFormat:@"￥ %@",[responseObject objectForKey:@"amount"]];
            
        if ([priceStr isEqualToString:@"(null)"]) {
            priceStr=@"0";
        }
        PriceTotalLabel.text =priceStr;
       [self.view hideToastActivity];
//        BiaoJiArr =[[NSMutableArray alloc]init];
//        for (NSArray * arr in DataArr) {
//            NSMutableArray * ZuArr=[[NSMutableArray alloc]init];
//            
//            for (NSArray *goodArr in arr) {
//                
//                NSMutableDictionary * dic =[[NSMutableDictionary alloc]init];
//                [dic setObject:@"NO" forKey:@"xuanzhong"];
//                
//                [ZuArr addObject:dic];
//            }
//            [BiaoJiArr addObject:ZuArr];
//        }
        if (isdelegate) {//是 删除后重新请求的
            
            [_tv reloadData];
        }
        else{
        
        [self  makeUI];
        }
      }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.view hideToastActivity];
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        failAlView.tag =11;
        [failAlView show];
        //(@"cook load failed ,%@",error);
    }];

}
-(void)makeUI{
    IOS_Frame
   
       _tv = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, ConentViewHeight -40) style:UITableViewStyleGrouped];
    _tv.delegate =self;
    _tv.dataSource =self;
    [self.view addSubview:_tv];
// 结算bottom
    
     BottomView =[[UIView alloc]initWithFrame:CGRectMake(0, ConentViewHeight-40, ConentViewWidth, 40)];
    
    //BottomView.backgroundColor =[UIColor colorWithRed:101/255.0 green:101/255.0 blue:101/255.0 alpha:0.9];
    BottomView.backgroundColor =[UIColor whiteColor];
  /*  结算 左边的Btn
    
    UIButton *imaBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    imaBtn.frame =CGRectMake(10, 10, 15, 15);
    [imaBtn addTarget:self action:@selector(ImaBtnact:) forControlEvents:UIControlEventTouchUpInside];
    imaBtn.backgroundColor =[UIColor whiteColor];
    [imaBtn setImage:[UIImage imageNamed:@"app_huiduihao"] forState:UIControlStateNormal];
    [imaBtn setImage:[UIImage imageNamed:@"app_duihaojihuo"] forState:UIControlStateSelected];
//[BottomView addSubview:imaBtn]; */
    UILabel * zongjiLabel =[[UILabel alloc]initWithFrame:CGRectMake(20, 5, 60, 30)];
    zongjiLabel.text=@"总计:";
    zongjiLabel.font =[UIFont systemFontOfSize:15];
    zongjiLabel.textColor =[UIColor blackColor];
    [BottomView addSubview:zongjiLabel];
    // jiahe
    PriceTotalLabel =[[UILabel alloc]initWithFrame:CGRectMake(60, 5, 120, 30)];
    PriceTotalLabel.textColor =[UIColor redColor];
    if ([priceStr isEqualToString:@"(null)"]) {
        priceStr=@"0";
    }

    PriceTotalLabel.text =priceStr;
    [BottomView addSubview:PriceTotalLabel];
   //结算btn
    acountBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    acountBtn.frame =CGRectMake(ConentViewWidth-70, 5, 65, 30);
    [acountBtn setTitle:@"结算" forState:UIControlStateNormal];
    [acountBtn addTarget:self action:@selector(JiesuanAct) forControlEvents:UIControlEventTouchUpInside];
    acountBtn.layer.cornerRadius= 4;
    acountBtn.titleLabel.font =[UIFont systemFontOfSize:12];
    [acountBtn setBackgroundColor:[UIColor colorWithRed:247/255.0 green:125/255.0 blue:137/255.0 alpha:1]];
    [BottomView addSubview:acountBtn];
    
    [self.view addSubview:BottomView];
}
-(void)JiesuanAct{
    //  购物车里面没有数据的话不能 结算
    if (DataArr.count ==0) {
        UIAlertView *alll =[[UIAlertView alloc]initWithTitle:@"提示" message:@"购物车没有数据" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        alll.tag =22;
        [alll show];
    }
    else{
      
    GWTJViewController * Gvc =[[GWTJViewController alloc]initWithDic:JieSuandic];
        
    [self.navigationController pushViewController:Gvc animated:YES];
    
    }
    
    
    
}
-(void)ImaBtnact:(UIButton *)Btn{
    Btn.selected = !Btn.selected;
    //(@" 全选 总的 价格  KVO KVC ");
    quanXuan = YES;
  
}
// 设置 头和尾
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView * HeaderView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, 30)];
    HeaderView.backgroundColor =[UIColor whiteColor];
    UILabel * nameLnel =[[UILabel alloc]initWithFrame:CGRectMake(10, 5, ConentViewWidth-10, 20)];
    
    nameLnel.text =[NSString stringWithFormat:@"%@",[DataArr[section] objectForKey:@"store_name"]];
    [HeaderView addSubview:nameLnel];

    return HeaderView;

}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * FootView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, 10)];
    FootView.backgroundColor =BackColor;
    UILabel* zongjiLabel =[[UILabel alloc]initWithFrame:CGRectMake(ConentViewWidth-70, 0, 65, 30)];
    zongjiLabel.textColor =[UIColor redColor];
    zongjiLabel.font =[UIFont systemFontOfSize:12];
    zongjiLabel.text =[NSString stringWithFormat:@"%@",[DataArr[section] objectForKey:@"amount"]];
    UILabel * zog =[[UILabel alloc]initWithFrame:CGRectMake(ConentViewWidth - 100, 0, 35, 30)];
    zog.text=@"总计:";
    zog.font =[UIFont systemFontOfSize:12];
    [FootView addSubview:zog];
    UILabel * numberlabel =[[UILabel alloc]initWithFrame:CGRectMake(ConentViewWidth - 170, 0, 80, 30)];
    numberlabel.font =[UIFont systemFontOfSize:12];
    numberlabel.text=[NSString stringWithFormat:@"共%@件商品",[DataArr[section] objectForKey:@"quantity"]];
    [FootView addSubview:numberlabel];
    
    [FootView addSubview:zongjiLabel];
       return FootView;

}


//设置每个分组的头和尾的高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{


    return 30;
}


//设置tableview中的分组个数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return DataArr.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  ////(@"%d    %d",indexPath.section ,indexPath.row);
    
}


-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray * Arr  =[DataArr[section] objectForKey:@"goods"];
    return  Arr.count ;
    
}
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 100;
//}
//
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray  * Arr =[DataArr[indexPath.section] objectForKey:@"goods"];
    
    gouwucellTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell ==nil) {
        cell =[[[NSBundle mainBundle]loadNibNamed:@"gouwucellTableViewCell" owner:self options:nil]lastObject];
    }
  //  cell.selectionStyle=UITableViewCellSelectionStyleNone;

    [cell cellMakeDateWithDic:Arr[indexPath.row]];
    
    //  修改后 计算总金额
      [cell MakeJieSuanBlocks:^(NSString *Number, NSString *recl_id) {
               //改变数量
          
//          NSUserDefaults * userdefault =[NSUserDefaults standardUserDefaults];
//          NSString *userID =[NSString stringWithFormat:@"%@",[userdefault objectForKey:@"Useid"]];
          // 暂时没有用到 userid
          NSString * ShouY = [NSString stringWithFormat:CHANGNUMBERFORGW,recl_id,Number];
          ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
          //(@"%@",ShouY);

          AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
          
          [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              isdelegate = YES;
              [self makeGOdata];
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
              failAlView.tag= 12;
              [failAlView show];
              //(@"cook load failed ,%@",error);
          }];
          
          

          }];
          // 删除 该商品
    [cell deleActionBlocks:^(NSString *MYrec_id) {
      
       
      // //(@"删除购物产品 %@",MYrec_id);

       delealerView =[[UIAlertView alloc]initWithTitle:@"删除此产品" message:@"您确定从购物车里面删除产品？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [delealerView show];
         MYResc_id  =MYrec_id;
       
       
   }];
    //判断 是不是选中状态
//    NSArray * zuArr =BiaoJiArr[indexPath.section];
//    NSString * xuanStr =[NSString stringWithFormat:@"%@",[zuArr[indexPath.row] objectForKey:@"xuanzhong"]];
//    
//    if ([xuanStr isEqualToString:@"YES"]) { //选中
//        cell.xuanZZZBtn.selected = YES;
//    }
//    else{ // 未选中
//    
//        cell.xuanZZZBtn.selected = NO;
//    }
    return cell;
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
 //   //(@"删除或者取消");
    if (alertView.tag ==22||alertView.tag ==11||alertView.tag==12||alertView.tag==13) {
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    else{
    if (buttonIndex == 1) {
        
        NSString * ShouY = [NSString stringWithFormat:DELEGwC,MYResc_id];
        //(@"%@",ShouY);
        ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
        
        [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //(@"%@",[responseObject objectForKey:@"msg"]);
            // 重新请求数据
            ///
            isdelegate = YES;
            [self makeGOdata];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            failAlView.tag=13;
            [failAlView show];
            //(@"cook load failed ,%@",error);
        }];
        

//(@"删除");
    }
    else{
     //(@"取消");
     //(@"0");
    
    }


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
