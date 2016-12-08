//
//  DaijianquanXQViewController.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-19.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "DaijianquanXQViewController.h"
#import "DaiTopView.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "Toast+UIView.h"
#import "LogViewController.h"
@interface DaijianquanXQViewController ()

@end

@implementation DaijianquanXQViewController

-(id)initVidWIthStr:(NSString *)Str andLIingqu:(BOOL)linqu{
    self =[super init];
    if (self) {
        VIdStr = Str;
        LingQu = linqu;
    }
    return self;
}
- (void)viewDidLoad {
    self.view.backgroundColor =[UIColor whiteColor];
    [super viewDidLoad];
    
    
    UIButton *BackBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    BackBtn.frame =CGRectMake(0, 0, 64, 27);
    [BackBtn  setBackgroundImage:[UIImage imageNamed:@"app_fanhui"] forState:UIControlStateNormal];
    [BackBtn addTarget:self action:@selector(BackAction)  forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem =[[UIBarButtonItem alloc]initWithCustomView:BackBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    [self makeDaiData];
}
-(void)makeDaiData{

    [self.view makeToastActivity];
    NSString *ShouY = [NSString stringWithFormat:DAIXIANGQING,VIdStr];
    //(@"%@",ShouY);
    ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
       AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
        NSString * str=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"result"]];
        if ( [str isEqualToString:@"1"]){
        dic =[[NSDictionary alloc]initWithDictionary:[responseObject objectForKey:@"retval"]];
        [self makeUI];
        }
        else{
            //(@"请求错误");
        }
       [self.view hideToastActivity];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.view hideToastActivity];
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [failAlView show];
        //(@"cook load failed ,%@",error);
    }];
    



}
-(void)BackAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)makeUI{
    IOS_Frame
    BackView =[[UIScrollView alloc]initWithFrame:self.view.frame];
    BackView.backgroundColor = BackColor;
    BackView.contentSize=CGSizeMake(ConentViewWidth, ConentViewHeight+200);
    BackView.bounces = NO;
    BackView.showsVerticalScrollIndicator = NO;
    BackView.backgroundColor =BackColor;
   [self.view addSubview:BackView];

  
    DaiTopView * TopVie =[[[NSBundle mainBundle]loadNibNamed:@"DaiTopView" owner:self options:nil]lastObject];
    TopVie.frame =CGRectMake(0, 0, ConentViewWidth, 186);
    [TopVie ViewMakeDAIRWithDIc:dic];
   [BackView addSubview:TopVie];
// 优惠介绍
    UIView  * YouHuiView =[[UIView alloc]initWithFrame:CGRectMake(0, TopVie.frame.size.height + TopVie.frame.origin.y+10, ConentViewWidth, 200)];
    YouHuiView.backgroundColor =[UIColor whiteColor];
    [BackView addSubview:YouHuiView];
    UIImageView *imao =[[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 20, 20)];
  //  imao.backgroundColor =[UIColor blackColor];
    [imao setImage:[UIImage imageNamed:@"app_youhuijieshao"]];
    [YouHuiView addSubview:imao];
   UILabel *nameLabelo =[[UILabel alloc]initWithFrame:CGRectMake(35, 5, 300, 25)];
    nameLabelo.text =@"优惠介绍";
    nameLabelo.font =[UIFont systemFontOfSize:14];
    [YouHuiView addSubview:nameLabelo];
    
    
    UILabel *LineLabel =[[UILabel alloc]initWithFrame:CGRectMake(20, 30, ConentViewWidth-20, 1)];
    LineLabel.backgroundColor =BackColor;
    [YouHuiView addSubview:LineLabel];
    
// 内容
    UILabel * YHconcentLabel =[[UILabel alloc]initWithFrame:CGRectMake(10, 30, ConentViewWidth -20, 60)];
    YHconcentLabel.numberOfLines = 0;
    YHconcentLabel.text =[NSString stringWithFormat:@"%@",[dic objectForKey:@"description"]];
  
    //YHconcentLabel.text.length/20
    YHconcentLabel.frame =CGRectMake(10, 35, ConentViewWidth -20, 17* YHconcentLabel.text.length/20 +15);
    YouHuiView.frame =CGRectMake(0, TopVie.frame.size.height + TopVie.frame.origin.y+10, ConentViewWidth, 35+  17* YHconcentLabel.text.length/20 +15);
    YHconcentLabel.font =[UIFont systemFontOfSize:14];
    YHconcentLabel.numberOfLines = 0;
 
    [YouHuiView addSubview:YHconcentLabel];
    
// 使用说明
    UIView  * ShiYongView =[[UIView alloc]initWithFrame:CGRectMake(0, YouHuiView.frame.size.height + YouHuiView.frame.origin.y+10, ConentViewWidth, 200)];
    ShiYongView.backgroundColor =[UIColor whiteColor];
    [BackView addSubview:ShiYongView];

    UIImageView *imat =[[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 20, 20)];
    //imat.backgroundColor =[UIColor blackColor];
   [imat setImage:[UIImage imageNamed:@"app_shiyongshuoming"]];
    [ShiYongView addSubview:imat];

    UILabel *nameLabelt =[[UILabel alloc]initWithFrame:CGRectMake(35, 5, 300, 25)];
    nameLabelt.text =@"使用说明";
    nameLabelt.font =[UIFont systemFontOfSize:14];
    [ShiYongView addSubview:nameLabelt];

    
    
    
    UILabel *LineLabelt =[[UILabel alloc]initWithFrame:CGRectMake(20, 30, ConentViewWidth-20, 1)];
    LineLabelt.backgroundColor =BackColor;
    [ShiYongView addSubview:LineLabelt];
  
 
// 内容
    UILabel * SYconcentLabel =[[UILabel alloc]initWithFrame:CGRectMake(10, 35, ConentViewWidth -20, 60)];
   SYconcentLabel.text =[NSString stringWithFormat:@"%@",[dic objectForKey:@"introduce"]];
  
    //YHconcentLabel.text.length/20
    SYconcentLabel.frame =CGRectMake(10, 35, ConentViewWidth -20, 17* SYconcentLabel.text.length/20 +15);
    ShiYongView.frame =CGRectMake(0, YouHuiView.frame.size.height + YouHuiView.frame.origin.y+10, ConentViewWidth, 35+  17* SYconcentLabel.text.length/20 +15);
    SYconcentLabel.font =[UIFont systemFontOfSize:14];
    SYconcentLabel.numberOfLines = 0;
  
    [ShiYongView addSubview:SYconcentLabel];

    BackView.contentSize=CGSizeMake(ConentViewWidth, ShiYongView.frame.size.height+ShiYongView.frame.origin.y+100);
    float numbr =[[dic objectForKey:@"surplus_days"]floatValue];
    if (numbr < 0) {
        LingQu = NO;
    }
   if (LingQu) {
    UIButton *LinQubtn =[UIButton buttonWithType:UIButtonTypeCustom];
    LinQubtn.frame =CGRectMake(0, ConentViewHeight -40, ConentViewWidth, 40);
    [LinQubtn addTarget:self action:@selector(LinQJuanBtn) forControlEvents:UIControlEventTouchUpInside];
    [LinQubtn setBackgroundColor:[UIColor colorWithRed:246/255.0 green:125/255.0 blue:137/255.0 alpha:1]];
    [LinQubtn setTitle:@"立即领取" forState:UIControlStateNormal];
    [self.view addSubview:LinQubtn];
    }

}
-(void)LinQJuanBtn{
    NSUserDefaults *UserDefault =[NSUserDefaults standardUserDefaults];
    NSString * UserIDs =[UserDefault objectForKey:@"Useid"];
    int denglu  = UserIDs.length;
    if (denglu ==  0) {// 未登录 进入登陆
        LogViewController *logview =[[LogViewController alloc]init];
        [self.navigationController pushViewController:logview animated:YES];
    }else{
    NSUserDefaults * UserDefault =[NSUserDefaults standardUserDefaults];
    NSString * UserID =[UserDefault objectForKey:@"Useid"];
    NSString *ShouY = [NSString stringWithFormat:ADDDAIJINQUAN,UserID,VIdStr];
    ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];    
    [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString * str=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"result"]];
      
        if ( [str isEqualToString:@"1"]){
            UIAlertView * al =[[UIAlertView alloc]initWithTitle:@"代金券领取" message:@"恭喜成功您领取代金券" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [al show];
        }else{
           UIAlertView * al =[[UIAlertView alloc]initWithTitle:@"代金券领取" message:@"您已经领取过了 谢谢" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [al show];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [failAlView show];
        //(@"cook load failed ,%@",error);
    }];
    }

}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

 [self.navigationController popViewControllerAnimated: YES];
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
