//
//  GouWView.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-19.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GouWView : UIView{
    void(^CheGouWBlock)();

}
-(void)LabelNUmber:(NSString *)NUmber;
-(void)MakeUIPush:(void(^)())Blocks;
- (IBAction)GouWuActions:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *NumberLabel;

@end
