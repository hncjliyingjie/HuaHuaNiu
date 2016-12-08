//
//  DYViewController.m
//  HuaHuaNiu
//
//  Created by mac on 16/11/4.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "DYViewController.h"
#import "DYTableViewCell.h"
#import "ZYTModel.h"
#import "ZTMoreViewController.h"
#import "Toast+UIView.h"
#import "MJRefresh.h"

@interface DYViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UIView *searchView;
//搜索框

@property (weak, nonatomic) IBOutlet UITableView *dyTableView;//数据列表

@property (strong,nonatomic) NSMutableArray *dataArr;//列表数据源

@property(strong,nonatomic)NSString *listId;//自媒体页面的ID值

@property (weak, nonatomic) IBOutlet UITextField *textField;//搜索输入框

@property (nonatomic) BOOL refreshing;

@property (assign,nonatomic) int page;//当前页

@property (nonatomic,assign)int totalPage;//总页数
@property (nonatomic, strong) NSDictionary *infoDic;//筛选条件字典
@property (nonatomic, strong) NSString *type;//记录是朋友圈/QQ空间/微博/公众号/直播类别

@property (weak, nonatomic) IBOutlet UIButton *WXButton;
@property (weak, nonatomic) IBOutlet UIButton *QQButton;
@property (weak, nonatomic) IBOutlet UIButton *WBButton;
@property (weak, nonatomic) IBOutlet UIButton *GZHButton;
@property (weak, nonatomic) IBOutlet UIButton *ZBButton;

@end

@implementation DYViewController

- (NSDictionary *)infoDic {
    if (_infoDic == nil) {
        _infoDic = [NSDictionary dictionaryWithObjectsAndKeys:@"", @"fans", @"", @"price", @"", @"province_id", @"", @"city_id", @"", @"profession", nil];
        
    }
    return _infoDic;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self viewWithStyle];
    
    [self requestMainData];//请求数据
    self.type = @"0";
    [self.WXButton setTitleColor:MainCorlor forState:UIControlStateNormal];
    
    //[self setupRefresh];
    
    [self.dyTableView addHeaderWithTarget:self action:@selector(refresh)];
    [self.dyTableView addFooterWithTarget:self action:@selector(loadMore)];
    self.page = 1;
    self.totalPage = 1;
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
        [self.dyTableView footerEndRefreshing];
    }
}

-(void)requestData:(int)page
{
    NSString* link = [NSString stringWithFormat:@"http://101.200.90.192:8180/dyc/appwemedia/wemediaList.do?token=test&member_id=1&type=0&page=%d",_page];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:link parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self didFinishRequestData:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self didFinishRequestData:nil];
    }];
}

-(void)didFinishRequestData:(NSDictionary*)dic
{
    [self.dyTableView headerEndRefreshing];
    if (dic == nil) {
        NSLog(@"请求失败");
        //此处可弹框显示无法连接
        return;
    }
    self.totalPage = [dic[@"totalPage"] intValue];
    
    if (_dataArr == nil) {
        self.dataArr = [[NSMutableArray alloc]init];
    }
    
    if (_page == 1) {
        [_dataArr removeAllObjects];
    }
    
    NSArray* array = dic[@"medias"];
    for (NSDictionary* dic in array) {
        NSString *nameStr=[dic objectForKey:@"name"];
        NSString *friendStr=[dic objectForKey:@"friends_num"];
        NSString *priceStr=[dic objectForKey:@"out_price"];
        NSString *collectStr=[dic objectForKey:@"collect_num"];
        NSString *idStr=[dic objectForKey:@"id"];
        
       //判断图像头部有没有http
        NSString *urlStr=[dic objectForKey:@"head"];
        NSString *str=@"http://";
        //代言城返回的图片
        NSString *headUrl=[NSString stringWithFormat:@"http://101.200.90.192:8090/%@",urlStr];
        
        NSString *url;
        if ([urlStr rangeOfString:str].location!=NSNotFound)
        {
            url=urlStr;
        }
        else
        {
            url=headUrl;
            
        }

//        NSMutableString *url=[NSMutableString stringWithFormat:DYListUrl,DYSTRRING, urlStr];
        
        UIImage *imgs=[self getImageFromURL:url];
        
        ZYTModel *model=[[ZYTModel alloc]init];
        model.name=nameStr;
        model.friendNumber=friendStr;
        model.price=priceStr;
        model.collect=collectStr;
        model.img=imgs;
        model.listId=idStr;
        
        [_dataArr addObject:model];
        [self.dyTableView reloadData];
    }
    [self.dyTableView footerEndRefreshing];
}

//点击键盘搜索按钮
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self requestMainData];
    [self.textField resignFirstResponder];
    
    return YES;
    
}
-(void)setupRefresh
{
    //1.添加刷新控件
    UIRefreshControl *control=[[UIRefreshControl alloc]init];
    [control addTarget:self action:@selector(refreshStateChange:) forControlEvents:UIControlEventValueChanged];
    [self.dyTableView addSubview:control];
    
    //2.马上进入刷新状态，并不会触发UIControlEventValueChanged事件
    [control beginRefreshing];
    
    // 3.加载数据
    [self refreshStateChange:control];
}

/**
 *  UIRefreshControl进入刷新状态：加载最新的数据
 */
-(void)refreshStateChange:(UIRefreshControl *)control
{
    // 3.发送请求
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    [mgr GET:@"http://101.200.90.192:8180/dyc/appwemedia/wemediaList.do?token=test&member_id=1&type=0" parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject){
        
        //2.刷新表格
        [self.dyTableView reloadData];
        
        // 3. 结束刷新
        [control endRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // 结束刷新刷新 ，为了避免网络加载失败，一直显示刷新状态的错误
        [control endRefreshing];
    }];
}

-(void)viewWithStyle{
    
    _dataArr = [NSMutableArray array];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.dyTableView.delegate=self;
    self.dyTableView.dataSource=self;
    //筛选框
    _searchView.layer.cornerRadius=5;
    
    self.textField.returnKeyType=UIReturnKeySearch;
    self.textField.delegate=self;
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DYTableViewCell *cell;
    cell=[tableView dequeueReusableCellWithIdentifier:@"DYcell"];
    if(cell==nil){
        cell=[[[NSBundle mainBundle]loadNibNamed:@"DYTableViewCell" owner:self options:nil]firstObject];
    }
    
    ZYTModel *nowModel=[_dataArr objectAtIndex:indexPath.row];
    [cell setCellWithData:nowModel];
    _listId=nowModel.listId;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.collectBlock = ^() {
        [self updateCollectionWithMediaID:nowModel.listId];
            };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZYTModel *model=[self.dataArr objectAtIndex:indexPath.row];
    ZTMoreViewController *vc=[[ZTMoreViewController alloc]initWithListId:model.listId];
    vc.hidesBottomBarWhenPushed=YES;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}
#pragma mark 网络请求
//自媒体界面获取数据
-(void)requestMainData {
    
    [self.view makeToastActivity];//加载菊花
    [_dataArr removeAllObjects];//移除所有内容
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
    NSString *urlStr = [NSString stringWithFormat:@"%@%@token=test&member_id=%@&type=%@&page=0&fans=%@&price=%@&name=%@&province_id=%@&city_id=%@&profession=%@", DYUrl, ZMTMainURL, userId, self.type, fans, price, textStr, province_id, city_id, profession];
    
    NSURL *url=[NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];// UTF－8
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    
    // 请求数据，设置成功与失败的回调函数
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.view hideToastActivity];
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        id dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        KMyLog(@"获取到的数据为：%@",dict);
        NSArray *array=[dict objectForKey:@"medias"];
        KMyLog(@"获取到的数据为---------------：%@",array);
              for (int i=0; i<array.count; i++) {
            NSDictionary *dic=[array objectAtIndex:i];
            NSString *nameStr=[dic objectForKey:@"name"];
            NSString *friendStr=[dic objectForKey:@"friends_num"];
            NSString *priceStr=[dic objectForKey:@"out_price"];
            NSString *collectStr=[dic objectForKey:@"collect_num"];
            NSString *idStr=[dic objectForKey:@"id"];
            
            //判断图像头部有没有http
            NSString *urlStr=[dic objectForKey:@"head"];
            NSString *str=@"http://";
            //代言城返回的图片
            NSString *headUrl=[NSString stringWithFormat:@"http://101.200.90.192:8090/dyc/%@",urlStr];
    
            NSString *url;
            if ([urlStr rangeOfString:str].location!=NSNotFound)
            {
                url=urlStr;
            }
            else
            {
                url=headUrl;
            
            }
//            NSMutableString *url=[NSMutableString stringWithFormat:DYListUrl,DYSTRRING, urlStr];
            NSLog(@"图片网址++++++++%@",url);
            
            UIImage *imgs=[self getImageFromURL:url];
            
            ZYTModel *model=[[ZYTModel alloc]init];
            model.name=nameStr;
            model.friendNumber=friendStr;
            model.price=priceStr;
            model.collect=collectStr;
            model.img=imgs;
            model.listId=idStr;
            
            [_dataArr addObject:model];
          
        }
        [self.dyTableView reloadData];
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.view hideToastActivity];
        NSLog(@"发生错误！******************%@",error);
    }];
    // 加入队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
}

-(UIImage *) getImageFromURL:(NSString *)fileURL
{
    UIImage * result;
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    return result;
}
//朋友圈
- (IBAction)WXButtonAction:(UIButton *)sender {
    [self buttonTitleCorlorChangeToBlack];
    self.type = @"0";
    [self requestMainData];
    [sender setTitleColor:MainCorlor forState:UIControlStateNormal];
}
//QQ空间
- (IBAction)QQButtonAction:(UIButton *)sender {
    [self buttonTitleCorlorChangeToBlack];
    self.type = @"1";
    [self requestMainData];
    [sender setTitleColor:MainCorlor forState:UIControlStateNormal];
}
//微博
- (IBAction)WBButtonAction:(UIButton *)sender {
    [self buttonTitleCorlorChangeToBlack];
    self.type = @"2";
    [self requestMainData];
    [sender setTitleColor:MainCorlor forState:UIControlStateNormal];
}
//公众号
- (IBAction)GZHButtonAction:(UIButton *)sender {
    [self buttonTitleCorlorChangeToBlack];
    self.type = @"3";
    [self requestMainData];
    [sender setTitleColor:MainCorlor forState:UIControlStateNormal];
}
//直播
- (IBAction)ZBButtonAction:(UIButton *)sender {
    [self buttonTitleCorlorChangeToBlack];
    self.type = @"4";
    [self requestMainData];
    [sender setTitleColor:MainCorlor forState:UIControlStateNormal];
}
- (void)buttonTitleCorlorChangeToBlack {
    
    [self.WXButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.QQButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.WBButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.GZHButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.ZBButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

//点击收藏,发到后台进行加一
- (void)updateCollectionWithMediaID:(NSString *)media_id {
    NSUserDefaults *defau = [NSUserDefaults standardUserDefaults];
    NSString *userId = [defau objectForKey:@"Useid"];
    KMyLog(@"用户ID:%@", userId);
    if ([userId isEqualToString:@""]) {
        KMyLog(@"没有登录!");
        return;
    }
    NSString *colleUrl = [NSString stringWithFormat:@"%@%@token=test&media_id=%@&user_id=%@&type=%@", DYUrl, KDYCollectionURL, media_id, userId, self.type];
    KMyLog(@"请求地址:%@", colleUrl);
    [[RequestManger share] requestDataByGetWithPath:colleUrl complete:^(NSDictionary *data) {
        KMyLog(@"%@",data);
    }];

}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SXDone" object:@"SXView"];
}

@end
