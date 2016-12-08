




//
//  CZLoopView.m
//
//  Created by mac on 16/3/15.
//  Copyright © 2016年 heima. All rights reserved.
//

#import "CZLoopView.h"
#import "CZCollectionViewCell.h"
#import "SeconderViewModel.h"
#import "StoreDetailsViewController.h"
#import "ProductDetailViewController.h"

#define HMCellIdentifier @"CZCollectionViewCell"
#define HMMaxSections 100
#define KSize [UIScreen mainScreen].bounds.size

@interface CZLoopView ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,assign) NSInteger index;
@property (nonatomic,strong) UIPageControl *pageContol;

@property (nonatomic,strong) NSIndexPath *indexpath;
@end

@implementation CZLoopView
- (NSArray *)modelArray{
    
    if (_modelArray == nil) {
        _modelArray = [NSArray array];
    }
    return _modelArray;
}

- (void)reloadData{
    [super reloadData];
//    // 添加定时器
//    if (self.modelArray.count > 0) {
//        [self addTimer];
//    }
}
- (instancetype)initWithFrame:(CGRect)frame{
    
    // 创建UICollectionView布局的实例对象
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // 格子的大小
    layout.itemSize = frame.size;
    // 格子之间最小间距
    layout.minimumInteritemSpacing = 0.0f;
    //    // 最小行间距
    layout.minimumLineSpacing = 0.0f;
    // 内边距  上 左  下 右
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //    layout.sectionInset = UIEdgeInsetsMake(20, 0, 0, 0);
    // 调用父类的给CollectionView传入指定的布局参数
    
    CZLoopView *imageColl = [[CZLoopView alloc] initWithFrame:frame collectionViewLayout:layout];
    
    imageColl.backgroundColor = [UIColor greenColor];
    return imageColl;
    
    
}
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    
    //注册轮播器cell
    
    [self registerClass:[CZCollectionViewCell class] forCellWithReuseIdentifier:HMCellIdentifier];
    
    self = [super initWithFrame:frame collectionViewLayout:layout];
    
    self.backgroundColor = [UIColor blueColor];
    
    self.index = 0;
    // 设置分页
    self.pagingEnabled = YES;
    self.showsHorizontalScrollIndicator = NO;
    
    self.dataSource = self;
    self.delegate = self;
    
    
    // 默认的位置
    
    NSIndexPath * indexpath = [NSIndexPath indexPathForItem:0 inSection:HMMaxSections / 2];
    if (self.modelArray.count > 0) {
        [self scrollToItemAtIndexPath:indexpath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    self.indexpath = indexpath;
    
    CGFloat w = 50;
    CGFloat h = 10;
    
    UIPageControl *pag = [[UIPageControl alloc] initWithFrame:CGRectMake(KSize.width - w -100, KSize.height * 0.25, w, h)];
    pag.numberOfPages = self.modelArray.count;
    self.pageContol = pag;
    [self addSubview:pag];

//    // 添加定时器

        [self addTimer];

    
    return self;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
//    return self.modelArray.count > 0 ? HMMaxSections : 0;
    return HMMaxSections;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.modelArray.count > 0 ? self.modelArray.count : 3;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CZCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CZCollectionViewCell" forIndexPath:indexPath];
    if (self.modelArray.count > 0) {
        SeconderViewModel *model = self.modelArray[indexPath.row];
        NSMutableString *imageUrl = [NSMutableString stringWithString:@"http://daiyancheng.cn/"];
        NSString *string = model.logo;
        [imageUrl appendString:string];
        
        cell.url = imageUrl;
    }
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    //(@"进入第 indexPath.row 条商家 ", );
    NSLog(@"indexPath.row====%lu",indexPath.row);
    SeconderViewModel *model = self. modelArray[[[self indexPathsForVisibleItems] lastObject].row];

    if ([[NSString stringWithFormat:@"%@",model.adtype] isEqualToString:@"1"]) {
        //商家
        StoreDetailsViewController *Stv  =[[StoreDetailsViewController alloc]initWithStr:[NSString stringWithFormat:@"%@",model.advalue]];
        //发送通知跳转控制器
        [[NSNotificationCenter defaultCenter] postNotificationName:@"pushViewController" object:Stv];
    }else if ([[NSString stringWithFormat:@"%@",model.adtype] isEqualToString:@"2"]){
        //商品
        NSString *str = model.advalue;
        ProductDetailViewController * pvc = [[ProductDetailViewController alloc] initWithStr:str];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"pushViewController" object:pvc];
    }else{

    }



    //(@"进入第 %d条商家 ",a );
}


///**
// *  添加定时器
// */
- (void)addTimer
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
}
///**
// *  移除定时器
// */
- (void)removeTimer
{
    // 停止定时器
    [self.timer invalidate];
    self.timer = nil;
}

- (NSIndexPath *)resetIndexPath
{
    // 当前正在展示的位置
    NSIndexPath *currentIndexPath = [[self indexPathsForVisibleItems] lastObject];
    // 马上显示回最中间那组的数据
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:HMMaxSections / 2];
    
    [self scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    return currentIndexPathReset;
}

///**
// *  下一页
// */
- (void)nextPage
{
    // 1.马上显示回最中间那组的数据
    NSIndexPath *currentIndexPathReset = [self resetIndexPath];
    //    int page = (int)(scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5) % self.modelArray.count;
    self.pageContol.currentPage = currentIndexPathReset.item;
    // 2.计算出下一个需要展示的位置
    NSInteger nextItem = currentIndexPathReset.item + 1;
    NSInteger nextSection = currentIndexPathReset.section;
    if (nextItem == self.modelArray.count) {
        nextItem = 0;
        nextSection++;
    }
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    
    // 3.通过动画滚动到下一个位置
    [self scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
}

#pragma mark  - UICollectionViewDelegate
/**
 *  当用户即将开始拖拽的时候就调用
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    [self removeTimer];
}
//
///**
// *  当用户停止拖拽的时候就调用
// */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addTimer];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //1.计算当前滚动到了哪一个item
    NSInteger realCurrentIndex = (int)scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    NSInteger needCurrentIndex = realCurrentIndex % self.modelArray.count;
    
    //2.让其滚动到中间组 对应的item
    NSIndexPath *centerIndexPath = [NSIndexPath indexPathForItem:needCurrentIndex inSection:HMMaxSections / 2];
    
    [self scrollToItemAtIndexPath:centerIndexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    //    NSIndexPath *currentIndexPathReset = [self resetIndexPath];
    int page = (int)(scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5) % (self.modelArray.count > 0 ? self.modelArray.count : 3);
    self.pageContol.currentPage = page;
}

@end