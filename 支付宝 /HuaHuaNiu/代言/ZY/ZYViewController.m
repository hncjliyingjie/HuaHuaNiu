//
//  ZYViewController.m
//  HuaHuaNiu
//
//  Created by mac on 16/11/5.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "ZYViewController.h"

#import "ZYTableViewCell.h"

#import "ZYMViewController.h"
#import "ZYDetailViewController.h"
#import "ZY_DataModel.h"
#import "Toast+UIView.h"
#import "MJRefresh.h"

@interface ZYViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UIView *searchView;//搜索框view

@property (weak, nonatomic) IBOutlet UIView *sxLineView;//筛选线条框

@property (weak, nonatomic) IBOutlet UITableView *zyTableView;//资源数据列表

@property(strong,nonatomic)NSMutableArray *dataArray;

@property double labelHeight;//简介高度

@property (assign,nonatomic) int page;//当前页

@property (nonatomic,assign)int totalPage;//总页数

@property (weak, nonatomic) IBOutlet UIButton *HWButton;
@property (weak, nonatomic) IBOutlet UIButton *WLButton;
@property (weak, nonatomic) IBOutlet UIButton *DSButton;
@property (weak, nonatomic) IBOutlet UIButton *BZButton;
@property (weak, nonatomic) IBOutlet UIButton *GBButton;
//李英杰添加
@property (nonatomic, strong) NSDictionary *infoDic;//筛选条件字典
@property (nonatomic, strong) NSString *type;//记录是户外/网络/电视/报纸/广播的哪一个
@property (weak, nonatomic) IBOutlet UIView *mySxButtonView;

@end

@implementation ZYViewController
//懒加载
- (NSDictionary *)infoDic {
    if (_infoDic == nil) {
        _infoDic = [NSDictionary dictionaryWithObjectsAndKeys:@"", @"fans", @"", @"price", @"", @"province_id", @"", @"city_id", @"", @"profession", nil];
        
    }
    return _infoDic;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.zySXButton = [YJButton buttonWithType:UIButtonTypeCustom];
    [self.zySXButton setImage:[UIImage imageNamed:@"shaixuan"] forState:UIControlStateNormal];
    [self.zySXButton setTitle:@"" forState:UIControlStateNormal];
    self.zySXButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.zySXButton setTitleColor:MainCorlor forState:UIControlStateNormal];
    self.zySXButton.imageRect = CGRectMake(0, 0, 49.5, 30);
    self.zySXButton.titleRect = CGRectMake(0, 10, 0, 0);
    [self.mySxButtonView addSubview:self.zySXButton];
    self.zySXButton.frame = CGRectMake(5, 0, 49.5, 30);
    self.zySXButton.backgroundColor = [UIColor whiteColor];
    
    self.zyTableView.delegate=self;
    self.zyTableView.dataSource=self;
    
    self.zyTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    
    [self viewWithStyle];
    
    _dataArray=[NSMutableArray array];
    
    self.type = @"0";//默认是户外
    [self.HWButton setTitleColor:MainCorlor forState:UIControlStateNormal];
    
    [self.zyTableView addHeaderWithTarget:self action:@selector(refresh)];
    [self.zyTableView addFooterWithTarget:self action:@selector(loadMore)];
    self.page = 1;
    self.totalPage = 1;
    
    [self requestMainData];//请求数据
    //添加通知中心观察者,当点击筛选界面确认按钮时,立即进行数据请求
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestDataWithSX:) name:@"SXDone" object:@"SXView"];
}
//点击筛选界面确认按钮后执行的方法
- (void)requestDataWithSX:(NSNotification *)info {
    KMyLog(@"点击确认了!%@", info);
    NSDictionary *dic = info.userInfo;
    NSString *city_id = [dic objectForKey:@"city_id"];
    NSString *fans = [dic objectForKey:@"fans"];
    NSString *price = [dic objectForKey:@"price"];
    NSString *profession = [dic objectForKey:@"profession"];
    NSString *province_id = [dic objectForKey:@"province_id"];
    if ([city_id isEqualToString:@"(null)"]) {
        city_id = @"";
    }
    if ([fans isEqualToString:@"(null)"]) {
        fans = @"";
    }
    if ([price isEqualToString:@"(null)"]) {
        price = @"";
    }
    if ([profession isEqualToString:@"(null)"]) {
        profession = @"";
    }
    if ([province_id isEqualToString:@"(null)"]) {
        province_id = @"";
    }
    self.infoDic = [NSDictionary dictionaryWithObjectsAndKeys:fans, @"fans", price, @"price", province_id, @"province_id", city_id, @"city_id", profession, @"profession", nil];
    [self requestMainData];//重新请求数据
}
//下拉刷新
-(void)refresh
{
    self.page = 1;
    [self requestData:_page];
}

//上拉刷新后进入这里
-(void)loadMore
{
    if (self.page + 1 <= _totalPage) {
        [self requestData:self.page+1];
        self.page += 1;
    }
    else {
        [self.zyTableView footerEndRefreshing];
    }
}

-(void)requestData:(int)page
{
    NSString *str=self.textField.text;
    
    NSString * ShouY = [NSString stringWithFormat:@"%@%@%@",DYUrl,ZYLISTURL,str];
    
    NSString* link = [NSString stringWithFormat:@"%@&page=%d",ShouY,_page];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:link parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self didFinishRequestData:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self didFinishRequestData:nil];
    }];
}

-(void)didFinishRequestData:(NSDictionary*)dic
{
    [self.zyTableView headerEndRefreshing];
    if (dic == nil) {
        NSLog(@"请求失败");
        //此处可弹框显示无法连接
        return;
    }
    self.totalPage = [dic[@"totalPage"] intValue];
    
    if (_dataArray == nil) {
        self.dataArray = [[NSMutableArray alloc]init];
    }
    
    if (_page == 1) {
        [_dataArray removeAllObjects];
    }
    
    NSArray* array = dic[@"resource"];
    for (NSDictionary* dic in array) {
        //评论数
        NSString *pinglunStr=[dic objectForKey:@"discuss_num"];
        //广告名称
        NSString *nameStr=[dic objectForKey:@"name"];
        //浏览
        NSString *liulanStr=[dic objectForKey:@"scan_num"];
        //广告内容
        NSString *filesStr=[dic objectForKey:@"profiles"];
        //点击的id
        NSString *idStr=[dic objectForKey:@"id"];
        //图片
        NSString *urlStr=[dic objectForKey:@"head"];
        NSMutableString *url=[NSMutableString stringWithFormat:DYListUrl,DYSTRRING, urlStr];
        UIImage *imgs=[self getImageFromURL:url];
        
        ZY_DataModel *model=[[ZY_DataModel alloc]init];
        model.nameStr=nameStr;
        model.liulanStr=liulanStr;
        model.filesStr=filesStr;
        model.idStr=idStr;
        model.pinglunStr=pinglunStr;
        model.headImg=imgs;
        
        [_dataArray addObject:model];
    }
    [self.zyTableView footerEndRefreshing];
}


-(void)requestMainData {
    
    [self.view makeToastActivity];//加载菊花
    [_dataArray removeAllObjects];//移除所有数据
    NSString *textStr=self.textField.text;//搜索框内容
    
    NSDictionary *dic = self.infoDic;//接收筛选字典
    NSString *city_id = [dic objectForKey:@"city_id"];
    NSString *fans = [dic objectForKey:@"fans"];
    NSString *price = [dic objectForKey:@"price"];
    NSString *profession = [dic objectForKey:@"profession"];
    NSString *province_id = [dic objectForKey:@"province_id"];
    //获取用户id
    NSUserDefaults *defau = [NSUserDefaults standardUserDefaults];
    NSString *userId = [defau objectForKey:@"Useid"];
    KMyLog(@"用户ID:%@", userId);
    if ([userId isEqualToString:@""]) {
        KMyLog(@"没有登录!");
        return;
    }
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@token=test&member_id=%@&type=%@&page=0&price=%@&name=%@&province_id=%@&city_id=%@&profession=%@", DYUrl, ZYMainURL, userId, self.type, price, textStr, province_id, city_id, profession];
    
    NSString *urlStringUTF8 = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    
    [manager GET:urlStringUTF8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self.view hideToastActivity];
        
        KMyLog(@"资源列表返回数据%@",responseObject);
        //
        NSMutableArray *array=[responseObject objectForKey:@"resource"];
        for (int  i=0; i<array.count; i++) {
            NSDictionary *dic=[array objectAtIndex:i];
            //评论数
            NSString *pinglunStr=[dic objectForKey:@"discuss_num"];
            //广告名称
            NSString *nameStr=[dic objectForKey:@"name"];
            //浏览
            NSString *liulanStr=[dic objectForKey:@"scan_num"];
            //广告内容
            NSString *filesStr=[dic objectForKey:@"profiles"];
            //点击的id
            NSString *idStr=[dic objectForKey:@"id"];
            //图片
            NSString *urlStr=[dic objectForKey:@"head"];
            NSMutableString *url=[NSMutableString stringWithFormat:@"%@/%@", DYUrl, urlStr];
            UIImage *imgs=[self getImageFromURL:url];
            
            ZY_DataModel *model=[[ZY_DataModel alloc]init];
            model.nameStr=nameStr;
            model.liulanStr=liulanStr;
            model.filesStr=filesStr;
            model.idStr=idStr;
            model.pinglunStr=pinglunStr;
            model.headImg=imgs;
            
            [_dataArray addObject:model];
            
        }
        KMyLog(@"获取到的数据为---------------：%@",array);
        [self.zyTableView reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self.view hideToastActivity];
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [failAlView show];
        
        
        
    }];
    
    
}
-(UIImage *) getImageFromURL:(NSString *)fileURL
{
    UIImage * result;
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    return result;
}
-(void)viewWithStyle{
    //筛选外面的线条框
    _sxLineView.layer.cornerRadius=5;
    _sxLineView.layer.borderWidth=1;
    _sxLineView.layer.borderColor=[[UIColor colorWithRed:0.047 green:0.365 blue:0.663 alpha:1]CGColor];
    self.textField.delegate=self;
    self.textField.returnKeyType=UIReturnKeySearch;
    _searchView.layer.cornerRadius=5;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 170+_labelHeight;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    ZYTableViewCell *cell;
    cell=[tableView dequeueReusableCellWithIdentifier:@"ZYTableViewCell1"];
    if(cell==nil){
        cell=[[[NSBundle mainBundle]loadNibNamed:@"ZYTableViewCell" owner:self options:nil]objectAtIndex:1];
        
    }
    ZY_DataModel *nowModel=[_dataArray objectAtIndex:indexPath.row];
    [cell setCellWithZYData:nowModel];
    
    //简介自适应高度
    cell.frofiesLbl.numberOfLines = 0;
    
    cell.frofiesLbl.lineBreakMode = NSLineBreakByWordWrapping;
    
    CGSize size = [cell.frofiesLbl sizeThatFits:CGSizeMake(cell.frofiesLbl.frame.size.width, MAXFLOAT)];
    
    //    cell.frofiesLbl.font = [UIFont systemFontOfSize:13];
    
    cell.forfielsHeight.constant=size.height;
    
    _labelHeight=size.height;
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZY_DataModel *nowModel=[_dataArray objectAtIndex:indexPath.row];
    NSString *idStr=nowModel.idStr;
    /**
     跳转到旧资源详情
    ZYMViewController *vc=[[ZYMViewController alloc]initWithIdStr:idStr];
    vc.hidesBottomBarWhenPushed=YES;
     */
    //跳转到新资源详情
    ZYDetailViewController *ZYDetailVC = [[ZYDetailViewController alloc] initWithNibName:@"ZYDetailViewController" bundle:[NSBundle mainBundle]];
    ZYDetailVC.hidesBottomBarWhenPushed = YES;
    ZYDetailVC.idStr = nowModel.idStr;
    [self.navigationController pushViewController:ZYDetailVC animated:YES];
    
}

#pragma mark  UITextViewDelegate
//点击键盘搜索按钮
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    //搜索永远都是户外的
    [self requestMainData];
    [self.textField resignFirstResponder];
    
    return YES;
    
}


- (IBAction)HWButtonAction:(UIButton *)sender {
    [self buttonTitleCorlorChangeToBlack];
    [sender setTitleColor:MainCorlor forState:UIControlStateNormal];
    self.type = @"0";
    [self requestMainData];
}
- (IBAction)WLButtonAction:(UIButton *)sender {
    [self buttonTitleCorlorChangeToBlack];
    [sender setTitleColor:MainCorlor forState:UIControlStateNormal];
    self.type = @"1";
    [self requestMainData];
    
}
- (IBAction)DSButtonAction:(UIButton *)sender {
    [self buttonTitleCorlorChangeToBlack];
    [sender setTitleColor:MainCorlor forState:UIControlStateNormal];
    self.type = @"2";
    [self requestMainData];
}
- (IBAction)BZButtonAction:(UIButton *)sender {
    [self buttonTitleCorlorChangeToBlack];
    [sender setTitleColor:MainCorlor forState:UIControlStateNormal];
    self.type = @"3";
    [self requestMainData];
}
- (IBAction)GBButtonAction:(UIButton *)sender {
    [self buttonTitleCorlorChangeToBlack];
    [sender setTitleColor:MainCorlor forState:UIControlStateNormal];
    self.type = @"4";
    [self requestMainData];
}
//将标题的字体颜色全部恢复
- (void)buttonTitleCorlorChangeToBlack {
    
    [self.HWButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.WLButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.DSButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.BZButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.GBButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}












@end
