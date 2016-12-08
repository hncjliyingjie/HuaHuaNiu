//
//  HoMFJLViewController.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-30.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "HoMFJLViewController.h"
#import "HoMFJLTableViewCell.h"
#import "AFNetworking.h"
#import "Toast+UIView.h"
@interface HoMFJLViewController ()<UIAlertViewDelegate>{
    NSInteger _delIndex;
}

@end

@implementation HoMFJLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.view.backgroundColor =BackColor;
    UIButton *BackBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    BackBtn.frame =CGRectMake(0, 0, 64, 27);
    [BackBtn  setBackgroundImage:[UIImage imageNamed:@"app_fanhui"] forState:UIControlStateNormal];
    // [BackBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    
    [BackBtn addTarget:self action:@selector(BackAction)  forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem =[[UIBarButtonItem alloc]initWithCustomView:BackBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    UIButton *RightBr =[UIButton buttonWithType:UIButtonTypeCustom];
    RightBr.frame =CGRectMake(0, 0, 15, 15);
    [RightBr addTarget:self action:@selector(RighrAction) forControlEvents:UIControlEventTouchUpInside];
    
    // RightBr.backgroundColor =[UIColor whiteColor];
    [RightBr setBackgroundImage:[UIImage imageNamed:@"矢量智能对象1"] forState:UIControlStateNormal];
    
    
    //  UIBarButtonItem *rightItem =[[UIBarButtonItem alloc]initWithCustomView:RightBr];
    
    // self.navigationItem.rightBarButtonItem = rightItem;
    diBView =[[UIView alloc]initWithFrame:CGRectMake(0, ConentViewHeight - 50, ConentViewWidth, 50)];;
    diBView.backgroundColor = BackColor;
    diBView.hidden = YES;
    deletBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [deletBtn addTarget:self action:@selector(delegateCCAction) forControlEvents:UIControlEventTouchUpInside];
    deletBtn.frame =CGRectMake(10, ConentViewHeight -40, ConentViewWidth-20 , 30);
    [deletBtn setTitle:@"删除" forState:UIControlStateNormal];
    [deletBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    deletBtn.hidden = YES;
    deletBtn.layer.cornerRadius = 5;
    [deletBtn setBackgroundColor:[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1]];
    [self.view addSubview:diBView];
    [self.view addSubview:deletBtn];

    
    self.navigationItem.title=@"得到记录";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self makeHoMfJ];
    
 
    // Do any additional setup after loading the view.
}
-(void)makeHoMfJ{
    [self.view makeToastActivity];
    NSUserDefaults * UserDefault = [NSUserDefaults standardUserDefaults];
    NSString * userID =[UserDefault objectForKey:@"Useid"];
    NSString *ShouY = [NSString stringWithFormat:ZHDEMIANHOST, userID];
    //(@"%@",ShouY);
    ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];    
    [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        dataArr =[[NSMutableArray alloc]initWithArray:[responseObject objectForKey:@"list"]];
        
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
    [self makeUI];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.view hideToastActivity];
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [failAlView show];
        //(@"cook load failed ,%@",error);
    }];
    

}

-(void)makeUI{
    IOS_Frame
    _tv  =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, ConentViewHeight) style:UITableViewStylePlain];
    _tv.delegate =self;
    _tv.dataSource =self;
    
    if (dataArr.count < 5) {
        _tv.frame=CGRectMake(0, 0, ConentViewWidth,90*dataArr.count);
        _tv.scrollEnabled = NO;
        
    }
    _tv.separatorStyle  =UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tv];
    
    
    
   }
-(void)delegateCCAction{
    //(@"%@",deleArr);
    
    //(@"删除");
}
-(void)RighrAction{
    
    HIddle =!HIddle;
    deletBtn.hidden =  !deletBtn.hidden;
    diBView.hidden=!diBView.hidden;
    [_tv reloadData];

}
-(void)BackAction{
    [self.navigationController popViewControllerAnimated:YES];
}


-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  dataArr.count;
    
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HoMFJLTableViewCell *cell =[[[NSBundle mainBundle]loadNibNamed:@"HoMFJLTableViewCell" owner:nil options:nil]lastObject];
   cell.selectionStyle=UITableViewCellSelectionStyleNone;
    NSDictionary *ddic =dataArr[indexPath.row];
    [cell honcellMakeWIthDIc:ddic];
    
//    [cell DeleBlocks:^(NSMutableArray *VchArr) {
//        deleArr =[[NSMutableArray alloc]initWithArray:VchArr];
//    }];
    
    if (HIddle) {
        cell.deleteBtn.hidden = NO;

    }
    else{
        cell.deleteBtn.hidden = YES;
    
    }
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   // 删除 元素
    UIAlertView * delAV =[[UIAlertView alloc]initWithTitle:@"提示" message:@"确定要删除该记录吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    delAV.tag =888;
    _delIndex =indexPath.row;
    [delAV show];
    
    //(@"dasta == %@",dataArr[indexPath.row]);
    

}
-(void)EnterAction{
    //    [LabelView removeFromSuperview];
    //    [tishiBakViw removeFromSuperview];
    //    //(@"yincang");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag ==888) {
        if (buttonIndex ==1) {
            NSString * deleStr =[NSString stringWithFormat:ZM_DEL,[dataArr[_delIndex]objectForKey:@"freelog_id"]];
            //
            //    NSUserDefaults * UserDefault = [NSUserDefaults standardUserDefaults];
            //    NSString * userID =[UserDefault objectForKey:@"Useid"];
            // NSString *ShouY = [NSString stringWithFormat:ZHDEMIANHOST, userID];
            
            deleStr =[deleStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
            
            [manager GET:deleStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                //(@"dic == %@",responseObject);
                NSString * restultstr =[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"result"]];
                if ([restultstr isEqualToString:@"1"]) {
                    
                    [self makeHoMfJ];
                    
                }
                
                [self.view hideToastActivity];
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [self.view hideToastActivity];
                UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [failAlView show];
                //(@"cook load failed ,%@",error);
            }];

        }
    }
}

@end
