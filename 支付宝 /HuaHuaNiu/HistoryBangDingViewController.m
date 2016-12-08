//
//  HistoryBangDingViewController.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-13.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "HistoryBangDingViewController.h"
#import "HistoryTableViewCell.h"
#import "AFNetworking.h"
#import "StoreDetailsViewController.h"
#import "Toast+UIView.h"
@interface HistoryBangDingViewController ()<UIAlertViewDelegate>{
    NSInteger deleIndex;
}

@end

@implementation HistoryBangDingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.navigationItem.title=@"绑定历史";
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
    
    UIButton *rightBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame =CGRectMake(0, 0, 15,15);
    
    [rightBtn setImage:[UIImage imageNamed:@"app_qianggoujilu_free"] forState:UIControlStateNormal];
    // [rightBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
    
    [rightBtn addTarget:self action:@selector(RigrhssssCtion) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem =[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    deletBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [deletBtn addTarget:self action:@selector(delegateCCActionw) forControlEvents:UIControlEventTouchUpInside];
    deletBtn.frame =CGRectMake(0, ConentViewHeight -30, ConentViewWidth , 30);
    [deletBtn setTitle:@"删除" forState:UIControlStateNormal];
    [deletBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    deletBtn.hidden = YES;
    deletBtn.backgroundColor = BackColor;
  //  [deletBtn setBackgroundColor:BackColor];
    [self.view addSubview:deletBtn];
    
    self.view.backgroundColor =BackColor;
    bsidArr  =[[NSMutableArray alloc]init];
    dataArr =[[NSMutableArray alloc]init];

    [self makeHostRistData:NO];
  
}
//reloada  判断是不是 删除后请求  yes  是
-(void)makeHostRistData:(BOOL )reloada{
    [self.view makeToastActivity];
    NSUserDefaults *UserDefault =[NSUserDefaults standardUserDefaults];
    NSString * UserIDs =[UserDefault objectForKey:@"Useid"];
    NSString *ShouY = [NSString stringWithFormat:MYDaiY,UserIDs];
    //(@"%@",ShouY);
    ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //(@"%@",[responseObject objectForKey:@"msg"]);
        dataArr =[responseObject objectForKey:@"binds"];
        if (reloada) {
            int a =ConentViewHeight/84 +1;
            if (dataArr.count <a) {
                _tv.frame =CGRectMake(0, 0, ConentViewWidth, 84*dataArr.count);
                _tv.bounces = NO;
            }
            else{
                _tv.bounces =YES;
            }
            [_tv reloadData];
        }
        else{
         [self makeUI];
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
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.view hideToastActivity];
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [failAlView show];
        //(@"cook load failed ,%@",error);
    }];
}


-(void)makeUI{
    _tv  =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, ConentViewHeight ) style:UITableViewStylePlain];
    _tv.delegate =self;
    _tv.dataSource =self;
    int a =ConentViewHeight/84 +1;
    if (dataArr.count <a) {
        _tv.frame =CGRectMake(0, 0, ConentViewWidth, 84*dataArr.count);
        _tv.bounces = NO;
    }
    else{
        _tv.bounces = YES;
    }
    [self.view addSubview:_tv];
}


-(void)delegateCCActionw{
//    [bsidArr addObject:@"3"];
//    NSArray * ar =[[NSArray alloc]initWithArray:bsidArr];
  
    UIAlertView  * alll =[[UIAlertView alloc]initWithTitle:@"提示" message:@"删除选中历史绑定商家" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alll show];
  

}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag == 11||alertView.tag ==12){
        [self.navigationController popViewControllerAnimated:YES];
    }else if(alertView.tag ==62){
                [dataArr removeObjectAtIndex:deleIndex];
                [_tv reloadData];
    }else{
    if (buttonIndex == 1) {
        // 删除关联
         NSString *DeleStr =[bsidArr componentsJoinedByString:@","];
        //(@"55555555555%@",DeleStr);
        NSString *ShouY = [NSString stringWithFormat:DELEGL,DeleStr];
        ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
        [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //  删除以后 在请求一次
            [self makeHostRistData:YES];
            deletBtn.hidden= deletBtn.hidden;
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [failAlView show];
            //(@"cook load failed ,%@",error);
        }];
        
        
    }
    else{
    }
    }

}
-(void)BackAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)RigrhssssCtion{
    if(dataArr.count  == 0){ }
    else{
    HIDDLE = !HIDDLE;
    deletBtn.hidden =!deletBtn.hidden;
        if (deletBtn.hidden) {
            _tv.frame=CGRectMake(0, 0, ConentViewWidth, ConentViewHeight );
           
            int a =ConentViewHeight/84 +1;
            if (dataArr.count <a) {
                _tv.frame =CGRectMake(0, 0, ConentViewWidth, 84*dataArr.count);
                _tv.bounces = NO;
            }

        }
        else{
        _tv.frame=CGRectMake(0, 0, ConentViewWidth, ConentViewHeight - 30 );
            
            int a =ConentViewHeight/84 +1;
            
            if (dataArr.count <a) {
                _tv.frame =CGRectMake(0, 0, ConentViewWidth, 84*dataArr.count);
                _tv.bounces = NO;
            }

        
        }
    [_tv reloadData];
    }
}
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  dataArr.count;
    
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 84;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (deletBtn.hidden) {
        NSString * storeId =[dataArr[indexPath.row] objectForKey:@"store_id"];
        StoreDetailsViewController * svc =[[StoreDetailsViewController alloc]initWithStr:storeId];
        [self.navigationController pushViewController:svc animated:YES];
    }
    else{
    
    }
   
    
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HistoryTableViewCell   * cell =[[[NSBundle mainBundle]loadNibNamed:@"HistoryTableViewCell" owner:nil options:nil]lastObject];
    
    [cell cellHistoryWithDic:dataArr[indexPath.row]];
    
    
    if(HIDDLE){
    cell.deldegateBtn.hidden = NO;
    }
    else{
      cell.deldegateBtn.hidden = YES;
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    [cell shareUserBlock:^(NSString *Str) {
        // 分享收益
        //(@"分享收益");
    }];
    // 判断 删除的事后是不是选中
    if([bsidArr containsObject:[dataArr[indexPath.row] objectForKey:@"bind_id"]] ){
       
        cell.deldegateBtn.selected = YES;
    }
    else{
        
          cell.deldegateBtn.selected = NO;
        
    }

    
    
    [cell CelldeleteBlocks:^(NSDictionary *dic) {
        //(@"判断删除");
        //  判断 是否已经加入 不是每次家 都 家
        if([bsidArr containsObject:[dataArr[indexPath.row] objectForKey:@"bind_id"]] ){
            [bsidArr removeObject:[dataArr[indexPath.row] objectForKey:@"bind_id"]];
            
        }
        else{
            
        //(@"%@",[dataArr[indexPath.row] objectForKey:@"bind_id"]);
            NSString * str =[NSString stringWithFormat:@"%@",[dataArr[indexPath.row] objectForKey:@"bind_id"]];
        [bsidArr addObject:str];
            
        }
        
    }];
    return cell;
  
}


-(void)longPressToDo:(UILongPressGestureRecognizer *)gesture
{
    if(gesture.state == UIGestureRecognizerStateBegan)
    {
        CGPoint point = [gesture locationInView:_tv];
        NSIndexPath * indexPath = [_tv indexPathForRowAtPoint:point];
        if(indexPath == nil) return ;
        deleIndex =indexPath.row;
        UIAlertView * av =[[UIAlertView alloc]initWithTitle:@"提示" message:@"您确定要删除该信息？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
        av.tag =62;
        [av show];
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
