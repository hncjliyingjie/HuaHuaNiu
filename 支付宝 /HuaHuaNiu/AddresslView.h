//
//  AddresslView.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-5-11.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddresslView : UIView{
 
   // void(^chooseAddressblocks)(NSDictionary * dic);

}


@property (weak, nonatomic) IBOutlet UILabel *NameLabel;

@property (weak, nonatomic) IBOutlet UILabel *PhoneLabel;

@property (weak, nonatomic) IBOutlet UILabel *AddressLabel;
@property (weak, nonatomic) IBOutlet UIView *hiddenView;


-(void)ViewmakedataWithdi:(NSDictionary *)dic;


//-(void)makeBlock:(void(^)(NSDictionary * dic))Blocks;













@end
