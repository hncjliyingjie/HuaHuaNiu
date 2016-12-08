//
//  DaxiangViewController.m
//  HuaHuaNiu
//
//  Created by alex on 16/1/4.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "DaxiangViewController.h"
#import "TableViewCell.h"

#import "AFNetworking.h"
#import "SearchReaultViewController.h"
#import "Toast+UIView.h"
#import "MJRefresh.h"
#import "CitychooSSViewController.h"
#import "WebViewController.h"


static NSString *identifier = @"cell";

@interface DaxiangViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *MytableView;


@end


@implementation DaxiangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"大象网--热点聚焦";
    self.navigationController.navigationBar.barTintColor =[UIColor colorWithRed:264/255.0 green:125/255.0 blue:137/255.0 alpha:1];
    [self MytableView];
    [self updata];
    
    self.slideSwitchView.tabItemNormalColor = [SUNSlideSwitchView colorFromHexRGB:@"868686"];
    self.slideSwitchView.tabItemSelectedColor = [SUNSlideSwitchView colorFromHexRGB:@"bb0b15"];
    self.slideSwitchView.shadowImage = [[UIImage imageNamed:@"red_line_and_shadow.png"]
                stretchableImageWithLeftCapWidth:59.0f topCapHeight:0.0f];
    
    
    
}

-(void)updata
{
    [self.MytableView reloadData];
    
    NSString *string = Daxiangshouye;
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection connectionWithRequest:request delegate:self];
    
    NSOperationQueue *queue=[NSOperationQueue mainQueue];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        //        NSLog(@"data === %@",dict);
        NSArray *arr = [dict objectForKey:@"data"];
        NSLog(@"%@",arr);
        NSArray *array = arr[0];
        self.mDataArray = array;
        
        //        NSLog(@"%lu",(unsigned long)self.mDataArray.count);
        //        NSLog(@"%@",self.mDataArray);
        //        NSLog(@"%@",)
        
        for (NSDictionary *dict2 in self.mDataArray) {
            NSLog(@"%@",[NSString stringWithFormat:@"%@",[dict2 objectForKey:@"title"]]);
        }
        //        for (int i = _a; i < self.tableViewData.count; i ++) {
        //            [_helper.mDataArray insertObject:[self.tableViewData objectAtIndex:i] atIndex:_helper.mDataArray.count];
        //        }
        [self.MytableView reloadData];
    }];
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        // 刷新表格
    //        [self.MytableView reloadData];
    //
    //        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    //        [self.MytableView footerEndRefreshing];
    //    });
}


#pragma mark -- 懒加载
-(UITableView *)MytableView{
    if (!_MytableView) {
        _MytableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -35, self.view.frame.size.width+20, self.view.frame.size.height) style:UITableViewStyleGrouped];
        _MytableView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_MytableView];
        _MytableView.delegate = self;
        _MytableView.dataSource = self;
        [_MytableView registerClass:[TableViewCell class] forCellReuseIdentifier:identifier];
        
        
    }
    return _MytableView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    NSDictionary *dic = self.mDataArray[indexPath.row];
    [cell cellMakeDataWithDic:dic];
    
    return cell;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mDataArray.count;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray *mutArray=[NSMutableArray array];
    NSMutableArray *mutArray1=[NSMutableArray array];
    NSMutableArray *mutArray2=[NSMutableArray array];
    for (NSDictionary *dict2 in self.mDataArray) {
        NSLog(@"%@",[NSString stringWithFormat:@"%@",[dict2 objectForKey:@"id"]]);
        [mutArray addObject:[dict2 objectForKey:@"id"]];
        [mutArray1 addObject:[dict2 objectForKey:@"title"]];
        [mutArray2 addObject:[dict2 objectForKey:@"newstime"]];
    }
    
    WebViewController *webView=[[WebViewController alloc]init];
    webView.strId=[mutArray objectAtIndex:indexPath.row];
    webView.strTitle=[mutArray1 objectAtIndex:indexPath.row];
    webView.strTime=[mutArray2 objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:webView animated:YES];
    NSLog(@"%@",[mutArray objectAtIndex:indexPath.row]);
    NSLog(@"%li",indexPath.row);
}



//
//#pragma mark 创建数据
//-(void)creatData{
//    
//    
//    NSString *string = Daxiangshouye;
//    NSURL *url = [NSURL URLWithString:string];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    
//    [NSURLConnection connectionWithRequest:request delegate:self];
//    
//    
//    NSOperationQueue *queue=[NSOperationQueue mainQueue];
//    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//        //              //(@"--block回调数据--%@---%d", [NSThread currentThread],data.length);
//        //隐藏HUD，刷新UI的操作一定要放在主线程执行
//        //             [MBProgressHUD hideHUD];
//        
//        //解析data
//        /*
//         60         {"success":"登录成功"}
//         61         {"error":"用户名不存在"}
//         62         {"error":"密码不正确"}
//         63          */
//        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//        NSLog(@"%@",dict);
//        NSObject *arr = [dict objectForKey:@"data"];
//        NSLog(@"%@",arr);
//        
//    }];
//    
//    
//    /////
//    [self.view makeToastActivity];
//    // 坐标 ll  page 页数   PaiXu  排序  cate_list 分类
//    NSString *ShouY ;
//    if (isQuyu) {// 区域访问
//        ShouY =[NSString stringWithFormat:ZhiGongQuID,region_id,page,PaiXu,FenLeiStr];
//    }
//    else{
//        ShouY = [NSString stringWithFormat:ZhiGongZuoBiao,ll,page,PaiXu,FenLeiStr];
//    }
//    
//    //(@"%@",ShouY);
//    ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
//    [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        [self.view hideToastActivity];
//        
//        Current_area =[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"current_area"]];
//        
//        if (page ==1) {
//            [DataArr removeAllObjects];
//        }
//        
//        
//        CityAreaDataArr = [[NSArray alloc]initWithArray:[[responseObject objectForKey:@"area"] objectForKey:@"children"]];
//        
//        region_id =[NSString stringWithFormat:@"%@",[[responseObject objectForKey:@"area"] objectForKey:@"id"]];
//        
//        
//        
//        [DataArr addObjectsFromArray:[responseObject objectForKey:@"goods"]];
//        
//        FirstTvDataArr =[[NSArray alloc]initWithArray:[responseObject objectForKey:@"cate_list"]];
//        
//        MorenTvDataArr =[[NSArray alloc]initWithArray:[responseObject objectForKey:@"order"]];
//        
//        if (FirstTvDataArr.count >0) {
//            SectionTvDataArr =[[NSArray alloc]initWithArray:[FirstTvDataArr[0] objectForKey:@"children"]];
//        }else{
//            SectionTvDataArr =[[NSArray alloc]init];
//        }
//        
//        
//        //第一次进入保存 省份的数据
//        if (numbr == 2) {
//            proviceArr =[[NSArray alloc]initWithArray:CityAreaDataArr];
//        }
//        numbr ++;
//        if(CityAreaDataArr.count == 0){
//            CityAreaDataArr =[[NSMutableArray alloc]initWithArray:proviceArr];
//        }
//        
//        //        [self makeUI];
//        //        [self makeTopView];
//        
//        if (tiishlable) {
//            
//        }
//        else{
//            tiishlable =[[UILabel alloc]initWithFrame:CGRectMake(30, ConentViewHeight/2 - 100 , ConentViewWidth - 60  , 30)];
//        }
//        
//        if(DataArr.count == 0){
//            tiishlable.textAlignment = NSTextAlignmentCenter;
//            tiishlable.text =@"暂无数据";
//            tiishlable.font =[UIFont systemFontOfSize:13];
//            [self.view addSubview:tiishlable];
//            tiishlable.hidden = NO;
//        }
//        else{
//            tiishlable.hidden =YES;
//        }
//        // 分类
//        //        [self makeFnelei];
//        [self.MytableView footerEndRefreshing];
//        [self.MytableView headerEndRefreshing];
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [self.MytableView footerEndRefreshing];
//        [self.MytableView headerEndRefreshing];
//        
//        [self.view hideToastActivity];
//        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//        [failAlView show];
//        //(@"cook load failed ,%@",error);
//    }];
//    
//}


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
