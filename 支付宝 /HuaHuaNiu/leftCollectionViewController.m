//
//  leftCollectionViewController.m
//  MeiPinJie
//
//  Created by mac on 15/11/18.
//  Copyright © 2015年 Alex. All rights reserved.
//

#import "leftCollectionViewController.h"
#import "MJRefreshHeaderView.h"
#import "MJRefresh.h"
#import "ZQW_AppTools.h"
#import "Model.h"
#import "UIImageView+WebCache.h"
#import "HMFileManager.h"
#import "CollectionViewCell.h"
#import "contentViewController.h"
#import "Reachability.h"

#define Krecultcaterypath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

@interface leftCollectionViewController ()
{
    int offcount;
    NSInteger pageType;
}

@end

@implementation leftCollectionViewController

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
   self.collectionView.alwaysBounceVertical = YES;
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    NSString *name = [NSString stringWithFormat:@"lefrContent%@.txt",self.UserId];
    NSString *name1 = [NSString stringWithFormat:@"leftWidths%@.txt",self.UserId];
    NSString *name2 = [NSString stringWithFormat:@"leftHeights%@.txt",self.UserId];
    
    NSString *filename = [Krecultcaterypath stringByAppendingPathComponent:name];
    NSArray *temparrays = [NSArray arrayWithContentsOfFile:filename];
    NSString *filename1 = [Krecultcaterypath stringByAppendingPathComponent:name1];
    NSArray *widths = [NSArray arrayWithContentsOfFile:filename1];
    NSString *filename2 = [Krecultcaterypath stringByAppendingPathComponent:name2];
    NSArray *heights = [NSArray arrayWithContentsOfFile:filename2];
    NSLog(@"self.pixarray == %@",self.pixclArray);
    NSMutableArray *datas = [NSMutableArray array];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tolefthairshow:) name:@"tolefthairshow" object:nil];
    NSMutableArray *mutablearray = [NSMutableArray array];
    for (NSDictionary *dic in temparrays) {
        Model *model = [Model new];
        [model initwithDictionary:dic];
        [mutablearray addObject:model];
    }
    
    if (mutablearray.count != 0){
        
        for (NSDictionary *dic in temparrays) {
            Model *model = [Model new];
            [model initwithDictionary:dic];
            [datas addObject:model];
        }
        
        _pixclArray = datas;
        [_widths addObjectsFromArray:widths];
        [_heights addObjectsFromArray:heights];
        
        
    }else{
        [self getAFNetWorkingData];
    }
    NSLog(@"self.pixarray111 === %@",self.pixclArray);
    
    
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
//    if ([self.ischanggeUserid isEqualToString:@"1"]) {
    
    [self.collectionView headerBeginRefreshing];
    
 //   }
    
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    _prombt = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDH , VIEW_HEIGHT)];
    _prombt.backgroundColor = UIColorFromRGB(0xf2f2f2);
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDH /2 - 50,20 , 100, 100)];
    image.image = [UIImage imageNamed:@"empty"];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 130, VIEW_WIDH - 20, 20)];
    label.textColor = [UIColor lightGrayColor];
    label.text = @"没找到相关的内容";
    label.textAlignment = UITextAlignmentCenter;
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 150, VIEW_WIDH - 20, 20)];
    label1.text = @"赶快去关注自己感兴趣的人吧^_^";
    label1.textColor = [UIColor lightGrayColor];
    
    label1.textAlignment = UITextAlignmentCenter;
    [_prombt addSubview:label1];
    [_prombt addSubview:label];
    [_prombt addSubview:image];
    [self.collectionView addSubview:_prombt];
    
}

- (void)viewWillDisappear:(BOOL)animated{
  //  [_prombt removeFromSuperview];
    self.ischanggeUserid = @"0";
}


- (void)tolefthairshow:(NSNotification *)sender{
    if ([self.ismeineirong isEqualToString:@"1"]) {
        [self.collectionView headerBeginRefreshing];
    }
}


- (void)addHeader{
    
    
    [self.collectionView addHeaderWithCallback:^{
        
        
        offcount = 1;
        if ([self.isNetwork isEqualToString:@"1"]) {
            [_pixclArray removeAllObjects];
            [self.widths removeAllObjects];
            [self.heights removeAllObjects];
        }
        [self getAFNetWorkingData];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       //     [self.collectionView reloadData];
            [self.collectionView headerEndRefreshing];
            NSLog(@"刷新了1");
            
        });
    }];
    
    // [self.tableView headerBeginRefreshing];
    
}

- (void)addfooter{
    [self.collectionView addFooterWithCallback:^{
        
        offcount += 1;
        [self getAFNetWorkingData];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
          //  [self.collectionView reloadData];
            [self.collectionView footerEndRefreshing];
        });
    }];
}


-(void)getAFNetWorkingData
{
    
    
    NSString *urlStr = @"/HairShow/Load/%d?type=0&userId=%@";
    NSString *str = [NSString stringWithFormat:@"%@%@",MAIN_URL,urlStr];
    NSString *url = [NSString stringWithFormat:str,offcount,self.UserId];
    NSLog(@"请求数据请求数据请求数据请求数据 == %@",url);
    [ZQW_AppTools getMessage:url Block:^(id result) {
        NSLog(@"result == %@",result);
        NSArray *resultArray = result[@"Data"];
        
         for (NSDictionary *dic in resultArray) {
        //    NSLog(@"dic1111== %@",dic);
            Model *model = [Model new];
            [model initwithDictionary:dic];
            [self.pixclArray addObject:model];
            [self.widths addObject:model.VideoWidth];
            [self.heights addObject:model.VideoHeight];
            
        }
        NSLog(@"pixarray ==== %lu",(unsigned long)self.pixclArray.count);
        
        if (self.pixclArray.count == 0) {
  //          [self.collectionView removeHeader];
//            [self.collectionView removeFooter];
//            [self.collectionView removeFromSuperview];
//
            self.ismeineirong = @"1";
            [_prombt setHidden:NO];
            
        }else{
            self.ismeineirong = @"0";
            [_prombt setHidden:YES];
            NSString *name = [NSString stringWithFormat:@"lefrContent%@.txt",self.UserId];
            NSString *name1 = [NSString stringWithFormat:@"leftWidths%@.txt",self.UserId];
            NSString *name2 = [NSString stringWithFormat:@"leftHeights%@.txt",self.UserId];
            
            NSString *filename = [Krecultcaterypath stringByAppendingPathComponent:name];
            NSArray *widths = self.widths;
            NSArray *heights = self.heights;
            NSString *filename1 = [Krecultcaterypath stringByAppendingPathComponent:name1];
            NSString *filename2 = [Krecultcaterypath stringByAppendingPathComponent:name2];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [resultArray writeToFile:filename atomically:YES];
                [widths writeToFile:filename1 atomically:YES];
                [heights writeToFile:filename2 atomically:YES];
            });
            [self.collectionView reloadData];
        }
        
      
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
      //  cell.hairshowLike.image = [UIImage imageNamed:@"hairshowlike"];
        NSString *string = [NSString stringWithFormat:@"%@",model.Reserve];
        cell.prefer.text = string;
       
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
        CGSize textSize = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, 100) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
        [cell.prefer setFrame:CGRectMake(cell.frame.size.width - textSize.width - 10, 5, textSize.width, 13)];
       
        NSString *user = [NSString stringWithFormat:@"%@%@%@%@",MAIN_URL,@"upload/",model.UserId,@"/avator.png"];
        
        [cell.userImage sd_setImageWithURL:[NSURL URLWithString:user] placeholderImage:[UIImage imageNamed:@"hairshow_default_icon"]];
        
       
        NSString *imageurl = [NSString stringWithFormat:@"%@%@",@"http://test.cdn2.p.meilianbao.net",model.ThumbUrl];
        NSLog(@"imageurl == %@",imageurl);
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
    
    return CGSizeMake((VIEW_WIDH - 5) / 2, (VIEW_WIDH - 5) / 2 * y/x +20);
    
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
  
    if ((scrollView.contentOffset.y + (scrollView.frame.size.height) + 200) > scrollView.contentSize.height) {
        [self.collectionView footerBeginRefreshing];
    }
}


@end
