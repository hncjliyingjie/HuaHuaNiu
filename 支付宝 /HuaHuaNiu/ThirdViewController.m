//
//  ThirdViewController.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-1.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "ThirdViewController.h"
#import "ChooseSTableViewCell.h"
#import "StoressssssTableViewCell.h"
#import "StoreDetailsViewController.h"
#import "AFNetworking.h"
#import "Toast+UIView.h"
@interface ThirdViewController ()

@end

@implementation ThirdViewController
-(id)initWithcateId:(NSString *)Str{
  
    self =[super init];
    if (self) {
        cates_ID = Str;
        ISSearCH = NO;
        orderStr =@"store_vol-desc";

    }
    return self;

}

-(id)initWithConcentStr:(NSString *)SearStr{
    self =[super init];
    if (self) {
        SearchConcent  = SearStr;
        ISSearCH = YES;
    }
    return self;
}

- (void)viewDidLoad {
    
    NSUserDefaults * userdefault =[NSUserDefaults standardUserDefaults];
    
    ll =[NSString stringWithFormat:@"%@",[userdefault objectForKey:@"ZUOBIAO"]];

    [super viewDidLoad];
    //导航栏设置
    [self maketopView];
// 创建的数据    搜索进入    分类进入    本界面的搜索 进入
    [self makeTableVie];
    [self makeUI];
    isFirstCome = YES;
    // 创建数据
    if (!ISSearCH) {  // 不是搜索进入的 本界面
       is_ll =@"0";
        [self makeFenLeiDataWithCates_Id:cates_ID];
        
    }
    else{  // 搜索进入的  请求不一样
    
        [self makeSearStoreData];
    }
    
      
    // Do any additional setup after loading the view from its nib.
}
#pragma mark 搜索进入
-(void)makeSearStoreData{
    [self.view makeToastActivity];
    NSString *ShouY = [NSString stringWithFormat:SearChSte, @"1",SearchConcent,ll];
    //(@"%@",ShouY);
    ShouY =[[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        StoreDataArr =[[NSMutableArray alloc]initWithArray:[responseObject objectForKey:@"stores"]];
       IOS_Frame
        
        StoreTv =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, ConentViewHeight -49) style:UITableViewStylePlain];
        StoreTv.delegate =self;
        StoreTv.dataSource =self;
        
        
        [self.view insertSubview:StoreTv atIndex:0];
        
        if (StoreDataArr.count < 6) {
            StoreTv.frame =CGRectMake(0, 0, ConentViewWidth, 75* StoreDataArr.count);
        }
        else{
            StoreTv.frame =CGRectMake(0, 0, ConentViewWidth, ConentViewHeight - 49);
        }
        [StoreTv reloadData];
        
      
   
        
        
        if(StoreDataArr.count== 0){
            
              tisishsl.hidden = NO;
            
            
        }
        else{
            
            tisishsl.hidden = YES;
            
        }

        [self.view hideToastActivity];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.view hideToastActivity];
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [failAlView show];

        //(@"cook load failed ,%@",error);
    }];
    
    
    
    



}


-(void)makeFenLeiDataWithCates_Id:(NSString *)Str{


  //  cates_ID 分类 id   ll区域 或者坐标 is_ll 坐标 0 区域id 1  排序 order
    // cate_id=%@&act=getstorelist&ll=%@&is_ll=%@&order=%@

    NSString * ShouY = [NSString stringWithFormat:WanshangFenLei,Str,ll,is_ll,orderStr,1];


    //(@"%@",ShouY);
   [self.view makeToastActivity];
   
    ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //(@"%@",ShouY);
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    
    [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
     
        [self makeStoreTv];
        // 刷新TableView
        // 分类
         allArr =[responseObject objectForKey:@"cates"];
        if (allArr.count< 7){
            FirstTv.frame= CGRectMake(0, 0, ConentViewWidth/2, 40*allArr.count);
        
        }
      // 距离
         ThirdDataArr =[[NSMutableArray alloc]initWithArray:[responseObject objectForKey:@"area"]];
          ForDataArr  =[[NSMutableArray alloc]initWithArray:[responseObject objectForKey:@"order"]];
        [FirstTv reloadData];
        
        [StoreDataArr removeAllObjects];
         StoreDataArr =[[NSMutableArray alloc]initWithArray:[responseObject objectForKey:@"stores"]];
        if (StoreDataArr.count < 6) {
            StoreTv.frame =CGRectMake(0, 30, ConentViewWidth, 75* StoreDataArr.count);
        }
        else{
            StoreTv.frame =CGRectMake(0, 30, ConentViewWidth, ConentViewHeight - 28);
        }

        [StoreTv reloadData];
        if (tisishsl) {
            
        }
        else{
           tisishsl =[[UILabel alloc]initWithFrame:CGRectMake(30, ConentViewHeight/2 - 100 , ConentViewWidth - 60  , 30)];
        }
  
        
        if(StoreDataArr.count== 0){
           
            
            tisishsl.textAlignment = NSTextAlignmentCenter;
            tisishsl.text =@"暂无数据";
            tisishsl.font =[UIFont systemFontOfSize:13];
            //[self.view addSubview:tisishsl];
            [self.view insertSubview:tisishsl atIndex:0];
            tisishsl.hidden = NO;

            
        }
        else{
            
            tisishsl.hidden = YES;
            
        }
        
        [self.view hideToastActivity];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.view hideToastActivity];
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [failAlView show];

        //(@"cook load failed ,%@",error);
    }];
    
    
    




}
-(void)makeStoreTv{
    if (StoreTv) {
        
    }
    else{
    StoreTv =[[UITableView alloc]initWithFrame:CGRectMake(0, 30, ConentViewWidth, ConentViewHeight - 28) style:UITableViewStylePlain];
    StoreTv.delegate =self;
    StoreTv.dataSource =self;
  
    
        [self.view insertSubview:StoreTv atIndex:0];
    //[self.view addSubview:StoreTv];
    }
}
-(void)makeTableVie{
   
  
    

    
    
      // 全部分类的 数据
//    allArr =[[NSArray alloc]initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"fenlei.plist" ofType:nil]];

    // 初始化数据源；
    FinallDataArr =[[NSMutableArray alloc]init];
    FirDataArr =[[NSMutableArray alloc]init];
    secDataArr =[[NSMutableArray alloc]init];
    ThirdDataArr =[[NSMutableArray alloc]init];
    ForDataArr =[[NSMutableArray alloc]init];
//   
//    for (NSDictionary *dic in allArr) {
//        [FirDataArr addObject:[dic objectForKey:@"state"]];
//    }
//    
//    secDataArr  =[[allArr objectAtIndex:0]objectForKey:@"cities"];
//    secDataArr =[secDataArr objectAtIndex:0];
    
//    ThirdDataArr =[[NSMutableArray alloc]initWithArray:@[@"全部",@"1km",@"2km",@"3km",@"4km",@"5km"]];

  
          UPView =[[UIView alloc]initWithFrame:CGRectMake(0, 30, ConentViewWidth,240)];
    UPView.hidden = NO;

    UPView.backgroundColor =[UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1];
    UPView.hidden = YES;
    [self.view addSubview:UPView];
    
    
//    
    FirstTv =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth/2, UPView.frame.size.height) style:UITableViewStylePlain];
    FirstTv.delegate =self;
    FirstTv.dataSource =self;
    FirstTv.scrollEnabled = NO;
    if(FirDataArr.count >6){
        FirstTv.scrollEnabled = YES;
    }
   // FirstTv.hidden = YES;
    [UPView addSubview:FirstTv];
    

    secondTv =[[UITableView alloc]initWithFrame:CGRectMake(ConentViewWidth/2, 0, ConentViewWidth/2, UPView.frame.size.height) style:UITableViewStylePlain];
    secondTv.delegate =self;
    secondTv.dataSource =self;
    secondTv.scrollEnabled = NO;
   // secondTv.hidden = YES;
    secondTv.backgroundColor =BackColor;
   [UPView addSubview:secondTv];
    
    ThirdTv =[[UITableView alloc]initWithFrame:CGRectMake(0, 30, ConentViewWidth, 200) style:UITableViewStylePlain];
    ThirdTv.delegate =self;
    ThirdTv.dataSource =self;
    ThirdTv.scrollEnabled = NO;
    ThirdTv.hidden = YES;
    [self.view addSubview:ThirdTv];
    
#pragma mark  城市 选择
    
//    CityTopView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, 230)];
//    CityTopView.backgroundColor = BackColor;
//    CityTopView.hidden =YES;

//    [self.view addSubview:CityTopView];
    

}
-(void)makeUI{
    IOS_Frame

    NSArray *ArrTit =@[@"全部分类",@"区域",@"距离"];
    for (int i = 0 ; i< 3; i++) {
   UIButton * AllBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    AllBtn.frame= CGRectMake(ConentViewWidth/3 * i, 0, ConentViewWidth/3-1, 30);
        [AllBtn setBackgroundColor: [UIColor whiteColor]];
        if (i == 3) {
         AllBtn.frame= CGRectMake(ConentViewWidth- ConentViewWidth/3, 0, ConentViewWidth/3, 30);
        }
        [AllBtn setTitle:ArrTit[i] forState:UIControlStateNormal];
        [AllBtn setImage:[UIImage imageNamed:@"app_huisanjiao"] forState:UIControlStateNormal];
        [AllBtn setImageEdgeInsets:UIEdgeInsetsMake(25, ConentViewWidth/3 -10, 0, 0)];
       [AllBtn setBackgroundColor:[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1]];
        [AllBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        AllBtn.tag =20+i;
        [AllBtn setImage:[UIImage imageNamed:@"app_hongsanjiao"] forState:UIControlStateSelected];
        [AllBtn addTarget:self action:@selector(AllBtnAction:) forControlEvents:UIControlEventTouchUpInside];
      //  AllBtn.backgroundColor =[UIColor whiteColor];
        [self.view addSubview:AllBtn];
        if(ISSearCH){  // 搜索的不要 分类
            AllBtn.hidden = YES;
            StoreTv.frame  = CGRectMake(0,0, ConentViewWidth, ConentViewHeight - 49);
           self.navigationItem.title=@"搜索结果";
        
        }else{
        AllBtn.hidden = NO;
        }
       
   
    }
    
}
-(void)AllBtnAction:(UIButton *)Btn{
    for (int i = 0 ; i<3; i++) {
        UIButton *ba =(UIButton *)[self.view viewWithTag:20+i];
        ba.selected = NO;
    }

    if (IsHide) {  // 隐藏
        IsHide = !IsHide;
        UPView.hidden = YES;
        ThirdTv.hidden  = YES;
            }
    else{  // 展示
        IsHide = !IsHide;
            Btn.selected= YES;
        
    if (Btn.tag ==20) {
        UPView.hidden = NO;
         ThirdTv.hidden = YES;
        //(@"全部分类");

       
    }
    else if(Btn.tag ==21){
    //(@"全部");
        isThree =  YES;
        ThirdTv.hidden = NO;
        UPView.hidden = YES;
        FinallDataArr = ThirdDataArr;
    //    ThirdTv.backgroundColor =[UIColor blackColor];
        [ThirdTv reloadData];
    }
    else{
        isThree = NO;
        UPView.hidden =YES;
        ThirdTv.hidden = NO;
         FinallDataArr = ForDataArr;
        [ThirdTv reloadData];
    ////(@"离我最近");

        }

    }
    
    if (tisishsl) {
        
    }
    else{
        tisishsl =[[UILabel alloc]initWithFrame:CGRectMake(30, ConentViewHeight/2 - 100 , ConentViewWidth - 60  , 30)];
        tisishsl.textAlignment = NSTextAlignmentCenter;
        tisishsl.text =@"暂无数据";
        tisishsl.font =[UIFont systemFontOfSize:13];
//        [self.view addSubview:tisishsl];
        [self.view insertSubview:tisishsl atIndex:0];
        
    }
}
//uitableViw相关
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
  //  //(@"%d",StoreDataArr.count);
    if (tableView ==FirstTv) {
        return allArr.count;
    }
    else if(tableView ==secondTv){
      return secDataArr.count;
    }
    else if(tableView ==ThirdTv){
        return FinallDataArr.count;
      }
    else if (tableView ==StoreTv){
    
        return StoreDataArr.count;
    }
    return  5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView ==StoreTv) {
        return 75;
    }
    return 40;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   

    if (tableView ==FirstTv) {
        secDataArr =[[NSMutableArray alloc]init];
        secDataArr =[[allArr objectAtIndex:indexPath.row] objectForKey:@"children"];
//        secDataArr =[secDataArr objectAtIndex:0];
        if (secDataArr.count <= 6) {
            secondTv.scrollEnabled = NO;
            secondTv.frame = CGRectMake(ConentViewWidth/2, 0, ConentViewWidth/2, 40*secDataArr.count);
        }
        else{
            secondTv.scrollEnabled = YES;
            secondTv.frame =CGRectMake(ConentViewWidth/2, 0, ConentViewWidth/2, UPView.frame.size.height);
        }
        
        [secondTv reloadData];
        
    }
   else if (tableView ==secondTv) {
        // 根据 标题进行 搜索
       cates_ID =[[secDataArr objectAtIndex:indexPath.row]objectForKey:@"id"];
       
      
       UPView.hidden = YES;
       ThirdTv.hidden = YES;
        UIButton *ba =(UIButton *)[self.view viewWithTag:20];
       ba.selected = NO;
       IsHide = !IsHide;
       [self makeFenLeiDataWithCates_Id:cates_ID];
       
    }
   else if(tableView == ThirdTv){
       if (isThree) {
           is_ll=@"1";
           AreaDic =[[NSMutableDictionary alloc]initWithDictionary:[FinallDataArr objectAtIndex:indexPath.row]];
           ll =[AreaDic objectForKey:@"region_id"];
       }
       else{
           PaiXuDic  =[[NSMutableDictionary alloc]initWithDictionary: [FinallDataArr objectAtIndex:indexPath.row]];
           orderStr =[NSString stringWithFormat:@"%@",[PaiXuDic objectForKey:@"value"]];
       }
       [self makeFenLeiDataWithCates_Id:cates_ID];
 
      
       UPView.hidden = YES;
       ThirdTv.hidden = YES;
       UIButton *ba =(UIButton *)[self.view viewWithTag:21];
       ba.selected = NO;
       UIButton *baa =(UIButton *)[self.view viewWithTag:22];
       baa.selected = NO;
       IsHide = !IsHide;

   }
   else if (tableView == StoreTv){
 
     //(@"商家详情%@", [[StoreDataArr objectAtIndex:indexPath.row]objectForKey:@"store_id"]);
       StoreDetailsViewController *svc =[[StoreDetailsViewController alloc]initWithStr:[[StoreDataArr objectAtIndex:indexPath.row]objectForKey:@"store_id"]];
       svc.hidesBottomBarWhenPushed = YES;
       [self.navigationController pushViewController:svc animated:YES];
         }



}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (tableView == StoreTv) {
      
        
        StoressssssTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if(cell == nil){
            cell =[[[NSBundle mainBundle]loadNibNamed:@"StoressssssTableViewCell" owner:nil options:nil]lastObject];
        }
        [cell MadddWithDic:[StoreDataArr objectAtIndex:indexPath.row]];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        return cell;
    }
    else{
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"indefint"];
        if (cell ==nil) {
            cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        }
    
        if (tableView == FirstTv) {
            NSString *SSSText =[[allArr objectAtIndex:indexPath.row] objectForKey:@"value"];
            cell.textLabel.text =SSSText;
        }
        else if (tableView ==secondTv){
           // cell.backgroundColor =[UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1];
            cell.backgroundColor = BackColor;
            cell.selectionStyle= UITableViewCellSelectionStyleNone;
           if (indexPath.row < secDataArr.count) {
                  cell.textLabel.text=[[secDataArr objectAtIndex:indexPath.row]objectForKey:@"value"];
                  
            }
        }
        else if (tableView == ThirdTv){
            
            ChooseSTableViewCell *Choosecell =[[[NSBundle mainBundle]loadNibNamed:@"ChooseSTableViewCell" owner:self options:nil]lastObject];
            if (isThree) {
                
            Choosecell.ConcentLabels.text =[[FinallDataArr objectAtIndex:indexPath.row] objectForKey:@"region_name"];
            }
            else{
                NSDictionary *cicdic =[[NSDictionary alloc]initWithDictionary:[FinallDataArr objectAtIndex:indexPath.row]];
             Choosecell.ConcentLabels.text =[cicdic objectForKey:@"name"] ;
            
            }
            Choosecell.selectionStyle =UITableViewCellSelectionStyleNone;
           //(@"===%f",Choosecell.textLabel.frame.size.width);
            return Choosecell;
        }
        
        
        return cell;
        
    }
    
  
}


-(void)maketopView{
 UIButton *BackBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    BackBtn.frame =CGRectMake(0, 0, 64, 27);
    [BackBtn  setBackgroundImage:[UIImage imageNamed:@"app_fanhui"] forState:UIControlStateNormal];
    // [BackBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    self.navigationItem.title=@"分类标题";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    

    [BackBtn addTarget:self action:@selector(BackAction)  forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem =[[UIBarButtonItem alloc]initWithCustomView:BackBtn];
    self.navigationItem.leftBarButtonItem = backItem;
}
-(void)BackAction{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
