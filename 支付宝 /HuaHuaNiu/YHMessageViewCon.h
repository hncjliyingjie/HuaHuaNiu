//
//  YHMessageView.h
//  HuaHuaNiu
//
//  Created by mac on 16/4/28.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHMessageViewCon : UIViewController
{
    UILabel *lable;
    UILabel *titleLable;
    UILabel *timeLable;
}
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *time;

@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@property (weak, nonatomic) IBOutlet UILabel *contentLable;

@property (weak, nonatomic) IBOutlet UILabel *timeLable;


@end
