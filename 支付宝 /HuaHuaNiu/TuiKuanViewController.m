//
//  TuiKuanViewController.m
//  HuaHuaNiu
//
//  Created by alex on 15/12/24.
//  Copyright © 2015年 张燕. All rights reserved.
//

#import "TuiKuanViewController.h"
#import "AFNetworking.h"
#import "Toast+UIView.h"

@interface TuiKuanViewController ()<UIAlertViewDelegate>
@property (nonatomic,strong)NSDictionary * dataDict;
@property (nonatomic,strong)UITextField * tf;
@end

@implementation TuiKuanViewController


-(id)initWithOrderId:(NSString *)orderid{
    self =[super init];
    if (self) {
        self.currentOrdId =orderid;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    [self createBtn];
    [self requestData];
    
    self.navigationItem.title=@"退款申请";
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
    NSString * ShouY = [NSString stringWithFormat:BackDingDan,userID,self.currentOrdId];
    //(@"%@",ShouY);
    
    ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //(@"xxxx%@",responseObject);
        [self.view hideToastActivity];
        self.dataDict =[responseObject objectForKey:@"order"];
        NSArray * tmpArr =@[@"订单编号:",@"商品总价:",@"订单总额:",@"退款金额:"];
        //(@"%@",self.dataDict);
        NSString * tmpStr1 =[NSString stringWithFormat:@"%@",[self.dataDict objectForKey:@"order_id"]];
        NSString * tmpStr2 =[NSString stringWithFormat:@"￥%@",[self.dataDict objectForKey:@"total_price"]];
        int n =[[self.dataDict objectForKey:@"total_price"]intValue]+[[self.dataDict objectForKey:@"fee"]intValue];
        NSString * tmpStr3 =[NSString stringWithFormat:@"￥%d",n];
        NSString * tmpStr4 =[NSString stringWithFormat:@"￥%@",[self.dataDict objectForKey:@"total_price"]];

        NSArray * tmpArr2 =@[tmpStr1,tmpStr2,tmpStr3,tmpStr4];

        
        for (int i = 0; i<4; i++) {
            UIView * view =[self createViewWithLB:tmpArr[i] andContext:tmpArr2[i]];
            view.frame =CGRectMake(0, 30*i+10, self.view.window.frame.size.width, 30);
            [self.view addSubview:view];
        }
        
        UIView * view2 = [self createView2WithLB:@"退款原因:" andContext:nil];
        view2.frame =CGRectMake(0, 130, ConentViewWidth,50);
        [self.view addSubview:view2];
        
        UILabel * warning =[[UILabel alloc]initWithFrame:CGRectMake(10, 180, ConentViewWidth-20, 150)];
        warning.textColor =[UIColor lightGrayColor];
        warning.text =@"提示:如果商家已发货，则需要承担商品往返运费,如果有疑问请联系代言城客服。客服热线:400-016-5855";
        warning.lineBreakMode =UILineBreakModeWordWrap;
        warning.numberOfLines =0;
        warning.textAlignment =UITextAlignmentLeft;
        [self.view addSubview:warning];

        
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
    self.tf.placeholder =@"必填，请输入退款原因";
    
    [view addSubview:lb1];
    [view addSubview:self.tf];
    UILabel *lin =[[UILabel alloc]initWithFrame:CGRectMake(0, 49, ConentViewWidth, 0.5)];
    lin.backgroundColor =[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
    [view addSubview:lin];
    return view;
}


-(void)createBtn{
    UIButton * btn =[UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame =CGRectMake(10, 300, ConentViewWidth-20, 50);
    [btn setTitle:@"确认退款" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.backgroundColor =BarColor;
    btn.layer.cornerRadius =6;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

-(void)btnClick{
    //(@"提交");
    if (self.tf.text.length ==0) {
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入您的退款原因" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [failAlView show];
    }else{
        [self.view makeToastActivity];
        NSUserDefaults * userdefault =[NSUserDefaults standardUserDefaults];
        NSString *userID =[NSString stringWithFormat:@"%@",[userdefault objectForKey:@"Useid"]];
        NSString * ShouY = [NSString stringWithFormat:CenterBack];
        //(@"%@",ShouY);
        
        NSDictionary * dict =[NSDictionary dictionaryWithObjectsAndKeys:self.tf.text,@"reason",userID,@"member_id",self.currentOrdId,@"order_id",@"test",@"token",nil];
        
        ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
        [manager POST:ShouY parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //(@"xxxx%@",responseObject);
            [self.view hideToastActivity];
                UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"申请成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
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
