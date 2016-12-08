//
//  DaiTopView.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-19.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DaiTopView : UIView{

  
}

@property (weak, nonatomic) IBOutlet UIImageView *BackImage;


//  满二百 送五十
@property (weak, nonatomic) IBOutlet UIImageView *logoIV;

@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet UILabel *GuoQiLabel;
@property (weak, nonatomic) IBOutlet UILabel *MianZhiLabel;

@property (weak, nonatomic) IBOutlet UILabel *MianFeiLaebl;

@property (weak, nonatomic) IBOutlet UILabel *ChiYouLabel;


-(void)ViewMakeDAIRWithDIc:(NSDictionary *)dic;








@end
