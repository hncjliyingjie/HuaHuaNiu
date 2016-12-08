//
//  YHSeconderScrollViewController.m
//  花花牛
//
//  Created by mac on 16/4/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "YHSeconderScrollViewController.h"
#import "AFNetworking.h"
#import "Secondermodel.h"
#import "SeconderViewModel.h"
#import "CZLoopView.h"
#import "YHGoodsCollectionCon.h"
#import "YHChouseTableView.h"
#import "YHOrderModel.h"
#import "YHCateModel.h"
#import "YHGoodsModel.h"
#import "CZLoopViewLayout.h"

@interface YHSeconderScrollViewController ()<YHChouseTableViewDelegate,UIWebViewDelegate,UIScrollViewDelegate>{
    UIButton *QuanBuBtn;
    UIButton *PaiXunBtn;
}
@property (nonatomic,strong) NSArray *imageArray;
//网络请求参数
@property (nonatomic,strong) NSString *ll;
@property (nonatomic,strong) NSString *order;
@property (nonatomic,strong) NSString *cate_id;
@property (nonatomic,strong) NSString *change_type;
@property (nonatomic,strong) NSString *sale_integral;
//搜索附近
@property (nonatomic,strong) NSString *llocation;
@property (nonatomic,assign) int page;
//网络请求 model 模型
@property (nonatomic,strong) NSArray *dataArray;
//网络请求 order model 模型
@property (nonatomic,strong) NSArray *orderArray;
//网络请求 cate_id model 模型
@property (nonatomic,strong) NSArray *cate_idArray;
//网络请求 goods model 模型
@property (nonatomic,strong) NSMutableArray *goodsArray;
//goods View
@property (nonatomic,strong) YHGoodsCollectionCon *GoodsCollectionCon;
//头部视图
@property (nonatomic,strong) UIView *headerVIew;
//种类选择 ButtonView
@property (nonatomic,strong) UIView *buttonVIew;
//轮播 view
@property (nonatomic,strong) CZLoopView *loopView;

@property (nonatomic,assign) BOOL isDuiHuan;
@property (nonatomic,assign) BOOL isQuanBu;

//ChouseTableView
@property (nonatomic,strong) YHChouseTableView *ChouseTableView;


//网络字典
@property (nonatomic,assign)  BOOL isLoding;
@end
@implementation YHSeconderScrollViewController

//懒加载
- (NSArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}
- (NSArray *)imageArray{
    if (_imageArray == nil) {
        _imageArray = [NSArray array];
    }
    return _imageArray;
}
- (NSArray *)orderArray{
    if (_orderArray == nil) {
        _orderArray = [NSArray array];
    }
    return _orderArray;
}
- (NSArray *)cate_idArray{
    if (_cate_idArray == nil) {
        _cate_idArray = [NSArray array];
    }
    return _cate_idArray;
}
- (NSMutableArray *)goodsArray{
    if (_goodsArray == nil) {
        _goodsArray = [NSMutableArray array];
    }
    return _goodsArray;
}

- (void)pinpaiButton{
    [self removeAllData];
    self.isDuiHuan = NO;
    self.GoodsCollectionCon.isDuiHuan = NO;
    
    //修改分类按钮的状态
    [QuanBuBtn setTitle:@"特产分类" forState:UIControlStateNormal];
    [PaiXunBtn setTitle:@"综合排名" forState:UIControlStateNormal];
    if (!self.ChouseTableView.hidden) {
        self.ChouseTableView.hidden = YES;
    }
    
    [self creatData];
}

- (void)duihuanButton{
    [self removeAllData];
    [QuanBuBtn setTitle:@"全部" forState:UIControlStateNormal];
    [PaiXunBtn setTitle:@"银元范围" forState:UIControlStateNormal];
    
    if (!self.ChouseTableView.hidden) {
        self.ChouseTableView.hidden = YES;
    }
    self.change_type = @"0";
    self.isDuiHuan = YES;
    self.GoodsCollectionCon.isDuiHuan = YES;
    [self.GoodsCollectionCon removeFromSuperview];
    //请求数据
    [self creatData];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
        self.delegate = self;
        
        self.clipsToBounds = YES;
        //        self.bounces = NO;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pinpaiButton) name:@"pinpaiButton" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(duihuanButton) name:@"duihuanButton" object:nil];
        self.isDuiHuan = YES;
        self.isQuanBu = YES;
        self.cate_id = @"";
        self.order = @"";
        NSUserDefaults * UserDefault  =[NSUserDefaults  standardUserDefaults];
        self.ll = [UserDefault objectForKey:@"ZUOBIAO"];
        self.change_type = @"0";
        //请求网络数据
        [self creatData];
        
        //设置 UI
        [self setUpUI];
        
        
    }
    return self;
}
//将数据初始化
- (void)removeAllData{
    _page = 1;
    [self.goodsArray removeAllObjects];
    self.change_type = @"";
    self.order = @"";
    self.isLoding = NO;
    self.sale_integral = @"";
}

#pragma mark - 添加控件
- (void)setUpUI{
    //添加轮播器
    [self shufflingCollectionView];
    //添加分类按钮
    [self addButton];
    
    //添加分类选择页面
    [self addChouseView];
    
}
//轮播器
- (void)shufflingCollectionView {
    // 创建 界面
    UIView * headerVIew = [[UIView alloc] initWithFrame:CGRectMake(4, 0, XMGScreenW, 160)];
    headerVIew.backgroundColor = [UIColor grayColor];
    self.headerVIew = headerVIew;
    CZLoopView *loopView = [[CZLoopView alloc] initWithFrame:CGRectMake(0, 0, XMGScreenW, 160)];
    loopView.frame = headerVIew.bounds;
    [headerVIew addSubview:loopView];
    self.loopView = loopView;
    [self addSubview:headerVIew];
}

//添加分类按钮
- (void)addButton{
    UIView *buttonVIew = [[UIView alloc] initWithFrame:CGRectMake(4, 160, XMGScreenW, 40)];
    self.buttonVIew = buttonVIew;
    buttonVIew.backgroundColor = BackColor;
    if (!QuanBuBtn) {
        QuanBuBtn =[UIButton buttonWithType: UIButtonTypeCustom];
        QuanBuBtn.frame = CGRectMake(0, 0, XMGScreenW/2, 40);
        QuanBuBtn.backgroundColor = BackColor;
        
        [QuanBuBtn setTitle:@"特产分类" forState:UIControlStateNormal];
    }
    
    [QuanBuBtn addTarget:self action:@selector(QuanBu:) forControlEvents:UIControlEventTouchUpInside];
    [QuanBuBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [buttonVIew addSubview:QuanBuBtn];
    
    if (!PaiXunBtn) {
        PaiXunBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        PaiXunBtn.frame  =CGRectMake(XMGScreenW/2 + 1,0, XMGScreenW /2-1, 40);
        PaiXunBtn.backgroundColor = BackColor;
        [PaiXunBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [PaiXunBtn setTitle:@"综合排名" forState:UIControlStateNormal];
    }
    [PaiXunBtn addTarget:self action:@selector(PaiXu:) forControlEvents:UIControlEventTouchUpInside];
    
    [buttonVIew addSubview:PaiXunBtn];
    [self addSubview:buttonVIew];
    
}

#pragma mark - 选择 tableView

- (void)addChouseView{
    
    YHChouseTableView *table = [[YHChouseTableView alloc] initWithFrame:CGRectMake(4, CGRectGetMaxY(self.buttonVIew.frame), XMGScreenW, 500) style:UITableViewStylePlain];
    table.cellDelegate = self;
    self.ChouseTableView = table;
    
    [self addSubview:table];
    table.hidden = YES;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    if (!self.ChouseTableView.hidden) {
        CGRect frame = self.ChouseTableView.frame;
        frame.size =self.ChouseTableView.contentSize;//CGRectMake(4, CGRectGetMaxY(self.buttonVIew.frame), XMGScreenW, 100);
        self.ChouseTableView.frame = frame;
        
        self.contentSize = CGSizeMake(XMGScreenW, CGRectGetMaxY(self.ChouseTableView.frame));
    }else{
        self.contentSize = CGSizeMake(XMGScreenW, CGRectGetMaxY(self.GoodsCollectionCon.frame));
    }
    
}

//YHChouseTableView的代理方法

- (void)setValue:(NSString *)Value With:(NSString *)key name:(NSString *)name{
    [self removeAllData];
    if (self.isDuiHuan) {
        
        if ([key isEqualToString: @"order"]) {
            self.sale_integral = Value;
            //发送请求刷新数据
            [PaiXunBtn setTitle:name forState:UIControlStateNormal];
            [self creatData];
            
        }else if([key isEqualToString: @"cate_id"]){
            if ([Value isEqualToString:@"3"]) {//传位置信息
                self.llocation = @"1";
                //                self.change_type = Value;
                [QuanBuBtn setTitle:name forState:UIControlStateNormal];
                [self creatData];
            }else{
                self.llocation = @"";
                self.change_type = Value;
                [QuanBuBtn setTitle:name forState:UIControlStateNormal];
                [self creatData];
            }
        }
    }else{
        if ([key isEqualToString: @"order"]) {
            self.order = Value;
            [PaiXunBtn setTitle:name forState:UIControlStateNormal];
            //发送请求刷新数据
            [self creatData];
            
        }else if([key isEqualToString: @"cate_id"]){
            self.cate_id = Value;
            [QuanBuBtn setTitle:name forState:UIControlStateNormal];
            [self creatData];
        }
    }
    
}


#pragma mark - scroll 的代理方法

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    if (self.contentOffset.y > self.contentSize.height- self.frame.size.height - 50) //x是触发操作的阀值
    {
        if (self.isLoding) {
            return;
        }else{
            //触发上拉刷新
            //发送请求
            [self addMoreData];
        }
        
    }
    
}
- (void)QuanBu:(UIButton *)button{
    //tableView 的隐藏
    
    if (self.ChouseTableView.hidden) {
        self.ChouseTableView.hidden = NO;
        self.ChouseTableView.dataArray = self.cate_idArray;
        self.ChouseTableView.lable = @"cate_id";
        [self layoutSubviews];
        [self.ChouseTableView reloadData];
        [self bringSubviewToFront:self.ChouseTableView];
        
        
    }else{
        self.ChouseTableView.hidden = YES;
        [self layoutSubviews];
        //请求数据
        self.ChouseTableView.dataArray = self.cate_idArray;
        self.ChouseTableView.lable = @"cate_id";
        [self.ChouseTableView reloadData];
    }
}

- (void)PaiXu:(UIButton *)button{
    
    //tableView 的隐藏
    if (self.ChouseTableView.hidden) {
        self.ChouseTableView.hidden = NO;
        [self layoutSubviews];
        self.ChouseTableView.dataArray = self.orderArray;
        self.ChouseTableView.lable = @"order";
        [self bringSubviewToFront:self.ChouseTableView];
        [self.ChouseTableView reloadData];
    }else{
        self.ChouseTableView.hidden = YES;
        [self layoutSubviews];
        //请求数据
        self.ChouseTableView.dataArray = self.orderArray;
        self.ChouseTableView.lable = @"order";
        [self.ChouseTableView reloadData];
    }
    
    
}
//添加产品展示 GoodsCollectionCon
#pragma mark - GoodsCollectionCon
- (void)addTableViewWith:(NSArray *)array{
    
    YHGoodsCollectionCon *GoodsCollectionCon = [[YHGoodsCollectionCon alloc] initWithFrame:CGRectMake(4, CGRectGetMaxY(self.buttonVIew.frame), XMGScreenW, 100) withDataArray:array isDuiHuan:self.isDuiHuan];
    if (self.isDuiHuan) {
        GoodsCollectionCon.isDuiHuan = YES;
    }else{
        GoodsCollectionCon.isDuiHuan = NO;
    }
    
    self.GoodsCollectionCon = GoodsCollectionCon;
    GoodsCollectionCon.backgroundColor = [UIColor grayColor];
    [self addSubview:GoodsCollectionCon];
    
    self.contentSize = CGSizeMake(XMGScreenW, CGRectGetMaxY(GoodsCollectionCon.frame));
}

//刷新数据

- (void)upUIWithData{
    
    [self.GoodsCollectionCon removeFromSuperview];
    
    if (self.imageArray.count > 0) {
        
        self.loopView.modelArray = self.imageArray;
        [self.loopView reloadData];
        
        
    }
    
    if (self.goodsArray.count > 0) {
        [self addTableViewWith:self.goodsArray];
    }
    
}

#pragma mark - 请求网络数据

-(void)creatData{
    NSUserDefaults *Userdefaults =[NSUserDefaults standardUserDefaults];
    //加载前的判断
    NSString *ShouY;
    if (self.isDuiHuan) {
        
        ShouY = [NSString stringWithFormat:@"http://daiyancheng.cn/appstore/ddindex.do?token=test&cstate=0&ll=%@&page=%d&change_type=%@&sale_integral=%@&page=%d&range=%@&proid=&member_id=%@",self.ll,self.page,self.change_type,self.sale_integral,self.page,self.llocation,[Userdefaults objectForKey:@"Useid"]];
        
        NSArray *orderDict = @[@{@"name" : @"1000以下",@"value" : @"0"},@{@"name" : @"1000-2000",@"value" : @"1"},@{@"name" : @"2000-5000",@"value" : @"2"},@{@"name" : @"5000-10000",@"value" : @"3"},@{@"name" : @"10000以上",@"value" : @"4"}];
        NSMutableArray *array =[NSMutableArray array];
        [orderDict enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            YHOrderModel *model = [YHOrderModel modelWithDict:obj];
            [array addObject:model];
        }];
        
        self.orderArray = array;
        
        
        NSMutableArray *array1 =[NSMutableArray array];
        //附近需要穿位置信息 range 参数
        
        NSArray *cate_idArray = @[@{@"value" : @"全部",@"cate_id" : @"0"},@{@"value" : @"支持邮寄",@"cate_id" : @"2"},@{@"value" : @"支持现场",@"cate_id" : @"1"},@{@"value" : @"附近",@"cate_id" : @"3"}];
        
        [cate_idArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            YHCateModel *model = [YHCateModel modelWithDict:obj];
            [array1 addObject:model];
        }];
        self.cate_idArray = array1;
        
    }else{
        ShouY = [NSString stringWithFormat:@"http://daiyancheng.cn/appstore/cgindex.do?token=test&cstate=0&ll=%@&page=%d&order=%@&cate_id=%@&page=%d&member_id=%@&proid=",self.ll,self.page,self.order,self.cate_id,self.page,[Userdefaults objectForKey:@"Useid"]];
    }

    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
#pragma mark - 分组信息转模型
        
        NSMutableArray *array =[NSMutableArray array];
        
        Secondermodel *model = [Secondermodel modelWithDict:responseObject];
        [array addObject:model];
        self.dataArray = array.copy;
        NSMutableArray *imArray =[NSMutableArray array];
        
#pragma mark - 头部图片转模型
        if (responseObject[@"adflash"]) {
            [responseObject[@"adflash"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                SeconderViewModel *imModel = [SeconderViewModel modelWithDict:obj];
                [imArray addObject:imModel];
            }];
            
            self.imageArray = imArray;
        }
        
#pragma mark - 选择列表转模型
        if (responseObject[@"order"]) {
            
            NSMutableArray *array =[NSMutableArray array];
            [responseObject[@"order"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                YHOrderModel *model = [YHOrderModel modelWithDict:obj];
                [array addObject:model];
            }];
            self.orderArray = array;
        }
        
        if (responseObject[@"cate_list"]) {
            
            NSMutableArray *array =[NSMutableArray array];
            [responseObject[@"cate_list"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                NSDictionary *dict = obj;
                
                if (dict[@"children"]) {
                    [dict[@"children"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        YHCateModel *model = [YHCateModel modelWithDict:obj];
                        [array addObject:model];
                    }];
                }
            }];
            self.cate_idArray = array;
        }
#pragma mark - 商品信息转模型
        if (responseObject[@"goods"]) {
            NSMutableArray *array =[NSMutableArray array];
            [responseObject[@"goods"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                YHGoodsModel *model = [YHGoodsModel modelWithDict:obj];
                [array addObject:model];
            }];
            self.goodsArray = array;
        }else if (responseObject[@"goodslist"]) {
            NSMutableArray *array =[NSMutableArray array];
            [responseObject[@"goodslist"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                YHGoodsModel *model = [YHGoodsModel modelWithDict:obj];
                [array addObject:model];
            }];
            self.goodsArray = array;
        }
        //刷新数据
        dispatch_async(dispatch_get_main_queue(), ^{
            [self upUIWithData];
        });
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];

    
}


- (void)addMoreData{
    self.isLoding = YES;
    _page++;
    //加载前的判断
    NSString *ShouY;
    NSUserDefaults *Userdefaults =[NSUserDefaults standardUserDefaults];
    if (self.isDuiHuan) {
        ShouY = [NSString stringWithFormat:@"http://daiyancheng.cn/appstore/ddindex.do?token=test&cstate=0&ll=%@&page=%d&change_type=%@&sale_integral=%@&page=%d&range=%@&member_id=%@&proid=",self.ll,self.page,self.change_type,self.sale_integral,self.page,self.llocation,[Userdefaults objectForKey:@"Useid"]];
        
        NSArray *orderDict = @[@{@"name" : @"1000以下",@"value" : @"0"},@{@"name" : @"1000-2000",@"value" : @"1"},@{@"name" : @"2000-5000",@"value" : @"2"},@{@"name" : @"5000-10000",@"value" : @"3"},@{@"name" : @"10000以上",@"value" : @"4"}];
        NSMutableArray *array =[NSMutableArray array];
        [orderDict enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            YHOrderModel *model = [YHOrderModel modelWithDict:obj];
            [array addObject:model];
        }];
        
        self.orderArray = array;
        
        
        NSMutableArray *array1 =[NSMutableArray array];
        
        NSArray *cate_idArray = @[@{@"value" : @"全部",@"cate_id" : @"0"},@{@"value" : @"支持邮寄",@"cate_id" : @"2"},@{@"value" : @"支持现场",@"cate_id" : @"1"},@{@"value" : @"附近",@"cate_id" : @"3"}];
        
        [cate_idArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            YHCateModel *model = [YHCateModel modelWithDict:obj];
            [array1 addObject:model];
        }];
        self.cate_idArray = array1;
        
    }else{
        ShouY = [NSString stringWithFormat:@"http://daiyancheng.cn/appstore/cgindex.do?token=test&cstate=0&ll=%@&page=%d&order=%@&cate_id=%@&page=%d&member_id=%@&proid=",self.ll,self.page,self.order,self.cate_id,self.page,[Userdefaults objectForKey:@"Useid"]];
    }

    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
#pragma mark - 商品信息转模型
        
        if (responseObject[@"goods"]) {
            NSMutableArray *array =[NSMutableArray array];
            [responseObject[@"goods"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                YHGoodsModel *model = [YHGoodsModel modelWithDict:obj];
                [array addObject:model];
            }];
            self.goodsArray = array;
        }else if (responseObject[@"goodslist"]) {
            NSMutableArray *array =[NSMutableArray array];
            [responseObject[@"goodslist"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                YHGoodsModel *model = [YHGoodsModel modelWithDict:obj];
                [array addObject:model];
            }];

            if (array.count < 1) {
                self.isLoding = YES;
            }else{
                [self.goodsArray addObjectsFromArray:array];
                self.isLoding = NO;
            }
            
        }
        //刷新数据
        dispatch_async(dispatch_get_main_queue(), ^{
            [self upUIWithData];
        });
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        self.isLoding = NO;
    }];
    

}

@end
