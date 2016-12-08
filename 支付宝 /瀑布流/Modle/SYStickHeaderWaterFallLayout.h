//
//  SYStickHeaderWaterFallLayout.h
//  SYStickHeaderWaterFall
//
//  Created by 张苏亚 on 16/3/4.
//  Copyright © 2016年 suya. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kDeviceWidth  [UIScreen mainScreen].bounds.size.width
#define kDeviceHeight [UIScreen mainScreen].bounds.size.height
#define kFixTop (44)//在此修正sectionheader停留的位置

@class SYStickHeaderWaterFallLayout;

@protocol SYStickHeaderWaterFallDelegate <NSObject>

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(SYStickHeaderWaterFallLayout *)collectionViewLayout
 heightForItemAtIndexPath:(NSIndexPath *)indexPath;

@optional

- (CGFloat) collectionView:(UICollectionView *)collectionView
                    layout:(SYStickHeaderWaterFallLayout *)collectionViewLayout
heightForHeaderAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface SYStickHeaderWaterFallLayout : UICollectionViewLayout

@property (nonatomic, assign)  id<SYStickHeaderWaterFallDelegate> delegate;
//itemWidth必须设定.如果topInset和BottomInset未设定则设为(kDeviceWidth -itemWidth) /3（两行时）
@property (nonatomic) CGFloat itemWidth;

@property (nonatomic) CGFloat topInset;
@property (nonatomic) CGFloat bottomInset;

//@property (nonatomic)BOOL isSectionHeaderInset;//是否头部有上下间距
//@property (nonatomic) CGFloat headerTopInset;//头部上间距
//@property (nonatomic) CGFloat headerBottomInset;//头部下间距

@property (nonatomic) BOOL stickyHeader;

@end


// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com