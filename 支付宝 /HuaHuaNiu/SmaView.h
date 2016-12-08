//
//  SmaView.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-2.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SmaView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *IconImage;
@property (weak, nonatomic) IBOutlet UILabel *IconLabel;
@property (weak, nonatomic) IBOutlet UILabel *Label;


-(void)setWithImaStr:(NSString *)imaStr AndLabelStr:(NSString *)LabelStr WoDeLable:(NSString *)woDe;












@end
