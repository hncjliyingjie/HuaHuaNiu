//
//  DingDanDeatilViewController.m
//  HuaHuaNiu
//
//  Created by alex on 15/12/24.
//  Copyright © 2015年 张燕. All rights reserved.
//

#import "DingDanDeatilViewController.h"
#import "DIngDanceTableViewCell.h"
#import "AFNetworking.h"
#import "ProductDetailViewController.h"
#import "Toast+UIView.h"
#import "AddPLVViewController.h"
#import "StoreDetailsViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "DingDanJSViewController.h"
#import "TuiKuanViewController.h"
#import "PingJiaViewController.h"
@interface DingDanDeatilViewController ()

@end

@implementation DingDanDeatilViewController

-(id)initWithStats:(NSString *)statas andOrdId:(NSString *)ordId{
    self =[super init];
    if (self) {
        self.currentOrdId =ordId;
        self.currentStatas =statas;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    // Do any additional setup after loading the view.
    GroupDataArr=[[NSMutableArray alloc]init];
    self.navigationItem.title=@"订单详情";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIButton *BackBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    BackBtn.frame =CGRectMake(0, 0, 64, 27);
    [BackBtn  setBackgroundImage:[UIImage imageNamed:@"app_fanhui"] forState:UIControlStateNormal];
    
    [BackBtn addTarget:self action:@selector(BackAction)  forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem =[[UIBarButtonItem alloc]initWithCustomView:BackBtn];
    self.navigationItem.leftBarButtonItem = backItem;

    [self makeDIngData];
}

-(void)BackAction{
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma  mark 创建数据
-(void)makeDIngData{
    [self.view makeToastActivity];
    NSUserDefaults * userdefault =[NSUserDefaults standardUserDefaults];
    NSString *userID =[NSString stringWithFormat:@"%@",[userdefault objectForKey:@"Useid"]];
    
    NSString * ShouY = [NSString stringWithFormat:DingDanDetail, userID,self.currentOrdId];
    //(@"%@",ShouY);
    ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    
    [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //(@"%@",responseObject);
        NSDictionary * dict =[responseObject objectForKey:@"order"];
        [GroupDataArr addObject:dict];
        //(@"zzzzzz%d",GroupDataArr.count);
        [self makeTVView];
        
        if(GroupDataArr.count == 0){
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
-(void)makeTVView{
    IOS_Frame
    _tv =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, ConentViewHeight) style:UITableViewStyleGrouped];
    _tv.delegate =self;
    _tv.dataSource =self;
    [self.view addSubview:_tv];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //  return DataArr.count;
    
    NSArray * Arr =[GroupDataArr[section] objectForKey:@"order_goods"];
    return Arr.count;
    
}
//设置tableview中的分组个数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return GroupDataArr.count;
}

//设置每个分组的头和尾的高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    NSString * statue =[NSString stringWithFormat:@"%@",[GroupDataArr[section] objectForKey:@"status"]];
    self.order_type = [NSString stringWithFormat:@"%@",[GroupDataArr[section] objectForKey:@"order_type"]];    if ([statue isEqualToString:@"2"]||[statue isEqualToString:@"6"]||[statue isEqualToString:@"7"]||[statue isEqualToString:@"8"]||[statue isEqualToString:@"9"]) {
        return 100;
    }else{
        return 185;
    }

    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 30;
}
//设置每个分组的头视图为一个按钮
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * baView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, 40)];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, 0, 320, 30);
    [btn setBackgroundColor:[UIColor clearColor]];
    NSString *titleStr;
    if ([GroupDataArr[section] objectForKey:@"seller_name"]){
        titleStr = [NSString stringWithFormat:@"%@",[GroupDataArr[section] objectForKey:@"seller_name"]];
    }else{
        titleStr = [NSString stringWithFormat:@"%@",[GroupDataArr[section] objectForKey:@"store_name"]];
    }
    
    UILabel * lane =[[UILabel alloc]initWithFrame:CGRectMake(20, 5, ConentViewWidth -120, 20)];
    lane.text =titleStr;
    lane.font =[UIFont systemFontOfSize:14];
    // [btn setTitle:titleStr forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = 200+section;
    
    UILabel * DDStLabel =[[UILabel alloc]initWithFrame:CGRectMake(ConentViewWidth - 115, 5,110, 20)];
    DDStLabel.font =[UIFont systemFontOfSize:14];
    
    NSString * statue =[NSString stringWithFormat:@"%@",[GroupDataArr[section] objectForKey:@"status"]];
    //(@"statue == %@",statue);
    if ( [statue isEqualToString:@"5"]) {
        DDStLabel.text =@"买家已发货";
        //self.StatuLabel.text=@"卖家已发货";
    }
    else if([statue isEqualToString:@"3"]){
        DDStLabel.text =@"等待卖家发货";
        //   self.StatuLabel.text=@"等待卖家发货";
    }else if([statue isEqualToString:@"4"]){
        DDStLabel.text =@"卖家已发货";
        //   self.StatuLabel.text=@"卖家已发货";
    }else if([statue isEqualToString:@"6"]){
        DDStLabel.text =@"交易成功";
        //  self.StatuLabel.text=@"交易成功";
    }else if([statue isEqualToString:@"2"]){
        DDStLabel.text =@"交易已取消";
        //     self.StatuLabel.text=@"交易已取消";
    }else if([statue isEqualToString:@"1"]){
        DDStLabel.text =@"买家未付款";
        //     self.StatuLabel.text=@"交易已取消";
    }else{
        DDStLabel.text =@"订单已过期失效";
        //   self.StatuLabel.text=@"等待买家付款";
    }
    
    
    
    //    [baView addSubview:DDStLabel];
    [baView addSubview:lane];
    [baView addSubview:btn];
    baView.backgroundColor = BackColor;
    return baView;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView * FootView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, 400)];
    FootView.backgroundColor = BackColor;
    UILabel *lin =[[UILabel alloc]initWithFrame:CGRectMake(0, 29, ConentViewWidth, 0.5)];
    lin.backgroundColor =[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
    [FootView addSubview:lin];
    
    UILabel *lb =[[UILabel alloc]initWithFrame:CGRectMake(20, 5, 100, 20)];
    lb.textColor =[UIColor orangeColor];
    lb.font =[UIFont systemFontOfSize:12];
    [FootView addSubview:lb];
    
    NSArray * tmpArr =@[@"订单编号:",@"商品总价:",@"订单总额:"];
    //(@"%@",GroupDataArr[0]);
    NSString * tmpStr1 =[NSString stringWithFormat:@"%@",[GroupDataArr[0] objectForKey:@"order_id"]];
    NSString * tmpStr2 =[NSString stringWithFormat:@"￥%@",[GroupDataArr[0] objectForKey:@"total_price"]];
    float n =[[GroupDataArr[0] objectForKey:@"total_price"]floatValue]+[[GroupDataArr[0] objectForKey:@"fee"]floatValue];
    acount =[NSString stringWithFormat:@"%.2f",n];
    NSString * tmpStr3 =[NSString stringWithFormat:@"￥%.2f",n];
    NSArray * tmpArr2 =@[tmpStr1,tmpStr2,tmpStr3];
    

    
    NSString * statue =[NSString stringWithFormat:@"%@",[GroupDataArr[section] objectForKey:@"status"]];
    if ([statue isEqualToString:@"2"]||[statue isEqualToString:@"6"]||[statue isEqualToString:@"7"]||[statue isEqualToString:@"8"]||[statue isEqualToString:@"9"]) {
        for (int i = 0; i<3; i++) {
            UIView * view =[self createViewWithLB:tmpArr[i] andContext:tmpArr2[i]];
            view.frame =CGRectMake(0, 30*i, ConentViewWidth, 30);
            view.tag =10000+i;
            [FootView addSubview:view];
        }
    }else{
        for (int i = 0; i<3; i++) {
            UIView * view =[self createViewWithLB:tmpArr[i] andContext:tmpArr2[i]];
            view.frame =CGRectMake(0, 30*i+100, ConentViewWidth, 30);
            view.tag =10000+i;
            [FootView addSubview:view];
        }
    }

    //(@"Statue = %@\n",statue);
    if ( [statue isEqualToString:@"1"]) {
        //self.StatuLabel.text=@"卖家已发货";
        lb.text =@"订单状态: 待付款";
        UIView * view =[self createView1];
        [FootView addSubview:view];
        
    }
    else if([statue isEqualToString:@"2"]){
        lb.text =@"订单状态: 已取消";
        

    }else if([statue isEqualToString:@"3"]){
        lb.text =@"订单状态: 待发货";
        UIView * view =[self createView2];
        [FootView addSubview:view];
        //   self.StatuLabel.text=@"卖家已发货";
    }else if([statue isEqualToString:@"4"]){
        lb.text =@"订单状态: 已发货";
        UIView * view =[self createView4];
        [FootView addSubview:view];
        //  self.StatuLabel.text=@"交易成功";
    }else if([statue isEqualToString:@"5"]){
        lb.text =@"订单状态: 已收货";
        UIView * view =[self createView3];
        [FootView addSubview:view];
        
        //     self.StatuLabel.text=@"交易已取消";
    }else if([statue isEqualToString:@"6"]){
        lb.text =@"订单状态: 交易完成";
        
        //     self.StatuLabel.text=@"交易已取消";
    }else if([statue isEqualToString:@"7"]){
        lb.text =@"订单状态: 过期失效";
        
        //     self.StatuLabel.text=@"交易已取消";
    }else if([statue isEqualToString:@"8"]){
        lb.text =@"订单状态: 退款中";
        
        //     self.StatuLabel.text=@"交易已取消";
    }else if([statue isEqualToString:@"9"]){
        lb.text =@"订单状态: 已退款";
        
        //     self.StatuLabel.text=@"交易已取消";
    }
    
    
    return FootView;
    
    
}


-(UIView *)createViewWithLB:(NSString * )lb andContext:(NSString *)context{
    UIView * view =[[UIView alloc]init];
    view.backgroundColor =[UIColor whiteColor];
    UILabel * lb1 =[[UILabel alloc]initWithFrame:CGRectMake(20, 5, 70, 20)];
    lb1.text =lb;
    [lb1 setFont:[UIFont systemFontOfSize:14]];
    UILabel * lb2 =[[UILabel alloc]initWithFrame:CGRectMake(90, 5, ConentViewWidth-70, 20)];
    lb2.text =context;
    [lb2 setFont:[UIFont systemFontOfSize:14]];
    lb1.textColor =[UIColor lightGrayColor];
    lb2.textColor =[UIColor lightGrayColor];
    [view addSubview:lb1];
    [view addSubview:lb2];
    return view;
}



-(UIView *)createView1{
    UIButton * btn =[UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame =CGRectMake(5, 10, ConentViewWidth/2-10, 50);
    [btn setTitle:@"取消订单" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(cancelDingDan) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * btn2 =[UIButton buttonWithType:UIButtonTypeSystem];
    btn2.frame =CGRectMake(ConentViewWidth/2+5, 10, ConentViewWidth/2-10, 50);
    [btn2 setTitle:@"立即付款" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(FootbtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView * view = [[ UIView alloc]initWithFrame:CGRectMake(0, 30, ConentViewWidth, 70)];
    view.backgroundColor =[UIColor whiteColor];
    [view addSubview:btn];
    [view addSubview:btn2];
    btn.backgroundColor =BarColor;
    btn2.backgroundColor =BarColor;
    btn.layer.cornerRadius =6;
    btn2.layer.cornerRadius =6;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    return view;
}

-(UIView *)createView2{
    
    UIButton * btn =[UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame =CGRectMake(10, 10, ConentViewWidth-20, 50);
    [btn setTitle:@"申请退货" forState:UIControlStateNormal];
    if ([self.order_type isEqualToString:@"1"]) {
        btn.hidden = YES;
        [btn setBackgroundColor:[UIColor grayColor]];
    }
    else {
        btn.hidden = NO;
        btn.backgroundColor = BarColor;
        [btn addTarget:self action:@selector(backDingDan) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIView * view = [[ UIView alloc]initWithFrame:CGRectMake(0, 30, ConentViewWidth, 70)];
    view.backgroundColor =[UIColor whiteColor];
    [view addSubview:btn];
//    btn.backgroundColor =BarColor;
    btn.layer.cornerRadius =6;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    return view;
}

-(UIView *)createView3{
    UIButton * btn =[UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame =CGRectMake(5, 10, ConentViewWidth/2-10, 50);
    [btn setTitle:@"申请退货" forState:UIControlStateNormal];
    if ([self.order_type isEqualToString:@"1"]) {
        btn.hidden = YES;
        btn.backgroundColor = [UIColor grayColor];
    }
    else {
        btn.hidden = NO;
        btn.backgroundColor = BarColor;
        [btn addTarget:self action:@selector(backDingDan) forControlEvents:UIControlEventTouchUpInside];
    }

    
    UIButton * btn2 =[UIButton buttonWithType:UIButtonTypeSystem];
    btn2.frame =CGRectMake(ConentViewWidth/2+5, 10, ConentViewWidth/2-10, 50);
    [btn2 setTitle:@"去评价" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(sayDingDan) forControlEvents:UIControlEventTouchUpInside];
    
    UIView * view = [[ UIView alloc]initWithFrame:CGRectMake(0, 30, ConentViewWidth, 70)];
    view.backgroundColor =[UIColor whiteColor];
    [view addSubview:btn];
    [view addSubview:btn2];
//    btn.backgroundColor =BarColor;
    btn2.backgroundColor =BarColor;
    btn.layer.cornerRadius =6;
    btn2.layer.cornerRadius =6;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    return view;
}

-(UIView *)createView4{
    UIButton * btn =[UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame =CGRectMake(5, 10, ConentViewWidth/2-10, 50);
    [btn setTitle:@"确认收货" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(centerDingDan) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * btn2 =[UIButton buttonWithType:UIButtonTypeSystem];
    btn.backgroundColor =BarColor;
//    btn2.backgroundColor =BarColor;
    btn.layer.cornerRadius =6;
    btn2.layer.cornerRadius =6;

    btn2.frame =CGRectMake(ConentViewWidth/2+5, 10, ConentViewWidth/2-10, 50);
    [btn2 setTitle:@"申请退货" forState:UIControlStateNormal];
    if ([self.order_type isEqualToString:@"1"]) {
        btn2.hidden= YES;
        btn2.backgroundColor = [UIColor grayColor];
    }
    else {
        btn2.hidden = NO;
        btn2.backgroundColor = BarColor;
        [btn2 addTarget:self action:@selector(backDingDan) forControlEvents:UIControlEventTouchUpInside];
    }

    
    UIView * view = [[ UIView alloc]initWithFrame:CGRectMake(0, 30, ConentViewWidth, 70)];
    view.backgroundColor =[UIColor whiteColor];
    [view addSubview:btn];
    [view addSubview:btn2];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    return view;
}


-(void)centerDingDan{
    [self.view makeToastActivity];
    NSUserDefaults * userdefault =[NSUserDefaults standardUserDefaults];
    NSString *userID =[NSString stringWithFormat:@"%@",[userdefault objectForKey:@"Useid"]];
    NSString * ShouY = [NSString stringWithFormat:CenterDingDan];
    //(@"%@",ShouY);
    NSDictionary * dict =[NSDictionary dictionaryWithObjectsAndKeys:userID,@"member_id",self.currentOrdId,@"order_id",@"test",@"token",nil];
    
    ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    [manager POST:ShouY parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //(@"xxxx%@",responseObject);
        [self.view hideToastActivity];
            UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"订单确认成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            failAlView.delegate =self;
            [failAlView show];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.view hideToastActivity];
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [failAlView show];
        //(@"cook load failed ,%@",error);
    }];

}

-(void)sayDingDan{
    NSArray * tmpArr =[NSArray arrayWithArray:[GroupDataArr[0]objectForKey:@"order_goods"]];
    NSString * orderDetailId= [tmpArr[0] objectForKey:@"orderdetail_id"];
    PingJiaViewController * tkvc =[[PingJiaViewController alloc]initWithOrderId:orderDetailId];
    tkvc.hidesBottomBarWhenPushed =YES;
    [self.navigationController pushViewController:tkvc animated:YES];
}



-(void)backDingDan{

    TuiKuanViewController * tkvc =[[TuiKuanViewController alloc]initWithOrderId:self.currentOrdId];
    tkvc.hidesBottomBarWhenPushed =YES;
    [self.navigationController pushViewController:tkvc animated:YES];
}

-(void)cancelDingDan{
    [self.view makeToastActivity];
    NSUserDefaults * userdefault =[NSUserDefaults standardUserDefaults];
    NSString *userID =[NSString stringWithFormat:@"%@",[userdefault objectForKey:@"Useid"]];
    NSString * ShouY = [NSString stringWithFormat:CancelDingDan];
    //(@"%@",ShouY);
    NSDictionary * dict =[NSDictionary dictionaryWithObjectsAndKeys:userID,@"member_id",self.currentOrdId,@"order_id",@"test",@"token",nil];
    
    ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    [manager POST:ShouY parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //(@"xxxx%@",responseObject);
            UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"订单取消成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            failAlView.delegate =self;
            [failAlView show];
        
        [self.view hideToastActivity];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.view hideToastActivity];
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [failAlView show];
        //(@"cook load failed ,%@",error);
    }];
 
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DIngDanceTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"DIngDanceTableViewCell" owner:self options:nil]lastObject];
    }
    NSArray  *Arr =[GroupDataArr[indexPath.section] objectForKey:@"order_goods"];
    NSDictionary * dic =Arr[indexPath.row];
    
    [cell cellMakeWIthDic:dic];
    
    
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    return  cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//每个分组脚的点击事件
-(void)FootbtnClick:(UIButton *)Btn{
    
    
    
    //        //(@"去付款 *  %d",Btn.tag- 400);
    //
    //        // 要支付的订单
    NSMutableDictionary * DingDZdic =  [[NSMutableDictionary alloc]initWithDictionary:GroupDataArr[0]];
    float n =[[GroupDataArr[0] objectForKey:@"total_price"]floatValue]+[[GroupDataArr[0] objectForKey:@"fee"]floatValue];
    NSString *order_amount =[NSString stringWithFormat:@"%.2f",n];
    [DingDZdic setValue:order_amount forKey:@"order_amount"];
//    [DingDZdic setValue:order_amount forKey:@"order_amount"];
    DingDanJSViewController * ds =[[DingDanJSViewController alloc]initWithDic:DingDZdic];
    [self.navigationController pushViewController:ds animated:YES];
    
    
    
}
//每个分组头的事件
-(void)btnClick:(UIButton *)btn{
    //(@"%@",[GroupDataArr[0] objectForKey:@"store_name"]);
    // 商家详情
    NSString * Soresid =[ NSString stringWithFormat:@"%@",[GroupDataArr[btn.tag-200] objectForKey:@"store_id"]];
    StoreDetailsViewController * svc =[[StoreDetailsViewController alloc]initWithStr:Soresid];
    [self.navigationController pushViewController:svc animated:YES];
}

#pragma mark 支付宝支付
-(void)makeZhiFuBaoZhifuWiThDic:(NSDictionary * )MYdic {
    
    // //(@"获取parnter 和 seller  、privateKey(私钥)")  ;
    
    /*
     *点击获取prodcut实例并初始化订单信息   自己赋值的话不用 Product
     */
    
    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = @"2088911222877472";//合作者ID
    NSString *seller = @"bbnkjzg@126.com";// 支付宝账号
    NSString *privateKey = @"-----BEGIN RSA PRIVATE KEY-----MIICXAIBAAKBgQC9RWd8SWkBxYUMngeaFoxAXr6fvV4GtvLWXZtaEoEUyiiQpRhPgDwedDCaiU/HmR60D7YO/VoVYu/4v8iStOmuPIydYpliGp5fR0RzVAYT6sdVXskc+AHTGvxHxKLc+0a0yoYMv2PjYXiWb/5+AP2A+rlfiG0Xz+O5JtmsU/A37QIDAQABAoGAFcOVUsVePcXotrq1RRKyrfQ3F0c/OKZw5hV9d64JCcr1Pyy8zueAAkB6FksT0W/aB/qGhNK9ORhXX9MtzTDgbeX/JPJIx7eXyaYRWOuYtwC+N9FXrz0O09qRI47F9UR8yTvLOxKqSJlSSEv4ZwPRiVy4YE4twVIEuJo2pOHZ5EECQQDk0bcX3ZVlZrGsoufs+m++2hjJ40JPyc2ahSpHfVqPv2yhSWa9qUP7h9Vw4qEZ1zO1kNRnGT/EeYQUQIB0XimfAkEA08EM1WjYG/XemBVZgIkbbPjnQ2LYUmhdO8/F/AILCImIjIzbV/eohAIXeevubJDtq0grP0mIsp17OTbS/YGK8wJBAIjpBmFsPtCeYp8GFjlQG36ZZo2dwfaVq8TR+tstoPszsV7L2YKP/dJJkydpIrWgcxsnXj+V9varMqEfevylvscCQCV0WBjHWrJXYu/zlsktdzRnMkCxEyJAY31Y2uQgWGNCMGzr3UBKBfyTgiOGn72ERQWu1jdzgkJVqJ4OHHPKnhECQDiFSTo26YFd7tshv2ASo8PRJsObuI1LnkN6VpPoApAY    YzlIlYkVOC49jAfiJorn2pZGPKX+d1gdJpy1Aq9CLyc=-----END RSA PRIVATE KEY-----";// RSA密钥
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     *商户的唯一的parnter 合作者id和seller  支付宝账号。
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = orderStr ;   //@"123123";  //订单ID（由商家自行制定）
    //    order.productName = product.subject; //商品标题
    order.productName = @"测试";  //商品标题
    //    order.productDescription = product.body; //商品描述
    order.productDescription = @"真的是测试";  //商品描述
    //(@"%@",acount);
    
    order.amount = [GroupDataArr[0] objectForKey:@"total_price"];  //商品价格
        order.notifyURL = [NSString stringWithFormat:ZHIFUHD,orderStr,order_type]; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"alisdkhuahuaniu";
    
    //将商品信息拼接成字符串orderSpec
    NSString *orderSpec = [order description];
    //(@"orderSpec = %@",orderSpec);
    
    
    //    NSString * ShouY = [NSString stringWithFormat:@"http://182.92.66.70:8080/alipay/index.php?data=%@",orderSpec];
    //    ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    
//    NSDictionary *dic =@{@"token":@"test",@"order_id":orderStr,@"order_amount":[GroupDataArr[0] objectForKey:@"total_price"],@"order_desc":@"productDescription"};
    float n =[[GroupDataArr[0] objectForKey:@"total_price"]floatValue]+[[GroupDataArr[0] objectForKey:@"fee"]floatValue];
    NSString *order_amount =[NSString stringWithFormat:@"%.2f",n];
     NSDictionary *dic =@{@"token":@"test",@"order_id":orderStr,@"order_amount":order_amount,@"order_desc":@"productDescription"};
    //(@"%@",dic);
    [manager POST:ZHIFU_REQUEST parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //   获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
        //    id<DataSigner> signer = CreateRSADataSigner(privateKey);
        //NSString *signedString = [signer signString:orderSpec]; //商品信息拼接成的字符串orderSpec
        
        NSString *signedString=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"sign"]];
        NSString *ordStr=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"payInfo"]];
        
        //(@"%@",signedString);
        //        signedString =[signedString stringByReplacingOccurrencesOfString:@" " withString:@""];
        //        [signedString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        //将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = nil;
        if (signedString != nil) {
            orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                           orderSpec, signedString, @"RSA"];
            
            [[AlipaySDK defaultService] payOrder:ordStr fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                //(@"reslut = %@",resultDic);
                NSString * str2 =[NSString stringWithFormat:@"%@",[resultDic objectForKey:@"memo"]];
                
                //(@"%@",str2);
                
                NSString * str =[NSString stringWithFormat:@"%@",[resultDic objectForKey:@"resultStatus"]];
                NSString * status  ;
                if ([str isEqualToString:@"9000"]) {
                    status =@"订单支付成功";
                    NSString * resquestUrl =[NSString stringWithFormat:ZHIFUHD,orderStr];
                    [[RequestManger share]requestDataByGetWithPath:resquestUrl complete:^(NSDictionary *data) {
                        //(@"%@",[data objectForKey:@"result"]);
                        //(@"%@",[data objectForKey:@"msg"]);
                    }];
                }
                else if ([str isEqualToString:@"8000"]) {
                    status =@"正在处理中";
                }
                else if ([str isEqualToString:@"6001"]) {
                    status =@"用户中途取消";
                    NSString * resquestUrl =[NSString stringWithFormat:ZHIFUHD,orderStr];
                    [[RequestManger share]requestDataByGetWithPath:resquestUrl complete:^(NSDictionary *data) {
                        //(@"%@",[data objectForKey:@"result"]);
                        //(@"%@",[data objectForKey:@"msg"]);
                    }];
                }
                else if ([str isEqualToString:@"6002"]) {
                    status =@"网络连接出错";
                }
                else{
                    status =@"网络连接出错";
                }
                
                UIAlertView * ResultAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:status delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                ResultAlView.tag= 66;
                [ResultAlView show];
                
                
                
            }];
            
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [failAlView show];
    }];
}


-(void)alertViewCancel:(UIAlertView *)alertView{

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    //(@"点击了");
    if (buttonIndex ==0) {
        [self.navigationController popViewControllerAnimated:YES];
        [self.delegate reloadTabelView];

    }
}



@end
