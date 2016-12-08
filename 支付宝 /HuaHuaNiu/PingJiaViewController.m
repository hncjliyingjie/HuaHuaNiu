//
//  PingJiaViewController.m
//  HuaHuaNiu
//
//  Created by alex on 15/12/24.
//  Copyright © 2015年 张燕. All rights reserved.
//

#import "PingJiaViewController.h"
#import "AFNetworking.h"
#import "Toast+UIView.h"

@interface PingJiaViewController ()<UIAlertViewDelegate>
@property (nonatomic,strong)NSDictionary * dataDict;
@property (nonatomic,strong)UITextField * tf;
@end

@implementation PingJiaViewController

-(id)initWithOrderId:(NSString *)orderid{
    if (self =[super init]) {
        self.currentOrdId =orderid;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    [self createBtn];
    [self requestData];

    self.navigationItem.title=@"商品评价";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIButton *BackBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    BackBtn.frame =CGRectMake(0, 0, 64, 27);
    [BackBtn  setBackgroundImage:[UIImage imageNamed:@"app_fanhui"] forState:UIControlStateNormal];
    
    [BackBtn addTarget:self action:@selector(BackAction)  forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem =[[UIBarButtonItem alloc]initWithCustomView:BackBtn];
    self.navigationItem.leftBarButtonItem = backItem;

    
}

-(void)BackAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)requestData{
    [self.view makeToastActivity];
    NSUserDefaults * userdefault =[NSUserDefaults standardUserDefaults];
    NSString *userID =[NSString stringWithFormat:@"%@",[userdefault objectForKey:@"Useid"]];
    NSString * ShouY = [NSString stringWithFormat:SayDingDanDetail,userID,self.currentOrdId];
    //(@"%@",ShouY);
    
    ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //(@"xxxx%@",responseObject);
        [self.view hideToastActivity];
        self.dataDict =[responseObject objectForKey:@"orderdetail"];
        NSArray * tmpArr =@[@"商品名称:",@"商品价格:",@"商品数量:",@"购买时间:"];
        //(@"%@",self.dataDict);
        NSString * tmpStr1 =[NSString stringWithFormat:@"%@",[self.dataDict objectForKey:@"goods_name"]];
        NSString * tmpStr2 =[NSString stringWithFormat:@"￥%@",[self.dataDict objectForKey:@"price"]];
        NSString * tmpStr3 =[NSString stringWithFormat:@"%@",[self.dataDict objectForKey:@"quantity"]];
        NSString * tmpStr4 =[NSString stringWithFormat:@"%@",[self.dataDict objectForKey:@"add_time"]];
        
        NSArray * tmpArr2 =@[tmpStr1,tmpStr2,tmpStr3,tmpStr4];
        
        
        for (int i = 0; i<4; i++) {
            UIView * view =[self createViewWithLB:tmpArr[i] andContext:tmpArr2[i]];
            view.frame =CGRectMake(0, 30*i+10, self.view.window.frame.size.width, 30);
            [self.view addSubview:view];
        }
        
        UIView * view2 = [self createView2WithLB:@"评价:" andContext:nil];
        view2.frame =CGRectMake(0, 130, ConentViewWidth,50);
        [self.view addSubview:view2];

        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.view hideToastActivity];
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [failAlView show];
        //(@"cook load failed ,%@",error);
    }];
    
}

-(UIView *)createViewWithLB:(NSString * )lb andContext:(NSString *)context{
    UIView * view =[[UIView alloc]init];
    UILabel * lb1 =[[UILabel alloc]initWithFrame:CGRectMake(20, 5, 100, 20)];
    lb1.text =lb;
    UILabel * lb2 =[[UILabel alloc]initWithFrame:CGRectMake(120, 5, 320-110, 20)];
    lb2.text =context;
    [view addSubview:lb1];
    [view addSubview:lb2];
    
    UILabel *lin =[[UILabel alloc]initWithFrame:CGRectMake(0, 29, ConentViewWidth, 0.5)];
    lin.backgroundColor =[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
    [view addSubview:lin];
    lb2.textColor =[UIColor lightGrayColor];
    
    return view;
}


-(UIView *)createView2WithLB:(NSString * )lb andContext:(NSString *)context{
    UIView * view =[[UIView alloc]init];
    UILabel * lb1 =[[UILabel alloc]initWithFrame:CGRectMake(20, 15, 100, 20)];
    lb1.text =lb;
    
    self.tf =[[UITextField alloc]initWithFrame:CGRectMake(120, 15, self.view.frame.size.width-120, 20)];
    self.tf.placeholder =@"亲，说说你的看法呗！";
    
    [view addSubview:lb1];
    [view addSubview:self.tf];
    UILabel *lin =[[UILabel alloc]initWithFrame:CGRectMake(0, 49, ConentViewWidth, 0.5)];
    lin.backgroundColor =[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
    [view addSubview:lin];
    return view;
}



-(void)createBtn{
    UIButton * btn =[UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame =CGRectMake(30, 200, 320, 50);
    [btn setTitle:@"提交评价" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.backgroundColor =BarColor;
    btn.layer.cornerRadius =6;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

-(void)btnClick{
    //(@"提交");
    if (self.tf.text.length ==0) {
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"说说你的看法呗~" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [failAlView show];
    }else{
        [self.view makeToastActivity];
        NSUserDefaults * userdefault =[NSUserDefaults standardUserDefaults];
        NSString *userID =[NSString stringWithFormat:@"%@",[userdefault objectForKey:@"Useid"]];
        NSString * ShouY = [NSString stringWithFormat:Say];
        //(@"%@",ShouY);

        NSString * orderId = [self.dataDict objectForKey:@"order_id"];
        NSString * goodsId = [self.dataDict objectForKey:@"goods_id"];

        NSDictionary * dict =[NSDictionary dictionaryWithObjectsAndKeys:self.tf.text,@"content",userID,@"member_id",orderId,@"order_id",@"test",@"token",goodsId,@"goods_id",@"",@"fileids",nil];
        
        ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
        [manager POST:ShouY parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //(@"xxxx%@",responseObject);
            [self.view hideToastActivity];
                UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"评价成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                failAlView.delegate =self;
                [failAlView show];
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self.view hideToastActivity];
            UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [failAlView show];
            //(@"cook load failed ,%@",error);
        }];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.tf resignFirstResponder];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex ==0) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
@end
