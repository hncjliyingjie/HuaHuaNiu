//
//  AddPLVViewController.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-5-9.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddPLVViewController : UIViewController<UITextViewDelegate,UIAlertViewDelegate>{

    NSDictionary *PLDic;
}

@property (weak, nonatomic) IBOutlet UILabel *ProductName;

@property (weak, nonatomic) IBOutlet UITextView *MYtextView;


- (IBAction)PlAddAction:(id)sender;

-(id)initWithDicFoSelf:(NSDictionary *)dic;

@end
