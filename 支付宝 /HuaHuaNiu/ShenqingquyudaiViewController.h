//
//  ShenqingquyudaiViewController.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-5-12.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShenqingquyudaiViewController : UIViewController<UITextViewDelegate,UITextFieldDelegate,UIAlertViewDelegate>{





}


@property (weak, nonatomic) IBOutlet UIScrollView *BackView;


@property (weak, nonatomic) IBOutlet UITextField *YXTextFiel;

@property (weak, nonatomic) IBOutlet UITextField *LianXITextFiel;

@property (weak, nonatomic) IBOutlet UITextField *DizhiTextField;

@property (weak, nonatomic) IBOutlet UITextField *PhoneTextFiel;

@property (weak, nonatomic) IBOutlet UITextField *EmailTextFiel;

@property (weak, nonatomic) IBOutlet UITextField *QQtextFiel;
@property (weak, nonatomic) IBOutlet UITextView *BeiZhuTextView;

- (IBAction)TouACtionss:(id)sender;
































@end
