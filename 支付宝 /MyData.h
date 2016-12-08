//
//  MyData.h
//  ModelToJson
//
//  Created by admin on 15/4/10.
//  Copyright (c) 2015年 sunyuqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyData : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *ad_type;
@property (nonatomic, strong) NSString *qrcode;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *start_time;
@property (nonatomic, strong) NSString *end_time;
@property (nonatomic, strong) NSString *tel;
@property (nonatomic, strong) NSString *require1;
@property (nonatomic, strong) NSString *way_type;
@property (nonatomic, strong) NSString *add_user_id;
@property (nonatomic, strong) NSString *paly_way;
@property (nonatomic, strong) NSString *city_id;
@property (nonatomic, strong) NSString *province_id;
@property (nonatomic, strong) NSString *media_id;

//@property (nonatomic, strong) NSString *img;

//@property (nonatomic, strong) NSString *Describe;
//@property (nonatomic, strong) NSString *Sort;

//@property (nonatomic, strong) MyData *objProp;

@property (nonatomic, strong) NSArray *images;

//@property (nonatomic, strong) NSDictionary *dicProp;
@end

