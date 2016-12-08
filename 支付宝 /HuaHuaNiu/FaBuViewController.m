//
//  FaBuViewController.m
//  HuaHuaNiu
//
//  Created by alex on 15/12/25.
//  Copyright © 2015年 张燕. All rights reserved.
//

#import "FaBuViewController.h"
#import "HelpTableViewCell.h"
#import "QiuZhiViewController.h"
#import "HGSpecialViewController.h"
#import "sqqViewController.h"

@interface FaBuViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView * _tv;
    NSArray * _dataArr;
    
}
@property (nonatomic,copy) NSString *member;
@end

@implementation FaBuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr =[NSArray arrayWithObjects:@"我的视频",@"我的求职",@"我的社区",nil];
    NSUserDefaults *Userdefaults =[NSUserDefaults standardUserDefaults];
    _member = [Userdefaults objectForKey:@"Useid"];
    [self createUI];
    self.view.backgroundColor =[UIColor groupTableViewBackgroundColor] ;
    
    //返回按钮
    UIImage *lbbImage = [UIImage imageNamed:@"back_new"];
    lbbImage = [lbbImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem * lbbItem = [[UIBarButtonItem alloc] initWithImage:lbbImage style:UIBarButtonItemStylePlain target:self action:@selector(backClick)];
    self.navigationItem.leftBarButtonItem = lbbItem;
    
    self.navigationItem.title=@"我的发布";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       
       NSForegroundColorAttributeName:[UIColor colorWithRed:0.047 green:0.364 blue:0.663 alpha:1]}];
}

-(void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)createUI{
    _tv =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, ConentViewHeight) style:UITableViewStylePlain];
    _tv.dataSource =self;
    _tv.delegate =self;
    _tv.separatorStyle =UITableViewCellSeparatorStyleNone;
    _tv.backgroundColor =[UIColor clearColor];
    [self.view addSubview:_tv];
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HelpTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell =[[[NSBundle mainBundle]loadNibNamed:@"HelpTableViewCell" owner:self options:nil]lastObject];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.nameLB.text =_dataArr[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
    HGSpecialViewController *special=[[HGSpecialViewController alloc]init];
        special.hidesBottomBarWhenPushed= YES;
        special.count=1;
        special.member = _member;
        [self.navigationController pushViewController:special animated:YES];
    }
    else if(indexPath.row==1){
        QiuZhiViewController * hdvc =[[QiuZhiViewController alloc]init];
        hdvc.hidesBottomBarWhenPushed= YES;
//        hdvc.
        [self.navigationController pushViewController:hdvc animated:YES];
    }else{
        sqqViewController * hdvc =[[sqqViewController alloc]init];
        hdvc.count = 1;
        hdvc.member = _member;
        hdvc.hidesBottomBarWhenPushed= YES;
        //        hdvc.
        [self.navigationController pushViewController:hdvc animated:YES];
    }
    
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
    
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
