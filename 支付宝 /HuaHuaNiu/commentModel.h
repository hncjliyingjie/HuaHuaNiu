//
//  commentModel.h
//  MeiPinJie
//
//  Created by mac on 15/11/20.
//  Copyright © 2015年 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface commentModel : NSObject

@property (nonatomic,strong)NSString *UserImage;
@property (nonatomic,strong)NSString *UserName;
@property (nonatomic,strong)NSString *userId;
@property (nonatomic,strong)NSString *Content;
@property (nonatomic,strong)NSString *time;
@property (nonatomic,strong)NSString *isAnonymous;
@property (nonatomic,strong)NSString *replyUserName;
@property (nonatomic,strong)NSString *replyContent;


- (void)initwithDictionary:(NSDictionary *)dic;
@end
