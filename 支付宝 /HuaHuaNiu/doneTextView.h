//
//  doneTextView.h
//  MeiPinJie
//
//  Created by mac on 15/11/23.
//  Copyright © 2015年 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DoneActionBlock)(id);

@interface doneTextView : UITextView

@property(nonatomic,retain) UIButton *doneButton;
@property(nonatomic,retain) NSString *ButtonTitle;
@property(nonatomic, copy) DoneActionBlock doneEven;

@end
