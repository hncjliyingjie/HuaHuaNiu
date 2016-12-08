//
//  RegistViewController.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-2.
//  Copyright (c) 2015年 张燕. All rights reserved.
//
#import <UIKit/UIKit.h>
@interface RegistViewController : UIViewController<UIWebViewDelegate,UIAlertViewDelegate>{

    UIWebView *WebView;
    
    // 短信验证码；
    NSString * YanZhenStr;
}
@property (weak, nonatomic) IBOutlet UITextField *NameTextField;
@property (weak, nonatomic) IBOutlet UITextField *PhoneTextField;

@property (weak, nonatomic) IBOutlet UITextField *PassWordTextField;
@property (weak, nonatomic) IBOutlet UITextField *YanZhengTextField;

@property (weak, nonatomic) IBOutlet UITextField *TuiJianNum;


- (IBAction)YZBtnAction:(id)sender;

#pragma mark - 验证码按钮倒计时
@property (strong, nonatomic) IBOutlet UIButton *YZMButton;

@property (weak, nonatomic) IBOutlet UIButton *ReadBtn;  //  是否阅读 协议

- (IBAction)TreatyAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *registAction;

- (IBAction)BeginREgistAction:(id)sender;

- (IBAction)yueduActions:(id)sender;














@end
