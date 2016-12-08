//
//  CZLoopView.h
//  UI-图片轮播
//
//  Created by Apple on 16/3/23.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CZLoopView : UICollectionView
@property (nonatomic, strong) NSArray *modelArray;

- (instancetype)initWithFrame:(CGRect)frame;



//@property (nonatomic,strong) NSArray *modelArray;
//- (instancetype)initWithURLs:(NSArray <NSString *> *)urls;
@end
