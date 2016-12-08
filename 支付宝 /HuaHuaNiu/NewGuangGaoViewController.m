//
//  NewGuangGaoViewController.m
//  HuaHuaNiu
//
//  Created by alex on 15/12/26.
//  Copyright © 2015年 张燕. All rights reserved.
//
//token=test&member_id=1&ad_name=123&total_num=100&total_money=1&summary=456&img_id=1512030203435360000
#import "NewGuangGaoViewController.h"
#import "AFNetworking.h"
#import "NewGGSentViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "PostProgressView.h"

@interface NewGuangGaoViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    PostProgressView *_postProgressView;
}
@end

@implementation NewGuangGaoViewController


//-(void)viewWillAppear:(BOOL)animated{
//    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
//    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
//    NSLog(@"%@",savedImage);
//    [self.img setImage:savedImage];
//}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.backScrollview.contentSize =CGSizeMake(ConentViewWidth, 800);
    self.backScrollview.backgroundColor = BackColor;
    self.backScrollview.showsVerticalScrollIndicator = NO;
    
    self.tf1.delegate =self;
    self.tf2.delegate =self;
    self.textView.delegate =self;

    self.tf2.keyboardType =UIKeyboardTypeNumberPad;

    UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapAActops)];
    [self.backScrollview addGestureRecognizer:tap];
    
    //  self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title=@"发广告";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIButton *BackBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    BackBtn.frame =CGRectMake(0, 0, 64, 27);
    [BackBtn  setBackgroundImage:[UIImage imageNamed:@"app_fanhui"] forState:UIControlStateNormal];
    // [BackBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    
    [BackBtn addTarget:self action:@selector(BackAction)  forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem =[[UIBarButtonItem alloc]initWithCustomView:BackBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    
    UIButton * Rightbtn =[UIButton buttonWithType:UIButtonTypeCustom];
    Rightbtn.frame =CGRectMake(0, 0, 15, 15);
    [Rightbtn addTarget:self action:@selector(gengduo) forControlEvents:UIControlEventTouchUpInside];
    [Rightbtn setImage:[UIImage imageNamed:@"app_wendangshuoming"] forState:UIControlStateNormal];
    UIBarButtonItem *RightItem =[[UIBarButtonItem alloc]initWithCustomView:Rightbtn];
    
    self.navigationItem.rightBarButtonItem = RightItem;

}

-(void)gengduo{
    NewGGSentViewController * nggvc =[[NewGGSentViewController alloc]init];
    nggvc.hidesBottomBarWhenPushed =YES;
    [self.navigationController pushViewController:nggvc animated:YES];
}
-(IBAction)cameraButton:(id)sender{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    
    picker.allowsEditing = YES;
    picker.sourceType = sourceType;
    [self presentViewController:picker animated:YES completion:nil];

}

-(IBAction)imageButton:(id)sender{
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePicker animated:YES completion:nil];

    
   
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    self.img.image=image;
}
//- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
//{
//    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
//    // 获取沙盒目录
//    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
//    // 将图片写入文件
//    [imageData writeToFile:fullPath atomically:NO];
//}

-(void)TapAActops{
    //
    [self.tf1 resignFirstResponder];
    [self.tf2 resignFirstResponder];
    [self.textView resignFirstResponder];
    self.backScrollview.contentSize =CGSizeMake(ConentViewWidth, ConentViewHeight+150);
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.tf1 resignFirstResponder];
    [self.tf2 resignFirstResponder];
    [self.textView resignFirstResponder];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    self.backScrollview.contentSize =CGSizeMake(ConentViewWidth, ConentViewHeight+50);
    if (textField== self.tf1||textField== self.tf2) {
        self.backScrollview.contentOffset =CGPointMake(0, 50);
    }


    
}


-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    self.tf1.text =[self.tf1.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    self.tf2.text =[self.tf2.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (textField==self.tf2) {
        float n =0.1*[textField.text floatValue];
        self.MoneyLB.text =[NSString stringWithFormat:@"￥%.2f",n];
    }
    
}
-(void)textViewDidBeginEditing:(UITextView *)textView{
    self.backScrollview.contentSize =CGSizeMake(ConentViewWidth, 568 +300);
    self.backScrollview.contentOffset =CGPointMake(0, 140);
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    self.textView.text =[self.textView.text stringByReplacingOccurrencesOfString:@" " withString:@""];
}



#pragma mark 支付宝支付
-(void)makeZhiFuBaoZhifu{
    
    // NSLog(@"获取parnter 和 seller  、privateKey(私钥)")  ;
    
    /*
     *点击获取prodcut实例并初始化订单信息   自己赋值的话不用 Product
     */
    
    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = @"2088911222877472";//合作者ID
    NSString *seller = @"bbnkjzg@126.com";  // 支付宝账号
    NSString *privateKey = @"-----BEGIN RSA PRIVATE KEY-----MIICXAIBAAKBgQC9RWd8SWkBxYUMngeaFoxAXr6fvV4GtvLWXZtaEoEUyiiQpRhPgDwedDCaiU/HmR60D7YO/VoVYu/4v8iStOmuPIydYpliGp5fR0RzVAYT6sdVXskc+AHTGvxHxKLc+0a0yoYMv2PjYXiWb/5+AP2A+rlfiG0Xz+O5JtmsU/A37QIDAQABAoGAFcOVUsVePcXotrq1RRKyrfQ3F0c/OKZw5hV9d64JCcr1Pyy8zueAAkB6FksT0W/aB/qGhNK9ORhXX9MtzTDgbeX/JPJIx7eXyaYRWOuYtwC+N9FXrz0O09qRI47F9UR8yTvLOxKqSJlSSEv4ZwPRiVy4YE4twVIEuJo2pOHZ5EECQQDk0bcX3ZVlZrGsoufs+m++2hjJ40JPyc2ahSpHfVqPv2yhSWa9qUP7h9Vw4qEZ1zO1kNRnGT/EeYQUQIB0XimfAkEA08EM1WjYG/XemBVZgIkbbPjnQ2LYUmhdO8/F/AILCImIjIzbV/eohAIXeevubJDtq0grP0mIsp17OTbS/YGK8wJBAIjpBmFsPtCeYp8GFjlQG36ZZo2dwfaVq8TR+tstoPszsV7L2YKP/dJJkydpIrWgcxsnXj+V9varMqEfevylvscCQCV0WBjHWrJXYu/zlsktdzRnMkCxEyJAY31Y2uQgWGNCMGzr3UBKBfyTgiOGn72ERQWu1jdzgkJVqJ4OHHPKnhECQDiFSTo26YFd7tshv2ASo8PRJsObuI1LnkN6VpPoApAY    YzlIlYkVOC49jAfiJorn2pZGPKX+d1gdJpy1Aq9CLyc=-----END RSA PRIVATE KEY-----";// RSA密钥
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     *商户的唯一的parnter 合作者id和seller  支付宝账号。
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO =[self.adVanDic objectForKey:@"adid"]; //订单ID（由商家自行制定）
    //    order.productName = product.subject; //商品标题
    order.productName = @"商品标题"; //商品标题
    //    order.productDescription = product.body; //商品描述
    order.productDescription = @"商品描述"; //商品描述
    NSString * priceStr =[NSString stringWithFormat:@"%@",[self.adVanDic objectForKey:@"total_m"]];
    order.amount = [NSString stringWithFormat:@"%.2f",[priceStr floatValue]]; //商品价格
    //  order.amount = [NSString stringWithFormat:@"%.2f",0.01]; //商品价格
    NSString *adid = [NSString stringWithFormat:@"AD%@",self.adVanDic[@"adid"]];
    order.notifyURL = [NSString stringWithFormat:ZHIFUHD,self.adVanDic[@"adid"],@"1"]; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"alisdkhuahuaniu";
    
    //将商品信息拼接成字符串orderSpec
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    
    
        AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
        NSDictionary *dic =@{@"token":@"test",@"order_id":[self.adVanDic objectForKey:@"adid"],@"order_amount":[NSString stringWithFormat:@"%.2f",[priceStr floatValue]],@"order_desc":@"productDescription"};
        NSLog(@"%@",dic);
        [manager POST:ZHIFU_REQUEST parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            //   获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
//                id<DataSigner> signer = CreateRSADataSigner(privateKey);
//            NSString *signedString = [signer signString:orderSpec]; //商品信息拼接成的字符串orderSpec
//            
            NSString *signedString=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"sign"]];
            NSString *ordStr=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"payInfo"]];
            
            NSLog(@"%@",signedString);
                    signedString =[signedString stringByReplacingOccurrencesOfString:@" " withString:@""];
                    [signedString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            //将签名成功字符串格式化为订单字符串,请严格按照该格式
            NSString *orderString = nil;
            if (signedString != nil) {
                orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                               orderSpec, signedString, @"RSA"];
                
                [[AlipaySDK defaultService] payOrder:ordStr fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                    NSLog(@"reslut = %@",resultDic);
                    NSString * str2 =[NSString stringWithFormat:@"%@",[resultDic objectForKey:@"memo"]];
                    
                    NSLog(@"%@",str2);
                    
                    NSString * str =[NSString stringWithFormat:@"%@",[resultDic objectForKey:@"resultStatus"]];
                    NSString * status  ;
                    if ([str isEqualToString:@"9000"]) {
                        status =@"订单支付成功";
                        NSString * resquestUrl =[NSString stringWithFormat:ZHIFUHD,[self.adVanDic objectForKey:@"adid"]];
                        [[RequestManger share]requestDataByGetWithPath:resquestUrl complete:^(NSDictionary *data) {
                            NSLog(@"%@",[data objectForKey:@"result"]);
                            NSLog(@"%@",[data objectForKey:@"msg"]);
                        }];
                    }
                    else if ([str isEqualToString:@"8000"]) {
                        status =@"正在处理中";
                    }
                    else if ([str isEqualToString:@"6001"]) {
                        status =@"用户中途取消";
                    }
                    else if ([str isEqualToString:@"6002"]) {
                        status =@"网络连接出错";
                    }
                    else{
                        status =@"网络连接出错";
                    }
                    
                    UIAlertView * ResultAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:status delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    ResultAlView.tag= 66;
                    [ResultAlView show];
                    
                    
                    
                }];
                
                
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [failAlView show];
        }];
        
        
    }
    



-(void)BackAction{
    [self.navigationController popViewControllerAnimated:YES];
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



- (IBAction)fukuanAction:(id)sender{
    BOOL  CanTiJiao; // 判断是否可以提交
    CanTiJiao = YES; // 有一条不满意就  不能提交

    if(self.tf1.text.length == 0){
        CanTiJiao = NO;
    }
    if(self.tf2.text.length==0){
        CanTiJiao = NO;
    }
    NSUserDefaults *userdefault =[NSUserDefaults standardUserDefaults];
    NSString *Username =[userdefault objectForKey:@"Useid"];
    
    if (CanTiJiao) {
        NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"Useid"]);
        if (!_postProgressView) {
            _postProgressView = [[PostProgressView alloc] initWithFrame:self.view.frame];
        }
        //显示上传进度
        [_postProgressView showInView:self.view];

        // 申请
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        //请求接口
        NSString *urlString = [NSString stringWithFormat:@"http://daiyancheng.cn/appfile/uploadfile.do?token=test&member_id=%@&type=pic",Username];
        
//        UIImageView *image = _img;
//        [self.img setImage:image];
        NSData *imageData =  UIImagePNGRepresentation(_img.image);
//        NSLog(@"imageData:%@",imageData);
        AFHTTPRequestOperation *operation = [manager POST:urlString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
            [formData appendPartWithFileData:imageData name:@"file" fileName:[NSString stringWithFormat:@"image%d.png",arc4random() % 5] mimeType:@"image/png"];
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"上传成功 %@",responseObject);
            if ([[responseObject objectForKey:@"result"] integerValue] == 1)
            {
                _file_id = [responseObject objectForKey:@"fileid"];
                _img_id = [responseObject objectForKey:@"img_id"];
                NSString *LoginStr =[NSString stringWithFormat:@"http://daiyancheng.cn/appprize/prize_add.do?token=test&member_id=%@&ad_name=%@&total_num=%d&total_money=%.2f&summary=%@&img_id=%@",[[[NSUserDefaults standardUserDefaults] objectForKey:@"Useid"]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ,[_tf1.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[_tf2.text intValue],[_tf2.text intValue]*0.1 ,[_textView.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[_file_id stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] ;
                NSString* UrlStr=[LoginStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSLog(@"%@",UrlStr);
                [manager POST:UrlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    self.adVanDic = responseObject;
                    [self makeZhiFuBaoZhifu];
                    //隐藏上传视图
                    [_postProgressView hide];
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    
                    UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    [failAlView show];
                    NSLog(@"%@",error);
                     [_postProgressView hide];
                }];
            }
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"上传失败 %@",error);
                     [_postProgressView hide];
        }];
        [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        
//            设置上传进度
            [_postProgressView updateWithProgress:(CGFloat)totalBytesWritten/totalBytesExpectedToWrite];
            
        }];

    }
    else
    {
        UIAlertView * al =[[UIAlertView alloc]initWithTitle:@"提示" message:@"信息不完整" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [al show];
         [_postProgressView hide];
    }


}
//        NSString *LoginStr =[NSString stringWithFormat:SendGG] ;
//        LoginStr =[LoginStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
//        /*
//         user_name 用户名  company_name 公司名称
//         link_man 联系人
//         area 所在区域
//         phone_mob 电话号码	email 电子邮箱	qq qq	introduce 资源整合意向
//         */
//        NSString * str1 =[[NSString stringWithFormat:@"%@",self.tf1.text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        NSString * str2 =[[NSString stringWithFormat:@"%@",self.tf2.text]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ;
//        
//        
//        NSArray *KeyArr =@[@"token",@"member_id",@"ad_name",@"total_num",@"total_money",@"summary",@"img_id"];
//        NSString * money =[self.MoneyLB.text substringFromIndex:1];
//        NSArray *ValueArr =@[@"test",Username,str1,str2,money,self.textView.text,@""];
//        
//        NSDictionary *dic =[[NSDictionary alloc]initWithObjects:ValueArr forKeys:KeyArr];
//        NSLog(@"%@",dic);
//        
//        [manager POST:LoginStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            NSLog(@"%@",responseObject);
//            
//            self.adVanDic =responseObject;
//            [self makeZhiFuBaoZhifu];
//            
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            
//            UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//            [failAlView show];
//            
//            NSLog(@"%@",error);
//        }];
//    }
//    else{
//        
//        UIAlertView * al =[[UIAlertView alloc]initWithTitle:@"提示" message:@"信息不完整" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        [al show];
//    }
    
    
    

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag ==98) {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
    
}

@end
