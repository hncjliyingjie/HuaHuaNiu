//
//  FindStoreView.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-11.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindStoreView : UIView{
    NSString *FirstStr;
    NSString *secondStr;
    NSString *ThirdStr;
    NSString *FourtStr;
    NSString *FiveStr;
    
    
   void (^PushStoreBlocks)(NSString *StoreStr);

}
-(void)pushBockTo:(void (^)(NSString *StoreStr))Blocks;


@property (weak, nonatomic) IBOutlet UIImageView *FirstImage;
//@property (weak, nonatomic) IBOutlet UILabel *FirstNameLabel;
//@property (weak, nonatomic) IBOutlet UILabel *FIrstLabel;


@property (weak, nonatomic) IBOutlet UIImageView *SecondeImage;
//@property (weak, nonatomic) IBOutlet UILabel *SecondNameLabel;
//@property (weak, nonatomic) IBOutlet UILabel *SecondLabel;



@property (weak, nonatomic) IBOutlet UIImageView *ThirdImage;
//@property (weak, nonatomic) IBOutlet UILabel *ThirdNameLabel;
//@property (weak, nonatomic) IBOutlet UILabel *ThirdLabel;


@property (weak, nonatomic) IBOutlet UIImageView *FourtIconImageView;
//@property (weak, nonatomic) IBOutlet UILabel *FourtNameLabel;
//@property (weak, nonatomic) IBOutlet UILabel *FourtPricceLabel;


@property (weak, nonatomic) IBOutlet UIImageView *FiveIconImageView;
//@property (weak, nonatomic) IBOutlet UILabel *FiveNameLabel;
//@property (weak, nonatomic) IBOutlet UILabel *FivePriceLabel;

- (IBAction)FirstAction:(id)sender;

- (IBAction)SecondAction:(id)sender;

- (IBAction)ThirdAction:(id)sender;

- (IBAction)FoutAction:(id)sender;

- (IBAction)FiveAction:(id)sender;

-(void)makeDataWithArr:(NSArray *)Arr;


@end
