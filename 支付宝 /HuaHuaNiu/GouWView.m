//
//  GouWView.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-19.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "GouWView.h"

@implementation GouWView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)LabelNUmber:(NSString *)NUmber{
    
    
    if (NUmber.length == 0) {
        self.NumberLabel.hidden = YES;
    }else{
        self.NumberLabel.hidden =NO;
        self.NumberLabel.text =NUmber;
    }
    
    self.NumberLabel.layer.masksToBounds = YES;
    self.NumberLabel.text = NUmber;
    self.NumberLabel.layer.cornerRadius = 5;
}
-(void)MakeUIPush:(void (^)())Blocks{
    CheGouWBlock =[Blocks copy];

}
- (IBAction)GouWuActions:(id)sender {
    CheGouWBlock();
}
@end
