//
//  SearchReaultViewController.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-4-8.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "SearchReaultViewController.h"
#import "AFNetworking.h"
#import "PeisongTableViewCell.h"
#import "Toast+UIView.h"
@interface SearchReaultViewController ()

@end

@implementation SearchReaultViewController
-(id)initWithStr:(NSString *)Str{
    self =[super init];
    if ( self) {
        SearchStr  = Str;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor  = BackColor;
    DataArr =[[NSArray alloc]init];
    // 分类
   
    [self creatData];
    UIButton *BackBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    BackBtn.frame =CGRectMake(0, 0, 64, 27);
    [BackBtn  setBackgroundImage:[UIImage imageNamed:@"app_fanhui"] forState:UIControlStateNormal];
    // [BackBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    
    [BackBtn addTarget:self action:@selector(BackAction)  forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem =[[UIBarButtonItem alloc]initWithCustomView:BackBtn];
    self.navigationItem.leftBarButtonItem = backItem;
}
-(void)BackAction{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)creatData{
    [self.view makeToastActivity];

    NSUserDefaults * userdefault =[NSUserDefaults standardUserDefaults];
    NSString * longstttr=[NSString stringWithFormat:@"%@",[userdefault objectForKey:@"ZUOBIAO"]];
    NSString *ShouY = [NSString stringWithFormat:SEARFORPRO,@"2",SearchStr,longstttr];
    ShouY =[[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    //(@"%@",ShouY);
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DataArr =[responseObject objectForKey:@"goods"];
        [self makeFenLei];
        [self.view hideToastActivity];
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.view hideToastActivity];
          UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
          [failAlView show];
        //(@"cook load failed ,%@",error);
    }];


}
-(void)makeFenLei{
IOS_Frame
    UIButton *YinPinBtn =[UIButton buttonWithType: UIButtonTypeCustom];
    YinPinBtn.frame = CGRectMake(0, 0, ConentViewWidth/2, 40);
    YinPinBtn.backgroundColor = [UIColor whiteColor];
    [YinPinBtn setTitle:@"全部分类" forState:UIControlStateNormal];
    [YinPinBtn addTarget:self action:@selector(YinPinBtnActionq) forControlEvents:UIControlEventTouchUpInside];
    [YinPinBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
   // [self.view addSubview:YinPinBtn];
    // 右边按钮
    UIButton *JinPinBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    JinPinBtn.frame  =CGRectMake(YinPinBtn.frame.size.width+1, 0, ConentViewWidth -YinPinBtn.frame.size.width-1, 40);
    JinPinBtn.backgroundColor = [UIColor whiteColor];
    [JinPinBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [JinPinBtn setTitle:@"默认排序" forState:UIControlStateNormal];
    [JinPinBtn addTarget:self action:@selector(JinPinBtnAction) forControlEvents:UIControlEventTouchUpInside];
   // [self.view addSubview:JinPinBtn];
    
    
   // MyTableView  =[[UITableView alloc]initWithFrame:CGRectMake(0,  YinPinBtn.frame.size.height+1, ConentViewWidth,  ConentViewHeight - YinPinBtn.frame.size.height ) style:UITableViewStylePlain];
     MyTableView  =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth,  ConentViewHeight -0 ) style:UITableViewStylePlain];
    
    MyTableView.delegate =self;
    MyTableView.dataSource =self;
    MyTableView.separatorStyle= UITableViewCellSeparatorStyleNone;
    [self.view addSubview:MyTableView];
    
    


}
-(void)YinPinBtnActionq{
    //(@"zuo");
}
-(void)JinPinBtnAction{
    //(@"you");
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 109;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return DataArr.count;
    //return JPdataArr.count;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSDictionary *dic =[DataArr objectAtIndex:indexPath.row];
//    ProductDetailViewController *Pvc =[[ProductDetailViewController alloc]initWithStr:[dic objectForKey:@"goods_id"]];
//    Pvc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:Pvc animated:YES];
    //(@"我是第%d 行",indexPath.row);
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PeisongTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"PeiSoncell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"PeisongTableViewCell" owner:self options:nil]lastObject];
    }
    NSDictionary *dic =[DataArr objectAtIndex:indexPath.row];
  
    [cell cellSearchWithDic:dic];
    
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    return  cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
