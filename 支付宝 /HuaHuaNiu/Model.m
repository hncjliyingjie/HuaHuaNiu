//
//  Model.m
//  瀑布流自己的
//
//  Created by dllo on 15/10/28.
//  Copyright © 2015年 zhaoqingwen. All rights reserved.
//

#import "Model.h"

@implementation Model

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (void)initwithDictionary:(NSDictionary *)dic{
    self.distance = dic[@"Distance"];
    self.ID = dic[@"ID"];
    self.PointCount = dic[@"PointCount"];
    self.Reserve = dic[@"Reserve"];
    self.ThumbUrl = dic[@"ThumbUrl"];
    self.UserId = dic[@"UserId"];
    self.VideoHeight = dic[@"VideoHeight"];
    self.VideoWidth = dic[@"VideoWidth"];
    self.VideoAddr = dic[@"VideoAddr"];
}

@end
