//
//  WJY_WaterFallLayout.h
//  DreamRoomage
//
//  Created by wjy on 15/9/16.
//  Copyright (c) 2015年 wjy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@protocol WaterLayoutDelegate <NSObject>

@required
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

@end
//@protocol WaterLayoutDataSource <NSObject>
//
//@required
//- (CGSize)collectionView:(UICollectionView *)collectionView
//                  layout:(UICollectionViewLayout *)collectionViewLayout
//  sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
//@end

@interface WJY_WaterFallLayout : UICollectionViewLayout<UICollectionViewDelegate>
@property (nonatomic, assign) id<WaterLayoutDelegate> delegate;
// 行数
@property (nonatomic, assign) NSInteger lineCount;
@property (nonatomic, assign) BOOL header;
// 水平间距
@property (nonatomic, assign) CGFloat verticaSpacing;
// 垂直间距
@property (nonatomic, assign) CGFloat horizontalSpacing;
@property (nonatomic, assign) UIEdgeInsets sectionInset;
@end
