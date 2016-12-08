//
//  ReleaseTaskfourthCell.h
//  demo
//
//  Created by 肖燊亮 on 2016/11/26.
//  Copyright © 2016年 肖燊亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReleaseTaskfourthCell : UITableViewCell
@property(nonatomic,strong)UITextField* textField_phone;
@property(nonatomic,strong)UITextView* textView_taskRequest;
@property(nonatomic,copy)void(^nextBlock)();
+(CGFloat)getHeight;
@end
