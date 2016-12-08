//
//  ZiyuashenqViewController.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-5-12.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZiyuashenqViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate,UIAlertViewDelegate>{


}
@property (weak, nonatomic) IBOutlet UIScrollView *backScrollview;


@property (weak, nonatomic) IBOutlet UITextField *CompanyTextFiel;

@property (weak, nonatomic) IBOutlet UITextField *DizhiTextFiel;

@property (weak, nonatomic) IBOutlet UITextField *LianXiRenTextFiel;

@property (weak, nonatomic) IBOutlet UITextField *PhoneTextFiel;

@property (weak, nonatomic) IBOutlet UITextField *WangZhanTextFiel;


@property (weak, nonatomic) IBOutlet UITextField *EmailTextFiel;


@property (weak, nonatomic) IBOutlet UITextField *QQTextFiel;

@property (weak, nonatomic) IBOutlet UITextView *BeiZhuTextView;
- (IBAction)TijiaoShenQing:(id)sender;



@end
