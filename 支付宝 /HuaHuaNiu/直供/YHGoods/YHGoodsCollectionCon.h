//
//  YHGoodsCollectionCon.h
//  花花牛
//
//  Created by mac on 16/4/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YHGoodsCollectionConDelegate <NSObject>

- (void)poushProductDetailViewControllerWith:(UIViewController *)viewCon;

@end

@interface YHGoodsCollectionCon : UICollectionView

//@property (nonatomic,assign) BOOL isDuiHuan;
@property (nonatomic,strong) id<YHGoodsCollectionConDelegate> delegateCell;
@property (nonatomic,strong) NSArray *modelArray;
- (instancetype)initWithFrame:(CGRect)frame withDataArray:(NSArray *)array isDuiHuan:(BOOL)isDuihuan;
//- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout withDataArray:(NSArray *)array;
@property (nonatomic,assign) BOOL isDuiHuan;
@end
