//
//  HPCollectionViewCell.m
//  mokoo
//
//  Created by Mac on 15/9/20.
//  Copyright (c) 2015年 Mac. All rights reserved.
//
#define kDeviceWidth  [UIScreen mainScreen].bounds.size.width
#define kDeviceHeight [UIScreen mainScreen].bounds.size.height
#import "HPCollectionViewCell.h"
#import "UIImageView+WebCache.h"
//#import "UIImage+ImageBlur.h"
//#import "MokooMacro.h"
@implementation HPCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setShop:(HomeModel *)shop
{
    _nameLabelWidthConstraint.constant = kDeviceWidth/2 -50 -38 -7.5;
    _leadingNameLableConstraint.constant = -(kDeviceWidth/2 -50 -38 -7.5) -38;
    _nameLabelConstraint.constant = -8;
    _locationIconConstraint.constant = -27;
    _locationNameConstraint.constant = -32;
    _shop = shop;
    self.vImageView.hidden = YES;
    [self.shopImage sd_setImageWithURL:[NSURL URLWithString:_shop.model_img] placeholderImage:[UIImage imageNamed:@"pic_loading.pdf"]];
    //    [self insertColorGradientByUIImageView:self.shopImage];
    self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.size.width/2;
    self.avatarImageView.layer.masksToBounds = YES;
    self.avatarImageView.contentMode =UIViewContentModeScaleAspectFill;
    self.shopName.text = _shop.city;
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:_shop.user_img] placeholderImage:[UIImage imageNamed:@"head.pdf"]];
    [self.shopImage addSubview:self.avatarImageView];
    if ([_shop.is_verify isEqualToString:@"1"]) {
        self.vImageView.hidden = NO;

    }
    [self.shopImage addSubview:self.vImageView];
    [self.nameLabel setText:_shop.nick_name];
    [self.shopImage addSubview:self.nameLabel];
    [self.shopImage addSubview:self.locationImageView];
    [self.locationLabel setText:_shop.city];
    [self.shopImage addSubview:self.locationLabel];
    
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com