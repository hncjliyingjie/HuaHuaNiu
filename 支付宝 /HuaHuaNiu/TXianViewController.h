//
//  TXianViewController.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-4-24.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TXianViewController : UIViewController<UIAlertViewDelegate,UITextFieldDelegate>{
  
    // 银行卡ID
    NSString * BanKID ;
    //name
    NSString * nameStr;
}

@property (weak, nonatomic) IBOutlet UILabel *MYmoneyLabel;

@property (weak, nonatomic) IBOutlet UIButton *BankCard;

- (IBAction)BankCardAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *jineTextField;


- (IBAction)YesActon:(id)sender;

//提现的金额


@end
