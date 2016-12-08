//
//  leftCollectionViewCell.h
//  MeiPinJie
//
//  Created by mac on 15/11/19.
//  Copyright © 2015年 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Model;
@interface leftCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)UIImageView *picImageView;
@property(nonatomic,strong)UIImageView *userImage;
@property(nonatomic,strong)UIView *view;
@property(nonatomic,strong)Model *model;

@end
