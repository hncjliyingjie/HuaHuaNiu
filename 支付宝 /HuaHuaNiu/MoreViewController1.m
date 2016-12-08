//
//  MoreViewController1.m
//  源质资本
//
//  Created by yuanzhi on 16/1/20.
//  Copyright © 2016年 洪慧康. All rights reserved.
//

#import "MoreViewController1.h"
#import "WJY_WaterFallLayout.h"
#import "ZQW_AppTools.h"
#import "Model.h"
#import "CollectionViewCell1.h"
//#import "DetailViewController.h"
@interface MoreViewController1 ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *pixclArray;
@end

@implementation MoreViewController1

-(void)viewWillAppear:(BOOL)animated{
    self.title=_moreTitle;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self scorMakeUI];
   
}
-(void)scorMakeUI{
    self.pixclArray = [NSMutableArray array];
    WJY_WaterFallLayout *waterFallLayout = [[WJY_WaterFallLayout alloc]init];
    waterFallLayout.lineCount = 2;
    waterFallLayout.verticalSpacing = 10;
    waterFallLayout.horizontalSpacing = 10;
    waterFallLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    _collectionView = [[UICollectionView alloc]initWithFrame:[[UIScreen mainScreen]bounds] collectionViewLayout:waterFallLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[CollectionViewCell1 class] forCellWithReuseIdentifier:@"cell"];
    [self getAFNetWorkingData];
}
-(void)getAFNetWorkingData
{
    [self.pixclArray addObject:@"Default.png"];
   [self.pixclArray addObject:@"Default.png"];
    [self.pixclArray addObject:@"启动影像@2x.png"];
    [self.pixclArray addObject:@"启动影像@2x.png"];
    [self.pixclArray addObject:@"启动影像@2x.png"];
    [self.pixclArray addObject:@"启动影像@2x.png"];
    [self.pixclArray addObject:@"启动影像@2x.png"];
    NSLog(@"%@",self.pixclArray);
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return  _pixclArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell1 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
//    Model *model = _pixclArray[indexPath.item];
    cell.titleLable.text=[_pixclArray objectAtIndex:indexPath.item];
    NSString *str=[NSString stringWithFormat:@"%i",_count];
    NSString *str2=[str stringByAppendingFormat:@"%li",indexPath.item];
    [cell.button setTag:[str2 intValue]];
    cell.showLable.text=@"这是说明";
//    [cell.button addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((375 - 30) / 2, arc4random()%50 + 250);
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

@end
