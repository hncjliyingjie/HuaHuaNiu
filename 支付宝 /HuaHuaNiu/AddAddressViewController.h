//
//  AddAddressViewController.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-3.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddAddressViewController : UIViewController<UIAlertViewDelegate,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>{
    //选择区域的ID
    NSString * AddressID ;
    //first 地址；
    BOOL FirstAdd;// 第一次给默认的城市赋值
    // 如果是修改进来的
    NSDictionary *DataDic ;
    BOOL IsChang;
    UILabel *TsLabel;
    UIPickerView *picView;
    //选择器的数据源
    NSArray * Provice;
    NSArray *Citys;
    NSArray *areas;
    // 获得的省市县
    NSString *ProviceStr;
    NSString *CityStr;
    NSString *areaStr;
    
    }
@property (weak, nonatomic) IBOutlet UITextField *cityTextF;
@property (weak, nonatomic) IBOutlet UITextField *NameTextField;
@property (weak, nonatomic) IBOutlet UITextField *PhoneTextfield;
@property (weak, nonatomic) IBOutlet UITextField *AddressTextField;
@property (weak, nonatomic) IBOutlet UITextField *YouBianTextField;
@property (weak, nonatomic) IBOutlet UILabel *CityLabel;

- (IBAction)CityAction:(id)sender;

- (IBAction)AddAction:(id)sender;

-(id)initWithDic:(NSDictionary *)Dic AndChang:(BOOL)change;

@end
