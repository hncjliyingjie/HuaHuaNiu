//
//  ReleaseTaskThirdCell.h
//  demo
//
//  Created by 肖燊亮 on 2016/11/26.
//  Copyright © 2016年 肖燊亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReleaseTaskThirdCell : UITableViewCell
@property(nonatomic,strong)NSString* beginTime;
@property(nonatomic,strong)NSString* endTime;
@property(nonatomic,assign)BOOL isCustom;//是否自定义
@property(nonatomic,copy)void(^instantlyBlock)();//立即开始回调
@property(nonatomic,copy)void(^customBlock)();//自定义回调
@property(nonatomic,copy)void(^beginTimeBlock)();//点击开始时间回调
@property(nonatomic,copy)void(^endTimeBlock)();//点击结束时间回调
+(CGFloat)getHeight:(BOOL)isCustom;

@end
