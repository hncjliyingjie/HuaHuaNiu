//
//  YHGoodsCollectionCon.m
//  花花牛
//
//  Created by mac on 16/4/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "YHGoodsCollectionCon.h"
#import "YHGoodsViewFlowLayout.h"
#import "YHGoodsCollectionCell.h"
#import "YHGoodsUiHuanCell.h"
#import "ProductDetailViewController.h"
#import "YHGoodsModel.h"
#import "ProductDetailViewController2.h"


#define Ksize [UIScreen mainScreen].bounds.size

@interface YHGoodsCollectionCon ()<UICollectionViewDataSource, UICollectionViewDelegate>
@end

@implementation YHGoodsCollectionCon
//
static NSString * const YHGoodsCollectionCellId = @"YHGoodsCollectionCell";

- (instancetype)initWithFrame:(CGRect)frame withDataArray:(NSArray *)array isDuiHuan:(BOOL)isDuihuan
{
    
    if (array.count > 0) {
        float count = array.count;
        int a;
        a = ceil(count / 2);
        frame.size.height = a * 180 + 10;
    }
    
    YHGoodsViewFlowLayout *layout = [[YHGoodsViewFlowLayout alloc] init];
    if (isDuihuan) {
        layout.itemHight = 170;
    }else{
        layout.itemHight = 200;
    }
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        if (array.count > 0) {
            self.modelArray = array;
        }else{
            
            self.modelArray = [NSArray array];
        }
        [self registerNib:[UINib nibWithNibName:@"YHGoodsCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"YHGoodsCollectionCell"];
        [self registerNib:[UINib nibWithNibName:@"YHGoodsUiHuanCell" bundle:nil] forCellWithReuseIdentifier:@"YHGoodsUiHuanCell"];
    }
    return self;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.modelArray.count > 0 ? 1 : 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.modelArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.isDuiHuan) {
        
        YHGoodsUiHuanCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YHGoodsUiHuanCell" forIndexPath:indexPath];
        cell.DuiHuanmodel = self.modelArray[indexPath.row];
        cell.backgroundColor = [UIColor whiteColor];
        return cell;
    }else{
        YHGoodsCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YHGoodsCollectionCell" forIndexPath:indexPath];
        cell.model = self.modelArray[indexPath.row];
        return cell;
    }
}



- (CGSize)collectionViewContentSize
{
    CGFloat heightest = self.modelArray.count * 210;
    
    CGSize size = CGSizeMake(0, heightest);
    
    return size;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    if (self.isDuiHuan) {
        YHGoodsModel *model = self.modelArray[indexPath.row];
        ProductDetailViewController2 *Pvc = [[ProductDetailViewController2 alloc] initWithStr:model.goods_id];
        Pvc.strName = model.goods_name;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"pushViewController" object:Pvc];
    }else{
        
        YHGoodsModel *model = self.modelArray[indexPath.row];
        ProductDetailViewController *Pvc =[[ProductDetailViewController alloc]initWithStr:model.goods_id];

        [[NSNotificationCenter defaultCenter] postNotificationName:@"pushViewController" object:Pvc];
    }
}

@end
