//
//  AddAddressViewController.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-3.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "AddAddressViewController.h"
#import "AFNetworking.h"
@interface AddAddressViewController (){
    NSString * region_name;
}

@end

@implementation AddAddressViewController

-(id)initWithDic:(NSDictionary *)Dic AndChang:(BOOL)change{
    self =[super init];
    if (self) {
        DataDic = Dic;
        IsChang = change;
    }
    
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    FirstAdd = NO;
    //获取城市信息
    [self makeCityData];
    
    // Do any additional setup after loading the view from its nib.
    UIButton *BackBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    BackBtn.frame =CGRectMake(0, 0, 64, 27);
    [BackBtn  setBackgroundImage:[UIImage imageNamed:@"app_fanhui"] forState:UIControlStateNormal];
    // [BackBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    
    [BackBtn addTarget:self action:@selector(BackAction)  forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem =[[UIBarButtonItem alloc]initWithCustomView:BackBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    self.navigationItem.title=@"添加收货地址";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
}

-(void)BackAction{
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)makeCityData{
    
    
    //    NSUserDefaults * userdefault =[NSUserDefaults standardUserDefaults];
    //    [userdefault objectForKey:@"Useid"];
    //    // 暂时没有用到 userid
    NSString * ShouY = [NSString stringWithFormat:AddSHDZ];
    ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",ShouY);
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray * arr =[[NSArray alloc]initWithArray:[responseObject objectForKey:@"retval"]];
        // 加载数据
        Provice =[[NSArray alloc]initWithArray:arr];

        Citys =[[NSArray alloc]init];
        areas =[[NSArray alloc]init];

        Citys =[[Provice objectAtIndex:0]objectForKey:@"children"];
        areas =[[Citys objectAtIndex:0]objectForKey:@"children"];

        [self makeUI];
        [self makePickerView];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [failAlView show];
        NSLog(@"cook load failed ,%@",error);
    }];
    
}
-(void)makeUI{
    self.NameTextField.delegate =self;
    self.PhoneTextfield.delegate =self;
    self.AddressTextField.delegate =self;
    self.YouBianTextField.delegate =self;
    self.YouBianTextField.keyboardType =UIKeyboardTypeNumberPad;
    TsLabel =[[UILabel alloc]initWithFrame:CGRectMake(10, ConentViewHeight- 150, 300, 25)];
    TsLabel.text=@"您输入的手机号码有误，请重新输入";
    TsLabel.textAlignment =NSTextAlignmentCenter;
    TsLabel.textColor =[UIColor whiteColor];
    TsLabel.font =[UIFont systemFontOfSize:15];
    TsLabel.backgroundColor =[UIColor blackColor];
    TsLabel.hidden = YES;
    [self.view addSubview:TsLabel];
    //
    if (IsChang) {
        [self makeDataWithDic];
    }
    
}
-(void)makeDataWithDic{
    // 用 dataDic给控件赋值 进行修改
    NSLog(@"是更改");
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if(textField ==self.NameTextField){
        [self.PhoneTextfield resignFirstResponder];
        [self.YouBianTextField resignFirstResponder];
        [self.AddressTextField resignFirstResponder];
        picView.hidden = YES;
    }
    else if(textField ==self.PhoneTextfield){
        [self.NameTextField resignFirstResponder];
        [self.YouBianTextField resignFirstResponder];
        [self.AddressTextField resignFirstResponder];
        [self.cityTextF resignFirstResponder];

        picView.hidden = YES;
        NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
        NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
        BOOL ret = [phoneTest evaluateWithObject:self.PhoneTextfield.text];
        
        if ( !ret) {
            
            TsLabel.hidden = NO;
        }
        else{
            TsLabel.hidden = YES;
        }
        
    }
    else if(textField == self.AddressTextField){
        [self.NameTextField resignFirstResponder];
        [self.PhoneTextfield resignFirstResponder];
        [self.YouBianTextField resignFirstResponder];
        [self.cityTextF resignFirstResponder];

        picView.hidden = YES;
    }
    else if(textField == self.YouBianTextField){
        [self.NameTextField resignFirstResponder];
        [self.PhoneTextfield resignFirstResponder];
        [self.AddressTextField resignFirstResponder];
        [self.cityTextF resignFirstResponder];

        picView.hidden = YES;
    }else if (textField == self.cityTextF){
        [self.NameTextField resignFirstResponder];
        [self.PhoneTextfield resignFirstResponder];
        [self.AddressTextField resignFirstResponder];
        picView.hidden = YES;

    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.NameTextField resignFirstResponder];
    [self.PhoneTextfield resignFirstResponder];
    [self.YouBianTextField resignFirstResponder];
    [self.AddressTextField resignFirstResponder];
    [self.cityTextF resignFirstResponder];
    picView.hidden = YES;
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
// 城市选择器  选择城市
-(void)makePickerView{
    picView =[[UIPickerView alloc]initWithFrame:CGRectMake(0, ConentViewHeight-230, ConentViewWidth,150)];
    picView.backgroundColor =[UIColor whiteColor];
    picView.delegate =self;
    picView.dataSource =self;
    picView.hidden = YES;
    [self.view addSubview:picView];
}
- (IBAction)CityAction:(id)sender {
    [self.NameTextField resignFirstResponder];
    [self.PhoneTextfield resignFirstResponder];
    [self.YouBianTextField resignFirstResponder];
    [self.AddressTextField resignFirstResponder];
//    picView.hidden =!picView.hidden;
    picView.hidden =YES;

    if (FirstAdd) {
        
    }
    else{
        FirstAdd = YES;
    //给区域赋值
        
        
    }

}
#pragma mark PicView的代理方法
// 返回组数
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}
// 每一组的个数；
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
   //  NSLog(@"aa  == %d  ,sss  === %d  , dddd == %d",Provice.count,Citys.count,areas.count);
    
    switch (component) {
      
              case 0:
            return [Provice count];
            break;
        case 1:
            return [Citys count];
            break;
        case 2:
            return [areas count];
            break;
        default:
            return 0;
            break;
    }
}
// 每一组的标题；
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
  //  NSLog(@"provice.cout= %d,    city.count= %d   areas.cou = %d   row =%d",Provice.count,Citys.count,areas.count,row);
    switch (component) {
        case 0:
        {
            if ([Provice count]>0) {
                return [[Provice objectAtIndex:row]objectForKey:@"region_name" ];
                break;
            }
            else{
                return @"";
            }
            break;
        }
        case 1:{

            if ([Citys count]>0) {
                return [[Citys objectAtIndex:row]objectForKey:@"region_name" ];
                break;
            }
            else{
                return @"";
            }
            break;
        }
        case 2:{
            if ([areas count]>0) {
                return [[areas objectAtIndex:row]objectForKey:@"region_name" ];
                
                break;
            }
            else{
                return @"";
            }
            break;
        }
        default:
            return nil;
            break;
    }
    
}
// 选择某一组  选择以后要对旗下边的数据重新赋值
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
 //   NSLog(@" 1111 --%d  ,22- %d  ,333 - %d  componet = %ld  roew =%d",Provice.count,Citys.count,areas.count,(long)component,row);
    switch (component) {
            
        case 0:
            
            //当省份确认后  将市修改为初始位置 重新加载新数据  县的在看是否需要
            Citys =[[Provice objectAtIndex:row]objectForKey:@"children"];
        if(Citys.count >0){
            AddressID =[NSString stringWithFormat:@"%@",[[Citys objectAtIndex:0] objectForKey:@"region_id"]];
    //        NSLog(@" Citys====%@",AddressID);
            
            [picView selectRow:0 inComponent:1 animated:YES];
            [picView reloadComponent:1];
           //  获取 位置
            ProviceStr =[NSString stringWithFormat:@"%@", [[Provice objectAtIndex:row]objectForKey:@"region_name"]];
            CityStr =[NSString stringWithFormat:@"%@",[[Citys objectAtIndex:0]objectForKey:@"region_name"]];
            areas=[[Citys objectAtIndex:0]objectForKey:@"children"];

            if ([areas count]>0) {
                areaStr =[NSString stringWithFormat:@"%@",[[areas objectAtIndex:0] objectForKey:@"region_name"]];
                AddressID =[NSString stringWithFormat:@"%@",[[areas objectAtIndex:0] objectForKey:@"region_id"]];
                
            } else{
                areaStr =@"";
            }
            [picView selectRow:0 inComponent:2 animated:YES];
             [picView reloadComponent:2];
            }
            else{// 第二阶没有数据
             AddressID =[NSString stringWithFormat:@"%@",[[Provice objectAtIndex:row ] objectForKey:@"region_id"]];
             ProviceStr =[NSString stringWithFormat:@"%@", [[Provice objectAtIndex:row]objectForKey:@"region_name"]];
               CityStr =[NSString stringWithFormat:@""];
                [picView selectRow:0 inComponent:1 animated:YES];
                [picView reloadComponent:1];
                [picView selectRow:0 inComponent:2 animated:YES];
                [picView reloadComponent:2];
            
            }
            break;
        case 1:
            
            
            areas =[[Citys objectAtIndex:row]objectForKey:@"children"];

            CityStr =[NSString stringWithFormat:@"%@",[[Citys objectAtIndex:row]objectForKey:@"region_name"]];
            AddressID =[NSString stringWithFormat:@"%@",[[Citys objectAtIndex:row] objectForKey:@"region_id"]];


            [picView selectRow:0 inComponent:2 animated:YES];
            [picView reloadComponent:2];
            if ([areas count]>0) {
                areaStr =[NSString stringWithFormat:@"%@",[[areas objectAtIndex:0] objectForKey:@"region_name"]];
                 AddressID =[NSString stringWithFormat:@"%@",[[areas objectAtIndex:0] objectForKey:@"region_id"]];
            }
            else{
                areaStr =@"";
            }
            break;
        case 2:
            if ([areas count]>0) {
                areaStr =[NSString stringWithFormat:@"%@",[[areas objectAtIndex:0] objectForKey:@"region_name"]];
                
                AddressID =[NSString stringWithFormat:@"%@",[[areas objectAtIndex:0] objectForKey:@"region_id"]];
                
                
          //      NSLog(@"areaStr  ==%@",AddressID);
            }
            else {
                areaStr =@"";
            }
            
            break;
        default:
            break;
    }
//    if ([CityStr isEqualToString:@"null"]) {
//        CityStr =@"";
//    }
//    if ([areaStr isEqualToString:@"null"]) {
//        areaStr = @"";
//    }
    
//    self.CityLabel.text =[NSString stringWithFormat:@"%@ %@ %@",ProviceStr,CityStr,areaStr];
//    self.CityLabel.text =[self.CityLabel.text stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
    NSLog(@"citylabel.text  ===  %@  ID  ==%@",self.CityLabel.text,AddressID);
  //  NSLog(@"%@ %@ %@  %@",ProviceStr,CityStr,areaStr ,AddressID);
    //picView.hidden = YES;
   // NSLog(@" AddressID  ==%@",AddressID);
}
#pragma  添加收货地址
- (IBAction)AddAction:(id)sender {
    
    
    if(self.NameTextField.text.length>0&self.PhoneTextfield.text.length>0&self.cityTextF.text.length>0&self.AddressTextField.text>0&self.YouBianTextField
       .text.length>0){
    
    
        
        
        if (TsLabel.hidden) {
            NSLog(@"可以提交");
            NSUserDefaults *userdefault =[NSUserDefaults standardUserDefaults];
            NSString *userID =[userdefault objectForKey:@"Useid"];
            // NSUserDefaults *Userdefault =[NSUserDefaults standardUserDefaults];
            // 登陆
            NSString *LoginStr =[NSString stringWithFormat:ADDADDRESS] ;
            LoginStr = [LoginStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

            AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
            /*consignee 收获人
             region_id 最下层区域id
             region_name 区域名称 例如：河南 郑州 经开区
             address 地址
             zipcode 邮编
             
             phone_mob手机
             user_id  userID
             
             */

            NSLog(@"%@",self.cityTextF.text);
//            NSString * nameStr =[[self.NameTextField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//            NSString * regionName =[[self.CityLabel.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//            NSString * addressStr =[[self.AddressTextField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

            NSArray *KeyArr =@[@"token",@"consignee",@"region_id",@"region_name",@"address",@"zipcode",@"mobile",@"member_id"];

            NSArray *ValueArr =@[@"test",self.NameTextField.text,@"0",self.cityTextF.text,self.AddressTextField.text,self.YouBianTextField.text,self.PhoneTextfield.text,userID];
            
            NSDictionary *dic =[[NSDictionary alloc]initWithObjects:ValueArr forKeys:KeyArr];
            NSLog(@"%@",dic);
            [manager POST:LoginStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSLog(@"%@",[responseObject objectForKey:@"msg"]);
                UIAlertView * al =[[UIAlertView alloc]initWithTitle:@"提示" message:@"地址添加成功提示" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                al.tag =20;
                [al show];
                               
                NSLog(@"%@",[responseObject objectForKey:@"retval"]);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [failAlView show];
                NSLog(@"%@",error);
            }];
            
        }

    
    }else{
        UIAlertView * all =[[UIAlertView alloc]initWithTitle:@"提示" message:@"信息不完整" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        all.tag =21;
        [all show];
        
    }
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 20) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
    
    
    
    }

}

@end
