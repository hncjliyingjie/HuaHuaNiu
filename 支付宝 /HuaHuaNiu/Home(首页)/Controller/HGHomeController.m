//
//  HGHomeController.m
//  HiGo
//
//  Created by Think_lion on 15/7/25.
//  Copyright (c) 2015年 Think_lion. All rights reserved.
//

#import "HGHomeController.h"
#import "HGTitleView.h"
#import "HGSpecialViewController.h"
#import "HGFindController.h"

#import "HGInPostViewController.h"

@interface HGHomeController ()<UIScrollViewDelegate,HGTitleViewDelegate>
@property (nonatomic,strong) NSMutableArray *childViews;  //子视图
@property (nonatomic,weak) UIScrollView *scrollView;
@property (nonatomic,weak) HGTitleView *titView;  //添加到导航的视图
@property (nonatomic,copy) NSString *member;


@end

@implementation HGHomeController


-(NSMutableArray *)childViews
{
    if(!_childViews){
        _childViews=[NSMutableArray array];
    }
    return _childViews;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationController.navigationBar.barTintColor =[UIColor colorWithRed:264/255.0 green:125/255.0 blue:137/255.0 alpha:1];
    NSUserDefaults *Userdefaults =[NSUserDefaults standardUserDefaults];
    _member = [Userdefaults objectForKey:@"Useid"];
                                       
    // 1.添加右边导航栏上面的点击按钮
    self.navigationItem.rightBarButtonItem=[UIBarButtonItem itemWithIcon:@"icon_camera2" highIcon:nil target:self action:@selector(photoGoods)];
    //2.添加titleView
    [self setupTitleView];
    //3.添加滚动视图
    [self setupScroll];
}
#pragma mark  添加titleview视图
-(void)setupTitleView
{
    HGTitleView *tv=[[HGTitleView alloc]init];
   // tv.backgroundColor=[UIColor redColor];
    tv.delegate=self;
    tv.frame=CGRectMake(0, 0, 200, 30);
    self.navigationItem.titleView=tv;
    self.titView=tv;
}

#pragma mark 添加titleView的代理方法
-(void)titleView:(HGTitleView *)titleView scrollToIndex:(NSInteger)tagIndex
{

    [self.scrollView scrollRectToVisible:CGRectMake(ScreenWidth*tagIndex, 0, self.view.width, self.view.height) animated:YES];
}

#pragma mark 添加滚动视图
-(void)setupScroll
{
   
    //2.控制器
    HGFindController *find=[[HGFindController alloc]init];
    find.member = _member;
    [self addChildViewController:find];
    //3.控制器
    HGSpecialViewController *special=[[HGSpecialViewController alloc]init];
    special.member = _member;
    [self addChildViewController:special];
    //这这几个自控制器的view添加到数组中
    
    [self.childViews addObject:find.view];
    [self.childViews addObject:special.view];
    
    
    UIScrollView *scrollView=[[UIScrollView alloc]initWithFrame:self.view.bounds];
    scrollView.delegate=self;
    [self.view addSubview:scrollView];
    for(int i=0;i<self.childViews.count;i++){

        CGFloat childVX=ScreenWidth*i;
        UIView *childV=self.childViews[i];
        childV.frame=CGRectMake(childVX, 0, ScreenWidth, self.view.height);
        [scrollView addSubview:childV];
    }
    
    //设置滚动的属性
    scrollView.showsHorizontalScrollIndicator=NO;
    scrollView.showsVerticalScrollIndicator=NO;
    scrollView.pagingEnabled=YES;
    scrollView.contentSize=CGSizeMake(ScreenWidth*2, 0);
    scrollView.bounces=NO;
    self.scrollView=scrollView;
    
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
   
    if(scrollView.contentOffset.x/ScreenWidth==0){
        [self.titView wanerSelected:0];
    }else if(scrollView.contentOffset.x/ScreenWidth==1){
        [self.titView wanerSelected:1];
    }
}


-(void)photoGoods
{
    HGInPostViewController *postup = [[HGInPostViewController alloc]init];
    postup.member = _member;
    [self.navigationController pushViewController:postup animated:YES];
  
}

@end
