//
//  ZLViewController.m
//  HuaHuaNiu
//
//  Created by mac on 16/11/19.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "ZLViewController.h"
#import "ItemView.h"
@interface ZLViewController ()
@property (weak, nonatomic) IBOutlet UIView *aboveView;//约束在scrollview上的view


@end

@implementation ZLViewController
{
    int ageNum;//年龄的个数
    int industryNum;//行业的个数
    int recordNum;//学历的个数
    int shoppingNum;//购物习惯的个数
    int likeNum;//兴趣爱好的个数

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"基本资料";
    //性别
    [self viewWithSexStyle];
    //年龄
    [self viewWithAgeStyle];
    //行业
    [self viewWithIndustryStyle];
    //地区
    [self viewWithQuyu];
    //学历
    [self viewWithRecordStyle];
    //子女情况
    [self viewWithChildStyle];
    //购物习惯
    [self viewWithsShoppingStyle];
    //兴趣爱好
    [self viewWithsLikeStyle];
    //重置保存按钮
    [self viewWithBtnStyle];


}
-(void)viewWithSexStyle{
    NSMutableArray * arr = [NSMutableArray arrayWithObjects:@"男",@"女",nil];
    ItemView *itemView = [[ItemView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, 70) withData:arr withTitle:@"性别"];
    [self.aboveView addSubview:itemView];
    itemView.columns = 4;
    
}
-(void)viewWithAgeStyle{
    NSMutableArray * arr = [NSMutableArray arrayWithObjects:@"18岁以下",@"18-27岁",@"28-37岁",@"38-47岁",@"48-57岁",@"60岁以上",nil];
    ageNum= (arr.count%4 == 0 )? (int)arr.count/4 :(int)(arr.count/4)+1;
    ItemView *itemView = [[ItemView alloc]initWithFrame:CGRectMake(0, 70, ConentViewWidth, ageNum*40+30) withData:arr withTitle:@"年龄"];
    [self.aboveView addSubview:itemView];
    itemView.columns = 4;
    
}
-(void)viewWithIndustryStyle{
    NSMutableArray * arr = [NSMutableArray arrayWithObjects:@"IT科技",@"电商",@"财经金融",@"创投管理",@"房产家居",@"广告公关",@"IT科技",@"电商",@"财经金融",@"创投管理",@"房产家居",@"广告公关",@"IT科技",@"电商",@"财经金融",@"创投管理",@"房产家居",@"广告公关",nil];
    
    industryNum= (arr.count%4 == 0 )? (int)arr.count/4 :(int)(arr.count/4)+1;
    int y=100+ageNum*40;
    ItemView *itemView = [[ItemView alloc]initWithFrame:CGRectMake(0, y, ConentViewWidth, industryNum*40+30) withData:arr withTitle:@"行业"];
    [self.aboveView addSubview:itemView];
    itemView.columns = 4;
    
}
-(void)viewWithQuyu{
    int y=130+ageNum*40+industryNum*40;
    UIView *views=[[UIView alloc]initWithFrame:CGRectMake(0, y, ConentViewWidth, 40)];
    UILabel *labl=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 30)];
    labl.text=@"地区";
    labl.font=[UIFont systemFontOfSize:15];
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(15, 39, ConentViewWidth-30, 1)];
    lineView.backgroundColor=[UIColor colorWithWhite:0.969 alpha:1.000];
    [views addSubview:lineView];
    [views addSubview:labl];
    [self.aboveView addSubview:views];

}
-(void)viewWithRecordStyle{
    NSMutableArray * arr = [NSMutableArray arrayWithObjects:@"高中及以下",@"大专",@"本科",@"硕士及以上",nil];
    recordNum= (arr.count%4 == 0 )? (int)arr.count/4 :(int)(arr.count/4)+1;
    int y=170+ageNum*40+industryNum*40;
    ItemView *itemView = [[ItemView alloc]initWithFrame:CGRectMake(0, y, ConentViewWidth, recordNum*40+30) withData:arr withTitle:@"学历"];
    [self.aboveView addSubview:itemView];
    itemView.columns = 4;
    
}
-(void)viewWithChildStyle{
    NSMutableArray * arr = [NSMutableArray arrayWithObjects:@"有",@"无",nil];
    int y=200+ageNum*40+industryNum*40+recordNum*40;
    ItemView *itemView = [[ItemView alloc]initWithFrame:CGRectMake(0, y, ConentViewWidth, 70) withData:arr withTitle:@"子女情况"];
    [self.aboveView addSubview:itemView];
    itemView.columns = 4;
    
}
-(void)viewWithsShoppingStyle{
    NSMutableArray * arr = [NSMutableArray arrayWithObjects:@"网上",@"实体店",@"海外",nil];
    int y=270+ageNum*40+industryNum*40+recordNum*40;
    shoppingNum= (arr.count%4 == 0 )? (int)arr.count/4 :(int)(arr.count/4)+1;
    ItemView *itemView = [[ItemView alloc]initWithFrame:CGRectMake(0, y, ConentViewWidth, shoppingNum*40+30) withData:arr withTitle:@"购物习惯"];
    [self.aboveView addSubview:itemView];
    itemView.columns = 4;
    
}
-(void)viewWithsLikeStyle{
    NSMutableArray * arr = [NSMutableArray arrayWithObjects:@"运动旅游",@"实音乐舞蹈",@"写作阅读",@"运动旅游",@"实音乐舞蹈",@"写作阅读",@"运动旅游",@"实音乐舞蹈",nil];
    int y=300+ageNum*40+industryNum*40+recordNum*40+shoppingNum*40;
    likeNum= (arr.count%4 == 0 )? (int)arr.count/4 :(int)(arr.count/4)+1;
    ItemView *itemView = [[ItemView alloc]initWithFrame:CGRectMake(0, y, ConentViewWidth, likeNum*40+30) withData:arr withTitle:@"兴趣爱好"];
    [self.aboveView addSubview:itemView];
    itemView.columns = 4;
    
}

-(void)viewWithBtnStyle{
     int y=380+ageNum*40+industryNum*40+recordNum*40+shoppingNum*40+likeNum*40;
    UIView *leftView=[[UIView alloc]initWithFrame:CGRectMake(0, y, ConentViewWidth/2, 40)];
     UIView *rightView=[[UIView alloc]initWithFrame:CGRectMake(ConentViewWidth/2, y, ConentViewWidth/2, 40)];
    UIButton *leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(10, 0, leftView.frame.size.width-20, 40)];
    [leftBtn setTitle:@"重置" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor colorWithWhite:0.686 alpha:1.000] forState:UIControlStateNormal];
     UIButton *rightBtn=[[UIButton alloc]initWithFrame:CGRectMake(10, 0, rightView.frame.size.width-20, 40)];
     [rightBtn setTitle:@"保存" forState:UIControlStateNormal];
    leftBtn.backgroundColor=[UIColor whiteColor];
    leftBtn.layer.cornerRadius=15;
    leftBtn.layer.borderWidth=1;
    leftBtn.layer.borderColor=GrayColor.CGColor;
    rightBtn.backgroundColor=[UIColor colorWithRed:0.047 green:0.364 blue:0.663 alpha:1];
    rightBtn.layer.cornerRadius=15;
   
    [leftView addSubview:leftBtn];
    [rightView addSubview:rightBtn];
    
    [self.aboveView addSubview:leftView];
    [self.aboveView addSubview:rightView];


}
@end
