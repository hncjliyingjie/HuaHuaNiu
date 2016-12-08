//
//  CitychooSSViewController.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15/6/28.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "CitychooSSViewController.h"
#import "AFNetworking.h"
#import "Toast+UIView.h"
#import "ChineseString.h"
#import "FirstViewController.h"
#import "YHCityChouseModel.h"
#import "YHCityChouseTableCell.h"


@interface CitychooSSViewController (){
    NSMutableArray * _cityTitleArr;
    NSMutableArray * _cityNameArr;
    NSMutableArray * _cityIndexArr;

}
@property (nonatomic, strong) NSMutableArray *cityarr;
@end

@implementation CitychooSSViewController

- (NSMutableArray *)cityarr{
    if (!_cityarr) {
        _cityarr = [NSMutableArray array];
    }
    return _cityarr;
}
- (void)viewDidLoad {
//  static  isStart= NO;
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
   
    self.navigationItem.title=@"城市选择";
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIButton *BackBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    BackBtn.frame =CGRectMake(0, 0, 64, 27);
    [BackBtn  setBackgroundImage:[UIImage imageNamed:@"app_fanhui"] forState:UIControlStateNormal];
    
    // [BackBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    
    [BackBtn addTarget:self action:@selector(BackAction)  forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem =[[UIBarButtonItem alloc]initWithCustomView:BackBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    //@[@"热",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"G",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
   
    [self makeCityTV];
    [self makeTVData];
}
-(void)BackAction{

    [self.navigationController popViewControllerAnimated:YES];
}
-(void)makeCityTV{
    IOS_Frame
    DataArr =[[NSMutableArray alloc]init];
    _TV  =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, ConentViewHeight) style:UITableViewStylePlain];
    _TV.delegate=self;
    _TV.dataSource =self;
    _TV.sectionIndexBackgroundColor = [UIColor whiteColor];
    _TV.sectionIndexColor =[UIColor  grayColor];
   
    UIView * topview =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, 30)];
    cityLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, 30)];
    cityLabel.font =[UIFont systemFontOfSize:14];
    NSUserDefaults * USerdefault =[NSUserDefaults standardUserDefaults];
    if ([USerdefault objectForKey:@"CITYNAME"]) {
    cityLabel.text =[NSString stringWithFormat:@"当前城市:%@",[USerdefault objectForKey:@"CITYNAME"]];
    }
    [topview addSubview:cityLabel];
    _TV.tableHeaderView = topview;
    [self.view addSubview:_TV];

}
#pragma mark 请求数据
-(void)makeTVData{
//    titleArr =[NSMutableArray array];
//    titleArr2 =[NSMutableArray array];
    // 每次请求 或者在首页请求 在后边去取
    // 请求数据
//    [self.view makeToastActivity];
//    NSString *ShouY = [NSString stringWithFormat:@"http://182.92.66.70:8080/index.php?app=api&act=getallcitybyindex"];
//   // NSString *ShouY = [NSString stringWithFormat:DAOJIAStr,@"34.763815678878,113.63489789543"];
//    ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
//    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/plain",@"text/html",nil];
//    
//    [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        [self.view hideToastActivity];
//        dic =[[NSDictionary alloc]initWithDictionary:[responseObject objectForKey:@"retval"]];
//        
//        NSArray *allkey =[dic allKeys];
//        //(@"allkey  = %@",allkey);
//       
//        titleArr =[[NSMutableArray alloc]init];
      // [titleArr insertObject:@"热" atIndex:0];
//
//        //  cityLabel  赋值 当前城市  
//        [_TV reloadData];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [self.view hideToastActivity];
//        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//        [failAlView show];
//        //(@"cook load failed ,%@",error);
//    }];
    NSUserDefaults * nsuserdefault =[NSUserDefaults standardUserDefaults];
    titleArr =[NSMutableArray array];
    titleArr2 =[NSMutableArray array];
    
    _cityTitleArr =[NSMutableArray array];
    _cityNameArr = [NSMutableArray array];
    _cityIndexArr =[NSMutableArray array];
//       dic =[[NSDictionary alloc]initWithDictionary:[ nsuserdefault objectForKey:@"CITYLIEBIAO"]];

//            NSArray *allkey =[dic allKeys];
//            //(@"allkey  = %@",allkey);
//    
    DataArr =[[NSMutableArray alloc]initWithArray:[nsuserdefault objectForKey:@"CITYLIEBIAO"]];
    //使用字典转模型
//    
//    [DataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        YHCityChouseModel *model = [YHCityChouseModel modelWithDict:obj];
//        
//        [self.cityarr addObject:model];
//        
//        if ([obj isKindOfClass:[NSArray class]]) {
//            [obj enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                YHCityChouseModel *model = [YHCityChouseModel modelWithDict:obj];
//                
//                [self.cityarr addObject:model];
//            }];
//        }
//    }];
    
    
    for (NSDictionary * dict in DataArr) {
        YHCityChouseModel *model = [YHCityChouseModel modelWithDict:dict];
        [self.cityarr addObject:model];
        
        NSArray * citys =  [dict objectForKey:@"children"];
        for (NSDictionary * dict2 in citys) {
            YHCityChouseModel *model = [YHCityChouseModel modelWithDict:dict2];
            [self.cityarr addObject:model];
            
            NSString * cityName = [dict2 objectForKey:@"region_name"];
            [_cityNameArr addObject:cityName];
            NSArray * xianCheng =[NSArray arrayWithArray:[dict2 objectForKey:@"children"]];
            if (xianCheng.count !=0) {
                YHCityChouseModel *model = [YHCityChouseModel modelWithDict:dict2];
                [self.cityarr addObject:model];
                
                for (NSDictionary * dict3 in xianCheng) {
                    NSString * xianchengName =[dict3 objectForKey:@"region_name"];
                    [_cityNameArr addObject:xianchengName];
                }
            }
        }
    }
    
    
    

    _cityTitleArr =[ChineseString LetterSortArray:_cityNameArr];
//        _cityTitleArr =[ChineseString LetterSortModelArray:self.cityarr];

//    NSMutableArray * tmpArr2 =[NSMutableArray array];
//    for (NSArray * tmpArr in _cityNameArr) {
//        for (NSString * tmpStr in tmpArr) {
//            [tmpArr2 addObject:tmpStr ];
//        }
//    }
//    _cityNameArr =[NSMutableArray arrayWithArray:tmpArr2];


    _cityIndexArr =[ChineseString IndexArray:_cityNameArr];

    [_TV reloadData];

}
#pragma mark 分组的标题
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    bgView.backgroundColor = [UIColor lightGrayColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 5, 250, 20)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:14];
    NSString * titstr =_cityIndexArr[section];
    titleLabel.text = titstr;
    
    [bgView addSubview:titleLabel];
    
    return bgView;

}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
// 分组个数；
//    NSString * str =[titleArr objectAtIndex:section];\int
//    int n =0;
//    for (NSDictionary * dict in DataArr) {
//        if([[dict objectForKey:@"region_name"]isEqualToString:_cityNameArr[section]]){
//            break;
//        }
//        n++;
//    }
//    NSArray * numberar =titleArr[n];
    
    NSArray * arr =[NSArray arrayWithArray:_cityTitleArr[section]];
    return arr.count;

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
// 分组个数
    return  _cityIndexArr.count;

}
#pragma mark 右侧名字
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{

    return [_cityIndexArr copy];

//    for (NSDictionary * dict in DataArr) {
//        NSString * str = [NSString stringWithFormat:@"%@",[dict objectForKey:@"region_id"]];
//        //(@"%@",str);
//        [titleArr2 addObject:str];
//    }
//   return [titleArr2 copy];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  //
    //(@"sec==%ld    row ==%ld",(long)indexPath.section ,(long)indexPath.row);
//把选中的数据存到   userdefault里面
    
    NSArray  * eeee  =[NSArray arrayWithArray:[_cityTitleArr objectAtIndex:indexPath.section]];
    NSString * str = eeee[indexPath.row];
    
    int n =0;

    for (NSDictionary * dict in DataArr) {
        NSArray * citys =  [NSArray arrayWithArray:[dict objectForKey:@"children"]];
        int x =0;
        for (NSDictionary * dict2 in citys) {
            
            NSString * cityName = [dict2 objectForKey:@"region_name"];
            if ([cityName isEqualToString:str]) {
                
                NSString * quyuid
                ;
                NSDictionary * dict11 = DataArr[n];
                NSArray *arr11 =[NSArray arrayWithArray:[dict11 objectForKey:@"children"]];
                NSDictionary * dict22 = arr11[x];
                quyuid  =[NSString stringWithFormat:@"%@",[dict22 objectForKey:@"region_id"]];
                
                //(@"ccccc%@",quyuid);
                
                NSUserDefaults * nsuserDefaule =[NSUserDefaults standardUserDefaults];
                
                [nsuserDefaule setObject:quyuid forKey:@"QUYUID"];
                [nsuserDefaule setObject:[dict22 objectForKey:@"region_name"] forKey:@"CITYNAME"];
                NSUserDefaults *Userdefaults =[NSUserDefaults standardUserDefaults];
//                NSLog(@"%@",[Userdefaults objectForKey:@"CITYNAME"]);
                [nsuserDefaule synchronize];
                [self.navigationController  popViewControllerAnimated:YES];
                return;
                
                
                
            }
            
            NSArray * xianCheng =[NSArray arrayWithArray:[dict2 objectForKey:@"children"]];
            if (xianCheng.count != 0) {
                int y =0;
                for (NSDictionary * dict3 in xianCheng) {
                    NSString * xianchengName =[dict3 objectForKey:@"region_name"];
                    if ([xianchengName isEqualToString:str]) {

                        NSString * quyuid ;
                        NSDictionary * dict11 = DataArr[n];
                        NSArray *arr11 =[NSArray arrayWithArray:[dict11 objectForKey:@"children"]];
                        NSDictionary * dict22 = arr11[x];
                        NSArray *arr22 =[NSArray arrayWithArray:[dict22 objectForKey:@"children"]];
                        
                        NSDictionary * dict33 = arr22[y];
                        //region_id  parent_id
                        quyuid =[NSString stringWithFormat:@"%@",[dict33 objectForKey:@"parent_id"]];
                        
                        
                        //(@"ccccc%@",quyuid);
                        
                        NSUserDefaults * nsuserDefaule =[NSUserDefaults standardUserDefaults];
                        [nsuserDefaule setObject:quyuid forKey:@"QUYUID"];
                        [nsuserDefaule setObject:[dict33 objectForKey:@"region_name"] forKey:@"CITYNAME"];
                        [nsuserDefaule synchronize];
                        [self.navigationController  popViewControllerAnimated:YES];
                        return;
                    
                    }
                    if(y ==xianCheng.count){
                        break;
                    }
                    y++;
                }
            }
            if(x == citys.count){
                break;
            }
            x++;
        }
        if(n ==DataArr.count){
            break;
        }
        n++;
    }
    //修改首页 iscomefromecity 的属性参数
    
    

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    //(@"title===%@",title);
    return index;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YHCityChouseTableCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell ==nil) {
        cell =[[YHCityChouseTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.textLabel.font =[UIFont systemFontOfSize:14];
        
         }
    NSArray * tmpArr= [NSArray arrayWithArray:_cityTitleArr[indexPath.section]];
    cell.textLabel.text =tmpArr[indexPath.row];
    
    
//    YHCityChouseModel *model = self.cityarr[indexPath.row];
//    
//    cell.textLabel.text =model.region_name;
    
    
    
//    int n = 0;
//    for (NSDictionary * dict in DataArr) {
//        if([[dict objectForKey:@"region_name"]isEqualToString:_cityNameArr[indexPath.section]]){
//            break;
//        }
//        n++;
//    }
//    NSArray * numberar =titleArr[n];
//    NSDictionary * daaddic =[numberar objectAtIndex:indexPath.row];
//    
//        cell.textLabel.text =[NSString stringWithFormat:@"%@",[daaddic objectForKey:@"region_name"]];
//        cell.detailTextLabel.text =[NSString stringWithFormat:@"%@",[daaddic objectForKey:@"region_id"]];
//        //(@"id  == %@",[NSString stringWithFormat:@"%@",[daaddic objectForKey:@"region_id"]]);
  
    return cell;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
