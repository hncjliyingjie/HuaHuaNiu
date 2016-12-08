//
//  GGaoViewController.m
//  HuaHuaNiu
//
//  Created by mac on 16/11/17.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "GGaoViewController.h"
#import "PlaceholderTextView.h"
#import "GGXQCollectionCell.h"
@interface GGaoViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UIButton *qgBtn;//发布求购按钮
@property (weak, nonatomic) IBOutlet UILabel *qgLbl;//发布求购
@property (weak, nonatomic) IBOutlet UICollectionView *collectView;
@property (weak, nonatomic) IBOutlet PlaceholderTextView *textView;//自定义textView;

@end

@implementation GGaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"广告需求";
    self.edgesForExtendedLayout=UIRectEdgeNone;
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self viewWithStyle];
    
    // 设置代理
    self.collectView.delegate = self;
    self.collectView.dataSource = self;
   
    
}
-(void)viewWithStyle{
    self.textView.Placeholder=@"最多50字";
    self.qgLbl.layer.cornerRadius=5;
    self.qgLbl.layer.masksToBounds=YES;
    self.qgLbl.layer.borderWidth=0.5;
    self.qgLbl.layer.borderColor=[[UIColor colorWithRed:0.047 green:0.364 blue:0.662 alpha:1]CGColor];
    [self.qgBtn addTarget:self action:@selector(qgDone:) forControlEvents:UIControlEventTouchUpInside];

}
//点击发布求购
-(void)qgDone:(id)sender{
    


}
#pragma mark -- UICollectionViewDataSource   

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 30;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //注册cell 有几种cell样式注册几次
    [self.collectView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"GGXQCollectionCell"];
    //在这里注册自定义的XIBcell否则会提示找不到标示符指定的cell
    UINib *nib = [UINib nibWithNibName:@"GGXQCollectionCell" bundle:[NSBundle mainBundle]];
    [collectionView registerNib:nib forCellWithReuseIdentifier:@"GGXQCollectionCell"];
    GGXQCollectionCell *cell = [[GGXQCollectionCell alloc]init];
    cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"GGXQCollectionCell" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor whiteColor];
    return cell;
}
#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(ConentViewWidth/2-10, 120);
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}
#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

@end
