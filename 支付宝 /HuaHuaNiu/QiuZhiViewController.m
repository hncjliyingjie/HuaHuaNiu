//
//  QiuZhiViewController.m
//  HuaHuaNiu
//
//  Created by alex on 15/10/24.
//  Copyright © 2015年 张燕. All rights reserved.
//

#import "QiuZhiViewController.h"
#import "MyQiuTableViewCell.h"
//#import "QiuzhiCell.h"
#import "QiuZhiModel.h"
#import "QiuZhiDeatilViewController.h"
#import "Toast+UIView.h"
#import "LogViewController.h"
@interface QiuZhiViewController (){
    UITableView * _tv;
    NSMutableArray * dataArr;
    QiuZhiModel * model;
}

@end

@implementation QiuZhiViewController
-(void)viewWillAppear:(BOOL)animated{
    if (_tv) {
        [self requestData];
    }
}

- (void)createNav{
    UIButton *BackBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    BackBtn.frame =CGRectMake(0, 0, 64, 27);
    [BackBtn  setBackgroundImage:[UIImage imageNamed:@"app_fanhui"] forState:UIControlStateNormal];
    [BackBtn addTarget:self action:@selector(BackAction)  forControlEvents:UIControlEventTouchUpInside];
    
//    UIButton *createBtn =[UIButton buttonWithType:UIButtonTypeCustom];
//    createBtn.frame =CGRectMake(ConentViewWidth -74, 0, 64, 27);
//    [createBtn setTitle:@"发布" forState:UIControlStateNormal];
//    [createBtn addTarget:self action:@selector(createAction)  forControlEvents:UIControlEventTouchUpInside];

    
    UIBarButtonItem *backItem =[[UIBarButtonItem alloc]initWithCustomView:BackBtn];
//    UIBarButtonItem *createItem =[[UIBarButtonItem alloc]initWithCustomView:createBtn];

    self.navigationItem.leftBarButtonItem = backItem;
//    self.navigationItem.rightBarButtonItem =createItem;
    self.navigationItem.title=@"我的求职";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:20],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
}

-(void)BackAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)createAction{
    QiuZhiDeatilViewController * qzvc =[[QiuZhiDeatilViewController alloc]init];
    [self.navigationController pushViewController:qzvc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    [self createNav];
    dataArr =[NSMutableArray array];
    [self requestData];
}

-(void)requestData{
    NSUserDefaults *UserDefault =[NSUserDefaults standardUserDefaults];
    NSString * UserIDs =[UserDefault objectForKey:@"Useid"];
    int denglu  = (int)UserIDs.length;
    if (denglu ==  0) {// 未登录 进入登陆
        LogViewController *logview =[[LogViewController alloc]init];
        [self.navigationController pushViewController:logview animated:YES];
    }
    else{

    NSString * userId =[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"Useid"]];
        NSLog(@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"Useid"]);
        //http://daiyancheng.cn/appwork/store_joins.do?token=test&page=1&ll=
        //http://daiyancheng.cn/appwork/jobhunts.do?token=test&page=1&ll=34.774632,113.733479&type=2
    NSString * requestUrl =[NSString stringWithFormat:@"http://daiyancheng.cn/appwork/my_applyjoin.do?token=test&member_id=%@",userId];
    [self.view makeToastActivity];
        
    RequestManger *manger =[RequestManger share];
   [manger requestDataByGetWithPath:requestUrl complete:^(NSDictionary *data) {
       //(@"%@",data);
       if ([data objectForKey:@"error"]) {
           //(@"%@",[data objectForKey:@"error"]);
       }else{
           [self.view hideToastActivity];
           QiuZhiModel * tmpModel =[QiuZhiModel makeListArrModelWith:data];
           dataArr = tmpModel.QiuzhiList;
           if (dataArr.count ==0) {
               UILabel * label =[[UILabel alloc]initWithFrame:CGRectMake(ConentViewWidth/2-100, ScreenHeight/2-20, 200, 30)];
               label.text =@"您还没有发布任何信息";
               label.textColor =[UIColor lightGrayColor];
               label.textAlignment =NSTextAlignmentCenter;
               [self.view addSubview:label];
           }else{
               if (_tv) {
                   [_tv reloadData];
               }else{
               [self createUI];
               }
           }
       }
    }];
    }
}

-(void)createUI{
    if (_tv) {
        [_tv reloadData];
    }else{
    _tv =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, ConentViewHeight) style:UITableViewStylePlain];
    _tv.separatorStyle =UITableViewCellSeparatorStyleNone;
    _tv.dataSource =self;
    _tv.delegate =self;
    [self.view addSubview:_tv];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyQiuTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell =[[[NSBundle mainBundle]loadNibNamed:@"MyQiuTableViewCell" owner:self options:nil]lastObject];
    }
    QiuZhiModel * listModel =dataArr[indexPath.row];
    [cell makeCellWith:listModel];
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    QiuZhiDeatilViewController * dvc =[[QiuZhiDeatilViewController alloc]init];
    [dvc.btn2  setTitle:@"修改" forState:UIControlStateNormal];
    dvc.count1=@"1";
    dvc.hidesBottomBarWhenPushed =YES;
    QiuZhiModel * listModel =dataArr[indexPath.row];
    dvc.currentModel = listModel;
    [self.navigationController pushViewController:dvc animated:YES];
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
