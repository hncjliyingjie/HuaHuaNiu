//
//  ShouZhiViewController.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-4-23.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "ShouZhiViewController.h"
#import "SZTableViewCell.h"
#import "AFNetworking.h"
@interface ShouZhiViewController ()

@end

@implementation ShouZhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ShouRuData =[[NSArray alloc]init];
    ZhichuData =[[NSArray alloc]init];
    dataArr =[[NSArray alloc]init];
    [self makeTOPVew];
    
    [self makeSZData];
    [self makeShouRuData];


    self.navigationItem.title=@"收支明细";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];

    
    self.view.backgroundColor =BackColor;
    // Do any additional setup after loading the view from its nib.
    UIButton *BackBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    BackBtn.frame =CGRectMake(0, 0, 64, 27);
    [BackBtn  setBackgroundImage:[UIImage imageNamed:@"app_fanhui"] forState:UIControlStateNormal];
    // [BackBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    
    [BackBtn addTarget:self action:@selector(BackAction)  forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem =[[UIBarButtonItem alloc]initWithCustomView:BackBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    
}

// 支出
-(void)makeSZData{
    NSUserDefaults *  UserDefault =[NSUserDefaults standardUserDefaults];
    NSString * UserID =[UserDefault objectForKey:@"Useid"];
    NSString * ShouY = [NSString stringWithFormat:ZHCHUMINGXI,UserID,1];
    //(@"%@",ShouY);
ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];

[manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    //(@"xxxx%@",responseObject);
    //(@"%@",[responseObject objectForKey:@"msg"]);
    NSString * str =[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"result"]];
    if ( [str isEqualToString:@"1"]) {
        ZhichuData =[responseObject objectForKey:@"list"];
    }
    else{
    //失败
    
    }


} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [failAlView show];
    //(@"cook load failed ,%@",error);
}];


}
// 收入
-(void)makeShouRuData{

    NSUserDefaults *  UserDefault =[NSUserDefaults standardUserDefaults];
    NSString * UserID =[UserDefault objectForKey:@"Useid"];
    
    NSString * ShouY = [NSString stringWithFormat:SHOURUMINGXI,UserID,1];
    //(@"%@",ShouY);

    ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    
    [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //(@"xxxx%@",responseObject);

        NSString * str =[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"result"]];
        if ( [str isEqualToString:@"1"]) {
        
            ShouRuData =[responseObject objectForKey:@"list"];
       
              dataArr = [[NSArray alloc]initWithArray:ShouRuData];
             [self  makeSHOUUI];
      
            
            if (tttlabel) {
                
            }
            else{
                tttlabel =[[UILabel alloc]initWithFrame:CGRectMake(30, ConentViewHeight/2 - 100 , ConentViewWidth - 60  , 30)];
            }
            
            tttlabel.textAlignment = NSTextAlignmentCenter;
            tttlabel.text =@"暂无数据";
            tttlabel.font =[UIFont systemFontOfSize:13];
            [self.view addSubview:tttlabel];

            if(dataArr.count == 0){
                  tttlabel.hidden = NO;
            }
            else{
                
                tttlabel.hidden =YES;
            }
        }
        else{
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [failAlView show];
        //(@"cook load failed ,%@",error);
    }];

}
// 收入和支出的按钮
-(void)makeTOPVew{
    NSArray * Ass =@[@"收入",@"支出"];
    for (int i = 0 ;i< 2;i++ ){
        
        UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame =CGRectMake( ConentViewWidth/2 * i, 0, ConentViewWidth/2, 40);
        [btn setTitle:Ass[i] forState:UIControlStateNormal];
        
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        if(i == 0){
            btn.selected = YES;
        }
        
        btn.tag =33+i;
        [btn addTarget:self action:@selector(BTNaCtion:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:[UIColor colorWithRed:246/255.0 green:125/255.0 blue:137/255.0  alpha:1] forState:UIControlStateSelected];
        
        [self.view addSubview: btn];
        
    }
    
}
// 切换收入支出
-(void)BTNaCtion:(UIButton *)Btn{
    for (int i =  0; i< 2; i++) {
        UIButton * brr =(UIButton *)[self.view viewWithTag:33+i];
        
        brr.selected = NO;
    }
    Btn.selected = YES;
    
    
    if (Btn.tag == 33) {
        dataArr =[[NSArray alloc]initWithArray:ShouRuData];
    }
    else{
        dataArr=[[NSArray alloc]initWithArray:ZhichuData];
    
    }
    if (dataArr.count == 0) {
        tttlabel.hidden = NO;
    }
    else{
        tttlabel.hidden = YES;
    }
    [self makeSHOUUI];
    [_Tv reloadData];
    
}
-(void)BackAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)makeSHOUUI{
    IOS_Frame
    if (_Tv) {
           }
    else{
        _Tv =[[UITableView alloc]initWithFrame:CGRectMake(0, 40, ConentViewWidth, ConentViewHeight -49) style:UITableViewStylePlain];
        _Tv.dataSource =self;
        _Tv.delegate =self;
        [self.view addSubview:_Tv];
    }
    if (dataArr.count < 11) {
        _Tv.frame =CGRectMake(0, 40, ConentViewWidth, 44*dataArr.count);
        _Tv.scrollEnabled = NO;
    }
    else{
        _Tv.frame =CGRectMake(0,40, ConentViewWidth, 44*5);
        _Tv.scrollEnabled = YES;
    }

    
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SZTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell =[[[NSBundle mainBundle]loadNibNamed:@"SZTableViewCell" owner:self options:nil]lastObject];
    }
   [cell SZCellMakeWithDIc:dataArr[indexPath.row]];
    return cell;
    
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
