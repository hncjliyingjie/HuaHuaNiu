//
//  YHAVPlayDisplayView.h
//  代言成
//
//  Created by YongHeng on 16/7/26.
//  Copyright © 2016年 YongHeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHAVPlayDisplayView : UIView
@property (weak, nonatomic) IBOutlet UILabel *contentLable;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;
@property (weak, nonatomic) IBOutlet UILabel *looks;
@property (weak, nonatomic) IBOutlet UILabel *comment_num;
@property (weak, nonatomic) IBOutlet UIImageView *lookImage;
@property (weak, nonatomic) IBOutlet UIImageView *commentImage;

@end
