//
//  QDXDViewController.m
//  HuaHuaNiu
//
//  Created by mac on 16/11/12.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "QDXDViewController.h"
#import "DDZFViewController.h"
#import "ModelToJson.h"
#import "MyData.h"
#import "NewModel.h"
#import "OederModel.h"
#import "MediaModel.h"
#import "Toast+UIView.h"

@interface QDXDViewController ()
@property (weak, nonatomic) IBOutlet UIView *addImgView;//显示分享微信等平台的view
@property (weak, nonatomic) IBOutlet UILabel *zhiding_area;//指定地区
@property (weak, nonatomic) IBOutlet UILabel *end_time;//结束时间
@property (weak, nonatomic) IBOutlet UILabel *start_time;//开始时间
@property (weak, nonatomic) IBOutlet UILabel *tf_biaozhun;//投放标准
@property (weak, nonatomic) IBOutlet UILabel *dj_price;//订单金额
@property (weak, nonatomic) IBOutlet UIView *bordView;//外边框
@property (weak, nonatomic) IBOutlet UILabel *smLbl;//任务要求
@property (weak, nonatomic) IBOutlet UIButton *nextDo;//下一步
@property (weak, nonatomic) IBOutlet UIImageView *firstImgView;
@property (weak, nonatomic) IBOutlet UIImageView *secoundImgView;
@property (weak, nonatomic) IBOutlet UIImageView *threeImgView;
@property(strong,nonatomic) NSString *jsonssText;//转化成json格式的需要上传的信息
@property(strong,nonatomic) NSData *_jsonssData;


@property(strong,nonatomic) NSString *set_name;
@property(strong,nonatomic) NSString *set_fxLink;
@property(strong,nonatomic) NSString *set_fxText;
@property(strong,nonatomic) NSString *set_picText;
@property(strong,nonatomic) NSString *set_context;
@property(strong,nonatomic) NSString *startTime;
@property(strong,nonatomic) NSString *endTime;
@property(strong,nonatomic) NSArray *select_Imgs;
@property(strong,nonatomic) NSString *set_phoneName;
//@property(strong,nonatomic) NSString *set_ljName;
//@property(strong,nonatomic) NSString *set_zyName;
@property(strong,nonatomic) NSString *set_wryqName;
@property(strong,nonatomic) NSString *set_area;
@property(strong,nonatomic) NSString *set_every_price;
@property(strong,nonatomic) NSString *sum_price;
@property(strong,nonatomic) NSString *sum_people;
@property(strong,nonatomic) NSString *zhiding_areas;

@property(strong,nonatomic) NSString *set_Mediatype;
@property(strong,nonatomic) NSString *UserIDs;

@property(strong,nonatomic) NSString *orederId;//服务器获取的orderID

@property(strong,nonatomic) NSString *set_type;


@property int set_sumPeople;

@property(strong,nonatomic)NSDictionary *firstDic;//第一个页面的信息

@property(strong,nonatomic)NSDictionary *secoundDic;//第二个页面的信息


//@property(strong,nonatomic) NSString *orderId;//获取的订单信息
@end


@implementation QDXDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"确定下单";
    [self viewWithStyle];
    [self readData];
    
//    [self ocToJson];
   
}
-(void)initWithFirstXinXi:(NSDictionary *)firstDic  andXuanZePingTaiXinxi:(NSDictionary *)secoundDic{
    
    _firstDic=firstDic;
    _secoundDic=secoundDic;
    
}
-(void)viewWithStyle{
    
    self.bordView.layer.cornerRadius=5;
    self.bordView.layer.borderColor=[[UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1]CGColor];
    self.bordView.layer.borderWidth=0.5;
    self.smLbl.text=@"任务要求：\r\n1.请仔细阅读分享规则及任务要求，确定任务准确分享。\r\n2.成功分享2小时后上传分享截图。\r\n3.至少收集一条非发布者的赞和评论。";
    
    self.nextDo.layer.cornerRadius=12;
    [self.nextDo addTarget:self action:@selector(nextDoVC:) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)nextDoVC:(id)sender{
    //提交数据
    [self ocToJson];
    //跳转页面
    DDZFViewController *VC=[[DDZFViewController alloc]initWithNibName:@"DDZFViewController" bundle:nil];
    //订单总金额
    _sum_price=[_secoundDic objectForKey:@"sum_price"];
    //将总金额传入下个页面
    [VC initWithSumPrice:_sum_price];
    
    [self.navigationController pushViewController:VC animated:YES];
}

//转json
-(void)ocToJson{
    [self readData];
    MyData *main = [[MyData alloc] init];
    main.name = _set_name;
    main.ad_type = _set_type;
//    main.qrcode=0;
    main.url=_set_fxLink;
    main.content=_set_context;
    main.start_time=_startTime;
    main.end_time=_endTime;
    main.tel=_set_phoneName;
    main.require1=_set_wryqName;
    main.way_type=[NSString stringWithFormat:@"%d",3];
    //用户ID，这个目前还有问题
    main.add_user_id=@"53465324";
    main.paly_way=@"";
    main.city_id=@"";
    main.province_id=_set_area;
    main.media_id=@"";
    
//    NewModel *childOfChild = [[NewModel alloc] init];
//    childOfChild.img = 0;
//    childOfChild.describe =0;
//    childOfChild.sort =0;
    
   
//    main.images = @[childOfChild];
    NSMutableArray *array=[NSMutableArray array];   
    for (int i=0; i<_select_Imgs.count;i++) {
        NewModel *childOfChild = [[NewModel alloc] init];
         childOfChild.img=_select_Imgs[i];
         childOfChild.sort=i;
         [array addObject:childOfChild];
    }
    main.images=array;
    
    OederModel *sumModel=[[OederModel alloc]init];
    sumModel.task=main;
    
    MediaModel *media=[[MediaModel alloc]init];
    media.media_type=_set_Mediatype;
    media.price=_set_every_price;
    media.tol_count=[_sum_people intValue];
    sumModel.order=@[media];
    
    NSDictionary *dicts = [ModelToJson getObjectData:sumModel];
    NSLog(@"dic==%@", dicts);
    __jsonssData = [ModelToJson getJSON:sumModel options:NSJSONWritingPrettyPrinted error:nil];
    _jsonssText = [[NSString alloc] initWithData:__jsonssData encoding:NSUTF8StringEncoding];
    
    
    NSLog(@"jsonText===%@", _jsonssText);
    
    [self makeJSONToFuwuqi];

}

//上传json，请求数据
-(void)makeJSONToFuwuqi{
    
     [self.view makeToastActivity];
           // 1.URL
        NSURL *url = [NSURL URLWithString:@"http://101.200.90.192:8180/dyc/appTaskOrder/addTaskOrder.do?token=test"];
        
        // 2.请求
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        // 3.请求方法
        request.HTTPMethod = @"POST";
        
        request.HTTPBody = __jsonssData;
        NSLog(@"%@",_jsonssText);
        
        // 5.设置请求头：这次请求体的数据不再是普通的参数，而是一个JSON数据
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        // 6.发送请求
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
          
            if (data == nil || connectionError) return;
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
              NSLog(@"获取的DIC数据是什么%@",dict);
            //获取的orderID
            NSString *orderId=[dict objectForKey:@"orderId"];
            NSLog(@"获取的order数据是什么%@",orderId);
            NSUserDefaults *userdefault=[NSUserDefaults standardUserDefaults];
            [userdefault  setValue:orderId forKey:@"orderId"];
             if (connectionError) {
                [self.view hideToastActivity];
                NSLog(@"失败%@",connectionError);
            } else {
                NSString *success = dict[@"success"];
                NSLog(@"成功%@",success);
                  [self.view hideToastActivity];
            }
        }];
    
}

-(void)readData{
    
    //  读取数据:
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSUserDefaults *UserDefault =[NSUserDefaults standardUserDefaults];
    
    _UserIDs =[UserDefault objectForKey:@"Useid"];
    
    //任务名称
    _set_name = [_firstDic objectForKeyedSubscript:@"name"];
    
    //分享链接下的分享链接
    _set_fxLink = [_firstDic objectForKey:@"link"];
    
    //分享链接或图文下的说点什么
    _set_context=[_firstDic objectForKey:@"content"];
    
//    //分享图文下的文字
//    _set_picText=[_firstDic objectForKey:@"picText"];
    
    //开始时间
    _startTime=[_firstDic objectForKey:@"beginTime"];
    
    //结束时间
    _endTime=[_firstDic objectForKey:@"endTime"];
    
   
//    _select_Imgs=[_firstDic objectForKey:@"images"];
    NSArray *picArray=[_firstDic objectForKey:@"images"];
    if (picArray.count==0) {
        _select_Imgs=[NSMutableArray arrayWithObject:@""];
    }else{
    
        _select_Imgs=[_firstDic objectForKey:@"images"];
    }

    
//    //分享链接下的图片
//    _link_photos=[_firstDic objectForKey:@"link_selectedPhotos"];
//    
//    //分享图文下的图片
//    _pic_photos=[_firstDic objectForKey:@"picText_selectedPhotos"];

    //联系号码
    _set_phoneName = [_firstDic objectForKey:@"phone"];
    
    //任务要求
    _set_wryqName = [_firstDic objectForKey:@"taskRequest"];
    
    //指定地区
   _set_area = [defaults objectForKey:@"zhidingdiqu"];
    
    //单价
   _set_every_price = [_secoundDic objectForKey:@"every_price"];
    
    //订单总金额
    _sum_price=[_secoundDic objectForKey:@"sum_price"];
    
    //总人数
    _sum_people=[_secoundDic objectForKey:@"people_number"];
    
    //指定地区
    _zhiding_areas=[_secoundDic objectForKey:@"area"];

    
    CGFloat type = [defaults floatForKey:@"fx_rw"];
    if (type==1) {
        _set_type=0;
    }
    else if (type==2) {
         _set_type=[NSString stringWithFormat:@"%d",1];
    }
    else{
        _set_type=[NSString stringWithFormat:@"%d",2];
    }
    
    //保存下来的分享平台
    BOOL wxSelected=[defaults boolForKey:@"wxselected"];
    BOOL wbSelected=[defaults boolForKey:@"wbselected"];
    BOOL qqSelected=[defaults boolForKey:@"qqselected"];
    
    NSMutableArray *array=[NSMutableArray array];
    if (wxSelected==YES) {
        
        UIImage *img=[UIImage imageNamed:@"wx_new"];
        [array addObject:img];
         _set_Mediatype=[NSString stringWithFormat:@"%d",0];
        
    }
    if (wbSelected==YES) {
        UIImage *img=[UIImage imageNamed:@"wb_new"];
        [array addObject:img];
        _set_Mediatype=[NSString stringWithFormat:@"%d",2];

    }
    if (qqSelected==YES) {
        UIImage *img=[UIImage imageNamed:@"qq_new"];
        [array addObject:img];
        _set_Mediatype=[NSString stringWithFormat:@"%d",1];
    }
    
    //设置图片的宽
    CGFloat imageW=20;
    //设置图片的高
    CGFloat imageH=10;
    //设置图片的y
    CGFloat imageY=5;
    //添加图片
    for (int i=0; i <array.count; i++)
    {
        UIImageView *imageView=[[UIImageView alloc]init];
        //每张图片的x
        CGFloat imageX= i *imageW;
        
        //设置imageview的frame
        imageView.frame=CGRectMake(imageX, imageY, imageW, imageH);
        
        //设置每张图片的名字
        imageView.image=[array objectAtIndex:i];
        
        [self.addImgView addSubview:imageView];
    }

    
    //显示订单金额
    self.dj_price.text=[NSString stringWithFormat:@"%@",_sum_price];
    //显示投放标准
    self.tf_biaozhun.text=[NSString stringWithFormat:@"%@元*%@人",_set_every_price,_sum_people];
    //开始时间
    self.start_time.text=[NSString stringWithFormat:@"%@",_startTime];
    //结束时间
     self.end_time.text=[NSString stringWithFormat:@"%@",_endTime];
    //说明
    self.smLbl.text=[NSString stringWithFormat:@"%@",_set_wryqName];
    //指定地区
    self.zhiding_area.text=[NSString stringWithFormat:@"%@",_zhiding_areas];

    
}

@end
