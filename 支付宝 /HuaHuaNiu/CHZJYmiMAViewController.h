//
//  CHZJYmiMAViewController.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-25.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHZJYmiMAViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *FirstMimaTextFiel;


@property (weak, nonatomic) IBOutlet UITextField *YnHengMaTextField;


@property (weak, nonatomic) IBOutlet UITextField *SecondMimaTextFiel;



- (IBAction)GetYanZhenMaACtion:(id)sender;

- (IBAction)QueDingActin:(id)sender;






@end
