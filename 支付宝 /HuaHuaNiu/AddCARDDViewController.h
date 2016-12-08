//
//  AddCARDDViewController.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-4-24.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddCARDDViewController : UIViewController<UIAlertViewDelegate>{

}

@property (weak, nonatomic) IBOutlet UITextField *NameTextfile;
@property (weak, nonatomic) IBOutlet UITextField *CardTextField;
- (IBAction)EnterActions:(id)sender;

@end
