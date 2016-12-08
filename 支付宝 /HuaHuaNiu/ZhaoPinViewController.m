//
//  ZhaoPinViewController.m
//  HuaHuaNiu
//
//  Created by alex on 15/10/24.
//  Copyright © 2015年 张燕. All rights reserved.
//

#import "ZhaoPinViewController.h"
#import "QiuZhiDeatilViewController.h"
#import "LogViewController.h"
#import "QiuzhiCell.h"

extern NSString *str;

@interface ZhaoPinViewController (){
    UITableView * _tv;
    UITableView *_tv1;
    UIButton *button1;
    UIButton *button2;
    NSMutableArray * dataArr;
    NSMutableArray * dataArr1;
    ZhaoPinModel * model;
    int count;
}


@end

@implementation ZhaoPinViewController
-(void)viewWillAppear:(BOOL)animated{
    
    [self.view addSubview:_tv1];
    [self.view addSubview:_tv];
    
    if (_tv) {
        [_tv reloadData];
    }
}

- (void)createNav{
    UIButton *BackBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    BackBtn.frame =CGRectMake(0, 0, 64, 27);
    UIView *viewB=[[UIView alloc]init];
    [viewB setBackgroundColor:[UIColor darkGrayColor]];
    viewB.frame=CGRectMake(self.view.frame.size.width/2, 5, 2, 30);
    button1 =[UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setTag:1];
    button1.frame =CGRectMake(0, 0, self.view.frame.size.width/2, 40);
    [button1 setTitle:@"招聘" forState:UIControlStateNormal];
//    [button1 setBackgroundColor:[UIColor redColor]];
    button2 =[UIButton buttonWithType:UIButtonTypeCustom];
    NSLog(@"%f",self.view.frame.size.width/2);
    button2.frame =CGRectMake(self.view.frame.size.width/2, 0, self.view.frame.size.width/2, 40);
    [button2 setTag:2];
    [button2 setTitle:@"求职" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [button1 addTarget:self action:@selector(button1:)  forControlEvents:UIControlEventTouchUpInside];
    [button2 addTarget:self action:@selector(button2:)  forControlEvents:UIControlEventTouchUpInside];
    [button1 setBackgroundColor:[UIColor colorWithRed:239.0/255 green:242.0/255 blue:246.0/255 alpha:1.0]];
    [button2 setBackgroundColor:[UIColor colorWithRed:239.0/255 green:242.0/255 blue:246.0/255 alpha:1.0]];
    button1.selected = YES;
    [self.view addSubview:button1];
    [self.view addSubview:button2];
    [self.view addSubview:viewB];
    
    
    [BackBtn  setBackgroundImage:[UIImage imageNamed:@"app_fanhui"] forState:UIControlStateNormal];
    [BackBtn addTarget:self action:@selector(BackAction)  forControlEvents:UIControlEventTouchUpInside];

    
    UIBarButtonItem *backItem =[[UIBarButtonItem alloc]initWithCustomView:BackBtn];
    UIButton *createBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    createBtn.frame =CGRectMake(ConentViewWidth -74, 0, 64, 27);
    [createBtn setTitle:@"发布" forState:UIControlStateNormal];
    [createBtn addTarget:self action:@selector(createAction)  forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem *createItem =[[UIBarButtonItem alloc]initWithCustomView:createBtn];

    self.navigationItem.rightBarButtonItem =createItem;
    self.navigationItem.leftBarButtonItem = backItem;
    self.navigationItem.title=@"招聘信息";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:20],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
}
-(void)button1:(UIButton *)sender{
    self.navigationItem.title=@"招聘信息";
    count=1;
    if (button2.selected) {
        button2.selected = NO;
    }
    sender.selected= YES;
    _tv1.hidden=YES;
    _tv.hidden=NO;
    [self requestData];
}
-(void)button2:(UIButton *)sender{
    self.navigationItem.title=@"求职信息";
    if (button1.selected) {
        button1.selected = NO;
    }
    sender.selected= YES;
    count=2;
    _tv.hidden=YES;
    _tv1.hidden=NO;
    [self requestData2];
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
    count=1;
    self.view.backgroundColor =[UIColor whiteColor];
    [self createNav];
    dataArr =[NSMutableArray array];
    dataArr1 =[NSMutableArray array];
    [self requestData];
}

-(void)requestData2{
    NSUserDefaults *UserDefault =[NSUserDefaults standardUserDefaults];
    NSString * UserIDs =[UserDefault objectForKey:@"Useid"];
    int denglu  = (int)UserIDs.length;
    if (denglu ==  0) {// 未登录 进入登陆
        LogViewController *logview =[[LogViewController alloc]init];
        [self.navigationController pushViewController:logview animated:YES];
    }
    else{
        str = @"34.774632,113.733479";
        //http://daiyancheng.cn/appwork/jobhunts.do?token=test&page=1&ll=34.774632,113.733479&type=2
        NSString * requestUrl =[NSString stringWithFormat:@"http://daiyancheng.cn/appwork/jobhunts.do?token=test&page=1&ll=%@&type=%i&member_id=%@",str,count ,UserIDs];
        [self.view makeToastActivity];
        RequestManger *manger =[RequestManger share];
        [manger requestDataByGetWithPath:requestUrl complete:^(NSDictionary *data) {
            //(@"%@",data);
            if ([data objectForKey:@"error"]) {
                //(@"%@",[data objectForKey:@"error"]);
            }else{
                [self.view hideToastActivity];
//                NSString *strH=[];
                QiuZhiModel * tmpModel =[QiuZhiModel makeListArrModelWith:data];
                dataArr1 = tmpModel.QiuzhiList;
                if (dataArr1.count ==0) {
                    UILabel * label =[[UILabel alloc]initWithFrame:CGRectMake(ConentViewWidth/2-100, ScreenHeight/2-20, 200, 30)];
                    label.text =@"您还没有发布任何信息";
                    label.textColor =[UIColor lightGrayColor];
                    label.textAlignment =NSTextAlignmentCenter;
                    [self.view addSubview:label];
                }else{
                        [self createUI1];
                    
                }
            }
        }];
    }
}

-(void)requestData{
    NSUserDefaults *UserDefault =[NSUserDefaults standardUserDefaults];
    NSString * UserIDs =[UserDefault objectForKey:@"Useid"];
    str = @"34.774632,113.733479";
    //daiyancheng.cn/appwork/jobhunts.do?token=test&page=1&ll=34.774632,113.733479&type=1
    //http://daiyancheng.cn/appwork/store_joins.do?token=test&page=1&ll=
    NSString * requestUrl =[NSString stringWithFormat:@"http://daiyancheng.cn/appwork/jobhunts.do?token=test&page=1&ll=%@&type=%i&member_id=%@",str ,count , UserIDs];

    [self.view makeToastActivity];
    RequestManger *manger =[RequestManger share];
    [manger requestDataByGetWithPath:requestUrl complete:^(NSDictionary *data) {
        //(@"%@",data);
        if ([data objectForKey:@"error"]) {
            //(@"%@",[data objectForKey:@"error"]);
        }else{
            [self.view hideToastActivity];
            ZhaoPinModel * tmpModel =[ZhaoPinModel makeListArrModelWith:data];
            dataArr = tmpModel.ZhaoPinList;
            if (dataArr.count ==0) {
                UILabel * label =[[UILabel alloc]initWithFrame:CGRectMake(ConentViewWidth/2-100, ScreenHeight/2-20, 200, 30)];
                label.text =@"暂时没有任何招聘信息";
                label.textColor =[UIColor lightGrayColor];
                label.textAlignment =NSTextAlignmentCenter;
                [self.view addSubview:label];
            }else{
                [self createUI];
            }
        }
    }];
}

-(void)createUI1{
    if (_tv1) {
        [_tv1 reloadData];
    }else{
        _tv1 =[[UITableView alloc]initWithFrame:CGRectMake(0, 40, ConentViewWidth, ConentViewHeight-64) style:UITableViewStylePlain];
//        _tv1.separatorStyle =UITableViewCellSeparatorStyleNone;
        _tv1.dataSource =self;
        _tv1.delegate =self;
        [self.view addSubview:_tv1];
    }
}
-(void)createUI{
    if (_tv) {
        [_tv reloadData];
    }else{
        _tv =[[UITableView alloc]initWithFrame:CGRectMake(0, 40, ConentViewWidth, ConentViewHeight-64) style:UITableViewStylePlain];
//        _tv.separatorStyle =UITableViewCellSeparatorStyleNone;
        _tv.dataSource =self;
        _tv.delegate =self;
        [self.view addSubview:_tv];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (count==1) {
        return dataArr.count;
    }else{
      return dataArr1.count;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (count==1) {
         return 141;
    }else{
        return 134;
    }
   
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (count==1) {
        ZhaoPinCellTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell==nil) {
            cell =[[[NSBundle mainBundle]loadNibNamed:@"ZhaoPinCellTableViewCell" owner:self options:nil]lastObject];
        }
        ZhaoPinModel * listModel =dataArr[indexPath.row];
        [cell makeCellWithModel:listModel];
return cell;
    }else{
        QiuzhiCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell==nil) {
            cell =[[[NSBundle mainBundle]loadNibNamed:@"QiuzhiCell" owner:self options:nil]lastObject];
        }
        QiuZhiModel * listModel =dataArr1[indexPath.row];
        cell.backgroundColor = [UIColor whiteColor];
        [cell makeCellWith:listModel];
return cell;
    }
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (count==1) {
        ZhaoPinDetailViewController * dvc =[[ZhaoPinDetailViewController alloc]init];
        
        dvc.hidesBottomBarWhenPushed =YES;
        ZhaoPinModel * listModel =dataArr[indexPath.row];
        dvc.currentModel = listModel;
        [self.navigationController pushViewController:dvc animated:YES];
    }else{
        QiuZhiDeatilViewController * dvc =[[QiuZhiDeatilViewController alloc]init];
        dvc.count1=@"2";
        dvc.hidesBottomBarWhenPushed =YES;
        QiuZhiModel * listModel =dataArr1[indexPath.row];
        
        NSLog(@"%@",dataArr1[indexPath.row]);
        dvc.currentModel = listModel;
        [self.navigationController pushViewController:dvc animated:YES];
    }
  
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
