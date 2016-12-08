//
//  ShangJiaShangDianViewController.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-20.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "ShangJiaShangDianViewController.h"
#import "ProductDetailViewController.h"
#import "PeisongTableViewCell.h"
#import "ProductSTableViewCell.h"
#import "AFNetworking.h"
#import "Toast+UIView.h"
@interface ShangJiaShangDianViewController ()
@property (nonatomic, strong) UIView *alertView;

@end

@implementation ShangJiaShangDianViewController
-(id)initWithStoreID:(NSString *)stre{
    self =[super init];
    if (self) {
        StoreID = stre;
        
    }
    return self;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =BackColor;
    DataArr =[[NSMutableArray alloc]init];
    [self creaData];
    UIButton *BackBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    BackBtn.frame =CGRectMake(0, 0, 64, 27);
    [BackBtn  setBackgroundImage:[UIImage imageNamed:@"app_fanhui"] forState:UIControlStateNormal];
    // [BackBtn setTitle:@"返回" forState:UIControlStateNormal];
    [BackBtn addTarget:self action:@selector(BackAction)  forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem =[[UIBarButtonItem alloc]initWithCustomView:BackBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    self.navigationItem.title=@"商家的商店";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];

    [self.view addSubview:self.alertView];
       // Do any additional setup after loading the view.
}
-(void)creaData{
    [self.view makeToastActivity];
    NSString *ShouY = [NSString stringWithFormat:ShangJiaStore,StoreID,1];
    //(@"%@",ShouY);
    ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.view hideToastActivity];
        if ([responseObject[@"msg"] isEqualToString:@"没有数据"]) {
            self.alertView.hidden = NO;
        }else{
            
            
            DataArr = [responseObject objectForKey:@"goods"];
            [self makeUI];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.view hideToastActivity];
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [failAlView show];
        //(@"cook load failed ,%@",error);
    }];
}

-(void)makeUI{
    self.view.backgroundColor =BackColor;
    
    _tv  =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, ConentViewHeight) style:UITableViewStylePlain];
    if(DataArr.count < 6){
    
        _tv.frame =CGRectMake(0, 0, ConentViewWidth, 88*DataArr.count);
     }
    _tv.delegate  = self;
    _tv.dataSource= self;
    [self.view addSubview:_tv];

   
}
-(void)BackAction{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ProductDetailViewController *pvc =[[ProductDetailViewController alloc]initWithStr:[NSString stringWithFormat:@"%@",[DataArr[indexPath.row] objectForKey:@"goods_id"]]];
    pvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:pvc animated:YES];
    
    
}
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  DataArr.count;
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 88;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ProductSTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell ==nil) {
        cell =[[[NSBundle mainBundle]loadNibNamed:@"ProductSTableViewCell" owner:self options:nil]lastObject];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    [cell makeProductDic:DataArr[indexPath.row]];
    return cell;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)alertView{
    if (!_alertView) {
        _alertView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 300, 300)];
        _alertView.center = self.view.center;
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"list_load_notice_normal"]];
        imageView.size = CGSizeMake(90, 90);
        imageView.centerX = _alertView.centerX;
        imageView.y = 20;
        [_alertView addSubview:imageView];
        UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 300, 300)];
        titleLable.text = @"没搜索到匹配数据";
        [titleLable sizeToFit];
        titleLable.textAlignment = NSTextAlignmentCenter;
        titleLable.centerX = _alertView.centerX;
        
        titleLable.y = CGRectGetMaxY(imageView.frame) + 30;
        
        
        [_alertView addSubview:titleLable];
        _alertView.hidden = YES;
        
    }
    return _alertView;
}

@end
