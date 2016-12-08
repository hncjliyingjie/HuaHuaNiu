//
//  leftCollectionViewController.h
//  MeiPinJie
//
//  Created by mac on 15/11/18.
//  Copyright © 2015年 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJY_WaterFallLayout.h"



@interface leftCollectionViewController : UICollectionViewController<WaterLayoutDelegate,UIScrollViewDelegate>
@property (nonatomic,assign)  id delegate;
@property (nonatomic,strong)NSMutableArray *heights;
@property (nonatomic,strong)NSMutableArray *widths;
@property(nonatomic,strong)NSMutableArray *pixclArray;
@property(nonatomic,strong)UIImage *dateImage;
@property(nonatomic,strong)UIView *prombt;
@property(nonatomic,strong)NSString *UserId;
@property(nonatomic,strong)NSString *haveShuju;
@property(nonatomic,strong)NSString *isNetwork;
@property(nonatomic,strong)NSString *ischanggeUserid;
@property(nonatomic,strong)NSString *isheaderbeginrefresh;
@property(nonatomic,strong)NSString *ismeineirong;
@end
