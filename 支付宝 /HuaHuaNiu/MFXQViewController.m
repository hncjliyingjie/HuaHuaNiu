//
//  MFXQViewController.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-30.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "MFXQViewController.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "Toast+UIView.h"
#import "DaiLIShangMapViewController.h"
#import "LogViewController.h"
@interface MFXQViewController ()

@end

@implementation MFXQViewController

-(id)initWithStr:(NSString *)mianfID andqiang:(BOOL )qiang{

    self =[super init];
    if (self) {
        Mfstr =mianfID;
        CanQiang = qiang;

    }
    return self;
}

- (IBAction)DdianHauAction:(id)sender {
    //(@"打电话");
    NSString * HhoneStr =[NSString stringWithFormat:@"tel://%@",[dic objectForKey:@"tel"]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:HhoneStr]];
}
// 进入地图
- (IBAction)MApViewAction:(id)sender {
    NSMutableArray * arr =[[NSMutableArray alloc]initWithObjects:dic, nil];
    DaiLIShangMapViewController * Dvc =[[DaiLIShangMapViewController alloc]initWithArr:arr];
    [self.navigationController pushViewController: Dvc  animated:YES];
    
    //(@"进入地图");

    

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor= BackColor;
    self.navigationItem.title=@"免费详情";
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
    
    [self makeMFXQData];
}
-(void)makeMFXQData{
    [self.view makeToastActivity];
    NSString *ShouY = [NSString stringWithFormat:TureXQStr,Mfstr];
    ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //(@"%@",ShouY);
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        dic =[responseObject objectForKey:@"retval"];
        [self.view hideToastActivity];
        [self makeMFUI];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.view hideToastActivity];
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [failAlView show];
        //(@"cook load failed ,%@",error);
    }];
    
 
}
-(void)makeMFUI{
    // 抢购历史进入的      不需要抢购按钮
    if (CanQiang ) {  // 抢购 进入
        [self maketimerForJs];
        
    } else{
        //  抢购  历史进入的
        self.QiangGouBtn.hidden = YES;
    }
    NSString *strrrr =[NSString stringWithFormat:IMaUrl,[dic objectForKey:@"default_image"]];
    [self.IconImage sd_setImageWithURL:[NSURL URLWithString:strrrr] placeholderImage:[UIImage imageNamed:@"default"]];

    self.NameLabel.text =[NSString stringWithFormat:@"%@",[dic objectForKey:@"goods_name"]];

    self.PhoneLaebl.text =[NSString stringWithFormat:@"   电话:%@",[dic objectForKey:@"tel"]];
    
    self.AddressLabel.text=[NSString stringWithFormat:@"   地址:%@",[dic objectForKey:@"address"]];
    //修改
    self.ShengyuLabel.text =[NSString stringWithFormat:@"%d",[[dic objectForKey:@"total_num"] intValue]-[[dic objectForKey:@"has_robbed"]intValue]];
    self.YIQiangLabel.text=[NSString stringWithFormat:@"%d",[[dic objectForKey:@"has_robbed"]intValue] ];
   
    self.concentLaebl.text =[NSString stringWithFormat:@"%@",[dic objectForKey:@"introduce"]];
    self.concentLaebl.numberOfLines = 0;
    
    NSString * bangdingstr =[NSString stringWithFormat:@"%@",[dic objectForKey:@"bind_status"]];
    
    self.concentLaebl.frame =CGRectMake(self.concentLaebl.frame.origin.x, self.concentLaebl.frame.origin.y+5, ConentViewWidth -66,self.concentLaebl.text.length);
    
    self.XQDDVIew.frame =CGRectMake(self.XQDDVIew.frame.origin.x,self.XQDDVIew.frame.origin.y,ConentViewWidth-20, self.concentLaebl.text.length +75 );
    
    //无代言人 0没有 1 寻找中 2有代言人
    if ( [bangdingstr isEqualToString:@"0"]) {
        self.DaiYanLabel.text =@"暂无代言人";
    }
    else if( [bangdingstr isEqualToString:@"1"]){
        self.DaiYanLabel.text =@"寻找代言人";
    }
    else{
        self.DaiYanLabel.text = @"已有代言人";
    }

}

#pragma 抢购时间设置
-(void)maketimerForJs{
    NSDate * date =[NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    NSString* timestr=[NSString stringWithFormat:@"localeDate ===%@",localeDate];
    NSArray *arr =[timestr componentsSeparatedByString:@" "];
    if (arr.count>2) {
        timestr =[NSString stringWithFormat:@"%@ %@",arr[0],arr[1]];
    }
    
    //(@" timer =%@ ",timestr);
    //获取时间 16 和 10  2015-05-07 11:05:57 +0000
    NSString * xiaoshi =[timestr substringWithRange:NSMakeRange(11,2)];
    //(@"%@",xiaoshi);
    int zhongdian =[xiaoshi intValue];

    // 抢购的时间
    NSString * qiangGoushijain;
    NSDate * qianghoushijainDate;


    qiangGoushijain =[NSString stringWithFormat:@"%@ %s",[dic objectForKey:@"end_date"],"00:00:00"];
    //(@"qiangGoushijain ====%@",qiangGoushijain);
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区
    // NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    //[formatter setTimeZone:timeZone];

    qianghoushijainDate = [formatter dateFromString:qiangGoushijain]; //------------将字符串按formatter转成nsdate

    NSInteger intervall = [zone secondsFromGMTForDate: date];

    qianghoushijainDate = [qianghoushijainDate  dateByAddingTimeInterval: intervall];

    // 当前时间聚格林威治时间的 差
    NSTimeInterval  nowCha =[ localeDate  timeIntervalSince1970];
    // 抢购时间距离格林威治时间的差
    NSTimeInterval  QianggouCha =[qianghoushijainDate timeIntervalSince1970];

    daojimiaoshu =(int)QianggouCha -(int)nowCha;
    if (daojimiaoshu >0) {
        [self makeTInwer];
    }else{
        
    }
}
-(void)viewDidDisappear:(BOOL)animated{
    [_timer invalidate];
}
// 定时器
-(void)makeTInwer{
    _timer =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(TimerActiom) userInfo:nil repeats:YES];
    
    [_timer fire];
}

-(void)TimerActiom{
    //(@"vv%d",daojimiaoshu);

    daojimiaoshu --;
    shi =(daojimiaoshu % (60 * 60 * 24)) / (60 * 60);
    fen = (daojimiaoshu % (60 * 60)) / 60;
    miao =daojimiaoshu % 60;
    tian =daojimiaoshu / (60 * 60 * 24);
    self.tianLB.text =[NSString stringWithFormat:@"%d",tian];
    self.ShiLabel.text =[NSString stringWithFormat:@"%.2d",shi];
    self.fenLabel.text =[NSString stringWithFormat:@"%.2d",fen];
    self.MiaoLabel.text =[NSString stringWithFormat:@"%.2d",miao];
    //  //(@"  %d      str = %@",daojimiaoshu ,str);


    if(tian ==0&&shi==0&&fen==0&&miao==0){
        self.isJieShu =YES;
        [_timer invalidate];
    }
    
}

-(void)RightBtnAct{
    //(@"分享");
    

}
-(void)BackAction{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)QiangDanAction:(id)sender {
    // 抢购
    NSUserDefaults *UserDefault =[NSUserDefaults standardUserDefaults];
    NSString * UserIDs =[UserDefault objectForKey:@"Useid"];
    int denglu  = UserIDs.length;
    if (denglu ==  0) {// 未登录 进入登陆
        LogViewController *logview =[[LogViewController alloc]init];
        
        [self.navigationController pushViewController:logview animated:YES];
        
        
    }
    else{
//  登陆以后可以抢购

    if (self.isJieShu){  // 抢购结束
        UIAlertView * al =[[UIAlertView alloc]initWithTitle:@"抢购已结束" message:@"本次抢购已结束！\n谢谢！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [al show];
    }
    else {// 可以抢购
        NSString *ShouY = [NSString stringWithFormat:GETMIANF,UserIDs,self.gf_id];
        ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        //(@"%@",ShouY);
        AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
        [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSString * done =[NSString stringWithFormat:@"%@", [responseObject objectForKey:@"result"]];
            if ( [done isEqualToString:@"2"]) {
                UIAlertView *alVe =[[UIAlertView alloc]initWithTitle:@"领取结果" message:@"您已经抢过单了，不能再抢了" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alVe show];
            }
            else{
                UIAlertView *alVe =[[UIAlertView alloc]initWithTitle:@"领取结果" message:@"恭喜您抢购成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                //(@"领取成功 有提示 ");
                [alVe show];
                
                
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [failAlView show];
            //(@"cook load failed ,%@",error);
            
        }];

    
    }
    }

    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    [self.navigationController popViewControllerAnimated:YES];

}
@end
