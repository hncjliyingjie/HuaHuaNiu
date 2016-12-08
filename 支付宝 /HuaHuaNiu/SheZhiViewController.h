//
//  SheZhiViewController.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-24.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SheZhiViewController : UIViewController<UIAlertViewDelegate>{

    UIAlertView *AlView;
}
@property (nonatomic,strong)NSString * currentPhoneNumber;
- (IBAction)ChangeMImAAction:(id)sender;

- (IBAction)ClealerAction:(id)sender;

@end
