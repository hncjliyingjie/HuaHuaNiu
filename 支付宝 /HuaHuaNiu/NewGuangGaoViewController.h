//
//  NewGuangGaoViewController.h
//  HuaHuaNiu
//
//  Created by alex on 15/12/26.
//  Copyright © 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewGuangGaoViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate,UIAlertViewDelegate>{


}
@property (nonatomic,strong) NSDictionary  * adVanDic;
@property (weak, nonatomic) IBOutlet UITextField *tf1;
@property (weak, nonatomic) IBOutlet UITextField *tf2;
@property (weak, nonatomic) IBOutlet UILabel *MoneyLB;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *fukuanBtn;
- (IBAction)fukuanAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *backScrollview;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UIButton *cameraButton;
@property (weak, nonatomic) IBOutlet UIButton *imgButton;
@property (nonatomic,copy) NSString *file_id;
@property (nonatomic,copy) NSString *img_id;
@end
