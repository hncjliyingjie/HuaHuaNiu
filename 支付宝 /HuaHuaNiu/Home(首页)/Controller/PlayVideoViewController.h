//
//  PlayVideoViewController.h
//  视频模块
//
//  Created by Vking on 16/1/6.
//  Copyright © 2016年 Vking. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HGFindFrameModel.h"
@interface PlayVideoViewController : UIViewController

@property (nonatomic,strong) HGFindFrameModel *video;
@property (nonatomic,copy) NSString *member;

@end
