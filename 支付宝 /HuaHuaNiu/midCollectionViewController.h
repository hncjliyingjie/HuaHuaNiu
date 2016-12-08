//
//  midCollectionViewController.h
//  MeiPinJie
//
//  Created by mac on 15/11/25.
//  Copyright © 2015年 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJY_WaterFallLayout.h"
@interface midCollectionViewController : UICollectionViewController<WaterLayoutDelegate,UIScrollViewDelegate>
@property (nonatomic,strong)NSMutableArray *heights;
@property (nonatomic,strong)NSMutableArray *widths;
@property(nonatomic,strong)NSMutableArray *pixclArray;
@property(nonatomic,strong)UIImage *dateImage;
@property(nonatomic,strong)NSString *isNetwork;
@property(nonatomic,strong)NSString *isheaderbeginrefresh;
@end
