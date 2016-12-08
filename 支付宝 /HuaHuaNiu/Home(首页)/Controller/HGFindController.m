//
//  HGFindController.m
//  HiGo
//
//  Created by Think_lion on 15/7/25.
//  Copyright (c) 2015年 Think_lion. All rights reserved.
//

#import "HGFindController.h"
#import "HGFindFrameModel.h"
#import "HGHttpTool.h"

#import "HGWaterFlow.h"

#import "HGFindCell.h"
#import "HGFindModel.h"
#import "CommentViewController.h"
#import "PlayVideoViewController.h"

#define HGFindCellName @"HGFindCellName"
#define HGFindHeaderName @"HGFindHeaderName"

@interface HGFindController ()<UICollectionViewDataSource,UICollectionViewDelegate,HGWaterFlowDelegate,RefreshBaseViewDelegate>


@property (nonatomic,copy)  NSString *currentPage;
@property (nonatomic,copy)  NSString *showCount;
@property (nonatomic,copy)  NSString *subCount;


@property (nonatomic,weak) UICollectionView *findCollectionView;


@property (nonatomic,strong) NSMutableArray *findArr;
@property (nonatomic,strong) NSMutableArray *findFrames;

@property (nonatomic,strong) RefreshHeaderView *header;
@property (nonatomic,strong) RefreshFooterView *footer;

@end

@implementation HGFindController

-(NSMutableArray *)findArr
{
    if(!_findArr){
        _findArr=[NSMutableArray array];
    }
    return _findArr;
}

-(NSMutableArray *)findFrames
{
    if(_findFrames==nil) {
        _findFrames=[NSMutableArray arrayWithCapacity:100];
    }
    return _findFrames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _currentPage = @"1";
    _showCount = @"5";
    
    
    //1.添加集合视图
    [self addFind];
    //2.发送网络请求
    [self setupRefresh];
}

#pragma mark 添加集合视图
-(void)addFind
{
    //创建瀑布流
    HGWaterFlow *waterFlow=[[HGWaterFlow alloc]init];
    waterFlow.delegate=self;
    waterFlow.columsCount=2; //显示2列
    waterFlow.sectionInset=UIEdgeInsetsMake(0, 10, 40, 10);
    
    UICollectionView *findCollection=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 110) collectionViewLayout:waterFlow];
    [findCollection registerClass:[HGFindCell class] forCellWithReuseIdentifier:HGFindCellName];
   
    
    findCollection.backgroundColor=HGColor(237, 237, 237);
    findCollection.delegate=self;
    findCollection.dataSource=self;
    [self.view addSubview:findCollection];
    self.findCollectionView=findCollection;
    
    
}

//刷新控件
-(void)setupRefresh
{
    //1.刷新控件
    RefreshHeaderView *header=[RefreshHeaderView header];
    header.scrollView=self.findCollectionView;
    header.delegate=self;
    //开始自动加载数据
    [header beginRefreshing];
    self.header=header;
    
    
    //2.上拉刷新
    RefreshFooterView *footer=[RefreshFooterView footer];
    footer.delegate=self;
    footer.scrollView=self.findCollectionView;
    self.footer=footer;
}
#pragma mark 代理上啦刷新
-(void)refreshViewBeginRefreshing:(RefreshBaseView *)refreshView
{
    //如果是下拉菜单
    if([refreshView isKindOfClass:[RefreshHeaderView class]]){
       
        [self sendRequest];
        
    }else{
       
        [self loadMoreData];  //上拉刷新
    }
   
}



#pragma mark 发送网络请求
-(void)sendRequest
{
    [HGHttpTool getWirhUrl:[NSString stringWithFormat:@"http://daiyancheng.cn/appvideo/video_list.do?token=test&member_id=%@&currentPage=1&showCount=%@",_member,_showCount] parms:nil success:^(id json) {
     
        NSLog(@"%@",json);
        _subCount = [json objectForKey:@"totalPage"];
        NSMutableArray *arrayFrames=[NSMutableArray array];
        //3.获得展示的数据
        NSArray *tempGoods = json[@"videos"];
        NSArray *goodsArr=[HGFindModel objectArrayWithKeyValuesArray:tempGoods];
        NSMutableArray *arr=[NSMutableArray array];
        
        [arr addObjectsFromArray:goodsArr];


        
        for(HGFindModel *findModel in arr) {
            HGFindFrameModel *findFrame=[[HGFindFrameModel alloc]init];
            findFrame.findModel=findModel;
            
            [arrayFrames addObject:findFrame];
        }
        
        //把新获得的数组放在前面
        NSMutableArray *tempArray=[NSMutableArray array];
        [tempArray addObjectsFromArray:arrayFrames];
        //添加新的数组
        [_findFrames removeAllObjects];
        [self.findFrames addObjectsFromArray:tempArray];
        
        //重新刷新标示图
        [self.findCollectionView reloadData];
        [self.header endRefreshing];
        
    } failture:^(id error) {
        [self.header endRefreshing];
    }];
}

#pragma mark 上啦刷新
-(void)loadMoreData
{
    _currentPage = [NSString stringWithFormat:@"%ld",[_currentPage  integerValue] + 1];
    
    if ([_currentPage integerValue] > [_subCount integerValue] ) {
        [self.footer endRefreshing];
        return;
    }
    
    [HGHttpTool getWirhUrl:[NSString stringWithFormat:@"http://daiyancheng.cn/appvideo/video_list.do?token=test&member_id=%@&currentPage=%@&showCount=%@",_member,_currentPage,_showCount] parms:nil success:^(id json) {
        
        NSMutableArray *shopFrames=[NSMutableArray array];
        //1.获得商品展示的数据
        NSArray *tempGoods = json[@"videos"];
        
        NSArray *goodsArr=[HGFindModel objectArrayWithKeyValuesArray:tempGoods];
        NSMutableArray *arr=[NSMutableArray array];
       
        [arr addObjectsFromArray:goodsArr];

        
        for(HGFindModel *findModel in arr) {
            HGFindFrameModel *findFrame=[[HGFindFrameModel alloc]init];
            findFrame.findModel=findModel;
            
            
            [shopFrames addObject:findFrame];
        }
        
        [self.findFrames addObjectsFromArray:shopFrames];
        
        //重新刷新标示图
        [self.findCollectionView reloadData];
        [self.footer endRefreshing];
        
    } failture:^(id error) {
        [self.footer endRefreshing];
    }];

}


#pragma mark
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
   // NSLog(@"%zd",self.findFrames.count);
    return self.findFrames.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HGFindCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:HGFindCellName forIndexPath:indexPath];
    
    HGFindFrameModel *findFrame=self.findFrames[indexPath.item];
    cell.findFrame=findFrame;
    
    return cell;
}
#pragma mark 返回瀑布流的高度

-(CGFloat)waterFlow:(HGWaterFlow *)waterFlow heightForWidth:(CGFloat)width indexPath:(NSIndexPath *)indexPath
{
    
   HGFindFrameModel *findFrame=self.findFrames[indexPath.item];
   
    return findFrame.cellH;
}


#pragma mark 单元格点击的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    HGFindFrameModel *video = self.findFrames[indexPath.row];
    
    [HGHttpTool getWirhUrl:[NSString stringWithFormat:@"http://daiyancheng.cn/appvideo/looker_add.do?token=test&member_id=%@&&video_id=%@",_member,video.findModel.video_id] parms:nil success:^(id json) {
        
        NSLog(@"%@",json);
    } failture:^(id error) {
        
    }];
    CommentViewController *vc = [[CommentViewController alloc]init];
    
    //PlayVideoViewController *vc=[[PlayVideoViewController alloc]init];
    
    [vc setHidesBottomBarWhenPushed:YES];
    
    vc.video = video;
    vc.member = _member;
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)dealloc
{
    [_footer free];
    [_header free];
}





@end
