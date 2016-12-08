//
//  ZXMoreViewController.m
//  HuaHuaNiu
//
//  Created by mac on 16/11/18.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "ZXMoreViewController.h"
#import "PLCell.h"
#import "Toast+UIView.h"
#import "PLModel.h"
#import "MBProgressHUD.h"
@interface ZXMoreViewController ()<UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate,UITextFieldDelegate>
- (IBAction)pinglunAction:(id)sender;//点击发送按钮
@property (weak, nonatomic) IBOutlet UITextField *textField;//写评论
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *chatView;//写评论的view
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;//分享按钮
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;//更多评论按钮
@property(strong,nonatomic)NSMutableArray *plArray;//评论的数组
@property(strong,nonatomic)NSDictionary *dic;//保存数据
@end

@implementation ZXMoreViewController
{
     UIWebView *web;
    CGFloat webHeight;
    int number;//区分是第一次加入页面还是评论后再次调的接口，显示评论成功

}

- (void)viewDidLoad {
    [super viewDidLoad];
    number=1;
     [self makeZixunMoreData];
    self.edgesForExtendedLayout=UIRectEdgeNone;
    [self viewWithStyle];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
   
   
}

#pragma mark  UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return 300;
    }
    if (indexPath.row==1) {
        if (self.plArray.count==0) {
            return 0;
        }
        else{
            return 40;
        }
    }
    else{
        return 40;
    }
    return 0;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.plArray.count+2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    PLCell *cell;
    if (indexPath.row==0)
    {
        cell=[tableView dequeueReusableCellWithIdentifier:@"PLCell1"];
     
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"PLCell" owner:self options:nil]objectAtIndex:1];
            web =[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, 300)];
            web.delegate=self;
            [cell.contentView addSubview:web];
        }
        NSString *urls=[_dic objectForKey:@"url"];
        NSURL *url=[NSURL URLWithString:urls];
        NSURLRequest *request=[NSURLRequest requestWithURL:url];
        web.delegate=self;
        [web loadRequest:request];

    }
    
   else if (indexPath.row==1)
    {
        cell=[tableView dequeueReusableCellWithIdentifier:@"PLCell2"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"PLCell" owner:self options:nil]objectAtIndex:2];
            UIImageView *imgView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 2, 20)];
                imgView.backgroundColor=[UIColor orangeColor];
            
                UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(20, 10, 40, 20)];
                lbl.text=@"评论";
                UILabel *numLbl=[[UILabel alloc]initWithFrame:CGRectMake(60, 10, 20, 20)];
                numLbl.text=@"(5)";
            
                lbl.font=[UIFont systemFontOfSize:13];
                numLbl.font=[UIFont systemFontOfSize:13];
            
                [cell.contentView addSubview:imgView];
                [cell.contentView addSubview:lbl];
                [cell.contentView addSubview:numLbl];
           
                
        }
    }
    else
    {
        cell=[tableView dequeueReusableCellWithIdentifier:@"PLCell"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"PLCell" owner:self options:nil]objectAtIndex:0];
        }
        PLModel *model=[self.plArray objectAtIndex:indexPath.row-2];
        NSLog(@"行数%ld",indexPath.row);
        cell.headImg.image=model.img;
        cell.nick_name.text=model.nick_name;
        cell.content.text=model.content;
        cell.time.text=model.add_time;

    }
    return cell;
   
}
#pragma mark  UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    //开始加载网页调用此方法
    NSLog(@"123");
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    //网页加载完成调用此方法
    NSLog(@"succed");
    CGSize actualSize = [webView sizeThatFits:CGSizeZero];
    
    CGRect newFrame = webView.frame;
    
    newFrame.size.height = actualSize.height;
    
    webView.frame = newFrame;

}

-(void)viewWithStyle{

    self.chatView.layer.cornerRadius=5;
    self.chatView.layer.borderColor=[[UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1]CGColor];
    self.chatView.layer.borderWidth=0.5;
    
    [self.shareBtn addTarget:self action:@selector(shareDone:) forControlEvents:UIControlEventTouchUpInside];
    
    self.textField.delegate=self;
    self.textField.returnKeyType=UIReturnKeySend;

}
#pragma mark  UITextFieldDelegate 调用发送评论接口
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    NSString *newsId=[_dic objectForKey:@"newsId"];
    
    NSString *content=[NSString stringWithFormat:@"%@",self.textField.text];
    
    NSUserDefaults *UserDefault =[NSUserDefaults standardUserDefaults];
    NSString * UserIDs =[UserDefault objectForKey:@"Useid"];
    
    NSString * ShouY = [NSString stringWithFormat:ZXPLURL,newsId,UserIDs,content];
    NSString *urlStringUTF8 = [ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    
    [manager GET:urlStringUTF8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self.textField resignFirstResponder];
        NSLog(@"评论返回数据%@",responseObject);
        number=2;
        [self makeZixunMoreData];
      
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [failAlView show];
        
    }];
    return YES;
}

#pragma mark 资讯详情接口
-(void)makeZixunMoreData{
    [self.view makeToastActivity];
    NSString * ShouY = [NSString stringWithFormat:ZXMoreURL];
    NSString *urlStringUTF8 = [ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    
    [manager GET:urlStringUTF8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self.view hideToastActivity];
        
        NSLog(@"资讯详情返回数据%@",responseObject);
        NSDictionary *dict=[responseObject objectForKey:@"news"];
        NSString *url=[dict objectForKey:@"url"];
        NSString *time=[dict objectForKey:@"add_time"];
        NSString *user=[dict objectForKey:@"add_user"];
        NSString *title=[dict objectForKey:@"title"];
        NSString *newId=[dict objectForKey:@"id"];
        //评论的数据
        NSMutableArray *array=[responseObject objectForKey:@"discuss"];
        for (int i=0; i<array.count; i++) {
            NSMutableDictionary *dics=[array objectAtIndex:i];
            //时间
            NSString *time=[dics objectForKey:@"add_time"];
            //评论内容
             NSString *content=[dics objectForKey:@"content"];
            //头像
//             NSString *head=[dics objectForKey:@"head"];
            //昵称
            NSString *nick_name=[dics objectForKey:@"nick_name"];
            
            //判断图像头部有没有http
            NSString *urlStr=[dics objectForKey:@"head"];
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
            UIImage *imgs=[self getImageFromURL:url];
            
            PLModel *model=[[PLModel alloc]init];
            model.add_time=time;
            model.content=content;
            model.img=imgs;
            model.nick_name=nick_name;
            [self.plArray addObject:model];
            if (number==2) {
                 [self showHint:@"评论成功"];
            }
           
            
        }
        _dic=@{@"url":url,
              @"time":time,
               @"user":user,
               @"title":title,
                @"newsId":newId,
              };

        [self.tableView reloadData];
        
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

-(NSMutableArray *)plArray{
    if (_plArray==nil) {
        _plArray=[NSMutableArray array];
    }
    return _plArray;

}

//点击分享
-(void)shareDone:(id)sender{


}

//点击发送评论按钮
- (IBAction)pinglunAction:(id)sender {
    [self makeZixunMoreData];
}

- (void)showHint:(NSString *)hint
{
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = hint;
    hud.margin = 10.f;
    //    hud.yOffset = IS_IPHONE_5?10.f:10.f;//修改了显示位置
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
}

@end
