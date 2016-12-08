//
//  DYMainViewController.m
//  HuaHuaNiu
//
//  Created by mac on 16/11/5.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "DYMainViewController.h"
#import "ZYViewController.h"
#import "DYViewController.h"
#import "Masonry.h"
#import "SXView.h"
#import "DYView.h"
#import "HYView.h"

#import "ITemViews.h"
#import "RightView.h"
#import "Toast+UIView.h"
#import "SSModel.h"

#import "NMCHttp.h"
#import "SXCollectionViewCell.h"
#import "IDModel.h"
#import "SXTableViewCell.h"

#import "ZMTSXPriceModel.h"
#import "ZMTSXFriendModel.h"

typedef enum {
    SXKindHY = 0,
    SXKindPrice,
    SXKindFriend
} SXKind;

@interface DYMainViewController ()<UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource,NMCHttpDelegate,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{
    UIImageView *navBarHairlineImageView;//导航栏上面的黑线
}
@property(strong,nonatomic)DYViewController *zmtVC;//自媒体页面
@property(strong,nonatomic)ZYViewController *zyVC;//资源页面

@property(strong,nonatomic)UIButton *leftBtn;
@property(strong,nonatomic)UIButton *rightBtn;

@property(strong,nonatomic)UIView *transView;//半透明view

@property(strong,nonatomic)SXView *sxView;//筛选页面
@property(strong,nonatomic)DYView *dyView;//地域页面
@property(strong,nonatomic)HYView *hyView;//行业页面


@property(strong,nonatomic)UIView *textView1;//导航栏的view

@property(strong,nonatomic)NSMutableArray *shengArray;//省份
@property(strong,nonatomic)NSMutableArray *shijiArray;//市级

@property(strong,nonatomic)NSMutableArray *hyArray;//行业界面数据源,主要用于切换数据源
@property(strong,nonatomic)NSMutableArray *buttonArray;//放右边按钮的数组

//@property(strong,nonatomic)NSMutableDictionary *sumDic;

@property (nonatomic , strong)UITableView * tableView;
@property (nonatomic , strong)UICollectionView * collectionView;

@property (nonatomic , strong)NSMutableArray * dataSource;//存放省的名字
@property (nonatomic,strong)NSMutableArray * provinceArray;
@property (nonatomic , strong)NSMutableArray * cityArray;//存放对应市的名字
@property (nonatomic , assign)NSInteger index;//点击省份的坐标

@property (nonatomic, strong) NSMutableArray *array;//放入所选中的省市模型
//李英杰添加
@property (nonatomic, strong) IDModel *cityModel;//存放省市名字
@property (nonatomic, strong) NSString *hyString;//记录行业的选择内容
@property (nonatomic, strong) ZMTSXPriceModel *priceModel;//记录价格的选择内容
@property (nonatomic, strong) ZMTSXFriendModel *friendModel;//记录好友数量的选择内容
@property (nonatomic, strong) NSMutableArray *hyDataSource;//存储行业数组
@property (nonatomic, strong) NSMutableArray *priceDataSource;//存储价格数组
@property (nonatomic, strong) NSMutableArray *friendDataSource;//存储好友数组
@property (nonatomic, assign) SXKind sxKind;//筛选类型--行业,价格,好友三种
@property (nonatomic, assign) NSInteger ZMTorZY;//记录是不是自媒体


@end

@implementation DYMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeUI];
    [self makeDiYuData];
    
    
}
-(void)makeUI{
    
    _array = [NSMutableArray array];
    //导航栏下的黑线
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    //自定义返回按钮
    UIImage *backButtonImage = [[UIImage imageNamed:@"back_new"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    //将返回按钮的文字position设置不在屏幕上显示
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
    
    //    self.edgesForExtendedLayout = UIRectEdgeNone;
    //    self.view.backgroundColor=[UIColor whiteColor];
    
    //导航栏左上角的图片
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@""] style:UIBarButtonItemStylePlain target:self action:nil];
    
    _textView1=[[UIView alloc]initWithFrame:CGRectMake(10, 10, 120, 30)];
    _textView1.backgroundColor=[UIColor clearColor];
    [self.navigationItem setTitleView:_textView1];
    _textView1.layer.cornerRadius=8;
    
    _leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    _leftBtn.tag=1;
    [_leftBtn setTitle:@"自媒体" forState:UIControlStateNormal];
    [_leftBtn setBackgroundImage: [UIImage imageNamed:@"blue.png"] forState:UIControlStateNormal];
    [_leftBtn addTarget:self action:@selector(selected:) forControlEvents:UIControlEventTouchUpInside];
    [_textView1 addSubview:_leftBtn];
    
    _rightBtn=[[UIButton alloc]initWithFrame:CGRectMake(60, 0, 60, 30)];
    _rightBtn.tag=2;
    [_rightBtn setBackgroundImage: [UIImage imageNamed:@"white.png"] forState:UIControlStateNormal];
    [_rightBtn setTitle:@"资 源" forState:UIControlStateNormal];
    [_rightBtn setTitleColor:[UIColor colorWithRed:0.047 green:0.365 blue:0.663 alpha:1] forState:UIControlStateNormal];
    [_rightBtn addTarget:self action:@selector(selected:) forControlEvents:UIControlEventTouchUpInside];
    [_textView1 addSubview:_rightBtn];
    
    //  一开始显示自媒体页面
    _zmtVC=[[DYViewController alloc]initWithNibName:@"DYViewController" bundle:nil];
    _zyVC=[[ZYViewController alloc]initWithNibName:@"ZYViewController" bundle:nil];
    self.ZMTorZY = 1;//默认是自媒体
    
    [self.view addSubview:_zmtVC.view];
    
    //添加筛选按钮的功能
    [_zmtVC.sxBtn addTarget:self action:@selector(sxDone:) forControlEvents:UIControlEventTouchUpInside];
    _zmtVC.sxBtn.tag = 301;
    
    
    
    //为了添加UInavagationcontroller,push到子页面
    [self addChildViewController:_zmtVC];
    
    //添加跟view的约束
    [self addViewConstraints:_zmtVC];

    

}
#pragma mark 懒加载
- (NSMutableArray *)hyDataSource {
    if (_hyDataSource == nil) {
        _hyDataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _hyDataSource;
}
- (NSMutableArray *)priceDataSource {
    if (_priceDataSource == nil) {
        _priceDataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _priceDataSource;
}
- (NSMutableArray *)friendDataSource {
    if (_friendDataSource == nil) {
        _friendDataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _friendDataSource;
}
-(NSMutableArray *)shengArray{
    if (_shengArray==nil) {
        _shengArray=[NSMutableArray array];

    }
    return _shengArray;
   
}
-(NSMutableArray *)shijiArray{
    if (_shijiArray==nil) {
        _shijiArray=[NSMutableArray array];
        
    }
    return _shijiArray;
    
}
-(NSMutableArray *)buttonArray{
    if (_buttonArray==nil) {
        _buttonArray=[NSMutableArray array];
        
    }
    return _buttonArray;
    
}
//城市模型
- (IDModel *)cityModel {
    if (_cityModel == nil) {
        _cityModel = [[IDModel alloc] init];
    }
    return _cityModel;
}


#pragma mark actions
//点击筛选
-(void)sxDone:(id)sender{
    [self addSxView];
}
- (void)sxzyDone:(UIButton *)sender {
    KMyLog(@"资源筛选");
    
}

//出现筛选页面
-(void)addSxView
{
    //请求行业数据
    [self makeHangYeData];
    //生成价格,好友数据源
    [self makePriceAndFrinendDataSource];
    
    self.sxView.frame = CGRectMake(ConentViewWidth, 64+30, ConentViewWidth, ConentViewHeight-29);
    
    self.sxView.transView.backgroundColor=[UIColor colorWithWhite:0 alpha:0];
    //移除浮层view,给透明部分添加点击收回
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc]  initWithTarget:self action:@selector(handleSingleTap)];
    tap.delegate = self;
    [self.sxView.transView addGestureRecognizer:tap];
    
    
    [UIView animateWithDuration:.5 animations:^{
        
        self.sxView.frame = CGRectMake(0,64+30,ConentViewWidth, ConentViewHeight-29);
        //view从透明到半透明
        self.sxView.transView.backgroundColor=[UIColor colorWithWhite:0 alpha:0.5];

       
    }];
    if (self.ZMTorZY == 1) {
        //是自媒体
        self.sxView.friendViewHeight.constant = 40;
        [self.zmtVC.view.window addSubview:self.sxView];
    } else if (self.ZMTorZY == 2) {
        //是资源
        self.sxView.friendViewHeight.constant = 0;
        [self.zyVC.view.window addSubview:self.sxView];
    }
    
}
//移除筛选视图轻拍手势方法
-(void)handleSingleTap
{
    [self removeSelf];
}
//移除筛选视图
-(void)removeSelf
{
     self.sxView.frame = CGRectMake(0,64+30,ConentViewWidth, ConentViewHeight-29);
    
    [UIView animateWithDuration:.5 animations:^{
       self.sxView.frame = CGRectMake(ConentViewWidth, 64+30, ConentViewWidth, ConentViewHeight-29);
        self.sxView.transView.backgroundColor=[UIColor colorWithWhite:0 alpha:0];
        
    }];
}
//瞬间移除筛选视图
- (void)removeSXViewWithNoAnimation
{
    self.sxView.frame = CGRectMake(ConentViewWidth,64+30,ConentViewWidth, ConentViewHeight-29);
    
    [UIView animateWithDuration:.5 animations:^{
        self.sxView.frame = CGRectMake(ConentViewWidth, 64+30, ConentViewWidth, ConentViewHeight-29);
        self.sxView.transView.backgroundColor=[UIColor colorWithWhite:0 alpha:0];
        
    }];
}
//出现地域筛选页面
-(void)addDyView{
    
    //加载数据
    [self makeBlockRequestData];
    [self.view makeToastActivity];
    
    self.dyView.frame = CGRectMake(ConentViewWidth, 64+30, ConentViewWidth-60, ConentViewHeight-29);
    
//    self. dyView.transView.backgroundColor=[UIColor colorWithWhite:0 alpha:0];
    //移除浮层view,给透明部分添加点击收回
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc]  initWithTarget:self action:@selector(handleSingleDiYuTap)];
    tap.delegate = self;
//    [self.dyView.transView addGestureRecognizer:tap];

    
    [UIView animateWithDuration:.5 animations:^{
        
        self.dyView.frame = CGRectMake(60,64+30,ConentViewWidth-60, ConentViewHeight-29);
        //view从透明到半透明
//        self. dyView.transView.backgroundColor=[UIColor colorWithWhite:0 alpha:0.5];
        
        
    }];
    [self.sxView.window addSubview:self.dyView];
    
    [self.dyView.okBtn addTarget:self action:@selector(okDone:) forControlEvents:UIControlEventTouchUpInside];

    [self.dyView.backBtn addTarget:self action:@selector(handleSingleDiYuTap) forControlEvents:UIControlEventTouchUpInside];
}

//生成价格好友数量数据源
- (void)makePriceAndFrinendDataSource {
    //获取价格数据源
    if (self.ZMTorZY == 1) {
        //自媒体价格数据源
        NSString *priceUrlStr = [NSString stringWithFormat:@"%@%@", DYUrl, PriceZMTSXURL];
        [self.priceDataSource removeAllObjects];//移除所有数据
        [[RequestManger share] requestDataByGetWithPath:priceUrlStr complete:^(NSDictionary *data) {
            if ([[data objectForKey:@"result"] integerValue] == 1) {
                //获取价格数据成功
                NSArray *mediaPrice = [data objectForKey:@"mediaPrice"];
                for (NSDictionary *dic in mediaPrice) {
                    ZMTSXPriceModel *priceMod = [[ZMTSXPriceModel alloc] init];
                    priceMod.price_id = [dic objectForKey:@"id"];
                    priceMod.price_name = [dic objectForKey:@"name"];
                    //存放在数据源中
                    [self.priceDataSource addObject:priceMod];
                }
            }
        }];
    } else if (self.ZMTorZY == 2) {
        //资源价格数据源
        NSString *priceUrlStr = [NSString stringWithFormat:@"%@%@", DYUrl, PriceZYSXURL];
        [self.priceDataSource removeAllObjects];//移除所有数据
        [[RequestManger share] requestDataByGetWithPath:priceUrlStr complete:^(NSDictionary *data) {
            if ([[data objectForKey:@"result"] integerValue] == 1) {
                //获取价格数据成功
                NSArray *mediaPrice = [data objectForKey:@"price"];
                for (NSDictionary *dic in mediaPrice) {
                    ZMTSXPriceModel *priceMod = [[ZMTSXPriceModel alloc] init];
                    priceMod.price_id = [dic objectForKey:@"id"];
                    priceMod.price_name = [dic objectForKey:@"name"];
                    //存放在数据源中
                    [self.priceDataSource addObject:priceMod];
                }
            }
        }];
    }
    
    //获取好友数据源
    NSString *friendUrlStr = [NSString stringWithFormat:@"%@%@", DYUrl, FriendSXURL];
    [self.friendDataSource removeAllObjects];//清空数据源
    [[RequestManger share] requestDataByGetWithPath:friendUrlStr complete:^(NSDictionary *data) {
        if ([[data objectForKey:@"result"] integerValue] == 1) {
            //获取价格数据成功
            NSArray *funs = [data objectForKey:@"funs"];
            for (NSDictionary *dic in funs) {
                ZMTSXFriendModel *friendMod = [[ZMTSXFriendModel alloc] init];
                friendMod.friend_id = [dic objectForKey:@"id"];
                friendMod.friend_name = [dic objectForKey:@"name"];
                //存放在数据源中
                [self.friendDataSource addObject:friendMod];
            }
        }
    }];

}
//点击地域界面的确认按钮
-(void)okDone:(id)sender{
    
    //返回到筛选界面,并显示选择的结果
    [self removeDySelf];
    self.sxView.dyLbl.text = [NSString stringWithFormat:@"%@%@", self.cityModel.provinceName, self.cityModel.cityName];
}
//出现行业筛选页面
-(void)addHYView
{
    self.hyView.frame = CGRectMake(ConentViewWidth, 64+30, ConentViewWidth-60, ConentViewHeight-29);
    
    //    self. dyView.transView.backgroundColor=[UIColor colorWithWhite:0 alpha:0];
    //移除浮层view,给透明部分添加点击收回
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc]  initWithTarget:self action:@selector(handleSingleDiYuTap)];
    tap.delegate = self;
//    [self.dyView.transView addGestureRecognizer:tap];
    
    
    [UIView animateWithDuration:.5 animations:^{
        
        self.hyView.frame = CGRectMake(60,64+30,ConentViewWidth-60, ConentViewHeight-29);
        //view从透明到半透明
        //        self. dyView.transView.backgroundColor=[UIColor colorWithWhite:0 alpha:0.5];
        
        
    }];
    [self.sxView.window addSubview:self.hyView];
    
    self.hyView.tableView.delegate=self;
    self.hyView.tableView.dataSource=self;
    
    [self.hyView.hyBtn addTarget:self action:@selector(hidehyView) forControlEvents:UIControlEventTouchUpInside];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40;

}

-(void)handleSingleDiYuTap
{
    [self removeDySelf];
}

-(void)removeDySelf
{
    self.dyView.frame = CGRectMake(60,64+30,ConentViewWidth-60, ConentViewHeight-29);
    
    [UIView animateWithDuration:.5 animations:^{
        self.dyView.frame = CGRectMake(ConentViewWidth, 64+30, ConentViewWidth-60, ConentViewHeight-29);
//        self. dyView.transView.backgroundColor=[UIColor colorWithWhite:0 alpha:0];
        
    }];
}
//点击行业界面的确认按钮
- (void)hyAckDoneAction:(UIButton *)sender {
    //返回筛选界面
    [self hidehyView];
    //给筛选界面赋值
    switch (self.sxKind) {
        case SXKindHY:
        {
            self.sxView.hyLabel.text = self.hyString;

        }
            break;
        case SXKindPrice:
        {
            self.sxView.priceLabel.text = self.priceModel.price_name;
        }
            break;
        case SXKindFriend:
        {
            self.sxView.friendLabel.text = self.friendModel.friend_name;
        }
            break;
    }
}
//点击行业界面的返回按钮
-(void)hidehyView{
    
    self.hyView.frame = CGRectMake(60,64+30,ConentViewWidth-60, ConentViewHeight-29);
    
    [UIView animateWithDuration:.5 animations:^{
        self.hyView.frame = CGRectMake(ConentViewWidth, 64+30, ConentViewWidth-60, ConentViewHeight-29);
        //        self. dyView.transView.backgroundColor=[UIColor colorWithWhite:0 alpha:0];
        
    }];

}
//点击筛选界面的地域按钮
-(void)dqDone:(id)sender{
    [self addDyView];

}
//点击筛选界面的行业按钮
-(void)hyDone:(id)sender{
    //切换数据源
    self.hyArray = self.hyDataSource;
    //跟新界面
    [self.hyView.tableView reloadData];
    self.sxKind = SXKindHY;//标记是哪个筛选条件
    //加载视图
    [self addHYView];
    
}
//点击筛选界面的价格按钮
-(void)jgDone:(id)sender{
    //切换数据源
    NSMutableArray *priceArr = [NSMutableArray arrayWithCapacity:1];
    for (ZMTSXPriceModel *mod in self.priceDataSource) {
        [priceArr addObject:mod.price_name];
    }
    self.hyArray = priceArr;
    //跟新界面
    [self.hyView.tableView reloadData];
    self.sxKind = SXKindPrice;//标记是哪个筛选条件
    //加载视图
     [self addHYView];
    
}
//点击筛选界面的好友数按钮
-(void)hysDone:(id)sender{
    //切换数据源
    NSMutableArray *friendArr = [NSMutableArray arrayWithCapacity:1];
    for (ZMTSXFriendModel *mod in self.friendDataSource) {
        [friendArr addObject:mod.friend_name];
    }
    self.hyArray = friendArr;
    //跟新界面
    [self.hyView.tableView reloadData];
    self.sxKind = SXKindFriend;//标记是哪个筛选条件
    //加载视图
     [self addHYView];
    
}
//点击筛选界面确认按钮
- (void)ackDoneAction:(UIButton *)sender {
    [self removeSelf];
    NSString *fans = [NSString stringWithFormat:@"%@", self.friendModel.friend_id];
    NSString *price = [NSString stringWithFormat:@"%@", self.priceModel.price_id];
    NSString *province_id = [NSString stringWithFormat:@"%@", self.cityModel.province_id];
    NSString *city_id = [NSString stringWithFormat:@"%@", self.cityModel.city_id];
    NSString *profession = [NSString stringWithFormat:@"%@", self.hyString];
    NSDictionary *infoDic = [NSDictionary dictionaryWithObjectsAndKeys:fans, @"fans", price, @"price", province_id, @"province_id", city_id, @"city_id", profession, @"profession", nil];
    //根据条件请求数据
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SXDone" object:@"SXView" userInfo:infoDic];
}

//点击筛选界面清除按钮
- (void)clearAction:(UIButton *)sender {
    //清除城市
    self.cityModel = [IDModel new];
    self.sxView.dyLbl.text = @"全部>";
    //清除行业
    self.hyString = [NSString new];
    self.sxView.hyLabel.text = @"全部>";
    //清除价格
    self.priceModel = [ZMTSXPriceModel new];
    self.sxView.priceLabel.text = @"全部>";
    //清除好友数
    self.friendModel = [ZMTSXFriendModel new];
    self.sxView.friendLabel.text = @"全部>";
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    navBarHairlineImageView.hidden = YES;
    [self.navigationController.navigationBar setTranslucent:YES];
}

/**
 make block request data -- 获取省市数据源
 */
- (void)makeBlockRequestData{
    NMCHttp * http = [NMCHttp new];
    [self.dataSource removeAllObjects];//清空省的数据源
    [self.cityArray removeAllObjects];//清空城市的数据源
    [http sendHttpGetRequestWithUrl:SXURL param:nil successBlock:^(NSData *data) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray * retval = dict[@"retval"];
        
        
        for (NSDictionary * item in retval) {
            //省份数组
            NSString *nameStr=[item objectForKey:@"region_name"];
            NSString *idStr=[item objectForKey:@"region_id"];
            IDModel *model=[[IDModel alloc]init];
            model.nameStr=nameStr;
            model.idStr=idStr;
            [self.dataSource addObject:model];
            
            //城市数组
            NSArray * array = item[@"children"];
            NSMutableArray * arrayC = [[NSMutableArray alloc ]init];
            for (NSDictionary * itemC in array) {
                
                NSString *nameStr=[itemC objectForKey:@"region_name"];
                NSString *idStr=[itemC objectForKey:@"region_id"];
                IDModel *model=[[IDModel alloc]init];
                model.nameStr=nameStr;
                model.idStr=idStr;
                [arrayC addObject:model];
            }
            [self.cityArray addObject: arrayC];
        }
        NSLog(@"make block request data over");
        
        [self makeCollectionView];
        
    } failedBlock:^(NSError *error) {
        NSLog(@"%@",error);
        NSLog(@"make block request data error");
    }];
    
}

/**
 make delegate request data
 */
- (void)makeDelegateRequestData{
    [NMCHttp sendHttpRequestWithUrl:SXURL param:nil delegate:self];
}
- (void)requestSuccess:(NSData *)data{
    [self.view hideToastActivity];
    NSLog(@"数据到了");
    NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"%@",dict);
}

- (void)requestFailedBlock:(NSError *)error{
      [self.view hideToastActivity];
    NSLog(@"数据没有到手");
}

/**
 make collectionView
 */

//省份列表的布局
- (void)makeCollectionView{
    //CollectionView布局特性
    UICollectionViewFlowLayout * fly = [UICollectionViewFlowLayout new];
    //每个item的大小
    fly.itemSize = CGSizeMake(self.dyView.leftView.frame.size.width/2.5, 30);
    //    fly.scrollDirection = UICollectionViewScrollDirectionVertical;
    fly.sectionInset = UIEdgeInsetsMake(10, 10,10, 10);
    //创建CollectionView
    _collectionView = [[UICollectionView alloc ]initWithFrame:CGRectMake(0, 0, self.dyView.leftView.bounds.size.width ,self.dyView.rightView.frame.size.height) collectionViewLayout:fly];
    //注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"SXCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"SXCELL"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.dyView.leftView addSubview:_collectionView];
    [self createTableView];
}

/**
 lazy loading provinceArray
 */

- (NSMutableArray *)provinceArray{
    
    if(!_provinceArray){
        _provinceArray = [[NSMutableArray alloc]init];
    }
    return _provinceArray;
}

/**
 lazy loading cityArray
 */

- (NSMutableArray *)cityArray{
    if(!_cityArray){
        _cityArray = [[NSMutableArray alloc]init];
    }
    return _cityArray;
}
/**
 lazy loading dataSource
 */

- (NSMutableArray *)dataSource{
    if(!_dataSource){
        _dataSource = [[NSMutableArray alloc]init];
    }
    return _dataSource;
}

/**
 create a tableView 显示城市列表的tableView
 */
- (void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.dyView.rightView.frame.size.width, self.dyView.rightView.frame.size.height) style:UITableViewStylePlain ];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.dyView.rightView addSubview:_tableView];
}
#pragma  make - collectionView delegate method
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataSource.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SXCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SXCELL" forIndexPath:indexPath];
    
    IDModel *model = _dataSource[indexPath.row];
    cell.label.text = model.nameStr;
    cell.label.textAlignment = NSTextAlignmentCenter;
    
    cell.layer.cornerRadius = 15;
    cell.layer.borderColor = [UIColor grayColor].CGColor;
    cell.layer.borderWidth = 1.0f;
    
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    _index = indexPath.row;
    [collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
     IDModel *model=_dataSource[indexPath.row];
    //记录选中城市的省级名字和id
    self.cityModel.provinceName = model.nameStr;
    self.cityModel.province_id = model.idStr;
    
    [_array addObject:model];
    [_tableView reloadData];
    NSLog(@"%ld",_index);
}

#pragma  - make tableview Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView== self.hyView.tableView) {
         return self.hyArray.count;
    }
    if (tableView==_tableView) {
        self.provinceArray = [NSMutableArray arrayWithArray:_cityArray[_index]];
        return self.provinceArray.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.hyView.tableView) {
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CELL"];
        if (cell==nil) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
        }
        cell.textLabel.text=[self.hyArray objectAtIndex:indexPath.row];
        cell.textLabel.font=[UIFont systemFontOfSize:13];
        return cell;

    }
    if (tableView==_tableView) {
        static NSString * Id = @"cell";
        self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        SXTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:Id];
       
        if(!cell){
            cell = [[SXTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Id];
            cell.btn=[[UIButton alloc]initWithFrame:CGRectMake(5, 5, self.dyView.rightView.frame.size.width-10, 30)];
            [cell.contentView addSubview:cell.btn];
            cell.btn.tag=indexPath.row;
            
            [cell.btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            cell.btn.titleLabel.font=[UIFont systemFontOfSize:14];
            cell.btn.userInteractionEnabled=NO;
            cell.btn.layer.borderWidth=1;
            cell.btn.layer.borderColor=[[UIColor colorWithRed:0.80 green:0.80 blue:0.80 alpha:1]CGColor];
            cell.btn.layer.cornerRadius=15;
            
        }
         [self.buttonArray addObject:cell.btn];
        IDModel *model=self.provinceArray[indexPath.row];
        [cell.btn setTitle:model.nameStr forState:UIControlStateNormal];
      
        
//        cell.textLabel.text = self.provinceArray[indexPath.row];
//        cell.textLabel.textColor=[UIColor grayColor];
//        cell.textLabel.font=[UIFont systemFontOfSize:14];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        return cell;

    }
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //李英杰添加
    if (tableView == _tableView) {//省市的列表
        //选中cell的坐标
        IDModel *cityModel = self.cityArray[_index][indexPath.row];
        //记录市级名字和id
        self.cityModel.cityName = cityModel.nameStr;
        self.cityModel.city_id = cityModel.idStr;
        KMyLog(@"选中了:%@%@", self.cityModel.provinceName, self.cityModel.cityName);
        
        //改变选中cell的颜色
        SXTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        UIButton *cityBtn = cell.btn;
        [cityBtn setTitleColor:MainCorlor forState:UIControlStateNormal];
        cell.btn.layer.borderColor = MainCorlor.CGColor;
        
    } else if (tableView == _hyView.tableView) {//行业/价格/好友数量的筛选列表
        switch (self.sxKind) {
            case SXKindHY:
            {
                //是筛选行业
                self.hyString = self.hyArray[indexPath.row];
            }
                break;
            case SXKindPrice:
            {
                //是筛选价格
                self.priceModel = self.priceDataSource[indexPath.row];
            }
                break;
            case SXKindFriend:
            {
                //是筛选好友
                self.friendModel = self.friendDataSource[indexPath.row];
            }
                break;
        }
    }
    
    
    
    
    
#if 0
    if(tableView==_tableView){
        SXTableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
        UIButton *senderBtn=cell.btn;
        
        for (UIButton *btn in self.buttonArray)
        {
            NSLog(@"当前点击的按钮%ld",senderBtn.tag);
            if (senderBtn.tag==btn.tag)
            {
                NSLog(@"遍历的按钮%ld",btn.tag);
                senderBtn.layer.borderColor=[UIColor blueColor].CGColor;
//                [senderBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//                type=[NSString stringWithFormat:@"%ld",btn.tag];
            }
            else
            {
                senderBtn.layer.borderColor=[UIColor grayColor].CGColor;
//                senderBtn.titleLabel.textColor=[UIColor grayColor];
//                [senderBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                
            }
        }

//        [cell.btn setTitleColor:[UIColor colorWithRed:0.047 green:0.364 blue:0.663 alpha:1]  forState:UIControlStateNormal];
//        cell.btn.layer.borderColor=[[UIColor colorWithRed:0.047 green:0.364 blue:0.663 alpha:1]CGColor];
        IDModel *model=_dataSource[indexPath.row];
//        _shiIdStr=model.idStr;//选中的市ID
//        _shiStr=model.nameStr;//选中的市
        [_array addObject:model];

    }
#endif
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _tableView) {
        SXTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        UIButton *cityBtn = cell.btn;
        [cityBtn setTitleColor:[UIColor groupTableViewBackgroundColor] forState:UIControlStateNormal];
    }
}
#pragma mark 行业接口

-(void)makeHangYeData{
    [self.hyDataSource removeAllObjects];//清空数据源
    [self.view makeToastActivity];
    
    NSString * ShouY = [NSString stringWithFormat:@"%@%@",DYUrl,HYSXURL];
    
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    
    [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"行业筛选返回的数据%@",responseObject);
        NSArray *array =[responseObject objectForKey:@"profession"];
        for (int i=0; i<array.count; i++) {
            NSString *hyStr=[array objectAtIndex:i];
            
            [self.hyDataSource addObject:hyStr];
        }
        
        [self.hyView.tableView reloadData];
        
        [self.view hideToastActivity];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        //        [self.view hideToastActivity];
        [failAlView show];
        NSLog(@"发生错误！******************%@",error);
        
    }];
    
    
}
#pragma mark 筛选地域接口
-(void)makeDiYuData{
    
//    [self.view makeToastActivity];
    NSString * ShouY = [NSString stringWithFormat:@"%@%@",MainDYURL,DYSXURL];
    
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    
    [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//        NSLog(@"地域筛选返回的数据%@",responseObject);
        NSArray *array=[responseObject objectForKey:@"retval"];
        NSLog(@"获取到的数据为---------------：%@",array);
        for (int i=0; i<array.count; i++) {
            NSMutableDictionary *dic=[array objectAtIndex:i];
            //获取到各个省
            NSString *shengStr=[dic objectForKey:@"region_name"];
            NSString *shengIdStr=[dic objectForKey:@"region_id"];
            [self.shengArray addObject:shengStr];
//            SSModel *model=[[SSModel alloc]init];
//            model.shengFen=shengStr;
//            model.shengFenId=shengIdStr;
//            [self.shengArray addObject:model];

        }
//        [self.view hideToastActivity];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//        [self.view hideToastActivity];
        [failAlView show];
        NSLog(@"发生错误！******************%@",error);

    }];
    
    
}

#pragma mark 懒加载
//筛选界面懒加载
-(SXView *)sxView
{
    if (_sxView==nil) {
        _sxView=[SXView allocSxView];
        [_sxView.dqBtn addTarget:self action:@selector(dqDone:) forControlEvents:UIControlEventTouchUpInside];
        [_sxView.hyBtn addTarget:self action:@selector(hyDone:) forControlEvents:UIControlEventTouchUpInside];
        [_sxView.jgBtn addTarget:self action:@selector(jgDone:) forControlEvents:UIControlEventTouchUpInside];
        [_sxView.hysBtn addTarget:self action:@selector(hysDone:) forControlEvents:UIControlEventTouchUpInside];
        [_sxView.ackDoneButton addTarget:self action:@selector(ackDoneAction:) forControlEvents:UIControlEventTouchUpInside];
        [_sxView.clearButton addTarget:self action:@selector(clearAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sxView;
}
//地域界面懒加载
-(DYView*)dyView
{
    if (_dyView==nil) {
        _dyView=[DYView allocDyView];
        
    }
    return _dyView;
}
//行业界面懒加载
-(HYView*)hyView
{
    if (_hyView==nil) {
        _hyView=[HYView allochyView];
        //确认按钮添加点击方法
        [_hyView.ackDoneButton addTarget:self action:@selector(hyAckDoneAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _hyView;
}

-(NSMutableArray*)hyArray
{
    if (_hyArray==nil) {
        _hyArray=[NSMutableArray array];
        
    }
    return _hyArray;
}
#pragma mark ---隐藏导航栏上的黑线
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

//区分自媒体和资源页面
-(void)selected:(UIButton *)sender{
    [self removeSXViewWithNoAnimation];//切换界面时移除筛选界面
    [self clearAction:self.sxView.clearButton];//清空筛选项
    UIButton *btn=sender;
    self.ZMTorZY = btn.tag;//记录是自媒体还是资源
    if (btn.tag==1) {
        [_leftBtn setBackgroundImage:[UIImage imageNamed:@"blue.png"] forState:UIControlStateNormal];
        [_rightBtn setBackgroundImage:[UIImage imageNamed:@"white.png"] forState:UIControlStateNormal];
        [_leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_rightBtn setTitleColor:[UIColor colorWithRed:0.047 green:0.365 blue:0.663 alpha:1] forState:UIControlStateNormal];

        [_zyVC.view removeFromSuperview ];
        [self addChildViewController:_zmtVC];
        [self.view addSubview:_zmtVC.view];        
        [self addViewConstraints:_zmtVC];
    }
    if (btn.tag==2) {
        
        [_leftBtn setBackgroundImage:[UIImage imageNamed:@"leftWhite.png"] forState:UIControlStateNormal];
        [_rightBtn setBackgroundImage:[UIImage imageNamed:@"rightBlue.png"] forState:UIControlStateNormal];
        [_leftBtn setTitleColor:[UIColor colorWithRed:0.047 green:0.365 blue:0.663 alpha:1] forState:UIControlStateNormal];
        [_rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_zmtVC.view removeFromSuperview];
        [self addChildViewController:_zyVC];
        [self.view addSubview:_zyVC.view];
        [self addViewConstraints:_zyVC];
        [_zyVC.zySXButton addTarget:self action:@selector(sxDone:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

#pragma mark 添加的view的约束
-(void)addViewConstraints:(UIViewController *)vc{
    
    [vc.view mas_makeConstraints:^(MASConstraintMaker *make){
        make.width.mas_equalTo(ConentViewWidth);
        make.left.mas_equalTo(self.view).offset(0);
        make.top.mas_equalTo(self.mas_topLayoutGuideBottom).with.offset(0);
        make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(0);
    }];
}


@end
