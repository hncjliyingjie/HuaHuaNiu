//
//  ZTMoreViewController.m
//  HuaHuaNiu
//
//  Created by mac on 16/11/6.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "ZTMoreViewController.h"
#import "ZTMoreCell.h"
#import "Toast+UIView.h"
#import "ZMTDetailModel.h"
#import "ZaJinDanViewController.h"
#import "ZMTFreebackViewController.h"
//友盟分享
#import "UMSocial.h"
#import "CoreUMeng.h"
#import "ARSViewController.h"

@interface ZTMoreViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong,nonatomic)NSString *idStr;//自媒体列表页传过来的id,区分点击的哪一行
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;//昵称
@property (weak, nonatomic) IBOutlet UIImageView *headView;//头像
@property (weak, nonatomic) IBOutlet UILabel *jiedanshuLbl;//接单数
@property (weak, nonatomic) IBOutlet UILabel *friendLbl;//好友数
@property (weak, nonatomic) IBOutlet UILabel *finshLbl;//接单完成率
@property (weak, nonatomic) IBOutlet UILabel *priceLbl;//广告价
@property (weak, nonatomic) IBOutlet UILabel *liulanshuLbl;//评分
@property (weak, nonatomic) IBOutlet UILabel *zhiyeTopLbl;//第一栏的基本资料
@property (weak, nonatomic) IBOutlet UILabel *zhiyeBottomLbl;//第二栏的基本资料

@property (weak, nonatomic) IBOutlet UIView *XXDSView;
@property (weak, nonatomic) IBOutlet UIImageView *listImgView;//恭喜**成为代言人前的头像
//李英杰添加
@property (weak, nonatomic) IBOutlet UILabel *XXDSLabel;//恭喜成为形象大使的内容
@property (nonatomic, strong) NSMutableArray *freeBackArray;//评论数据源
@property (nonatomic, assign) BOOL canZJD;//是否已经成为形象大使
@property (weak, nonatomic) IBOutlet UIView *feedbackMoreView;//评价-更多视图

@property (weak, nonatomic) IBOutlet UILabel *feedbackCountLabel;//评价的个数


@end

@implementation ZTMoreViewController
//懒加载
- (NSMutableArray *)freeBackArray {
    if (_freeBackArray == nil) {
        _freeBackArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _freeBackArray;
}
-(ZTMoreViewController *)initWithListId:(NSString *)str{
    _idStr=str;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"自媒体详情";
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.tableFooterView = [UIView new];
    
    //给形象大使添加砸金蛋手势
    UITapGestureRecognizer *ZJDTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ZJDAction:)];
    [self.XXDSView addGestureRecognizer:ZJDTap];
    self.canZJD = YES;
    //给评价-更多界面添加手势
    UITapGestureRecognizer *moreTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(feedbackMoreAction:)];
    [self.feedbackMoreView addGestureRecognizer:moreTap];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:0.047 green:0.365 blue:0.663 alpha:1],NSForegroundColorAttributeName,nil]];
    
    //自定义返回按钮
    UIImage *backButtonImage = [[UIImage imageNamed:@"back_new"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    //将返回按钮的文字position设置不在屏幕上显示
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
    
    [self makeData];
}

//砸金蛋手势
- (void)ZJDAction:(UITapGestureRecognizer *)tap {
    if (_canZJD) {
        ZaJinDanViewController * zvc =[[ZaJinDanViewController alloc]init];
        zvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:zvc animated:YES];
    }
}
//评价-更多点击手势
- (void)feedbackMoreAction:(UITapGestureRecognizer *)tap {
    KMyLog(@"更多评价内容");
    ZMTFreebackViewController *freebackVC = [[ZMTFreebackViewController alloc] initWithNibName:@"ZMTFreebackViewController" bundle:[NSBundle mainBundle]];
    freebackVC.dataSource = self.freeBackArray;
    [self.navigationController pushViewController:freebackVC animated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
        return self.freeBackArray.count;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 82;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZTMoreCell *cell;
    cell=[tableView dequeueReusableCellWithIdentifier:@"ZTMoreCell"];
    if(cell==nil){
            cell=[[[NSBundle mainBundle]loadNibNamed:@"ZTMoreCell" owner:self options:nil]objectAtIndex:0];
            
        }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [cell showDataWithModel:self.freeBackArray[indexPath.row]];
    return cell;
    
}

//请求数据
-(void)makeData{
    
    NSString * ShouY = [NSString stringWithFormat:@"%@%@%@",DYUrl,ZMTMOREURL,_idStr];
    
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    
    [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"自媒体详情返回数据%@",responseObject);
        //评论数据
        [self.freeBackArray removeAllObjects];
        NSArray *freebackArr = [responseObject objectForKey:@"feedback"];
        for (NSDictionary *dic in freebackArr) {
            KMyLog(@"评论数据:%@", dic);
            ZMTDetailModel *freebackMod = [[ZMTDetailModel alloc] init];
            freebackMod.feedback = [dic objectForKey:@"feedback"];
            freebackMod.finish_time = [dic objectForKey:@"finish_time"];
            freebackMod.head = [dic objectForKey:@"head"];
            freebackMod.freeBack_id = [dic objectForKey:@"id"];
            freebackMod.score = [dic objectForKey:@"score"];
            KMyLog(@"评分:%@", freebackMod.score);
            [self.freeBackArray addObject:freebackMod];
        }
        //设置评论头信息
        self.feedbackCountLabel.text = [NSString stringWithFormat:@"Ta的评价(%ld)", self.freeBackArray.count];
        //用户详细信息
        NSDictionary *array=[responseObject objectForKey:@"media"];
        NSLog(@"获取到的数据为---------------：%@",array);
        //名字
        NSString *nameStr=[array objectForKey:@"name"];
        //年龄
        NSString *ageStr = [array objectForKey:@"age"];
        //接单数
        NSString *jiedanStr=[array objectForKey:@"task_num"];
        //好友数
        NSString *friendStr=[array objectForKey:@"friends_num"];
        //广告价
        NSString *priceStr=[array objectForKey:@"out_price"];
        //平均分
        NSString *pingfenStr=[array objectForKey:@"avgScore"];
        //完成数
        NSString *wanchengshuStr=[array objectForKey:@"finish_num"];
        //主头像
        NSString *headStr=[array objectForKey:@"head"];
        //恭喜***成为代言人的小头像
        NSString *listImageStr=[array objectForKey:@"represent"];
        //职业
        NSString *professionStr=[array objectForKey:@"profession"];
        //省名字
        NSString *provinceName = [array objectForKey:@"provinceName"];
        //城市
        NSString *cityStr=[array objectForKey:@"cityName"];
        //学历
        NSString *gradeStr = [array objectForKey:@"grade"];
        //是否认证
        NSString *stateStr;
        NSString *state=[array objectForKey:@"state"];
        switch ([state integerValue]) {
            case 0:
                stateStr = @"待审核";
                break;
            case 1:
                stateStr = @"已审核";
                break;
            case 2:
                stateStr = @"审核未通过";
                break;
            case 3:
                stateStr = @"未认证";
                break;
            default:
                break;
        }
        //接单完成率
        NSString *finishRateStr;
        if ([jiedanStr integerValue] == 0) {
            finishRateStr = @"0";
        } else {
            CGFloat finishRate = ([wanchengshuStr integerValue] / [jiedanStr integerValue]);
            finishRateStr = [NSString stringWithFormat:@"%.0f", (finishRate * 100)];
        }
        //头像给的是网址，需要转化
        UIImage *headimg=[self getImageFromURL:headStr];
        
        //恭喜**成为代言人前的头像
        NSMutableString *listImgUrl = [NSMutableString stringWithFormat:@"%@/%@", DYUrl, listImageStr];
        UIImage *listImg = [self getImageFromURL:listImgUrl];
        
        //赋值
        self.nameLbl.text=nameStr;
        self.jiedanshuLbl.text=[NSString stringWithFormat:@"%@",jiedanStr];
        self.friendLbl.text=[NSString stringWithFormat:@"%@",friendStr];
        self.priceLbl.text=[NSString stringWithFormat:@"%@",priceStr];
        self.finshLbl.text=[NSString stringWithFormat:@"%@%%",finishRateStr];
        self.liulanshuLbl.text=[NSString stringWithFormat:@"%@",pingfenStr];
        self.zhiyeTopLbl.text=[NSString stringWithFormat:@"%@ %@ | %@",provinceName, cityStr, professionStr];
        self.zhiyeBottomLbl.text=[NSString stringWithFormat:@"%@ | %@ | %@",ageStr, gradeStr, stateStr];
        self.XXDSLabel.text = [NSString stringWithFormat:@"恭喜%@成为形象大使", nameStr];
        self.headView.image = headimg;
        self.listImgView.image = listImg;
        
        
        [self.view hideToastActivity];
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
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
//收藏按钮
- (IBAction)collectAction:(UIButton *)sender {
    NSUserDefaults *defau = [NSUserDefaults standardUserDefaults];
    NSString *userId = [defau objectForKey:@"Useid"];
    KMyLog(@"用户ID:%@", userId);
    if ([userId isEqualToString:@""]) {
        KMyLog(@"没有登录!");
        return;
    }
    //收藏地址中 type=0
    NSString *colleUrl = [NSString stringWithFormat:@"%@%@token=test&media_id=%@&user_id=%@&type=0", DYUrl, KDYCollectionURL, _idStr, userId];
    
    [[RequestManger share] requestDataByGetWithPath:colleUrl complete:^(NSDictionary *data) {
        NSString *infoStr = [data objectForKey:@"msg"];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"收藏" message:infoStr delegate:self cancelButtonTitle:@"朕知道了" otherButtonTitles:nil, nil];
        [alertView show];
    }];
    
}
//分享按钮
- (IBAction)shareAction:(UIButton *)sender {
    KMyLog(@"分享");
    
    NSString * ShareStr =[NSString stringWithFormat:@"www.baidu.com"];
    //李英杰分享了
    NSString * concentStr =[NSString stringWithFormat:@"代言城"];
    //_imgTitle.image
    [CoreUmengShare show:self text:concentStr image:[UIImage imageNamed:@"Default"]];
    //                                           delegate:nil];
    [UMSocialData defaultData].extConfig.wechatSessionData.url = ShareStr;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url =ShareStr;
    
    [UMSocialData defaultData].extConfig.qqData.url = ShareStr;
    [UMSocialData defaultData].extConfig.qzoneData.url = ShareStr;
    
    NSString *ProductName = @"#笨笨鸟#";
    [UMSocialData defaultData].extConfig.wechatSessionData.title = ProductName;
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = ProductName;
    [UMSocialData defaultData].extConfig.qqData.title = ProductName;
    [UMSocialData defaultData].extConfig.qzoneData.title = ProductName;
}
//客服按钮
- (IBAction)customerSeriviceAction:(UIButton *)sender {
}
//购物车
- (IBAction)buyCarAction:(UIButton *)sender {
    NSString *userID = [[UserDefaultManager shareUserDefaultManager] getUid];
    NSString *urlStr = [NSString stringWithFormat:KZMTBuyCarURL, DYUrl, @"test", _idStr, userID];
    [[RequestManger share] requestDataByGetWithPath:urlStr complete:^(NSDictionary *data) {
        NSString *infoStr = [data objectForKey:@"msg"];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"加入购物车" message:infoStr delegate:self cancelButtonTitle:@"朕知道了" otherButtonTitles:nil, nil];
        [alertView show];
    }];
    
}
//去派单
- (IBAction)sendOrderAction:(UIButton *)sender {
    ARSViewController *ajdVC=[[ARSViewController alloc]init];
    ajdVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:ajdVC animated:YES];
}


@end
