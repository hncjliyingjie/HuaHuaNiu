//
//  ForgetPWViewController.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-2.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgetPWViewController : UIViewController<UIAlertViewDelegate>{
    NSString * YanZhenStr;
}
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *YZMTextField;

- (IBAction)GetYZMAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *NewPassWorld;
@property (weak, nonatomic) IBOutlet UITextField *PassWorldAgain;
- (IBAction)enterAction:(id)sender;


































@end
