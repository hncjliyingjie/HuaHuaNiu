//
//  RecommendViewController.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-13.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "RecommendViewController.h"
#import "RecommendTableViewCell.h"
#import "StoreDetailsViewController.h"
#import "Toast+UIView.h"
#import "MJRefresh.h"
#import "LogViewController.h"
#import "bindStoreModel.h"
@interface RecommendViewController ()

@end

@implementation RecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =BackColor;
    dataArr =[[NSMutableArray alloc]init];
    pagenumber= 1;
    self.navigationItem.title=@"推荐绑定商家";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self makeRecommData];
    UIButton *BackBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    BackBtn.frame =CGRectMake(0, 0, 64, 27);
    [BackBtn  setBackgroundImage:[UIImage imageNamed:@"app_fanhui"] forState:UIControlStateNormal];
    [BackBtn addTarget:self action:@selector(BackAction)  forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem =[[UIBarButtonItem alloc]initWithCustomView:BackBtn];
    self.navigationItem.leftBarButtonItem = backItem;

}
-(void)makeRecommData{
    [self.view makeToastActivity];
    NSString *ShouY = [NSString stringWithFormat:TUIJIANBANGD,pagenumber];
    //(@"%@",ShouY);
    ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[RequestManger share]requestDataByGetWithPath:ShouY complete:^(NSDictionary *data) {
        [self.view hideToastActivity];
        [_tv footerEndRefreshing];
        [_tv headerEndRefreshing];
        if ([data objectForKey:@"error"]) {
            UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [failAlView show];
        }else{
            bindStoreModel * model =[bindStoreModel makeModelWithDict:data];
            if (pagenumber ==1) {
                [dataArr removeAllObjects];
            }
            [dataArr addObjectsFromArray:model.bindStoreArr];
            [self makeUI];
            
            if (dataArr.count == 0) {
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
        }
    }];
}
-(void)FootAdd{
    pagenumber ++;
    [self makeRecommData];
}
-(void)HeadFresh{
    pagenumber = 1;
   [self makeRecommData];
}
-(void)makeUI{
    IOS_Frame
    if (_tv) {
        [_tv reloadData];
    }
    else{
        _tv  =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, ConentViewHeight) style:UITableViewStylePlain];
        _tv.delegate =self;
        _tv.dataSource =self;
        [_tv addFooterWithTarget:self action:@selector(FootAdd)];
        [_tv addHeaderWithTarget:self action:@selector(HeadFresh)];
        if (dataArr.count < 7) {
            _tv.frame=CGRectMake(0, 0, ConentViewWidth, 84*dataArr.count);
            _tv.scrollEnabled = NO;
        }
        UILongPressGestureRecognizer * longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressToDo:)];
        longPressGr.minimumPressDuration = 1.0;
        [_tv addGestureRecognizer:longPressGr];
        [self.view addSubview:_tv];
    }
}
-(void)BackAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  dataArr.count;
    
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 84;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    bindStoreModel *bsModel =dataArr[indexPath.row];
    NSString * storeId = bsModel.store_id;
    StoreDetailsViewController * svc =[[StoreDetailsViewController alloc]initWithStr:storeId];
    [self.navigationController pushViewController:svc animated:YES];
    
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RecommendTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell ==nil) {
        cell =[[[NSBundle mainBundle]loadNibNamed:@"RecommendTableViewCell" owner:nil options:nil]lastObject];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    bindStoreModel * model =dataArr[indexPath.row];
    [cell coremmondcellmakeWithModel:model];


    [cell TishiBlocksShow:^(NSString *Str) {
        //  此处应该发送 绑定请求   请示成功返回成功 失败返回失败
        NSUserDefaults *UserDefault =[NSUserDefaults standardUserDefaults];
        NSString * UserIDs =[UserDefault objectForKey:@"Useid"];
        NSInteger denglu  = UserIDs.length;
        if (denglu ==  0) {// 未登录 进入登陆
            LogViewController *logview =[[LogViewController alloc]init];
            [self.navigationController pushViewController:logview animated:YES];
        }
        else{
            NSString *ShouY = [NSString stringWithFormat:BANGSTORESS,UserIDs,Str];
            //(@"%@",ShouY);
            ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [[RequestManger share]requestDataByGetWithPath:ShouY complete:^(NSDictionary *data) {
                //(@"%@",data);
                if ([data objectForKey:@"error"]) {
                    
                }else{
                    //   判断是否绑定成功
                    NSString * ResultStr =[NSString stringWithFormat:@"%@",[data objectForKey:@"result"]];
                    if ( [ResultStr isEqualToString:@"1"]) {
                        UIAlertView * TiShiAlw =[[UIAlertView alloc]initWithTitle:@"绑定成功" message:@"恭喜你成为该商家代言人！ 你将获得该商家十五天内总收入的  1%" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                        TiShiAlw.tag = 61;
                        [TiShiAlw show];
                    }
                    else{
                        NSString * MsgStr=[NSString stringWithString:[data objectForKey:@"msg"]];
                        if([MsgStr isEqualToString:@"该用户已经绑定"]){
                            MsgStr =@"您已经绑定商家不能再次绑定";
                        }
                        UIAlertView * TiShiAlw =[[UIAlertView alloc]initWithTitle:@"绑定失败" message:MsgStr delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                        [TiShiAlw show];
                    }

                }
            }];
        }
    }];
   
    return cell;
    
}





-(void)EnterAction{
//    [LabelView removeFromSuperview];
//    [tishiBakViw removeFromSuperview];
//    //(@"yincang");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
