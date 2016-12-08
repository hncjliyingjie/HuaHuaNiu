//
//  ReleaseTaskSecondCell.m
//  demo
//
//  Created by 肖燊亮 on 2016/11/26.
//  Copyright © 2016年 肖燊亮. All rights reserved.
//

#import "ReleaseTaskSecondCell.h"

@interface ReleaseTaskSecondCell ()
@property(nonatomic,strong)UIView* view_base;
@property(nonatomic,strong)UIView* view_shareIcon;
@property(nonatomic,strong)UIButton* button_link;
@property(nonatomic,strong)UIButton* button_picText;

@end

@implementation ReleaseTaskSecondCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView* view = [[UIView alloc]initWithFrame:CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width - 20, 250)];
        view.layer.cornerRadius = 5;
        view.layer.borderColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1].CGColor;
        view.layer.borderWidth = 0.5;
        view.clipsToBounds = YES;
        view.userInteractionEnabled = YES;
        view.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:view];
        self.view_base = view;
        
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"分享链接" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor blueColor];
        button.tag = 1000;
        button.frame = CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width - 20) / 2, 40);
        [view addSubview:button];
        self.button_link = button;
        
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"分享图文" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        button.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 20) / 2, 0, ([UIScreen mainScreen].bounds.size.width - 20) / 2, 40);
        button.backgroundColor = [UIColor whiteColor];
        button.tag = 2000;
        [view addSubview:button];
        self.button_picText = button;
        
    }
    return self;
}

-(void)onClick:(UIButton*)button
{
    if (self.shareBlock) {
        BOOL isLink = !(button.tag - 1000);
        self.view_link.hidden = !isLink;
        self.view_picText.hidden = isLink;
        self.shareBlock(isLink);
    }
}


+(CGFloat)getHeight:(BOOL)isLink imageUrlsCount:(NSInteger)count
{
    count++;
    float height = 55;
    if (([UIScreen mainScreen].bounds.size.width - 20) < count * 54) {
        height = 110;
    }
    return isLink ? 200 + height : 180 + height;
}

-(void)setLink_imageUrls:(NSArray *)link_imageUrls
{
    _link_imageUrls = link_imageUrls;
    float height = 55;
    if (([UIScreen mainScreen].bounds.size.width - 20) < (link_imageUrls.count + 1) * 54) {
        height = 110;
    }
    if (_view_link) {
        [_view_link removeFromSuperview];
    }
    
    self.view_link = [[ShareLinkView alloc]initWithFrame:CGRectMake(0, 40, self.view_base.frame.size.width, 150 + height)];
    __weak typeof(self) weakSelf = self;
    _view_link.addBlock = ^(BOOL isLink){
        weakSelf.addBlock(isLink);
    };
    _view_link.exampleBlock = ^(BOOL isLink){
        weakSelf.exampleBlock(isLink);
    };
    _view_link.heigthBlock =  ^(BOOL isLink, NSMutableArray *selectedPhotos,NSMutableArray *selectedAssets){
        weakSelf.heigthBlock(isLink,selectedPhotos,selectedAssets);
    };
    [_view_base addSubview:_view_link];
}

-(void)setPicText_imageUrls:(NSArray *)picText_imageUrls
{
    _picText_imageUrls = picText_imageUrls;
    
    float height = 60;
    if (([UIScreen mainScreen].bounds.size.width - 20) < (_picText_imageUrls.count + 1) * 54) {
        height = 120;
    }
    if (_view_picText) {
        [_view_picText removeFromSuperview];
    }
    
    self.view_picText = [[SharePicTextView alloc]initWithFrame:CGRectMake(0, 40, self.view_base.frame.size.width, 130 + height)];
    __weak typeof(self) weakSelf = self;
    _view_picText.addBlock = ^(BOOL isLink){
        weakSelf.addBlock(isLink);
    };
    _view_picText.exampleBlock = ^(BOOL isLink){
        weakSelf.exampleBlock(isLink);
    };
    _view_picText.heigthBlock =  ^(BOOL isLink, NSMutableArray *selectedPhotos,NSMutableArray *selectedAssets){
        weakSelf.heigthBlock(isLink,selectedPhotos,selectedAssets);
    };
    [_view_base addSubview:_view_picText];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.view_link.selectedPhotos = _link_imageUrls;
    self.view_picText.selectedPhotos = _picText_imageUrls;
    self.view_link.selectedAssets = _link_assetsImageUrls;
    self.view_picText.selectedAssets = _picText_assetsImageUrls;
    
    
    CGRect f = self.view_base.frame;
    f.size.height = _isLink ? [ReleaseTaskSecondCell getHeight:_isLink imageUrlsCount:_link_imageUrls.count] - 10: [ReleaseTaskSecondCell getHeight:_isLink imageUrlsCount:_picText_imageUrls.count] - 10;
    self.view_base.frame = f;
    
    if (self.isLink) {
        [self.button_link setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.button_link.backgroundColor = [UIColor colorWithRed:0.047 green:0.364 blue:0.662 alpha:1];
        [self.button_picText setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.button_picText.backgroundColor = [UIColor whiteColor];
        self.view_picText.hidden = YES;
        self.view_link.hidden = NO;
    }
    else{
        [self.button_picText setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.button_picText.backgroundColor = [UIColor colorWithRed:0.047 green:0.364 blue:0.662 alpha:1];
        [self.button_link setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.button_link.backgroundColor = [UIColor whiteColor];
        self.view_picText.hidden = NO;
        self.view_link.hidden = YES;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
