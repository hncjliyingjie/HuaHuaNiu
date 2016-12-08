//
//  Model.h
//  瀑布流自己的
//
//  Created by dllo on 15/10/28.
//  Copyright © 2015年 zhaoqingwen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject


@property(nonatomic,copy)NSString *distance;
@property(nonatomic,copy)NSString *ID;
@property(nonatomic,copy)NSString *PointCount;
@property(nonatomic,copy)NSString *Reserve;
@property(nonatomic,copy)NSString *ThumbUrl;
@property(nonatomic,copy)NSString *UserId;
@property(nonatomic,copy)NSString *VideoHeight;
@property(nonatomic,copy)NSString *VideoWidth;
@property(nonatomic,copy)NSString *VideoAddr;
- (void)initwithDictionary:(NSDictionary *)dic;
@end
