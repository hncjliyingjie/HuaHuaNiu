//
//  ChangeLabeViewController.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-27.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeLabeViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>{
    BOOL CanTiJiao;// 能不能提交
    NSString *MtitleStr ;

}
@property (weak, nonatomic) IBOutlet UITextField *changeTextFiel;
- (IBAction)XiuGaiActions:(id)sender;

//  判断是  修改昵称 或者 name
-(id)initWithTitle:(NSString *)TiTleStr;
@end
