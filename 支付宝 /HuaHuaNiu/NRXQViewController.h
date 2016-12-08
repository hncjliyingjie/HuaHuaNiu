//
//  NRXQViewController.h
//  HuaHuaNiu
//
//  Created by Vking on 16/1/25.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NRXQViewController : UIViewController

@property (nonatomic,strong) NSString * infoId;
@property (weak, nonatomic) IBOutlet UIImageView *imagelable;
@property (weak, nonatomic) IBOutlet UILabel *titlelable;


@property (weak, nonatomic) IBOutlet UILabel *maneylable;

@property (weak, nonatomic) IBOutlet UILabel *timelable;
@property (nonatomic,strong) NSDictionary *array;
@property (nonatomic,strong) UIImage *image;

@property (weak, nonatomic) IBOutlet UILabel *centerlable;

@property (weak, nonatomic) IBOutlet UILabel *phonelable;

@property (weak, nonatomic) IBOutlet UILabel *adresslable;


@end
