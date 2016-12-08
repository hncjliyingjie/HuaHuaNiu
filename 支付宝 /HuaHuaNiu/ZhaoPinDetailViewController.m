//
//  ZhaoPinDetailViewController.m
//  HuaHuaNiu
//
//  Created by alex on 15/10/24.
//  Copyright © 2015年 张燕. All rights reserved.
//

#import "ZhaoPinDetailViewController.h"
#import "Toast+UIView.h"
#import "UIImageView+WebCache.h"
@interface ZhaoPinDetailViewController ()

@end

@implementation ZhaoPinDetailViewController{
    ZhaoPinModel * _zhaopinModel;
    UIScrollView * _sv;
    CGFloat _svHeight;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [self createData];
}

-(void)createData{
    RequestManger * manger =[RequestManger share];
    [self.view makeToastActivity];
    NSString * requestUrl =[NSString stringWithFormat:ZHAOPIN_DETAIL,self.currentModel.joinId];
    [manger requestDataByGetWithPath:requestUrl complete:^(NSDictionary *data) {
        [self.view hideToastActivity];
        if ([data objectForKey:@"error"]) {
            
        }else{
            _zhaopinModel =[ZhaoPinModel makeDetailModelWith:data];
            [self createUI];
        }
    }];
}

-(void)createUI{
    [self createSV];
    [self createNav];
}

- (void)createNav{
    UIButton *BackBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    BackBtn.frame =CGRectMake(0, 0, 64, 27);
    [BackBtn  setBackgroundImage:[UIImage imageNamed:@"app_fanhui"] forState:UIControlStateNormal];
    [BackBtn addTarget:self action:@selector(BackAction)  forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem =[[UIBarButtonItem alloc]initWithCustomView:BackBtn];
    
    self.navigationItem.leftBarButtonItem = backItem;
    self.navigationItem.title=@"招聘详情";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:20],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
}

-(void)BackAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)createSV{
    _sv =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, ConentViewHeight)];
    [self makeTopView];
    [self makePhoneView];
    [self makeDeatailView1];
    [self makeDeatailView2];
    [self makeDeatailView3];
    _sv.contentSize =CGSizeMake(ConentViewWidth, 1000);
    [self.view addSubview:_sv];
}


-(void)makeTopView{
    UIView * topView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, 320)];
    topView.backgroundColor =[UIColor whiteColor];
    
    UIImageView * iv =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, 200)];
    
    
    [iv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:IMaUrl,_zhaopinModel.storeLogo]] placeholderImage:[UIImage imageNamed:@"default"]];
    
    [topView addSubview:iv];
    
    UILabel * title =[[UILabel alloc]initWithFrame:CGRectMake(10, iv.frame.size.height+iv.frame.origin.y+10, ConentViewWidth-20, 20)];
    title.text =_zhaopinModel.title;
    [topView addSubview:title];
    
    UIView * line =[[UIView alloc]initWithFrame:CGRectMake(40, title.frame.size.height +title.frame.origin.y+10, ConentViewWidth-40, 1)];
    line.backgroundColor =[UIColor lightGrayColor];
    [topView addSubview:line];

    
    UILabel * number =[[UILabel alloc]initWithFrame:CGRectMake(10, line.frame.size.height+line.frame.origin.y+10, 150, 20)];
    number.text =[NSString stringWithFormat:@"招聘人数:%@人",_zhaopinModel.joinNum];
    [topView addSubview:number];
    
    UILabel * time =[[UILabel alloc]initWithFrame:CGRectMake(ConentViewWidth-170, line.frame.size.height+line.frame.origin.y+10, 170, 20)];
    time.text =[NSString stringWithFormat:@"截止时间:%@",    _zhaopinModel.endDate];
    [topView addSubview:time];
    
    UIView * line2 =[[UIView alloc]initWithFrame:CGRectMake(40, number.frame.size.height +number.frame.origin.y+10, ConentViewWidth-40, 1)];
    line2.backgroundColor =[UIColor lightGrayColor];
    [topView addSubview:line2];

    
    UILabel * place =[[UILabel alloc]initWithFrame:CGRectMake(ConentViewWidth-150, line2.frame.size.height+line2.frame.origin.y+10, 150, 20)];
    place.text =[NSString stringWithFormat:@"工作地点:%@",    _zhaopinModel.workPlace];
    
    [topView addSubview:place];
    
    
    
    [_sv addSubview:topView];
}


-(void)makePhoneView{
    UIView * phoneView =[[UIView alloc]initWithFrame:CGRectMake(0, 340, ConentViewWidth, 70)];
    phoneView.backgroundColor =[UIColor whiteColor];
    UILabel * phone =[[UILabel alloc]initWithFrame:CGRectMake(10, 25, ConentViewWidth-100, 20)];
    phone.text =_zhaopinModel.storeTel;
    [phoneView addSubview:phone];
    
    UIImageView * iv =[[UIImageView alloc]initWithFrame:CGRectMake(ConentViewWidth-50, 12, 45, 45)];
    [iv setImage:[UIImage imageNamed:@"app_button_tel"]];
    [phoneView addSubview:iv];
    
    [_sv addSubview:phoneView];
}

-(void)makeDeatailView1{
    
    UIView * deatilView1 =[[UIView alloc]initWithFrame:CGRectMake(0, 430, ConentViewWidth, 100)];
    deatilView1.backgroundColor = [UIColor whiteColor];
    UILabel * title =[[UILabel alloc]initWithFrame:CGRectMake(10, 10, ConentViewWidth, 20)];
    title.text =@"工作待遇";
    [deatilView1 addSubview:title];
    
    UIView * line =[[UIView alloc]initWithFrame:CGRectMake(40, title.frame.size.height +title.frame.origin.y+10, ConentViewWidth-40, 1)];
    line.backgroundColor =[UIColor lightGrayColor];
    [deatilView1 addSubview:line];
    
    UILabel * text =[[UILabel alloc]initWithFrame:CGRectMake(40,line.frame.size.height +line.frame.origin.y+10, ConentViewWidth-40, 20)];
    text.text =_zhaopinModel.treatment;
    [deatilView1 addSubview:text];
    
    [_sv addSubview:deatilView1];
    
}

-(void)makeDeatailView2{
    
    UIView * deatilView2 =[[UIView alloc]initWithFrame:CGRectMake(0, 550, ConentViewWidth, 150)];
    deatilView2.backgroundColor =[UIColor whiteColor];
    UILabel * title =[[UILabel alloc]initWithFrame:CGRectMake(10, 10, ConentViewWidth, 20)];
    title.text =@"工作要求";
    [deatilView2 addSubview:title];
    
    UIView * line =[[UIView alloc]initWithFrame:CGRectMake(40, title.frame.size.height +title.frame.origin.y+10, ConentViewWidth-40, 1)];
    line.backgroundColor =[UIColor lightGrayColor];
    [deatilView2 addSubview:line];
    
    
    NSArray * arr =[_zhaopinModel.workRequirement componentsSeparatedByString:@"\n"];
    int n =0;
    for (NSString * str in arr) {
        UILabel * text =[[UILabel alloc]initWithFrame:CGRectMake(40,line.frame.size.height+line.frame.origin.y+10+20*n, ConentViewWidth-40, 20)];
        text.text =str;
        [deatilView2 addSubview:text];
        n++;
    }
    
    [_sv addSubview:deatilView2];}

-(void)makeDeatailView3{
    
    UIView * deatilView3 =[[UIView alloc]initWithFrame:CGRectMake(0, 720, ConentViewWidth, 100)];
    deatilView3.backgroundColor =[UIColor whiteColor];
    UILabel * title =[[UILabel alloc]initWithFrame:CGRectMake(10, 10, ConentViewWidth, 20)];
    title.text =@"工作职责";
    [deatilView3 addSubview:title];
    
    UIView * line =[[UIView alloc]initWithFrame:CGRectMake(40, title.frame.size.height +title.frame.origin.y+10, ConentViewWidth-40, 1)];
    line.backgroundColor =[UIColor lightGrayColor];
    [deatilView3 addSubview:line];
    
    UILabel * text =[[UILabel alloc]initWithFrame:CGRectMake(40,line.frame.size.height+line.frame.origin.y+10, ConentViewWidth-40, 60)];
    text.text =_zhaopinModel.workQualification;
    [deatilView3 addSubview:text];
    
    [_sv addSubview:deatilView3];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
