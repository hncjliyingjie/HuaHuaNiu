//
//  QiuZhiDeatilViewController.m
//  HuaHuaNiu
//
//  Created by alex on 15/10/24.
//  Copyright © 2015年 张燕. All rights reserved.
//

#import "QiuZhiDeatilViewController.h"
#import "AFNetworking.h"
@interface QiuZhiDeatilViewController ()<UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate>{
    NSString * _currentNumber;
    NSString * _currentTitle;
    NSString * _currentPlace;
    NSString * _currentYears;
    NSString * _currentEdcation;
    NSArray *arayM;
    UITextField * tf0;
    UITextField * tf1;
    UITextField * tf2;
    UITextField * tf3;
    UITextField * tf4;
    UITextField * tf5;
    UITextField * tf6;
    UITextField * tf7;
    BOOL CanTiJiao;
}

@end

@implementation QiuZhiDeatilViewController

- (void)showMsg{
    NSString * requestUrl =[NSString stringWithFormat: @"http://daiyancheng.cn/appwork/apply_join_info.do?token=test&join_id=%@",self.currentModel.joinId];
//    [self.view makeToastActivity];
    RequestManger *manger =[RequestManger share];
    [manger requestDataByGetWithPath:requestUrl complete:^(NSDictionary *data) {
        //(@"%@",data);
        if ([data objectForKey:@"error"]) {
            //(@"%@",[data objectForKey:@"error"]);
        }else{
            NSLog(@"%@",data);
            tf0.text=[data objectForKey:@"name"];
            tf1.text=[data objectForKey:@"sex"];
            tf2.text=[NSString stringWithFormat:@"%i",[[data objectForKey:@"age"] intValue]];
            tf3.text=[data objectForKey:@"title"];
            tf4.text=[data objectForKey:@"salary"];
            tf5.text=[data objectForKey:@"mobile"];
            
            tf6.text=[data objectForKey:@"work_experience"];
            tf7.text=[data objectForKey:@"remark"];

        }
    }];
}

- (void)createNav{
    UIButton *BackBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    BackBtn.frame =CGRectMake(0, 0, 64, 27);
    [BackBtn  setBackgroundImage:[UIImage imageNamed:@"app_fanhui"] forState:UIControlStateNormal];
    [BackBtn addTarget:self action:@selector(BackAction)  forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem =[[UIBarButtonItem alloc]initWithCustomView:BackBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    self.navigationItem.title=@"申请求职";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:20],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
}

-(void)BackAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    arayM=[NSArray array];
    _pickView=[[UIPickerView alloc]initWithFrame:CGRectMake(0, ConentViewHeight-200, ConentViewWidth, 200)];
    _pickView.delegate=self;
    _pickView.dataSource=self;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [_pickView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_pickView];
    _pickView.hidden=YES;
    [self createUI];
    [self createNav];
    [self showMsg];

}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([_count1 isEqualToString:@"2"]) {
        return NO;
    }
    else{
    if (textField.tag==1001) {
        [self touchScrollView];
        _pickView.hidden=NO;
       return NO;
    }else{
        if (textField.tag==1006) {
            tf5.keyboardType =UIKeyboardTypeNumberPad;
        }

        _pickView.hidden=YES;
        return YES;
    }
    }
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    switch (textField.tag) {
        case 1000:{
            
            _pickView.hidden=YES;
            return YES;
            break;
        }
        case 1001:{
            _pickView.hidden=NO;
//            textField.enabled=NO;
            return YES;
            
            break;
        }
        case 1002:{
            //(@"3");
            _pickView.hidden=YES;
            return YES;
            break;
        }
        case 1003:{
            //(@"4");
            _pickView.hidden=YES;
            return YES;
            break;
        }
        case 1004:{
            //(@"5");
           _pickView.hidden=YES;
            return YES;
            break;
        }
        case 1005:{
            //(@"6");
            _pickView.hidden=YES;
            return YES;
            break;
        }
        case 1006:{
            //(@"6");
           _pickView.hidden=YES;
            return YES;
            break;
        }
            
        case 1007:{
            //(@"6");
            _pickView.hidden=YES;
            return YES;
            break;
        }
            
        default:
            break;
    }
    return YES;

}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    switch (textField.tag) {
        case 1000:{
            //(@"1");
            [textField resignFirstResponder];
            break;
        }
        case 1001:{
            NSInteger row = [_pickView selectedRowInComponent:0];
            tf1.text=[arayM objectAtIndex:row];
            [textField resignFirstResponder];

            break;
        }
        case 1002:{
            //(@"3");
            [textField resignFirstResponder];

            break;
        }
        case 1003:{
            //(@"4");
            [textField resignFirstResponder];

            break;
        }
        case 1004:{
            //(@"5");
            [textField resignFirstResponder];

            break;
        }
        case 1005:{
            //(@"6");
            [textField resignFirstResponder];
            
            break;
        }
        case 1006:{
            //(@"6");
            [textField resignFirstResponder];
            
            break;
        }

        case 1007:{
            //(@"6");
            [textField resignFirstResponder];
            
            break;
        }

        default:
            break;
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 2;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
 {
     arayM=@[@"男",@"女"];
     NSLog(@"%@",[arayM objectAtIndex:row]);
     tf1.text=[arayM objectAtIndex:row];
     return [arayM objectAtIndex:row];
     }
-(void)createUI{
    
    NSArray * titles =@[@"姓名:",@"性别:",@"年龄:",@"期望职位:",@"期望薪资:",@"联系方式:",@"工作经历:",@"自我评价:"];
    NSArray * labels =@[@"必填",@"必填",@"必填",@"必填",@"必填",@"必填",@"选填，简要对自己工作经验评价",@"选填，简要对自己评价"];
    
    UIScrollView * sv =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, ConentViewHeight)];
    sv.contentSize =CGSizeMake(ConentViewWidth, ConentViewHeight+190);
    for (int i =0; i<8; i++) {
        UILabel * label =[[UILabel alloc]initWithFrame:CGRectMake(10, 25, 90, 20)];
        label.text =titles[i];
        
        UIView * titleView =[[UIView alloc]initWithFrame:CGRectMake(0, 10+70*i, self.view.bounds.size.width, 70)];

        if (i==0) {
            tf0 =[[UITextField alloc]initWithFrame:CGRectMake(110, 25, 240, 20)];
            tf0.delegate =self;
            tf0.placeholder =labels[i];
            tf0.tag =1000+i;
            [titleView addSubview:tf0];
        }
        
        if (i==1) {
            tf1 =[[UITextField alloc]initWithFrame:CGRectMake(110, 25, 240, 20)];
            tf1.delegate =self;
            tf1.placeholder =labels[i];
            tf1.tag =1000+i;
            [titleView addSubview:tf1];
            
        }
        
        if (i==2) {
            tf2 =[[UITextField alloc]initWithFrame:CGRectMake(110, 25, 240, 20)];
            tf2.delegate =self;
            tf2.placeholder =labels[i];
            tf2.tag =1000+i;
            [titleView addSubview:tf2];
        }
        if (i==3) {
            tf3 =[[UITextField alloc]initWithFrame:CGRectMake(110, 25, 240, 20)];
            tf3.delegate =self;
            tf3.placeholder =labels[i];
            tf3.tag =1000+i;
            [titleView addSubview:tf3];
        }
        if (i==4) {
            tf4 =[[UITextField alloc]initWithFrame:CGRectMake(110, 25, 240, 20)];
            tf4.delegate =self;
            tf4.placeholder =labels[i];
            tf4.tag =1000+i;
            [titleView addSubview:tf4];
        }
        if (i==5) {
            tf5 =[[UITextField alloc]initWithFrame:CGRectMake(110, 25, 240, 20)];
            tf5.delegate =self;
            tf5.placeholder =labels[i];
            tf5.tag =1000+i;
            [titleView addSubview:tf5];
        }
        if (i==6) {
            tf6 =[[UITextField alloc]initWithFrame:CGRectMake(110, 25, 240, 20)];
            tf6.delegate =self;
            tf6.placeholder =labels[i];
            tf6.tag =1000+i;
            [titleView addSubview:tf6];
        }
        if (i==7) {
            tf7 =[[UITextField alloc]initWithFrame:CGRectMake(110, 25, 240, 20)];
            tf7.delegate =self;
            tf7.placeholder =labels[i];
            tf7.tag =1000+i;
            [titleView addSubview:tf7];
        }

        UIView * line2 =[[UIView alloc]initWithFrame:CGRectMake(0, 69, self.view.bounds.size.width, 1)];
        line2.backgroundColor =[UIColor lightGrayColor];
        
        
        UIView * line1 =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 1)];
        line1.backgroundColor =[UIColor lightGrayColor];
        
        [titleView addSubview:line1];
    
    if (i==7) {
        [titleView addSubview:line2];
    }
        [titleView addSubview:label];
        titleView.backgroundColor =[UIColor whiteColor];
        [sv addSubview:titleView];
        
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchScrollView)];
        [recognizer setNumberOfTapsRequired:1];
        [recognizer setNumberOfTouchesRequired:1];
        [sv addGestureRecognizer:recognizer];
        

    }
    
    _btn2 =[UIButton buttonWithType:UIButtonTypeSystem];;
    _btn2.frame =CGRectMake(ConentViewWidth/2 -100/2, sv.height+160, 100, 30);
    NSLog(@"%@",_count1);
    if ([_count1 isEqualToString:@"1"]) {
        [_btn2 setTitle:@"修改" forState:UIControlStateNormal];
        [_btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btn2 setBackgroundColor:BarColor];
        
        [_btn2 addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
        [sv addSubview:_btn2];
//        [self.view addSubview:sv];

    }else if ([_count1 isEqualToString:@"2"]){

    }
    else{
        [_btn2 setTitle:@"申请" forState:UIControlStateNormal];
        [_btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btn2 setBackgroundColor:BarColor];
        
        [_btn2 addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
        [sv addSubview:_btn2];
//        [self.view addSubview:sv];

    }
    
//    [_btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [_btn2 setBackgroundColor:BarColor];
//    
//    [_btn2 addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
//    [sv addSubview:_btn2];
    [self.view addSubview:sv];
    [self.view addSubview:_pickView];

}
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
//    return NO;
//}
- (void)touchScrollView
{
    [tf0 resignFirstResponder];
    [tf1 resignFirstResponder];
    [tf2 resignFirstResponder];
    [tf3 resignFirstResponder];
    [tf4 resignFirstResponder];
    [tf5 resignFirstResponder];
    [tf6 resignFirstResponder];
    [tf7 resignFirstResponder];

}





-(void)isSave{
    CanTiJiao =YES;
    if (tf0.text.length==0) {
        CanTiJiao =NO;
    }else if (tf1.text.length ==0){
        CanTiJiao =NO;
    }else if (tf3.text.length ==0){
        CanTiJiao =NO;
    }else if (tf4.text.length ==0){
        CanTiJiao =NO;
    }else if (tf5.text.length ==0){
        CanTiJiao =NO;
    }
}

-(void)save{
    [self isSave];
    if (CanTiJiao) {
        NSUserDefaults * userdefault =[NSUserDefaults standardUserDefaults];
        NSString * userID =[NSString stringWithFormat:@"%@",[userdefault objectForKey:@"Useid"]];
        NSString * ShouY =[NSString stringWithFormat:QIUZHI_SHENQING1,userID,[tf0.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[tf1.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[tf2.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[tf3.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[tf4.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[tf5.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[tf6.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[tf7.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//        [NSString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"%@",ShouY);
//        appwork/apply_join_add.do?token=test&member_id=%@&name=%@&sex=%@&age=%@&title=%@&salary=%@&&mobile=%@&work_experience=%@&remark=%@
//        NSDictionary *dict1=[NSDictionary dictionary];
        
        NSDictionary * dict =[NSDictionary dictionaryWithObjectsAndKeys:@"test",@"token",userID,@"member_id",tf0.text,@"name",tf1.text,@"sex",tf2.text,@"age",tf3.text,@"title",tf4.text,@"salary",tf5.text,@"mobile",tf6.text,@"work_experience",tf7.text,@"remark",nil];
        NSLog(@"%@",dict);
        AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
        [manager POST:ShouY parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
            
            if ([[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"result"]] isEqualToString:@"1"]) {
                UIAlertView * alew =[[UIAlertView alloc]initWithTitle:@"提示" message:@"申请成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                alew.tag =10000;
                [alew  show];
            }else{
                UIAlertView * alew =[[UIAlertView alloc]initWithTitle:@"提示" message:[responseObject objectForKey:@"msg"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                alew.tag =10001;
                [alew  show];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [failAlView show];
            //(@"cook load failed ,%@",error);
        }];
    }else{
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"您的信息未填写完整" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [failAlView show];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag ==10000) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
