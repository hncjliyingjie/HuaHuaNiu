//
//  InViteViewController.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-14.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HGFindFrameModel.h"

@interface InViteViewController : UIViewController{
    // 用户ID
    NSString *UserID;
    //产品ID
    NSString *ProductId ;
    //分享
    UIImageView *shareView;
}
@property (nonatomic,strong) HGFindFrameModel *video;
//@property (weak, nonatomic) IBOutlet UILabel *NumberLabel;
@property (weak, nonatomic) IBOutlet UIImageView *IconImage;

@end
