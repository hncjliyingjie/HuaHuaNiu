//
//  CollectionViewCell.h
//  瀑布流自己的
//
//  Created by dllo on 15/10/28.
//  Copyright © 2015年 zhaoqingwen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Model;
@interface CollectionViewCell1 : UICollectionViewCell

@property(nonatomic,strong)UIView *mainView;
@property(nonatomic,strong)UILabel *titleLable;
@property(nonatomic,strong)UILabel *showLable;
@property(nonatomic,strong)UIButton *button;
@property(nonatomic,strong)UIImageView *picImageView;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)Model *model;
@property(nonatomic,assign)int tagCount;
@property(nonatomic,strong)UIImageView *picImageView1;
@property(nonatomic,strong)UIImageView *picImageView2;
@property(nonatomic,strong)UIImageView *picImageViewJ;
@property(nonatomic,strong)UILabel *lableJ;
@property(nonatomic,strong)UILabel *lableS;
@property(nonatomic,strong)UILabel *lableY;
@property(nonatomic,strong)UIImageView *picImageViewR;
@property(nonatomic,strong)UILabel *lable1;
@end
