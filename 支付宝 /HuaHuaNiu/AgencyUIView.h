//
//  AgencyUIView.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-14.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AgencyUIView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *ImageIma;
@property (weak, nonatomic) IBOutlet UILabel *NameLabel;
@property (weak, nonatomic) IBOutlet UILabel *SloganLabel;
@property (weak, nonatomic) IBOutlet UILabel *DistanceLabel;
-(void)makeDataWithDic:(NSDictionary *)Dic;
@end
