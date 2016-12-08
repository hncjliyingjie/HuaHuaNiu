//
//  AddQuanddddViewController.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-26.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "AddQuanddddViewController.h"
#import "StoressssssTableViewCell.h"
#import "StoreDetailsViewController.h"
#import "AFNetworking.h"
#import "Toast+UIView.h"
#import "MJRefresh.h"
@interface AddQuanddddViewController ()

@end

@implementation AddQuanddddViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    page = 1;
    
    DataArr =[[NSMutableArray alloc]init];
  
    // Do any additional setup after loading the view.
    self.navigationItem.title=@"添加卡券";
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
    [self makeAddData];
    [self.view makeToastActivity];
}
-(void)makeAddData{

    NSUserDefaults * userdefault =[NSUserDefaults standardUserDefaults];
    
    DingWeistr =[NSString stringWithFormat:@"%@",[userdefault objectForKey:@"ZUOBIAO"]];
    
    NSString *ShouY = [NSString stringWithFormat:GEtDaiJIn,DingWeistr,page];
    
    ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //(@"%@",ShouY);

    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    
    [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
    [DataArr addObjectsFromArray:[responseObject objectForKey:@"stores"]];
    
      [self makeUI];
        if(DataArr.count == 0){
            UILabel * tisishsl =[[UILabel alloc]initWithFrame:CGRectMake(30, ConentViewHeight/2 - 100 , ConentViewWidth - 60  , 30)];
            tisishsl.textAlignment = NSTextAlignmentCenter;
            tisishsl.text =@"暂无数据";
            tisishsl.font =[UIFont systemFontOfSize:13];
            tisishsl.tag = 100;
            [self.view addSubview:tisishsl];
        }
        else{
            UILabel * tisi =(UILabel *)[self.view  viewWithTag:100];
            tisi.hidden = YES;
        }
        [self.view hideToastActivity];
        [_tv footerEndRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.view hideToastActivity];
        [_tv footerEndRefreshing];
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [failAlView show];
        //(@"cook load failed ,%@",error);
    }];
}
-(void)BackAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)FootActio{
    page++;
    [self makeAddData];
    [_tv footerBeginRefreshing];
    
}

-(void)makeUI{
    IOS_Frame

    _tv=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, ConentViewHeight )];
    _tv.delegate =self;
    _tv.dataSource =self;
    [_tv addFooterWithTarget:self action:@selector(FootActio)];
    if(DataArr.count < 7){
        _tv.frame =CGRectMake(0, 0, ConentViewWidth, 75*DataArr.count);
        _tv.scrollEnabled = NO;
    }
    [self.view addSubview:_tv];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  DataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    StoressssssTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell =[[[NSBundle mainBundle]loadNibNamed:@"StoressssssTableViewCell" owner:self options:nil]lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell MadddWithDic:DataArr[indexPath.row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * Storeid =[DataArr[indexPath.row] objectForKey:@"store_id"];
    
    StoreDetailsViewController *Svc =[[StoreDetailsViewController alloc]initWithStr:Storeid];
    [self.navigationController pushViewController:Svc animated:YES];
    //(@"选中了");
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
