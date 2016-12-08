//
//  WSMoreViewController.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-4-10.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "WSMoreViewController.h"
#import "AFNetworking.h"
#import "MoreFLView.h"
#import "moreBrtn.h"
#import "ThirdViewController.h"
@interface WSMoreViewController ()

@end

@implementation WSMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
       self.view.backgroundColor =BackColor;
    // Do any additional setup after loading the view.
    
    self.navigationItem.title=@"更多分类";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self makeWSBackScrollView];
    [self creatMoreData];
    UIButton *BackBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    BackBtn.frame =CGRectMake(0, 0, 64, 27);
    [BackBtn  setBackgroundImage:[UIImage imageNamed:@"app_fanhui"] forState:UIControlStateNormal];
    // [BackBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    
    [BackBtn addTarget:self action:@selector(BackAction)  forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem =[[UIBarButtonItem alloc]initWithCustomView:BackBtn];
    self.navigationItem.leftBarButtonItem = backItem;
}
-(void)makeWSBackScrollView{
    BackScrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, ConentViewHeight)];
    BackScrollView.delegate =self;
    BackScrollView.contentSize =CGSizeMake(ConentViewWidth, ConentViewHeight );
    BackScrollView.bounces = NO;
    BackScrollView.backgroundColor =BackColor;
    BackScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:BackScrollView];

}
-(void)BackAction{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)creatMoreData{

    NSString *ShouY = [NSString stringWithFormat:WANMOREMM];
    //(@"%@ == shou",ShouY);
    ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    
    [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DataArr =[[NSMutableArray alloc]initWithArray:responseObject];
 
        
        [self makeMoreUI];
           } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
               
               UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
               [failAlView show];

        //(@"cook load failed ,%@",error);
    }];

}
-(void)makeMoreUI{
    IOS_Frame
    float HIngt  =  0;
    for (int i = 0; i<DataArr.count; i++) {
//        //(@"    %@   " ,[DataArr[i] objectForKey:@"value"]);
        SmallArr =[[NSMutableArray alloc]initWithArray:[DataArr[i] objectForKey:@"children"]];
        
        MoreFLView * MVView =[[[NSBundle mainBundle]loadNibNamed:@"MoreFLView" owner:self options:nil]lastObject];
        MVView.NameLabel.text =[NSString stringWithFormat:@"%@",[DataArr[i] objectForKey:@"value"]];
        MVView.frame =CGRectMake(0,   HIngt  , ConentViewWidth, 40 + 30 *( SmallArr.count/3 +1)   );
        for (int j = 0; j< SmallArr.count; j++) {
//             //(@"%@" ,[SmallArr[i] objectForKey:@"value"]);
         
            moreBrtn *Btn =[moreBrtn buttonWithType:UIButtonTypeCustom];
            CGFloat BtnWeath = (ConentViewWidth - 80)/3;
            
            Btn.frame =CGRectMake( 25 + (BtnWeath +20) *(j %3) , 40 + 30 *(j/3) ,BtnWeath , 20);
            Btn.layer.cornerRadius = 3;
            Btn.backgroundColor = [UIColor whiteColor];
            Btn.IDStr = [SmallArr[j] objectForKey:@"id"];
            Btn.titleLabel.font =[UIFont systemFontOfSize:13];
            [Btn setTitle:[SmallArr[j] objectForKey:@"value"] forState:UIControlStateNormal];
            [Btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [Btn addTarget:self action:@selector(morBtnAct:) forControlEvents:UIControlEventTouchUpInside];
            [MVView addSubview:Btn];
            
        }
        HIngt =  MVView.frame.origin.y + MVView.frame.size.height;
        [BackScrollView addSubview:MVView];
    }
    
    BackScrollView.contentSize =CGSizeMake(ConentViewWidth, HIngt);
}
-(void)morBtnAct:(moreBrtn *)Btn{
    
    
    ThirdViewController *Tvc =[[ThirdViewController alloc]initWithcateId:Btn.IDStr];
    [self.navigationController pushViewController:Tvc  animated:YES];
   

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
