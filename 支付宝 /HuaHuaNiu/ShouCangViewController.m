//
//  ShouCangViewController.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-25.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "ShouCangViewController.h"
#import "ProductDetailViewController.h"
#import "StoreDetailsViewController.h"
#import "SCStoreTableViewCell.h"
#import "ProductSTableViewCell.h"
#import "AFNetworking.h"
#import "Toast+UIView.h"
@interface ShouCangViewController ()

@end

@implementation ShouCangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatData];
    [self makeTopView];
    isproductdele = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    ProductDataArr =[[NSMutableArray alloc]init];
    StoreDataArr =[[NSMutableArray alloc]init];

    //返回按钮
    UIImage *lbbImage = [UIImage imageNamed:@"back_new"];
    lbbImage = [lbbImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem * lbbItem = [[UIBarButtonItem alloc] initWithImage:lbbImage style:UIBarButtonItemStylePlain target:self action:@selector(backClick)];
    self.navigationItem.leftBarButtonItem = lbbItem;
    self.navigationItem.title=@"收藏";
    
    UIButton *RightBr =[UIButton buttonWithType:UIButtonTypeCustom];
    RightBr.frame =CGRectMake(0, 0, 15, 15);
    [RightBr addTarget:self action:@selector(RighrAction) forControlEvents:UIControlEventTouchUpInside];
    
    // RightBr.backgroundColor =[UIColor whiteColor];
    // 删除的图标
    //[RightBr setBackgroundImage:[UIImage imageNamed:@"矢量智能对象1"] forState:UIControlStateNormal];
    
    
//UIBarButtonItem *rightItem =[[UIBarButtonItem alloc]initWithCustomView:RightBr];
    
  // self.navigationItem.rightBarButtonItem = rightItem;

}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
    
}
#pragma mark 创建数据
-(void)creatData{
    [self.view makeToastActivity];
    NSUserDefaults * userdefault =[NSUserDefaults standardUserDefaults];
    NSString *userID =[NSString stringWithFormat:@"%@",[userdefault objectForKey:@"Useid"]];
   
    NSString * ShouY= [NSString stringWithFormat:MYSHOUCANG, userID];
    ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //(@"%@",ShouY);
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    
    [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (!isproductdele) {
        NSDictionary * dic =[responseObject objectForKey:@"retval"];
        ProductDataArr =[dic objectForKey:@"goods"];
        StoreDataArr =[dic objectForKey:@"stores"];
        [self makeUI];
        
        
        if (Storelabel) {
            
        }
        else{
            Storelabel =[[UILabel alloc]initWithFrame:CGRectMake(30, ConentViewHeight/2 - 100 , ConentViewWidth - 60  , 30)];
        }
            Storelabel.textAlignment = NSTextAlignmentCenter;
            Storelabel.text =@"暂无数据";
            Storelabel.font =[UIFont systemFontOfSize:13];
            [self.view addSubview:Storelabel];

        if(StoreDataArr.count == 0){
            
                        Storelabel.hidden = NO;
        }
        else{
            
            Storelabel.hidden =YES;
        }
        
        
        }
        else{
        
            NSDictionary * dic =[responseObject objectForKey:@"retval"];
            ProductDataArr =[dic objectForKey:@"goods"];
          
        
            [ProductTV reloadData];
            if(ProductDataArr.count == 0){
                  Storelabel.hidden = NO;
            ProductTV.frame =CGRectMake(0, 0, ConentViewWidth, 88*ProductDataArr.count);
                
            }
            else{
                
                Storelabel.hidden =YES;
            }

        
        
        }
        

        
        [self.view hideToastActivity];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.view hideToastActivity];
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        failAlView.tag =12;
        [failAlView show];
        //(@"cook load failed ,%@",error);
    }];
    
    
    
    


}
#pragma mark 删除数据
-(void)deleDataType:(NSString *)Type andStr:(NSString *)str{



}
-(void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)makeTopView{
    UIView *topView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    
    
    StoreBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    StoreBtn.frame=CGRectMake(0, 0, 50, 30);
    
    [StoreBtn setTitle:@"商家" forState:UIControlStateNormal];
    [StoreBtn addTarget:self action:@selector(StoreActionchan) forControlEvents:UIControlEventTouchUpInside];
//    [StoreBtn setBackgroundColor:[UIColor colorWithRed:246/255.0 green:125/255.0 blue:127/255.0 alpha:1]];
    [topView addSubview:StoreBtn];

    ProductBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    ProductBtn.frame=CGRectMake(51, 0, 49, 30);
    
    [ProductBtn setTitle:@"产品" forState:UIControlStateNormal];
    [ProductBtn addTarget:self action:@selector(ProductActionChan) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:ProductBtn];
    

    
    self.navigationItem.titleView = topView;
}
-(void)makeUI{
    IOS_Frame
    if (StorTV) {
       
    }
    else{
        StorTV =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, ConentViewHeight)style:UITableViewStylePlain];
        ProductTV =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, ConentViewHeight) style:UITableViewStylePlain];
        
    }
    
        if (StoreDataArr.count< 6) {
        StorTV.frame =CGRectMake(0, 0, ConentViewWidth, 88*StoreDataArr.count);
        StorTV.scrollEnabled = NO;
    }
        else{
            StorTV.frame =CGRectMake(0, 0, ConentViewWidth, ConentViewHeight);
        }
    
    StorTV.delegate =self;
    StorTV.dataSource =self;
    
       if (ProductDataArr.count < 6) {
        ProductTV.frame =CGRectMake(0, 0, ConentViewWidth, 88*ProductDataArr.count);
        ProductTV.scrollEnabled = NO;
    }
       else{
           ProductTV.frame =CGRectMake(0, 0, ConentViewWidth, ConentViewHeight);
       }
    ProductTV.delegate =self;
    ProductTV.dataSource =self;
    ProductTV.hidden = YES;
    [self.view addSubview:ProductTV];
    
    [self.view addSubview:StorTV];

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 88;
}
-(void)RighrAction{
    
    HIddle =!HIddle;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == StorTV){
        NSString * SoreID =[NSString stringWithFormat:@"%@",[StoreDataArr[indexPath.row]objectForKey:@"store_id"]];
        StoreDetailsViewController *svc =[[StoreDetailsViewController alloc]initWithStr:SoreID];
        [self.navigationController pushViewController:svc animated:YES];
    
    }
    else{
            NSString * ProductId =[NSString stringWithFormat:@"%@",[ProductDataArr[indexPath.row]objectForKey:@"goods_id"]];
        ProductDetailViewController *pvc =[[ProductDetailViewController alloc]initWithStr:ProductId];
        [self.navigationController pushViewController:pvc animated:YES];
        
    
    
    
    
    }




}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   if ( tableView == StorTV) {
        SCStoreTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell =[[[NSBundle mainBundle]loadNibNamed:@"SCStoreTableViewCell" owner:self options:nil]lastObject];
        }
       NSMutableDictionary *dic =[[NSMutableDictionary alloc]initWithDictionary:StoreDataArr[indexPath.row]];
//       [dic setValue:@"商家名字商家名字商家名字商家名字商家名字商家名字商家名字商家名字" forKey:@"wer"];
       [cell makeWithDic:dic];
       if (HIddle) {
           cell.DeleBtn.hidden = YES;
       }else{
       cell.DeleBtn.hidden = YES;
       }
       [cell deleBee:^{
           //  删除 传参 item_id

           [self deleDataType:@"store" andStr:@"item_id"];
           // 删除  刷新数据
           [self creatData];
  
       }];
       
       cell.selectionStyle =UITableViewCellSelectionStyleNone;
       
       
       
       UILongPressGestureRecognizer *longPress =[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(shanjia:)];
       cell.tag  = 400+indexPath.row;
       
       [cell addGestureRecognizer:longPress];
       
        return cell;
    }
    else{
        ProductSTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell =[[[NSBundle mainBundle]loadNibNamed:@"ProductSTableViewCell" owner:self options:nil]lastObject];
        }
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
//        cell.ShouchuLabel.hidden = YES;
        NSMutableDictionary *Dic =[[NSMutableDictionary alloc]initWithDictionary:ProductDataArr[indexPath.row]];
       [ cell makeProductDic:Dic];
        
        UILongPressGestureRecognizer *tap =[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(chanpin:)];
        
        cell.tag= 200+indexPath.row;
        [cell addGestureRecognizer:tap];
        
        if (HIddle) {
            cell.DeleBtn.hidden = YES;
        }else{
            cell.DeleBtn.hidden = YES;
        }
        [cell deleBee:^{
            //  删除 传参 item_id
            [self deleDataType:@"goods" andStr:@"item_id"];

            // 删除  刷新数据
            
            
            [self creatData];
            
        }];
        return cell;
    }
    
}
-(void)shanjia:(UILongPressGestureRecognizer *)tap{
 
    if(tap.state==UIGestureRecognizerStateBegan){
        int a =tap.view.tag - 400;
   NSString *stree =[NSString stringWithFormat:@"%@",[StoreDataArr[a] objectForKey:@"favorite_id"]];
        
        [self deleteType:@"store" andId:stree];
    //(@"删除 商家 %@",StoreDataArr[a]);
    }
}
-(void)chanpin:(UILongPressGestureRecognizer *)tap{
    if(tap.state==UIGestureRecognizerStateBegan){
        
        [self deeeddddd:@""];
        int a =tap.view.tag - 200;
        NSString * strrrr =[NSString stringWithFormat:@"%@",[ProductDataArr[a] objectForKey:@"favorite_id"]];
        [self deleteType:@"goods" andId:strrrr];
        
        //(@"删除 产品 %@",ProductDataArr[a]);
    }
   
}
-(void)deeeddddd:(NSString *)str{



}
-(void)deleteType:(NSString *)type andId:(NSString *)str{
    UIAlertView   * deleAl=[[UIAlertView alloc]initWithTitle:@"提示" message:@"确定要删除该收藏！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    ttye = type;
    ssstr  =str;

    [deleAl show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag == 12||alertView.tag ==11){
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
    if (buttonIndex == 1) {
        [self.view makeToastActivity];

        NSString * ShouY= [NSString stringWithFormat:DELEShouCAN,ssstr];
        //(@"%@",ShouY);
        ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
       
        AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
        
        [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            [self creatData];

            [self.view hideToastActivity];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self.view hideToastActivity];
            UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            failAlView.tag =11;
            [failAlView show];
            //(@"cook load failed ,%@",error);
        }];
        
        

    }
    else{
    
    }
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == StorTV) {
        
        return  StoreDataArr.count;
    }
    else{
    
    return  ProductDataArr.count;
    }
  //  return  StoreDataArr.count;

}


-(void)StoreActionchan{
    StorTV.hidden = NO;
    ProductTV.hidden = YES;
    
    if(StoreDataArr.count == 0){
        Storelabel.hidden = NO;
    }
    else{
        Storelabel.hidden =YES;
    }

}

-(void)ProductActionChan{
    StorTV.hidden = YES;
    ProductTV.hidden = NO;
    if(ProductDataArr.count == 0){

        Storelabel.hidden = NO;
    }
    else{
        
        Storelabel.hidden =YES;
    }

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
