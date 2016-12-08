//
//  DaiJinQuanViewController.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-14.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "DaiJinQuanViewController.h"
#import "DaiJinQTableViewCell.h"
#import "DaijianquanXQViewController.h"
#import "AddQuanddddViewController.h"
#import "AFNetworking.h"
#import "Toast+UIView.h"
#import "LogViewController.h"
#import "MJRefresh.h"
@interface DaiJinQuanViewController ()<UIAlertViewDelegate>{
    NSInteger deleIndex;
    NSMutableArray *dataArr;
}

@end

@implementation DaiJinQuanViewController
-(void)viewWillAppear:(BOOL)animated{
     self.navigationController.navigationBar.hidden = NO;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    page = 1;
     self.view.backgroundColor =BackColor;
     dataArr =[NSMutableArray array];
   
    [self makeDJQData];
   
    [self makeItem];
    
    // Do any additional setup after loading the view.
}
-(void)makeDJQData{
    NSUserDefaults *UserDefault =[NSUserDefaults standardUserDefaults];
    NSString * UserIDs =[UserDefault objectForKey:@"Useid"];
    NSInteger denglu  = UserIDs.length;
    if (denglu ==  0) {// 未登录 进入登陆
        LogViewController *logview =[[LogViewController alloc]init];
        [self.navigationController pushViewController:logview animated:YES];
    }else{
        [self.view makeToastActivity];
        NSUserDefaults * userDefault =[NSUserDefaults standardUserDefaults];
        NSString * userID =[NSString stringWithFormat:@"%@",[userDefault objectForKey:@"Useid"]];
        NSString *ShouY = [NSString stringWithFormat:DAIJINQUAN,userID];
        //(@"%@",ShouY);
        ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
        [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString * str=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"result"]];
        if ( [str isEqualToString:@"1"]) {
            dataArr =[responseObject objectForKey:@"list"];
            if (dataArr.count < 4) {
                _tv.frame=CGRectMake(0, 0, ConentViewWidth, 120*dataArr.count);
                _tv.scrollEnabled = NO;
            }
             [self makeUI];
        }

        if(dataArr.count == 0){
            UILabel * tisishsl =[[UILabel alloc]initWithFrame:CGRectMake(30, ConentViewHeight/2 - 100 , ConentViewWidth - 60  , 30)];
            tisishsl.textAlignment = NSTextAlignmentCenter;
            tisishsl.text =@"暂无数据";
            tisishsl.font =[UIFont systemFontOfSize:13];
            [self.view addSubview:tisishsl];
            tisishsl.tag =100;
        }else{
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

}
-(void)makeItem{
    self.navigationItem.title=@"代金券";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:[UIColor colorWithRed:0.047 green:0.364 blue:0.663 alpha:1]}];

    UIButton * Rightbtn =[UIButton buttonWithType:UIButtonTypeCustom];
    Rightbtn.frame =CGRectMake(0, 0, 15, 15);
    [Rightbtn addTarget:self action:@selector(AddQuanAction) forControlEvents:UIControlEventTouchUpInside];
    [Rightbtn setImage:[UIImage imageNamed:@"app_tianjiakaquan"] forState:UIControlStateNormal];
    UIBarButtonItem *RightItem =[[UIBarButtonItem alloc]initWithCustomView:Rightbtn];
    
    self.navigationItem.rightBarButtonItem = RightItem;

    //返回按钮
    UIImage *lbbImage = [UIImage imageNamed:@"back_new"];
    lbbImage = [lbbImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem * lbbItem = [[UIBarButtonItem alloc] initWithImage:lbbImage style:UIBarButtonItemStylePlain target:self action:@selector(BackAction)];
    self.navigationItem.leftBarButtonItem = lbbItem;
}
-(void)BackAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)AddQuanAction{
   AddQuanddddViewController *Avc =[[AddQuanddddViewController alloc]init];
    [self.navigationController pushViewController:Avc animated:YES];
    //(@"添加劵");
}
//底部
-(void)FootAct{
    page ++;
}
// 顶部
-(void)HeatAct{
    page =1;
}
-(void)makeUI{
    _tv  =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, ConentViewHeight) style:UITableViewStylePlain];
    _tv.delegate =self;
    _tv.backgroundColor =[UIColor whiteColor];
    _tv.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tv.dataSource =self;
    [_tv addFooterWithTarget:self action:@selector(FootAct)];
    [_tv addHeaderWithTarget:self action:@selector(HeatAct)];
    if (dataArr.count < 4) {
        _tv.frame=CGRectMake(0, 0, ConentViewWidth, 130*dataArr.count);
        _tv.scrollEnabled = NO;
    }
    UILongPressGestureRecognizer * longP =[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressToDo:)];
    longP.minimumPressDuration = 1.0;
    [_tv addGestureRecognizer:longP];
    [self.view addSubview:_tv];
}
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  dataArr.count;
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DaiJinQTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell ==nil) {
        cell =[[[NSBundle mainBundle]loadNibNamed:@"DaiJinQTableViewCell" owner:nil options:nil]lastObject];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.tag =indexPath.row +99;
    NSDictionary * Dic =dataArr[indexPath.row];
    [cell dajincellmakeWithDic:Dic];
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *strr =[dataArr[indexPath.row]  objectForKey:@"voucher_id" ];
    DaijianquanXQViewController *Dvc =[[DaijianquanXQViewController alloc]initVidWIthStr:strr andLIingqu:NO];

    [self.navigationController pushViewController:Dvc animated:YES];
    //(@"进入代金券详情 ");

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


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag ==62) {
    if (buttonIndex ==1) {
        NSString * vCode = [NSString stringWithFormat:@"%@",[dataArr[deleIndex] objectForKey:@"voucher_code"]];
        NSString *ShouY = [NSString stringWithFormat:DELDAIJINQUAN,vCode];
        //(@"%@",ShouY);
        ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

        AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
        [self.view makeToastActivity];
        [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSString * str=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"result"]];
            if ( [str isEqualToString:@"1"]) {
                NSMutableArray * tmpArr =[NSMutableArray arrayWithArray:dataArr];
                [tmpArr removeObjectAtIndex:deleIndex];
                dataArr =[NSMutableArray arrayWithArray:tmpArr];
                [_tv reloadData];
            }
            [self.view hideToastActivity];
            [_tv footerEndRefreshing];
            [_tv headerEndRefreshing];
        }    failure:^(AFHTTPRequestOperation *operation, NSError *error) {

            [self.view hideToastActivity];
            [_tv footerEndRefreshing];
            [_tv headerEndRefreshing];
            //(@"cook load failed ,%@",error);
        }];
    }
    }
}

@end
