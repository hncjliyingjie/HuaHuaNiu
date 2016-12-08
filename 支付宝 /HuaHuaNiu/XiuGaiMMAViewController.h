//
//  XiuGaiMMAViewController.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-25.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XiuGaiMMAViewController : UIViewController<UITextFieldDelegate>
@property (nonatomic,strong) NSString * currentPhone;
@property (weak, nonatomic) IBOutlet UITextField *OldTextField;


@property (weak, nonatomic) IBOutlet UITextField *NewTextField;

@property (weak, nonatomic) IBOutlet UITextField *SecondTextField;

- (IBAction)QueDingActionnn:(id)sender;













@end
