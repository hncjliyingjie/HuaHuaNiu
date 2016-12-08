//
//  MyLoneViewController.m
//  HuaHuaNiu
//
//  Created by yuanzhi on 16/3/18.
//  Copyright © 2016年 张燕. All rights reserved.
//
NSString *strIndex;
#import "MyLoneViewController.h"
#import "ZFChart.h"
#import "ShouZhiViewController.h"
#import "InViteViewController.h"
#import "YHZhiGongViewController.h"
#import "TXianViewController.h"
#import "ZhiJieViewController.h"
#import "YHHelpDetailViewController.h"


@interface MyLoneViewController ()
{
    BOOL yinYuan;
    BOOL WoDe;
    
}
@property (nonatomic,strong) NSMutableArray *chengLiMutArray;
@end

@implementation MyLoneViewController

- (NSMutableArray *)chengLiMutArray{
    if (_chengLiMutArray == nil) {
        _chengLiMutArray = [[NSMutableArray alloc]init];
    }
    return _chengLiMutArray;
}

-(void)viewWillAppear:(BOOL)animated{
    self.title=@"财富榜";
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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    yinYuan=YES;
    WoDe=YES;
    _JiFenMingXiBtn.hidden=YES;
    
   [self shuJu];
   [self showBarChart];
 
}


- (IBAction)tiShengShouYiButton:(id)sender {
    
    //加载帮助页面
    
    NSUserDefaults *Userdefaults =[NSUserDefaults standardUserDefaults];
    
    NSString * ShouY = [NSString stringWithFormat:UpProfit,[Userdefaults objectForKey:@"Useid"]];
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString * str = [responseObject objectForKey:@"content"];
        YHHelpDetailViewController * hdvc =[[YHHelpDetailViewController alloc] init];
        hdvc.currentStr =str;
        hdvc.hidesBottomBarWhenPushed= YES;
        [self.navigationController pushViewController:hdvc animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [failAlView show];
        
    }];

    
    
    
}


#pragma mark - 加载数据
-(void)shuJu{
    NSUserDefaults * userdefault =[NSUserDefaults standardUserDefaults];
    NSString *  UserID =[NSString stringWithFormat:@"%@",[userdefault objectForKey:@"Useid"]];
    NSString *ShouY = [NSString stringWithFormat:@"http://daiyancheng.cn/appfun/mySilver.do?token=test&member_id=%@",UserID];
    ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[RequestManger share]requestDataByPostWithPath:ShouY dictionary:nil complete:^(NSDictionary *data) {
        if ([data objectForKey:@"error"]) {
            UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [failAlView show];
        }else{
            NSLog(@"%@",data);
            if (yinYuan) {
                if (WoDe) {
                    [self.chengLiMutArray removeAllObjects];
                    NSString *str1=[NSString stringWithFormat:@"%@",[[data objectForKey:@"silver"] objectForKey:@"first_funs"]];
                    NSString *str2=[NSString stringWithFormat:@"%@",[[data objectForKey:@"silver"] objectForKey:@"second_funs"]];
                    NSString *str3=[NSString stringWithFormat:@"%@",[[data objectForKey:@"silver"] objectForKey:@"third_funs"]];
                    [self.chengLiMutArray addObject:str1];
                    [self.chengLiMutArray addObject:str2];
                    [self.chengLiMutArray addObject:str3];
                    [self showBarChart];
                }else{//不是我的银元
                    [self.chengLiMutArray removeAllObjects];
                    NSString *str1=[NSString stringWithFormat:@"%@",[[data objectForKey:@"helpSilver"] objectForKey:@"first_silver"]];
                    NSString *str2=[NSString stringWithFormat:@"%@",[[data objectForKey:@"helpSilver"] objectForKey:@"second_silver"]];
                    NSString *str3=[NSString stringWithFormat:@"%@",[[data objectForKey:@"helpSilver"] objectForKey:@"third_silver"]];
                    [self.chengLiMutArray addObject:str1];
                    [self.chengLiMutArray addObject:str2];
                    [self.chengLiMutArray addObject:str3];
                    [self showBarChart];
                }
                    _yinZongShuLable.text=[NSString stringWithFormat:@"%@",[[data objectForKey:@"silver"] objectForKey:@"total_silver"]];
                    _jinYinShuLable.text=[NSString stringWithFormat:@"%@",[[data objectForKey:@"silver"] objectForKey:@"t_addsilver"]];
                    _yiDuiShuLable.text=[NSString stringWithFormat:@"%@",[[data objectForKey:@"silver"] objectForKey:@"dh_silver"]];
                

            }else{//积分
                if (WoDe) {//我的积分
                    [self.chengLiMutArray removeAllObjects];
                    NSString *str1=[NSString stringWithFormat:@"%@",[[data objectForKey:@"silver"] objectForKey:@"first_funs"]];
                    NSString *str2=[NSString stringWithFormat:@"%@",[[data objectForKey:@"silver"] objectForKey:@"second_funs"]];
                    NSString *str3=[NSString stringWithFormat:@"%@",[[data objectForKey:@"silver"] objectForKey:@"third_funs"]];
                    [self.chengLiMutArray addObject:str1];
                    [self.chengLiMutArray addObject:str2];
                    [self.chengLiMutArray addObject:str3];
                    [self showBarChart];
                }else{//不是我的积分
                    [self.chengLiMutArray removeAllObjects];
                    NSString *str1=[NSString stringWithFormat:@"%@",[[data objectForKey:@"helpJf"] objectForKey:@"first_jf"]];
                    NSString *str2=[NSString stringWithFormat:@"%@",[[data objectForKey:@"helpJf"] objectForKey:@"second_jf"]];
                    NSString *str3=[NSString stringWithFormat:@"%@",[[data objectForKey:@"helpJf"] objectForKey:@"third_jf"]];
                    [self.chengLiMutArray addObject:str1];
                    [self.chengLiMutArray addObject:str2];
                    [self.chengLiMutArray addObject:str3];
                    [self showBarChart];
                }
               _yinZongShuLable.text=[NSString stringWithFormat:@"%@",[[data objectForKey:@"silver"] objectForKey:@"total_jf"]];
                _jinYinShuLable.text=[NSString stringWithFormat:@"%@",[[data objectForKey:@"silver"] objectForKey:@"t_addjf"]];
            }
        }
    }];
}

- (void)showBarChart{
    
    ZFBarChart * barChart = [[ZFBarChart alloc] initWithFrame:CGRectMake(0, -60, SCREEN_WIDTH, SCREEN_HEIGHT)];

    barChart.xLineValueArray = self.chengLiMutArray;
    barChart.xLineTitleArray = [NSMutableArray arrayWithObjects:@"一级城里人", @"二级城里人", @"三级城里人", nil];
    barChart.yLineMaxValue = 500;
    barChart.yLineSectionCount = 0;
    [_zhuView addSubview:barChart];
    [barChart strokePath];
}
- (void)showBarChartNoTltle{
    
    ZFBarChart * barChart = [[ZFBarChart alloc] initWithFrame:CGRectMake(0, -60, SCREEN_WIDTH, SCREEN_HEIGHT)];
    NSLog(@"%@",self.chengLiMutArray);

    barChart.isShowValueOnChart = NO;

    barChart.xLineTitleArray = [NSMutableArray arrayWithObjects:@"一级城里人", @"二级城里人", @"三级城里人", nil];
    barChart.yLineMaxValue = 500;
    barChart.yLineSectionCount = 10;
    [_zhuView addSubview:barChart];
    [barChart strokePath];
}

-(IBAction)YinYuan:(id)sender{
    yinYuan=YES;
    [self shuJu];
    [_jiFenBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_yinYuanBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _yinZongLable.text=@"银元总数";
    _jinYinLable.text=@"今日银元";
    _yiDuiLable.text=@"已兑银元";
    _yaoQingBtn.hidden=NO;
    _yiDuiLable.hidden=NO;
    _yiDuiShuLable.hidden=NO;
    _JiFenMingXiBtn.hidden=YES;
    [_quDuiHuanBtn setTitle:@"去兑换" forState:UIControlStateNormal];
    [_bangZhuanBtn setTitle:@"帮赚银元" forState:UIControlStateNormal];
    [self removeAllView];
    [self showBarChartNoTltle];
}
-(IBAction)JiFen:(id)sender{
   
    yinYuan=NO;
    [self shuJu];
    [_jiFenBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_yinYuanBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
     _yaoQingBtn.hidden=YES;
    _yinZongLable.text=@"积分总数";
    _jinYinLable.text=@"今日收益";
    _yiDuiLable.hidden=YES;
    _yiDuiShuLable.hidden=YES;
    _JiFenMingXiBtn.hidden=NO;
    [_quDuiHuanBtn setTitle:@"提现" forState:UIControlStateNormal];
    [_bangZhuanBtn setTitle:@"帮赚积分" forState:UIControlStateNormal];
    [self removeAllView];
    
    [self showBarChartNoTltle];
    
}
-(IBAction)YaoQing:(id)sender{
    InViteViewController *inv=[[InViteViewController alloc]init];
    
    [self.navigationController pushViewController:inv animated:YES];
   
}
-(IBAction)QuDuiHuan:(id)sender{
    if (yinYuan==YES) {
//        SeconderViewController *seach=[[SeconderViewController alloc]init];
//        [self.navigationController pushViewController:seach animated:YES];
        [self.navigationController popViewControllerAnimated:YES];
        strIndex=@"11";
    }else{
    TXianViewController *tx=[[TXianViewController alloc]init];
    [self.navigationController pushViewController:tx animated:YES];
    }
}
-(IBAction)WoDe:(id)sender{
    WoDe=YES;
    [self shuJu];
    [_woDeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_bangZhuanBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self removeAllView];
    [self showBarChartNoTltle];
}
-(IBAction)BangZhuan:(id)sender{
    WoDe=NO;
    [self shuJu];
    [_woDeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_bangZhuanBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self removeAllView];
    [self showBarChartNoTltle];
}
-(IBAction)JiFenMingXi:(id)sender{
    ShouZhiViewController *shouzhi=[[ShouZhiViewController alloc]init];
    [self.navigationController pushViewController:shouzhi animated:YES];
}
-(void)removeAllView{
    for (UIView * view in _zhuView.subviews) {
        NSLog(@"%@",view);
        [(ZFBarChart *)view removeFromSuperview];
    }
}
-(IBAction)zhiJieAction:(id)sender{
    ZhiJieViewController *zhiJie=[[ZhiJieViewController alloc]init];
    [self.navigationController pushViewController:zhiJie animated:YES];
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
