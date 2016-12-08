//
//  MyLaysViewController.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-13.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "MyLaysViewController.h"
#import "WDYTableViewCell.h"
#import "HistoryBangDingViewController.h"
#import "StoreDetailsViewController.h"
#import "LogViewController.h"

#import "UIImageView+WebCache.h"
#import "Toast+UIView.h"
@interface MyLaysViewController ()

@end

@implementation MyLaysViewController

- (void)viewDidLoad {
   
 [super viewDidLoad];
    DataArr =[[NSArray alloc]init];
    self.view.backgroundColor =BackColor;
    [self Creatdaiyan];
    [self makeUI];
}
-(void)Creatdaiyan{
    
    NSUserDefaults *UserDefault =[NSUserDefaults standardUserDefaults];
    NSString * UserIDs =[UserDefault objectForKey:@"Useid"];
    int denglu  = (int)UserIDs.length;
    if (denglu ==  0) {// 未登录 进入登陆
        LogViewController *logview =[[LogViewController alloc]init];
        [self.navigationController pushViewController:logview animated:YES];
    }
    else{
    [self.view makeToastActivity];
    NSString *ShouY = [NSString stringWithFormat:DAIYAN,UserIDs];
    //(@"%@",ShouY);
    ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[RequestManger share]requestDataByGetWithPath:ShouY complete:^(NSDictionary *data) {
            [self.view hideToastActivity];
            
            if ([data objectForKey:@"error"]) {
                UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [failAlView show];
            }else{
                AlexModel *model =[AlexModel makeBindsModelWithDict:data];
                NSMutableArray * mutArr =[NSMutableArray array];
                for (NSInteger  i  = model.bindArr.count -1; i>=0; i--) {
                    [mutArr addObject:model.bindArr[i]];
                }
                DataArr =[mutArr copy];
                if (model.bindArr.count == 0) {
                    UIAlertView *alView =[[UIAlertView alloc]initWithTitle:@"暂无关联商家" message:@"您还没有关联商家,\n请参加砸金蛋获取关联商家！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles: nil];
                    [alView show];
                    UILabel * Storelabel =[[UILabel alloc]initWithFrame:CGRectMake(30, ConentViewHeight/2 - 100 , ConentViewWidth - 60  , 30)];
                    Storelabel.textAlignment = NSTextAlignmentCenter;
                    Storelabel.text =@"暂无数据";
                    Storelabel.font =[UIFont systemFontOfSize:13];
                    Storelabel.tag = 100;
                    [self.view addSubview:Storelabel];
                }else{
                    UILabel * tisi =(UILabel *)[self.view  viewWithTag:100];
                    tisi.hidden = YES;
                    [self makeWithData];

                }
            }
        }];
    }
}

-(void)makeWithData{
    IOS_Frame
    _Tv =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, ConentViewHeight) style:UITableViewStylePlain];
    _Tv.delegate =self;
    _Tv.dataSource =self;
    if (DataArr.count < 5) {
        _Tv.frame = CGRectMake(0, 0, ConentViewWidth, 96 * DataArr.count);
        _Tv.bounces  =  NO;
    }
    [self.view addSubview:_Tv];
    
/*    [self.IconImage  sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:IMaUrl,[dic objectForKey:@"store_logo"]]] placeholderImage:[UIImage imageNamed:@"default"]];
//  
//    
//    self.StoreName.text =[NSString stringWithFormat:@"%@",[dic objectForKey:@"store_name"]];
//    self.ShouYiLabel.text =[NSString stringWithFormat:@"收益%@元",[dic objectForKey:@"money"]];
//    //  绑定时间
//    
//    double BDShijian =[[dic objectForKey:@"bind_time"] doubleValue];
//    NSDate * BDdate =[NSDate dateWithTimeIntervalSince1970:BDShijian];
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//    
//    NSString * BDdataStr =[dateFormatter stringFromDate:BDdate];
//    NSArray *bdArr = [BDdataStr componentsSeparatedByString:@""];
//    
//    self.TimeLabel.text =[NSString stringWithFormat:@"%@",bdArr[0]];
//    
//    //结束时间
//    double JieShushijian  =[[dic objectForKey:@"bind_endtime"] doubleValue];
//    NSDate *JieShuTime =[NSDate dateWithTimeIntervalSince1970:JieShushijian];
//    
//    
//    NSTimeInterval cha =[JieShuTime timeIntervalSinceNow];
//    //(@"sdf   %f",cha);
//    
//    int datime =cha/3600/24;
    self.RemainTimeLabel.text =[NSString stringWithFormat:@"%d天",datime];
  */
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  96;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  DataArr.count;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AlexModel *bindModel =DataArr[indexPath.row];
    NSString * storeId =bindModel.store_id;
    StoreDetailsViewController * svc =[[StoreDetailsViewController alloc]initWithStr:storeId];
    [self.navigationController pushViewController:svc animated:YES];
    

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    WDYTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"WDYTableViewCell" owner:nil options:nil]lastObject];
    }
    AlexModel *bindModel = DataArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell makeCellWithModel:bindModel];
    [cell MaekShaeWithBlocks:^(NSString *Str) {
        //(@"%@",Str);
    }];
    return cell;
}

-(void)makeUI{
    
    self.navigationItem.title=@"我的关联商家";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];

    UIButton *RightBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    RightBtn.frame =CGRectMake(0, 0, 15, 15);
    //[RightBtn setTitle:@"历史" forState:UIControlStateNormal];
    [RightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
   [RightBtn setImage:[UIImage imageNamed:@"app_qianggoujilu_free"] forState:UIControlStateNormal];
    [RightBtn addTarget:self action:@selector(BtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *RightItem =[[UIBarButtonItem alloc]initWithCustomView:RightBtn];
    self.navigationItem.rightBarButtonItem = RightItem;
    UIButton *BackBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    BackBtn.frame =CGRectMake(0, 0, 64, 27);
    [BackBtn  setBackgroundImage:[UIImage imageNamed:@"app_fanhui"] forState:UIControlStateNormal];
    // [BackBtn setTitle:@"返回" forState:UIControlStateNormal];
    [BackBtn addTarget:self action:@selector(BackAction)  forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem =[[UIBarButtonItem alloc]initWithCustomView:BackBtn];
    self.navigationItem.leftBarButtonItem = backItem;
}
-(void)BackAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)BtnAction{
//
    NSUserDefaults *UserDefault =[NSUserDefaults standardUserDefaults];
    NSString * UserIDs =[UserDefault objectForKey:@"Useid"];
    NSInteger denglu  = UserIDs.length;
    if (denglu ==  0) {// 未登录 进入登陆
        LogViewController *logview =[[LogViewController alloc]init];
        [self.navigationController pushViewController:logview animated:YES];
    }
    else{
    HistoryBangDingViewController *Hvc =[[HistoryBangDingViewController alloc]init];
    [self.navigationController pushViewController:Hvc animated:YES];
    }
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
