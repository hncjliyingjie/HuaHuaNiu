//
//  YHGoodsViewFlowLayout.m
//  花花牛
//
//  Created by mac on 16/4/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "YHGoodsViewFlowLayout.h"

#define Ksize [UIScreen mainScreen].bounds.size

@implementation YHGoodsViewFlowLayout
- (void)prepareLayout {
    [super prepareLayout];
    // 直接利用 collectionView 的属性设置布局
    CGFloat w = (Ksize.width - 10 * 3) / 2;
    self.collectionView.contentInset = UIEdgeInsetsMake(10, 10, 0, 10);
//    self.itemSize = CGSizeMake(w, self.itemHight);
    self.itemSize = CGSizeMake(w, 170);
    self.minimumInteritemSpacing = 10;
    self.minimumLineSpacing = 10;
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    
//    self.collectionView.bounces = NO;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
}
@end
