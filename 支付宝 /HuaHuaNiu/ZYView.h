//
//  ZYView.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-4.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ZYView : UIView{
    NSString * IDStr;
    void(^PushChanPinBlocks)(NSString *Str);

}
@property (weak, nonatomic) IBOutlet UILabel *IntrLabel;
@property (weak, nonatomic) IBOutlet UIImageView *smallImage;
@property (weak, nonatomic) IBOutlet UILabel *LongLabel;
- (IBAction)PushAction:(id)sender;

///首页进入的
-(void)makeDataWithModel:(AlexModel *)model;

// 商家详情的
-(void)makeDataWithStoreDic:(NSDictionary *)dic;
-(void)ViewPushBlocks:(void(^)(NSString *Str))Blocks;
@end
