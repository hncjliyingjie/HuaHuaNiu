//
//  midCollectionViewController.m
//  MeiPinJie
//
//  Created by mac on 15/11/25.
//  Copyright © 2015年 Alex. All rights reserved.
//

#import "midCollectionViewController.h"
#import "MJRefresh.h"
#import "ZQW_AppTools.h"
#import "Model.h"
#import "UIImageView+WebCache.h"
#import "HMFileManager.h"
#import "CollectionViewCell.h"
#import "contentViewController.h"
#import "Reachability.h"
#import "SRRefreshView.h"
#define Krecultcaterypath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

@interface midCollectionViewController ()<SRRefreshDelegate>
{
    SRRefreshView   *_slimeView;
    int offcount;
    NSInteger pageType;
    CGFloat contentOffsetY;
    
    CGFloat oldContentOffsetY;
    
    CGFloat newContentOffsetY;
}

@end

@implementation midCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (NSMutableArray *)pixclArray{
    if (!_pixclArray) {
        _pixclArray = [NSMutableArray array];
    }
    return _pixclArray;
}

- (NSMutableArray *)widths{
    if (!_widths) {
        _widths = [NSMutableArray array];
    }
    return _widths;
}

- (NSMutableArray *)heights{
    if (!_heights) {
        _heights = [NSMutableArray array];
    }
    return _heights;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self pixclArray];
    
    [self widths];
    [self heights];
    [self addHeader];
    [self addfooter];
    offcount = 1;
    self.collectionView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    //  self.collectionView.pagingEnabled = YES;
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
   // [self getAFNetWorkingData];
   // _pixclArray = [NSMutableArray array];
    NSString *filename = [Krecultcaterypath stringByAppendingPathComponent:@"midContent.txt"];
    NSArray *temparrays = [NSArray arrayWithContentsOfFile:filename];
    NSString *filename1 = [Krecultcaterypath stringByAppendingPathComponent:@"midWidths.txt"];
    NSArray *widths = [NSArray arrayWithContentsOfFile:filename1];
    NSString *filename2 = [Krecultcaterypath stringByAppendingPathComponent:@"midHeights.txt"];
    NSArray *heights = [NSArray arrayWithContentsOfFile:filename2];
    NSLog(@"self.pixarray == %@",self.pixclArray);
    NSMutableArray *datas = [NSMutableArray array];
    Reachability* reach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    
    
    reach.reachableBlock = ^(Reachability * reachability)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"网络可用");
            self.isNetwork = @"1";
            
        });
    };
    
    reach.unreachableBlock = ^(Reachability * reachability)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"网络不可用");
            self.isNetwork = @"0";
            
        });
    };
    [reach startNotifier];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (widths){
    
        for (NSDictionary *dic in temparrays) {
            Model *model = [Model new];
            [model initwithDictionary:dic];
            [datas addObject:model];
        }
        //  [self.collectionView reloadData];
        _pixclArray = datas;
        [_widths addObjectsFromArray:widths];
        [_heights addObjectsFromArray:heights];
        self.isheaderbeginrefresh = @"1";
        [self.collectionView headerBeginRefreshing];
        
        
    }else{
        [self getAFNetWorkingData];
    }
    //主动让页面下拉刷新
    
    _slimeView = [[SRRefreshView alloc] init];
    _slimeView.delegate = self;
    _slimeView.upInset = 0;
    _slimeView.slimeMissWhenGoingBack = YES;
    _slimeView.slime.bodyColor = [UIColor lightGrayColor];
    _slimeView.slime.skinColor = [UIColor lightGrayColor];
    _slimeView.slime.lineWith = 1;
    _slimeView.slime.shadowBlur = 3;
    _slimeView.slime.shadowColor = UIColorFromRGB(0xf2f2f2);
    
  //  [self.collectionView addSubview:_slimeView];
   
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
   
    
}


- (void)addHeader{
    [self.collectionView addHeaderWithCallback:^{
        offcount = 1;
        if ([self.isNetwork isEqualToString:@"1"]) {
            [_pixclArray removeAllObjects];
            [self.widths removeAllObjects];
            [self.heights removeAllObjects];
        }
        NSLog(@"刷新了123");
        [self getAFNetWorkingData];
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
             //    [self.collectionView reloadData];
            [self.collectionView headerEndRefreshing];
            
            
        });
    }];
    
    
    
}

- (void)addfooter{
    [self.collectionView addFooterWithCallback:^{
        
        offcount += 1;
        [self getAFNetWorkingData];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
         //   [self.collectionView reloadData];
            [self.collectionView footerEndRefreshing];
        });
    }];
}


-(void)getAFNetWorkingData
{
    if ([self.isheaderbeginrefresh isEqualToString:@"1"]) {
        [_pixclArray removeAllObjects];
        [self.widths removeAllObjects];
        [self.heights removeAllObjects];
        
    }
    NSString *urlStr = @"/HairShow/Load/%d?type=1";
    NSString *str = [NSString stringWithFormat:@"%@%@",MAIN_URL,urlStr];
    NSString *url = [NSString stringWithFormat:str,offcount];
    NSLog(@"url == %@",url);
    [ZQW_AppTools getMessage:url Block:^(id result) {
        NSLog(@"result == %@",result);
        NSArray *resultArray = result[@"Data"];
        
        NSString *filename = [Krecultcaterypath stringByAppendingPathComponent:@"midContent.txt"];
        
        [resultArray writeToFile:filename atomically:YES];
        
        for (NSDictionary *dic in resultArray) {
            NSLog(@"dic1111== %@",dic);
            Model *model = [Model new];
            [model initwithDictionary:dic];
            [self.pixclArray addObject:model];
            [self.widths addObject:model.VideoWidth];
            [self.heights addObject:model.VideoHeight];
            
        }
        NSArray *widths = self.widths;
        NSArray *heights = self.heights;
        NSString *filename1 = [Krecultcaterypath stringByAppendingPathComponent:@"midWidths.txt"];
        NSString *filename2 = [Krecultcaterypath stringByAppendingPathComponent:@"midHeights.txt"];
        [widths writeToFile:filename1 atomically:YES];
        [heights writeToFile:filename2 atomically:YES];
        NSLog(@"_pixarray == %@",_pixclArray[1]);
        [self.collectionView reloadData];
        self.isheaderbeginrefresh = @"0";
    } and:^(id result1) {
        
        
    }];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return self.pixclArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
     
    
    if (_pixclArray.count > 0) {
        Model *model = _pixclArray[indexPath.item];
        cell.model = model;
        
        cell.hairshowLike.image = [UIImage imageNamed:@"heart"];
        NSString *string = [NSString stringWithFormat:@"%@",model.PointCount];
        cell.prefer.text = string;
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
        CGSize textSize = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
        NSString *user = [NSString stringWithFormat:@"%@%@%@%@",MAIN_URL,@"upload/",model.UserId,@"/avator.png"];
        [cell.hairshowLike setFrame:CGRectMake(cell.frame.size.width - textSize.width - 30, 3, 15, 15)];
        
        [cell.userImage sd_setImageWithURL:[NSURL URLWithString:user] placeholderImage:[UIImage imageNamed:@"hairshow_default_icon"]];
        
        
        NSString *imageurl = [NSString stringWithFormat:@"%@%@",@"http://test.cdn2.p.meilianbao.net",model.ThumbUrl];
        
        [cell.picImageView sd_setImageWithURL:[NSURL URLWithString:imageurl]];
    }
    
    // Configure the cell
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *width = self.widths[indexPath.row];
    NSString *height = self.heights[indexPath.row];
    int x = [width intValue];
    int y = [height intValue];
    
    return CGSizeMake((VIEW_WIDH - 5) / 2, (VIEW_WIDH - 5) / 2 * y/x + 20);
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"wwwwww %@",_pixclArray[indexPath.row]);
    Model *model = _pixclArray[indexPath.row];
    NSString *width = self.widths[indexPath.row];
    NSString *height = self.heights[indexPath.row];
    NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:model.ID,@"textOne",width,@"width",height,@"height",model.VideoAddr,@"videoaddr",model.ThumbUrl,@"ThumbUrl", nil];
    NSLog(@"视频路径2 %@",model.VideoAddr);
    NSNotification *notification = [NSNotification notificationWithName:@"leftControll" object:nil userInfo:dict];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_slimeView scrollViewDidScroll];
    if ((scrollView.contentOffset.y + (scrollView.frame.size.height) + 200) > scrollView.contentSize.height) {
        [self.collectionView footerBeginRefreshing];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_slimeView scrollViewDidEndDraging];
}
#pragma mark - slimeRefresh delegate

- (void)slimeRefreshStartRefresh:(SRRefreshView *)refreshView
{
    offcount = 1;
    if ([self.isNetwork isEqualToString:@"1"]) {
        [_pixclArray removeAllObjects];
        [self.widths removeAllObjects];
        [self.heights removeAllObjects];
    }
    NSLog(@"刷新了123");
    [self getAFNetWorkingData];
    [_slimeView performSelector:@selector(endRefresh)
                     withObject:nil afterDelay:3
                        inModes:[NSArray arrayWithObject:NSRunLoopCommonModes]];
}

@end
