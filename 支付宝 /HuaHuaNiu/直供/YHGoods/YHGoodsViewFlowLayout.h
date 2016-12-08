//
//  YHGoodsViewFlowLayout.h
//  花花牛
//
//  Created by mac on 16/4/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHGoodsViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic,assign) CGFloat itemHight;

@property (nonatomic,strong) CGFloat (^itemHigeht)();

@end
