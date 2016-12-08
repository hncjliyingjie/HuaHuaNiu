//
//  commentModel.m
//  MeiPinJie
//
//  Created by mac on 15/11/20.
//  Copyright © 2015年 Alex. All rights reserved.
//

#import "commentModel.h"

@implementation commentModel

- (void)initwithDictionary:(NSDictionary *)dic{
    self.isAnonymous = dic[@"IsAnonymous"];
    self.time = dic[@"CreateTimeStr"];
    self.UserName = dic[@"UserName"];
    self.userId = dic[@"ID"];
    self.UserImage = dic[@"UserId"];
    self.Content = dic[@"Content"];
    self.replyUserName = dic[@"ReplyUserName"];
    self.replyContent = dic[@"ReplyContent"];
}

@end
