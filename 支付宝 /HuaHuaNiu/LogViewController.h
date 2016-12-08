//
//  LogViewController.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-2.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>{

    UILabel *TSlabel ;

}
@property (weak, nonatomic) IBOutlet UIImageView *IconImage;
@property (weak, nonatomic) IBOutlet UITextField *AccountTextField;
@property (weak, nonatomic) IBOutlet UITextField *PassWordTextField;
- (IBAction)LogAction:(id)sender;
- (IBAction)registAction:(id)sender;
- (IBAction)ForgetPassWordAction:(id)sender;

@end
