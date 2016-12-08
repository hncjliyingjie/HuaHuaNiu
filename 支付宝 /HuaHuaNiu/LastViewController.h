//
//  LastViewController.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-1.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BiglogView ;
@interface LastViewController : UIViewController<UIAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    BiglogView *Bvc ; //登陆后的View
    BOOL Enter;  // 判断是否登录   yes  未登录
   //  登陆后的topView
    UIView *topVIew;
    UIScrollView *BackScroll;
}
@property(nonatomic,strong)NSString *str;





















@end
