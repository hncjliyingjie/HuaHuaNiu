//
//  ShipinViewController.m
//  HuaHuaNiu
//
//  Created by alex on 16/1/7.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "ShipinViewController.h"
#import "QiuZhiModel.h"
#import "QiuzhiCell.h"

#import "Toast+UIView.h"
#import "LogViewController.h"
@interface ShipinViewController (){
    UITableView * _tv;
    NSMutableArray * dataArr;
    QiuZhiModel * model;
}
@end

@implementation ShipinViewController
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
    
    
    UIBarButtonItem *backItem =[[UIBarButtonItem alloc]initWithCustomView:BackBtn];
    
    self.navigationItem.leftBarButtonItem = backItem;
    self.navigationItem.title=@"我的视频";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:20],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
}

-(void)BackAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    [self createNav];
    dataArr =[NSMutableArray array];
    [self requestData];

}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    [self BackAction];
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
        UIAlertView *Shipin = [[UIAlertView alloc]initWithTitle:@"提示" message:@"没有数据" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [Shipin show];
        NSString * userId =[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"Useid"]];
        NSString * requestUrl = SHIPIN_LIST;

        [self.view makeToastActivity];
        RequestManger *manger =[RequestManger share];
        NSDictionary *dict = @{userId : @"member_id"};
        [manger requestDataByPostWithPath:requestUrl dictionary:dict complete:^(NSDictionary *data) {
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
    return 160;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    QiuzhiCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell =[[[NSBundle mainBundle]loadNibNamed:@"QiuzhiCell" owner:self options:nil]lastObject];
    }
    QiuZhiModel * listModel =dataArr[indexPath.row];
    [cell makeCellWith:listModel];
    return cell;
}



//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    QiuZhiDeatilViewController * dvc =[[QiuZhiDeatilViewController alloc]init];
//    dvc.hidesBottomBarWhenPushed =YES;
//    QiuZhiModel * listModel =dataArr[indexPath.row];
//    dvc.currentModel = listModel;
//    [self.navigationController pushViewController:dvc animated:YES];
//}



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
