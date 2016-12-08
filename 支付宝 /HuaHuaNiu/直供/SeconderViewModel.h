//
//  SeconderViewModel.h
//  HuaHuaNiu
//
//  Created by mac on 16/4/23.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SeconderViewModel : NSObject


@property (nonatomic,strong) NSString *ad_id;
@property (nonatomic,strong) NSString *adtype;
@property (nonatomic,strong) NSString *advalue;
@property (nonatomic,strong) NSString *logo;
@property (nonatomic,strong) NSString *price;
@property (nonatomic,strong) NSString *summary;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *type_id;
//@property (nonatomic,strong) NSString *<#String#>;
//@property (nonatomic,strong) NSString *<#String#>;
//@property (nonatomic,strong) NSString *<#String#>;
//@property (nonatomic,strong) NSString *<#String#>;

+ (instancetype)modelWithDict:(NSDictionary *)dict;
@end
