//
//  XunZhaoViewController.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-20.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XunZhaoViewController : UIViewController<UITextViewDelegate,UIAlertViewDelegate>{

    NSString * storeID;
}

@property (weak, nonatomic) IBOutlet UILabel *StoreNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ShangjiaMiaoshuLab;
@property (weak, nonatomic) IBOutlet UITextView *WDMSTextView;

- (IBAction)TijaioAction:(id)sender;




-(id)initWithStoreId:(NSString *)Str;



@end
