//
//  CYRZViewController.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-4-25.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "CYRZViewController.h"
#import "CYRUXCTableViewCell.h"
#import "LianXiMeViewController.h"
#import "JIanJieViewController.h"
#import "ShangJRZViewController.h"
#import "GUANGGAOViewController.h"
#import "QudaiLiViewController.h"
#import "ZiyuashenqViewController.h"
#import "ShenqingquyudaiViewController.h"
@interface CYRZViewController ()

@end

@implementation CYRZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeSeTV];
    
    UIButton * Rightbtn =[UIButton buttonWithType:UIButtonTypeCustom];
    Rightbtn.frame =CGRectMake(0, 0, 15, 15);
    [Rightbtn addTarget:self action:@selector(gengduo) forControlEvents:UIControlEventTouchUpInside];
    [Rightbtn setImage:[UIImage imageNamed:@"app_wendangshuoming"] forState:UIControlStateNormal];
    UIBarButtonItem *RightItem =[[UIBarButtonItem alloc]initWithCustomView:Rightbtn];
    
    self.navigationItem.rightBarButtonItem = RightItem;
        
    self.navigationItem.title=@"诚邀加入";
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
}
-(void)BackAction{
    [self.navigationController popViewControllerAnimated:YES];
}
// 显示 新闻资讯 公司简介产品介绍 联系我们等
-(void)gengduo{
    TopView.hidden = !TopView.hidden;
}
-(void)makeARR{
    ImaArr =@[@"app_quyudaili",@"app_shangjiaruzhu",@"app_guanggaotoufang",@"app_ziyuanzhenghe"];
    TitleArr=@[@"区域代理申请",@"商家入驻申请",@"广告投放申请",@"资源整合申请"];
    concentArr =@[@"移动互联网风暴来袭，眼球在哪里，经济就在哪里，如果您认可我们的经营模式，如果您认可我们的平台，就请加盟吧，让我们携手共创辉煌。",@"移动互联网让您插上腾飞的翅膀，一个广阔的平台在您眼前。来吧，动动手不出家门，让您的信息在轻轻松松就传播万里。",@"精准用户的投放，得到的即是你想要的，万千代言人的分类传播，让您和互联网互动起来，指尖上的财富瞬间拥有。",@"创新无处不在，只要能想到就能做到，把你我的优势联合起来，共同实现人生梦想。"];
    

}
-(void)viewWillAppear:(BOOL)animated{
    if (TopView) {
         TopView.hidden  = YES;
    }
    else{
    
    }
   

}
-(void)makeSeTV{
    
    
    
IOS_Frame
    [self makeARR];
    CGFloat hig =444;
    if (ConentViewHeight -140 < 444) {
        hig = ConentViewHeight -140;
    }
    
    _Tv =[[UITableView alloc]initWithFrame:CGRectMake(0, 140, ConentViewWidth, hig) style:UITableViewStylePlain];
    _Tv.delegate = self;
    _Tv.dataSource =self;
    _Tv.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_Tv];

// 顶部电话
    UIImageView * imaVie =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, 40)];
    imaVie.image =[UIImage imageNamed:@"rexian"];
    imaVie.userInteractionEnabled = YES;
    UITapGestureRecognizer * Tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapAACtio)];
    [imaVie addGestureRecognizer:Tap];
    
    [self.view addSubview:imaVie];
// 顶部图片
    UIImageView *baView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 40, ConentViewWidth, 100)];
    baView.image =[UIImage imageNamed: @"app_chengyaojiaru_pic"];
    [self.view addSubview:baView];
   
//右侧的
    TopView =[[UIView alloc]initWithFrame:CGRectMake(ConentViewWidth- 70, 0, 60, 60)];
    TopView.backgroundColor =BackColor;
    
    NSArray * arr =@[@"公司介绍",@"联系我们"];
    for (int i  = 0 ; i< arr.count; i++) {
        UIButton * but=[UIButton buttonWithType:UIButtonTypeCustom];
        [but setTitle:arr[i] forState:UIControlStateNormal];
        [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        but.frame =CGRectMake(0,5+ 30* i, 70, 19);
        but.titleLabel.font =[UIFont systemFontOfSize:14];
        //[but setBackgroundColor:[UIColor whiteColor]];
        but.tag = 11+i;
        [but addTarget:self action:@selector(ButAvyio:) forControlEvents:UIControlEventTouchUpInside];
        [TopView addSubview:but];

    }
    TopView.hidden = YES;
    [self.view addSubview:TopView];

}
-(void)TapAACtio{
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://037165990055"]];

}
-(void)ButAvyio:(UIButton * )Btn{
    if (Btn.tag == 11) {
        JIanJieViewController * JVC  =[[JIanJieViewController alloc]init];
        JVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:JVC animated:YES];
        //(@"%d",Btn.tag);

        //(@"%d",Btn.tag);
    }
    else if(Btn.tag ==12){
        LianXiMeViewController * Lvc =[[LianXiMeViewController alloc]init];
        Lvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:Lvc animated:YES];
        //(@"%d",Btn.tag);

            }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //(@"%d",indexPath.row);
    
    if (indexPath.row == 0) {
        ShenqingquyudaiViewController *Qvc =[[ShenqingquyudaiViewController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:Qvc animated:YES];
    }
    else  if(indexPath.row == 1){
        ShangJRZViewController * SVc =[[ShangJRZViewController alloc]init];
        SVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:SVc animated:YES];
        
    }
    else  if(indexPath.row == 2){
        
        GUANGGAOViewController *Gvc =[[GUANGGAOViewController alloc]init];
        Gvc.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:Gvc animated:YES];
    }
    else  if(indexPath.row == 3){//#import "ZiyuashenqViewController.h"

        ZiyuashenqViewController * Zvc =[[ZiyuashenqViewController alloc]init];
       Zvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:Zvc animated:YES];
    }
    


 

}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  111;

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section{
    return  ImaArr.count;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CYRUXCTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell =[[[NSBundle mainBundle]loadNibNamed:@"CYRUXCTableViewCell" owner:self options:nil]lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell cellMakeWith:TitleArr[indexPath.row] andimaArr:ImaArr[indexPath.row] andconcentArr:concentArr[indexPath.row]];
    return cell;



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

@end
