//
//  SQCommentViewController.h
//  HuaHuaNiu
//
//  Created by Vking on 16/1/26.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HGFindFrameModel.h"

@interface SQCommentViewController : UIViewController

@property (nonatomic,copy) NSString *member;
@property (nonatomic,strong) HGFindFrameModel *video;
@property (nonatomic,copy) NSString *video_id;
@property (nonatomic,copy) NSString *_on_looks;
@property (nonatomic,copy) NSString *comment_num;
@property (nonatomic,copy) NSString *path;
@property (nonatomic,copy) NSString *titles;
@property (nonatomic,copy) NSString *addtime;

@property (nonatomic,strong) UIImage *image1;

@end
