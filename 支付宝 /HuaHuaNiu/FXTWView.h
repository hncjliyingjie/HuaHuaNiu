//
//  FXTWView.h
//  HuaHuaNiu
//
//  Created by mac on 16/11/11.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaceholderTextView.h"
@interface FXTWView : UIView

+(FXTWView *)creatView;//分享图文的view

+(FXTWView *)creatFirstView;//分享链接的view
@property (weak, nonatomic) IBOutlet UICollectionView *collectView;


@property (weak, nonatomic) IBOutlet UIButton *twImgBtn;//分享图文的图标
@property (weak, nonatomic) IBOutlet UIButton *ljImgBtn;//分享链接的图标

@property (weak, nonatomic) IBOutlet UIButton *fxljBtn;//分享链接按钮
@property (weak, nonatomic) IBOutlet UIButton *fxtwBtn;//分享图文按钮
@property (weak, nonatomic) IBOutlet UITextField *fxljTextField;//分享链接下的分享链接输入框
@property (weak, nonatomic) IBOutlet PlaceholderTextView *fxljTextView;//分享链接下的代言人分享


@property (weak, nonatomic) IBOutlet PlaceholderTextView *fxtwTextFiled;//分享图文下的直发内容

//分享图文上的分享链接按钮
-(void)styleWithBtn;

//分享链接上的分享图文按钮；
-(void)styleWithOtherBtn;
@end
