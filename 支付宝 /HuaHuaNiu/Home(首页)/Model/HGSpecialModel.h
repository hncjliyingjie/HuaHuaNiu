//
//  HGSpecialModel.h
//  HiGo
//
//  Created by Think_lion on 15/7/28.
//  Copyright (c) 2015年 Think_lion. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HGSpecialMainImageModel;

@interface HGSpecialModel : NSObject

@property (nonatomic,strong) NSData *date;
@property (nonatomic,strong) UIImage *image;
@property (nonatomic,copy) NSString *fileName;
@property (nonatomic,strong) NSURL *url;
@property  int64_t fileSize;



@end
