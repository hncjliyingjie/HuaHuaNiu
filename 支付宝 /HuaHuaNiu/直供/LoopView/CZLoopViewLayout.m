//
//  CZLoopViewLayout.m
//
//  Created by Apple on 16/3/23.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "CZLoopViewLayout.h"

@implementation CZLoopViewLayout

// 在 collectionView 的第一次布局的时候，被调用，此时 collectionView 的 frame 已经设置完毕
- (void)prepareLayout {
    // 一定 super
    [super prepareLayout];
    
    NSLog(@"%@", self.collectionView);
    // 直接利用 collectionView 的属性设置布局
    self.itemSize = self.collectionView.bounds.size;
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView.bounces = NO;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
}

@end
