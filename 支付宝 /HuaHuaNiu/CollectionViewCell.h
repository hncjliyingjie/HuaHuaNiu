//
//  CollectionViewCell.h
//  瀑布流自己的
//
//  Created by dllo on 15/10/28.
//  Copyright © 2015年 zhaoqingwen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Model;
@interface CollectionViewCell : UICollectionViewCell

@property(nonatomic,strong)UIImageView *picImageView;
@property(nonatomic,strong)UIImageView *userImage;
@property(nonatomic,strong)UIView *userImageView;
@property(nonatomic,strong)UIView *view;
@property(nonatomic,strong)Model *model;
@property(nonatomic,strong)UIImageView *hairshowLike;
@property(nonatomic,strong)UIImageView *isPhoto;
@property(nonatomic,strong)UILabel *prefer;
@end
