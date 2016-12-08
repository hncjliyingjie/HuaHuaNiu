//
//  NRXQViewController.m
//  HuaHuaNiu
//
//  Created by Vking on 16/1/25.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "NRXQViewController.h"

@interface NRXQViewController ()
@property (nonatomic,strong)UIWebView *webView;
- (IBAction)call:(id)sender;

@end

@implementation NRXQViewController
- (UIWebView *)webView {
    if (_webView == nil) {
        self.webView = [[UIWebView alloc]init];
    }
    return _webView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    self.title = @"详情";
    
    
    
    
    [self loadData];
    
}
- (void)loadData{
    //请求网络数据
    NSUserDefaults *Userdefaults =[NSUserDefaults standardUserDefaults];
    http://daiyancheng.cn/appinfo/info_show.do?token=test&member_id=1&info_id=0ba1e90f95514b668fadd08eb7e9c9bc
    [HGBaseMethod get:[NSString stringWithFormat:@"http://daiyancheng.cn/appinfo/info_show.do?token=test&member_id=%@&info_id=%@",[Userdefaults objectForKey:@"Useid"],_infoId] parms:nil success:^(id json) {
        _array  = json[@"info"];
        [self setUI];
    } failture:^(id json) {
        
    }];

    
}

- (void)setUI{
    self.imagelable.image = _image;
    self.titlelable.text = _array[@"title"];
    self.maneylable.text = [NSString stringWithFormat:@"%@元",_array[@"price"]];
    self.timelable.text = [NSString stringWithFormat:@"发布时间：%@",_array[@"add_time"]];
    self.centerlable.text = _array[@"content"];
    self.phonelable.text = [NSString stringWithFormat:@"联系电话：%@",_array[@"phone"]];
    self.adresslable.text = [NSString stringWithFormat:@"我的位置：%@",_array[@"address"]];
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

- (IBAction)call:(id)sender {
    //创建一个可变字符串，用来存储电话 前缀：tel:
    NSMutableString *phoneStr = [NSMutableString stringWithFormat:@"tel:%@",_array[@"phone"]];
    //实现打电话功能
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneStr]];
//    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:phoneStr]]];
}
@end
