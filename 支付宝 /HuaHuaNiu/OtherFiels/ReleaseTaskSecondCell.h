//
//  ReleaseTaskSecondCell.h
//  demo
//
//  Created by 肖燊亮 on 2016/11/26.
//  Copyright © 2016年 肖燊亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShareLinkView.h"
#import "SharePicTextView.h"

@interface ReleaseTaskSecondCell : UITableViewCell
@property(nonatomic,assign)BOOL isLink;
@property(nonatomic,strong)ShareLinkView* view_link;
@property(nonatomic,strong)SharePicTextView* view_picText;
@property(nonatomic,strong)NSMutableArray* link_imageUrls;
@property(nonatomic,strong)NSMutableArray* picText_imageUrls;
@property(nonatomic,strong)NSMutableArray* link_assetsImageUrls;
@property(nonatomic,strong)NSMutableArray* picText_assetsImageUrls;
@property(nonatomic,copy)void(^shareBlock)(BOOL isLink);//选择回调
@property(nonatomic,copy)void(^exampleBlock)(BOOL isLink);//示例回调
@property(nonatomic,copy)void(^addBlock)(BOOL isLink);//添加图片回调
@property(nonatomic,copy)void(^heigthBlock)(BOOL isLink, NSMutableArray *selectedPhotos,NSMutableArray *selectedAssets);//高度变化回调
+(CGFloat)getHeight:(BOOL)isLink imageUrlsCount:(NSInteger)count;
@end
