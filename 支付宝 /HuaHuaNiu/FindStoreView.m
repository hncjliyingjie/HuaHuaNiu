//
//  FindStoreView.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-11.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "FindStoreView.h"
#import "UIImageView+WebCache.h"
@implementation FindStoreView

-(void)makeDataWithArr:(NSArray *)Arr{
   
    for (int i  = 0; i< Arr.count ; i++) {
        
        AlexModel * bouModel =[Arr objectAtIndex:i];
        if (i== 0) {
            NSURL *urlStr =[NSURL URLWithString:[NSString stringWithFormat:IMaUrl,bouModel.boutiqueLogo]];
            
            [self.FirstImage sd_setImageWithURL: urlStr placeholderImage:[UIImage imageNamed:@"default"]];

            FirstStr = bouModel.boutiqueId;
            
        }
        else   if (i== 1) {
            
            NSURL *urlStr =[NSURL URLWithString:[NSString stringWithFormat:IMaUrl,bouModel.boutiqueLogo]];
            
            [self.SecondeImage sd_setImageWithURL: urlStr placeholderImage:[UIImage imageNamed:@"default"]];

            secondStr  =bouModel.boutiqueId;
            
        }
        else   if (i== 2) {
            NSURL *urlStr =[NSURL URLWithString:[NSString stringWithFormat:IMaUrl,bouModel.boutiqueLogo]];
            
            [self.ThirdImage sd_setImageWithURL: urlStr placeholderImage:[UIImage imageNamed:@"default"]];

            ThirdStr  =bouModel.boutiqueId;
            


        }
        else   if (i== 3) {
            
            NSURL *urlStr =[NSURL URLWithString:[NSString stringWithFormat:IMaUrl,bouModel.boutiqueLogo]];
            
            [self.FourtIconImageView sd_setImageWithURL: urlStr placeholderImage:[UIImage imageNamed:@"default"]];

            FourtStr  =bouModel.boutiqueId;


        }
        else   if (i== 4) {
            
            NSURL *urlStr =[NSURL URLWithString:[NSString stringWithFormat:IMaUrl,bouModel.boutiqueLogo]];
            
            [self.FiveIconImageView sd_setImageWithURL: urlStr placeholderImage:[UIImage imageNamed:@"default"]];

            FiveStr  =bouModel.boutiqueId;
        
        }
           }
}

-(void)pushBockTo:(void (^)(NSString *))Blocks{
    PushStoreBlocks  =[Blocks copy];
}
- (IBAction)FirstAction:(id)sender {
    PushStoreBlocks (FirstStr);
    //(@"firstStore");
}

- (IBAction)SecondAction:(id)sender {
    PushStoreBlocks (secondStr);
    //(@"SecondStore");
}

- (IBAction)ThirdAction:(id)sender {
    PushStoreBlocks (ThirdStr);
    //(@"ThirdStore");
}
- (IBAction)FoutAction:(id)sender {
   PushStoreBlocks (FourtStr);
    //(@"FourtStr");
}
- (IBAction)FiveAction:(id)sender {
    PushStoreBlocks (FiveStr);
    //(@"FiveStr");
}
@end
