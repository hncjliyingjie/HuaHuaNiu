//
//  PlaceholderTextView.h
//  PlaceholderTextView
//
//  Created by 胡旭 on 14/12/12.
//  Copyright (c) 2014年 huxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceholderTextView : UITextView

@property(nonatomic,strong)NSString *Placeholder;
@property(nonatomic,strong)UIFont *PlaceholderFont;
@property(nonatomic,strong)UIColor *PlaceholderColor;

/**
 *  隐藏水印
 */
-(void)setPlaceholderHidden;

@end
